---
name: fix-one-thing
description: Pick one entry from improvements.md, diagnose it, propose a fix, make the edit with user confirmation, then remove the line. One fix per invocation — small and reviewable. Use when the user runs /fix-one-thing, says "fix one thing", or asks to work through the improvements list.
---
## Purpose

Close the loop on system maintenance. `/weekly-review` surfaces friction; this skill fixes it, one entry at a time, in the right file.

## Workflow

### 1. Pick an entry

Read `improvements.md`. If the file is empty or missing, say so and stop.

- If the user named a topic (`/fix-one-thing calendar`), search for entries containing that term.
- If they named nothing, pick the top entry by priority (P0 first), then oldest date within the same priority.
- If multiple entries look equally strong, list the top three and ask which one.

### 2. Identify the target files

Based on the entry, name the files you expect to edit **before** touching them. Common targets:

- A skill → `.claude/skills/<skill-name>/SKILL.md`
- A state file → `goals.md`, `tasks.md`, `improvements.md`, a `People/` file
- Claude's behaviour → `CLAUDE.md`
- A hook → `.claude/hooks/<hook>.sh` or `.claude/settings.json`

If the entry is vague enough that you're not sure, ask: "This sounds like it lives in either X or Y — which?"

### 3. Diagnose before editing

Read the target files. Understand the current behaviour before proposing a change.

State in one line what the current behaviour is, and what the new behaviour should be. If those two lines don't cleanly describe the problem, you're not ready to edit — ask for more information.

### 4. Propose the fix

Show the proposed edit as a before → after. Keep it small — one rule, one line, one section.

If the fix touches multiple files or looks like a rewrite, flag it and ask whether to proceed, break it into smaller entries, or handle it manually.

Wait for confirmation before editing.

### 5. Make the edit

Once confirmed, make the changes. Keep the rest of the file untouched.

### 6. Remove the line from improvements.md

Delete the entry you just fixed. Leave the rest of the list in its current sort order.

### 7. Confirm

One line, no ceremony: "Fixed /daily-plan priority cap. Removed from improvements.md."

## Rules

- **One entry per invocation.** If the user wants two fixed, run the skill twice. Small edits are easier to review and roll back.
- **Diagnose before editing.** Unexpected behaviour is evidence your model of the system may be wrong. Read the file, confirm the cause, then fix.
- **Propose, don't just edit.** Show the before → after. Let the user approve.
- **Don't invent fixes.** If the entry is too vague to act on, ask. Don't make up detail.
- **Never edit silently.** The whole point of this module is visibility into how the system changes.