---
name: weekly-review
description: Review the past week of Claude Code conversations, notice what worked and what didn't, log suggested POS improvements to improvements.md. Use when the user runs /weekly-review, says "weekly review", or asks how the week with the POS went. Typically Fridays.
---
## Purpose

Reflect on the past week of conversations with Claude. The job is to spot patterns — where the POS helped, where it got in the way — and turn the friction into concrete entries in `improvements.md`. This is what makes the system compound.

## Workflow

### 1. Find sessions from the past 7 days

Claude Code stores each session as a JSONL file at `~/.claude/projects/<project-slug>/<session-id>.jsonl`.

The `<project-slug>` is the current workspace path with `/` replaced by `-`. Compute it by running `pwd | sed 's/\//-/g'` and prefixing `~/.claude/projects/`.

- List all `.jsonl` files in that directory.
- Filter to files modified in the last 7 days (`find <dir> -name '*.jsonl' -mtime -7`).
- If zero sessions, tell the user and stop.

### 2. Scan, don't read

Each line in a session file is one JSON event — user message, assistant response, tool call, tool result. Don't read full sessions end-to-end. Sample and pattern-match.

Focus on **user messages** (that's where friction surfaces) and places where the user **corrected Claude, restated a request, or had to say "use the skill"**.

Look for patterns in five buckets:

- **Corrections** — "no, I meant...", "that's not what I asked for", "try again", "stop doing X"
- **Repeated clarifications** — the user having to provide context Claude should already have had
- **Missed skill invocations** — user had to explicitly invoke a skill that should have auto-run
- **Output quality drops** — long task dumps when the skill says three priorities, missing goal tags, ignored rules
- **What worked** — skills that fired cleanly, outputs the user accepted without edits

### 3. Output a tight summary of 2-3 key issues

Keep it under 60 seconds to read.
Wait for user feedback.
Offer to edit or add to improvements.md

#### Output format after step 3

---
## Weekly review — [YYYY-MM-DD to YYYY-MM-DD]

**Sessions reviewed:** N conversations across M days.

**What's working**
- [pattern with specifics]
- [pattern]

**What's not working**
- [pattern with specifics]
- [pattern]

**Suggested improvements**
- [entry]
- [entry]
  
Add these to improvements.md?

---


#### Example Output after step 3

---
## Weekly review — 2026-04-14 to 2026-04-20

**Sessions reviewed:** 12 conversations across 5 days.

**What's working**
- /daily-plan hit exactly 3 priorities on 4/5 runs
- /who-is + the context hook handled Jane Doe and Marcus cleanly
- /new-task auto-inferred correct goal tags on 7/9 captures

**What's not working**
- /daily-plan drifted to 5 priorities on days when tasks.md had 12+ items
- /who-is returned empty output when the person wasn't in People/ — didn't offer to create one
- /new-task missed goal tags on cross-cutting tasks (conversion vs onboarding overlap)

**Suggested improvements**
- /daily-plan sometimes lists 4–5 priorities when tasks.md is long | P1 | 2026-04-19
- /who-is should offer /new-person when no match is found | P1 | 2026-04-19
- /new-task tag inference struggles on cross-cutting tasks | P2 | 2026-04-19
  
Add these to improvements.md?

---

### 4. Append to improvements.md

After the user has provided input, append a line in the standard format for each "what's not working" pattern:

`problem description | priority | YYYY-MM-DD`

Priority guidance:
- **P0** — something actively broke or misled the user
- **P1** — useful fix, affects common workflows
- **P2** — nice-to-have, edge case

Before appending, read `improvements.md` first. If an entry is close to one already open, flag it: "This looks similar to '[existing entry]' — skip or merge?" Don't duplicate.

Re-sort the list after appending: P0 first, then by date ascending within the same priority.

## Rules

- **Notice, don't fix.** This skill is diagnostic only. Fixes ship via `/fix-one-thing`.
- **Capture wins too.** Not just problems. Positive patterns tell the user what to preserve.
- **Three-to-five improvements max.** If you're logging ten, you're not prioritising — pick the highest-leverage ones and skip the rest.
- **Specific, not generic.** "The skill was bad" is not an entry. "/daily-plan listed 5 priorities on 2 runs when tasks.md had 12+ items" is.
- **Only write to improvements.md.** Don't edit skills, goals, or tasks.
