---
description: "Use when modifying code to understand project conventions, contribution guidelines, and to capture feedback."
applyTo: "**"
---

# Project Context

Before making changes, find and read the `README.md` and `CONTRIBUTING.md` files closest to the files being modified. Walk up from the file's directory to the repository root, stopping at the first match for each.

# Capture Insights from Feedback

When receiving corrections, preferences, recurring feedback or pattern worth remembering — whether during interactive chats or code reviews — proactively capture reusable insights so they don't need to be repeated.

- Capture the underlying preference or project convention, not just the specific correction.
- Don't codify trivial one-off corrections — only insights useful in future conversations.
- Store human-readable instructions in the `CONTRIBUTING.md` files
  - Place project-specific instructions the project directory.
  - Place repository-specific instructions in the root directory.
- Store general instructions applicable across multiple repositories in the `.instructions.md` files.
- Store repository-specific instructions needed by agents but redundant for humans in the `copilot-instructions.md` file.

