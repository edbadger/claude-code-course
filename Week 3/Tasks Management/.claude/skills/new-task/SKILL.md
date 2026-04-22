---
name: new-task
description: Capture a new task to tasks.md. Takes a plain-English task, infers priority/due date/goal tag where obvious, asks for anything unclear, then appends to the file in sorted order. Use when the user says "add a task", "remind me to", or describes something they need to do later.
---

## Purpose

Quick capture. One task at a time. Writes to `tasks.md` in the workspace root.

## When to use

- User says "add a task to X"
- User says "remind me to X"
- User describes something they need to do later
- User runs `/new-task [description]`

## Workflow

### 1. Parse the input

Extract what's obvious from the user's message:

- **Task description** — always required. Paraphrase to a clear, action-starting sentence ("Send contract to legal", not "the contract thing").
- **Priority** — look for signals:
  - "urgent", "asap", "today", "blocker" → P0
  - "important", "this week", "soon" → P1
  - "someday", "eventually", "when I get a chance" → P2
- **Due date** — parse explicit dates; resolve relative dates ("tomorrow", "Friday", "next week") against today's date.
- **Goal tag** — read `goals.md`, look for topic overlap with the task. Only tag if the link is obvious. Don't guess.

### 2. Ask for anything unclear

In a **single message**, ask only for fields that are missing and matter:

- If priority is unclear: "Priority — P0 (urgent), P1 (important), or P2 (when I can)?"
- If the task sounds time-sensitive but there's no date: "Due date, or no deadline?"
- If a goal tag isn't obvious and `goals.md` has named goals: "Goal — [list short tags from goals.md], or none?"

If the user gave enough signal to propose defaults, propose them in one line: "Filing as P2, no due date, no goal tag — sound right?" Let them confirm or override.

**Don't** ask questions in sequence. One message, one round-trip.

### 3. Append to tasks.md

Format each line exactly:

```
description | priority | due date | goal
```

- Use `YYYY-MM-DD` for dates.
- Leave optional fields empty but keep the pipes: `Book flights | P2 | 2026-04-28 |`
- Undated and untagged: `Draft case study | P1 | |`

After appending, re-sort the task list (everything below the `---`) by:
1. Due date ascending (empty dates sink to the bottom)
2. Priority ascending within the same date (P0 before P1 before P2)

### 4. Confirm

One line, no ceremony:

```
Added: Send Aviv contract to legal | P1 | 2026-04-24 | MRR
```

## Rules

- **Never invent a due date.** If unclear, leave blank or ask.
- **Never invent a goal tag.** Match against `goals.md` or leave blank.
- **Don't triage.** If the user says it's a task, it's a task. Don't second-guess whether it should be a meeting note or an email draft.
- **One task per invocation.** If the user gives a list, handle them sequentially and confirm each — or ask them to run separately.

## Example

**User:** "Add a task to review the new onboarding wireframes before Thursday"

**Parse:**
- description: "Review onboarding wireframes"
- due date: this Thursday → 2026-04-23
- priority: unclear
- goal: onboarding (matches Goal 2)

**Ask:** "Priority — P0 (urgent), P1 (important), or P2?"

**User:** "P1"

**Append and confirm:** "Added: Review onboarding wireframes | P1 | 2026-04-23 | onboarding"
