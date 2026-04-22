---
name: daily-plan
description: Produce three focused priorities for today, each tied to a goal or an urgent task. Reads goals.md, tasks.md, and today's calendar. Flags conflicts. Does not dump the task list. Use when the user runs /daily-plan or asks what they should focus on today.
---

## Purpose

Turn goals, tasks, and calendar into three priorities for today. The job is focus, not capture.

## Workflow

### 1. Gather inputs

- Read `goals.md` — the current quarterly goals. These are the "why" for every priority.
- Read `tasks.md` — the full backlog. This is the pool to pick from.
- Read today's calendar via the Calendar MCP. Note meeting times and the gaps between them.

If any input is missing, flag it and continue with what you have. Don't block on a missing calendar.

### 2. Pick three priorities

Limit to strictly top three priorities.

Selection rules:
- Each priority must **either (a) move a goal forward or (b) be urgent enough that ignoring it today causes a concrete problem**.
- Prefer items already in `tasks.md`, but you can surface something from the calendar (e.g. prep for a 2pm meeting) even if it isn't written down.
- If multiple tasks are urgent, pick the one whose consequence is worst if skipped.
- If the user has a packed calendar, size priorities to what will actually fit in the gaps.

### 3. Justify each

For each priority, one line covering:
- **What it is** — the task, in a sentence
- **Why it made the list** — which goal it moves, or what breaks if skipped
- **Rough time** — so the user can sanity-check against calendar gaps

### 4. Flag conflicts

If calendar density means the priorities won't fit, say so. If two priorities compete for the same block, call it out. Keep this short — one or two bullets.

### 5. Note-but-not-today

Anything you considered and rejected goes under a "Noted but not today" list with a one-phrase reason. This keeps the main list tight without losing visibility on what else is live.

## Rules

- **Three priorities. Not a dump.** If you can't choose, choose anyway. An opinionated list the user can argue with is more useful than everything in `tasks.md`.
- **No generic advice.** "Focus on MRR" is not a priority. "Send Acme contract — closes Q2 deal, deadline Friday" is.
- **Link to goals or urgency.** If a priority traces back to neither, it shouldn't be on the list.
- **Don't schedule the day.** Flag conflicts, but don't assign time blocks unless the user asks.
- **Don't edit `tasks.md`.** This skill reads only. Use `/new-task` to add, and manual edits to complete.


## Output format

```
## Today's priorities — [DATE]

1. **[Priority]** — [justification, goal tag]. ~[time]
2. **[Priority]** — [justification, goal tag]. ~[time]
3. **[Priority]** — [justification, goal tag]. ~[time]

### Conflicts
- [Any calendar or time risks]

### Noted but not today
- [Task] — [why not today]
- [Task] — [why not today]
```


## Example Output

```
## Today's priorities — 2026-04-20

1. **Send onboarding PRD to eng leadership** — biggest bet on the conversion goal, goal: onboarding. Hard deadline tomorrow. ~1.5 hours.
2. **Run Acme discovery interview on upgrade blockers** — feeds the pricing question blocking exec review, goal: discovery. Scheduled 14:00, can't move. ~1 hour.
3. **Review trial conversion dashboard with data team** — signals whether the current experiment is moving the metric, goal: conversion. ~45 min.

### Conflicts
- 10:00–11:00 sprint review + 14:00–15:00 Acme interview leaves two clean blocks: 08:30–10:00 and 15:30–17:30. The PRD fits in the morning; dashboard review needs to squeeze into the afternoon gap.

### Noted but not today
- Draft Q2 roadmap update — P1, due Friday, tomorrow is soon enough.
- FAQ for CS team on new pricing — P1 but undated; park until next week.
- Competitor onboarding audit — P2, no urgency.
```
