## Personal CRM

Files and skills for tracking the people I work with. Read the relevant files before answering questions about anyone.

**Files**
- `People/` — one file per person I work with, named `Firstname-Lastname.md`. Contains role, relationship, rolling notes, and optional aliases.

**Skills**
- `/new-person [name]` — create a new `People/` file. Checks for duplicates; asks for missing fields.
- `/who-is [name]` — quick briefing on a person: their file, any related tasks, any upcoming meetings. Falls back to the next meeting's attendees if no name given.

**Behaviour**
- When I describe meeting someone new, offer to run `/new-person`.
- When I ask about a person, run `/who-is` rather than reading their file raw.
- When I describe a new interaction with someone, offer to append a note to their file.
