---
name: who-is
description: Quick briefing on a person — their file, any tasks mentioning them, and any upcoming meetings. Use when the user asks "who is X?", "what do I know about X?", "what's the state with X?", or "prep me for X". If no name is given, falls back to the next meeting's attendees.
---

## Purpose

A fast briefing on a person. Combines their `People/` file with open tasks and upcoming meetings into one scannable overview.

## Workflow

### 1. Resolve the person

In parallel run two tasks:

* Calendar check
	1. *Read this week's calendar via the Calendar MCP
	2. Find any meetings where the named person is attending

* Find their file in People/ in this order:
	1. *Exact filename match: `People/<Firstname-Lastname>.md`
	2. Case-insensitive filename match
	3. `**Aliases:**` line in any person file
### 2. Read the person file

Extract:
- Role + company
- Relationship
- Last contact date (compute "X days ago" vs today)
- Up to 3 most relevant Context bullets
- Up to 3 most recent Notes entries

### 3. Find related tasks

Grep `tasks.md` for lines containing the person's first name or full name. Include any matches with their priority and due date.

### 4. Find upcoming meetings

Via the Calendar MCP, look for events in the next 14 days with this person as an attendee.

### 5. Output

Tight format. **Omit sections that are empty** — don't leave dangling headers.

```
## [Name] — [Role]

[Relationship]. Last contact: [date] ([N days ago]).

**What they care about**
- [point]
- [point]

**Recent**
- [date]: [note]
- [date]: [note]

**Open tasks**
- [task] — [priority], [due date]

**Upcoming**
- [date time] — [meeting title] ([duration])
```

## Rules

- **Summarise, don't dump.** Pick the 2–3 most relevant context points and recent notes. Full file is already in context via the hook.
- **Surface the signal.** If last contact was >30 days, flag it. If a task is overdue, flag it.
- **Don't speculate.** If the file is sparse, say so: "Thin file, only one interaction logged."
- **One person per invocation.** If multiple names are given, ask which one — or handle sequentially.

## Example

**User:** `/who-is Jane`

**Resolve:** match `People/Jane-Doe.md`.

**Output:**

```
## Jane Doe — VP Product at Acme Corp

Customer, champion for the enterprise pilot. Last contact: 2026-04-15 (5 days ago).

**What she cares about**
- Cutting onboarding time for new enterprise accounts
- Her sign-off unlocks the full annual contract

**Recent**
- 2026-04-15: Pilot kick-off. Engaged, wants success criteria by next week.
- 2026-04-10: Intro call. Sold on the problem.

**Upcoming**
- 2026-04-23 14:00 — Pilot check-in (30 min)
```
