---
name: new-person
description: Create a new person file in People/ from a name and a few facts. Writes to People/Firstname-Lastname.md. Checks for an existing file first; asks for missing fields. Use when the user says "add a new person", "start a file for X", or "I just met X".
---

## Purpose

Create a new person's file in `People/`.
## Workflow

### 1. Parse input

Extract what's obvious from the user's message:

- **Name** — always required. Filename will be `Firstname-Lastname.md`.
- **Role** — title + company
- **Relationship** — one line on how they fit into the user's work
- **Context** — any volunteered details about what they care about, background, or constraints
- **Aliases** — nicknames or short forms the user mentioned

### 2. Check for duplicates

Before writing, scan `People/` for:

- **Exact filename match** — stop and say "You already have a file for [Name] at `People/[Name].md`. Want to update it instead?"
- **Similar match** (same last name, close first name, or a name that appears as an alias in another file) — ask: "There's already a file for [close match] — same person?"

### 3. Ask for anything missing

Required: Name, Role, Relationship.
Recommended: one Context bullet, a first Note entry.

Ask in a **single message** for whatever is missing:

> "Got the name. Role (title + company) and relationship?"

### 4. Write the file

Path: `People/<Firstname-Lastname>.md`.

Template:

```
# [Name]

**Role:** [title] at [company]
**Relationship:** [one line]
**Last contact:** [today's date]
**Aliases:** [only include this line if aliases were given]

## Context
- [point]
- [point]

## Notes
- [today]: [initial note — how/why you're starting this file]
```

Only include the `**Aliases:**` line if aliases were explicitly given. Don't add an empty line.

### 5. Confirm

One line, just: "Created `People/Jane-Doe.md`."

## Rules

- **Filename format is non-negotiable.** `Firstname-Lastname.md`, pascal-cased, single hyphen. The context-injection hook greps against this.
- **Don't invent facts.** If you don't know a role or company, ask or leave blank. Never fabricate.
- **Aliases only when volunteered.** Don't guess nicknames.
- **Existing file wins.** Never overwrite — offer to update instead.

## Example

**User:** "Start a file for Marcus Chen, our new head of engineering."

**Parse:**
- Name: Marcus-Chen
- Role: Head of Engineering
- Company: internal (no company mentioned)
- Relationship: colleague (implied)

**Ask:** "Got the basics. Any context worth capturing now — what he cares about, where he came from, how best to reach him?"

**User:** "Owns the platform team. Previously at Shopify. Prefers Slack over email."

**Write `People/Marcus-Chen.md` and confirm:** "Created `People/Marcus-Chen.md`."
