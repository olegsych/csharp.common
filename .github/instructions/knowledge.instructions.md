---
description: "Always use when modifying or reviewing any files."
applyTo: "**"
---

# Understand Project Context

Find and read the `README.md` and `CONTRIBUTING.md` files closest to the files being modified or reviewed. Walk up from the file's directory to the repository root, stopping at the first match for each.

# Capture Insights from Feedback

- Evaluate all feedback received in interactive chats and code reviews to identify key insights and guidelines that will be important in future sessions. 
- Watch for key insights and guidelines expressed as
  - Phrases like `always`, `never`, `make sure`, `you should`, `why didn't you`.
  - Multiple requests to fix similar problems. 
- Don't codify trivial one-off corrections, only high-confidence insights.
- Ask for clarification and confirmation when in doubt.

# Organize Knowledge for Humans

- Store human-readable insights and guidelines in the `CONTRIBUTING.md` files.
  - Place repository-wide content in the `CONTRIBUTING.md` file in the root directory.
  - When repository contains multiple product projects (as opposed to test or example projects), place project-specific content the project directory.
- Store general instructions applicable across multiple repositories, such as coding style, methodology, etc. in the `.instructions.md` files.
- Your audience is experienced engineers. Don't restate the obvious.
- Avoid duplicating information readily available from the source code.
- Check `.md` files for accuracy and redundancy during code reviews.

# Ensure Knowledge Available to Agents

Make sure `copilot-instructions.md` contains minimal instructions required for agents to discover the available knowledge.
= Instructions to checkout submodules checkout, if any.
- Instructions to read `README.md` and `CONTRIBUTING.md` files.
