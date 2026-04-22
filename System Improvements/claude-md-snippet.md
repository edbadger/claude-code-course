## System Maintenance

Files and skills for keeping the POS improving over time.

**Files**
- `improvements.md` — running log of friction and ideas, one line per entry. Format: `problem | priority | date added`.

**Skills**
- `/weekly-review` — scans the past week of Claude Code sessions, surfaces what's worked and what hasn't, appends entries to `improvements.md`.
- `/fix-one-thing` — picks one entry from `improvements.md`, diagnoses, proposes a fix, edits the right file, removes the line.

**Behaviour**
- When I correct you on something mid-conversation, offer to log it to `improvements.md` or run `/fix-one-thing` straight away. Don't just acknowledge and move on — the point is to fix the system, not just this session.
- On Fridays, or when I ask "how did the week go", run `/weekly-review`.
- When I ask to improve the POS, run `/fix-one-thing`.