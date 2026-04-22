#!/usr/bin/env bash
#
# inject-people.sh — UserPromptSubmit hook
#
# Automatically loads relevant People/ files into context whenever the user's
# prompt mentions a person by name or alias. This is how context from your
# personal CRM flows into Claude without you having to ask for it.
#
# How it works:
#   1. Claude Code runs this script every time you submit a prompt.
#   2. The prompt text arrives as JSON on stdin (field: "prompt").
#   3. For each file in People/, derive the person's name from the filename
#      ("Firstname-Lastname.md" -> "firstname lastname") and collect any
#      aliases listed in the file on a line like:  **Aliases:** Jane, JD
#   4. If any of those terms appear in the prompt (case-insensitive), print
#      the file wrapped in a <person-context> marker.
#   5. Claude Code injects anything this script prints into the conversation
#      as additional context before calling the model.
#
# Setup:
#   - Place this file at .claude/hooks/inject-people.sh
#   - Make it executable:  chmod +x .claude/hooks/inject-people.sh
#   - Register it in .claude/settings.json under "hooks.UserPromptSubmit"
#   - Restart Claude Code so it picks up the hook
#
# Dependencies: bash, python3 (shipped with macOS). No jq required.
#
# Extending this:
#   - Add matching on first name only (risk: false positives with common names)
#   - Pull relevant tasks from tasks.md the same way
#   - Inject upcoming calendar attendees' files even when not mentioned
#
# Debugging:
#   - Anything printed to stdout goes into Claude's context.
#   - Anything printed to stderr surfaces in Claude Code logs.
#   - Silent exit (exit 0 with no stdout) = no injection for this prompt.

set -euo pipefail

# Read the hook input and extract the prompt text.
input=$(cat)
prompt=$(python3 -c 'import json, sys; print(json.loads(sys.stdin.read()).get("prompt", ""))' <<< "$input")
[ -z "$prompt" ] && exit 0

# Locate the People/ folder inside the project.
project_dir="${CLAUDE_PROJECT_DIR:-$PWD}"
people_dir="$project_dir/People"
[ ! -d "$people_dir" ] && exit 0

# Lowercase the prompt once for case-insensitive matching.
prompt_lower=$(echo "$prompt" | tr '[:upper:]' '[:lower:]')

for file in "$people_dir"/*.md; do
  [ -f "$file" ] || continue

  filename=$(basename "$file" .md)
  # "Firstname-Lastname" -> "firstname lastname"
  full_name_lower=$(echo "${filename//-/ }" | tr '[:upper:]' '[:lower:]')

  # Collect search terms: the full name plus any aliases from the file.
  terms=("$full_name_lower")

  aliases_list=$(grep -iE '^\*\*Aliases:\*\*' "$file" 2>/dev/null \
    | sed -E 's/^\*\*[Aa]liases:\*\*[[:space:]]*//' || true)
  if [ -n "$aliases_list" ]; then
    IFS=',' read -ra alias_array <<< "$aliases_list"
    for alias in "${alias_array[@]}"; do
      alias_clean=$(echo "$alias" | tr '[:upper:]' '[:lower:]' | xargs)
      [ -n "$alias_clean" ] && terms+=("$alias_clean")
    done
  fi

  # If any term appears anywhere in the prompt, inject the file.
  matched=false
  for term in "${terms[@]}"; do
    case "$prompt_lower" in
      *"$term"*)
        matched=true
        break
        ;;
    esac
  done

  if [ "$matched" = true ]; then
    rel_path="${file#$project_dir/}"
    echo "<person-context file=\"$rel_path\">"
    cat "$file"
    echo "</person-context>"
    echo ""
  fi
done

exit 0
