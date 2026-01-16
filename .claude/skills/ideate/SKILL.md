---
name: ideate
description: Ideation Assistant. Use when the user wants to brainstorm, explore an idea, think through a feature, or needs help specifying something before implementation. Triggers include "let's think through", "I'm considering", "help me spec out", "brainstorm", or when the user describes a vague idea that needs clarification.
user-invocable: true
---

# Ideation Assistant

Help the user think through and fully specify an idea. The goal: produce a spec so complete that implementation requires zero searching — no codebase exploration, no documentation lookups, no web searches.

## Process

### Phase 1: Quick Skim

Before asking any questions, do a fast codebase exploration:
- Identify the general area of code relevant to the idea
- Understand existing patterns and conventions
- Note key files, types, and relationships

This prevents asking obvious questions you should already know. Don't go deep — just enough context to have an informed conversation.

### Phase 2: Structured Brainstorm

Ask numbered questions, 3-5 at a time. The user responds by number.

**What to probe for:**
- **Core behavior** — What exactly should happen? What triggers it?
- **Edge cases** — Errors? Empty states? Boundary conditions?
- **Scope boundaries** — What is explicitly NOT part of this?
- **User experience** — How will someone actually use this?
- **Dependencies** — What does this interact with? What needs to exist first?
- **Constraints** — Performance? Platform limitations? Compatibility?

**Example format:**
```
Based on my skim of the events system, a few questions:

1. **Trigger** — Should this activate on app launch, or only when the user navigates to the events view?

2. **Empty state** — If there are no events, should we show a placeholder message or hide the section entirely?

3. **Caching** — The current EventStorageManager caches aggressively. Should this new feature respect that cache or always fetch fresh?
```

Continue until you have enough to specify implementation without ambiguity.

### Phase 3: Deep Research

Once the design is clear, gather everything needed for implementation:

**Codebase:**
- Find exact files and line numbers that need changes
- Identify all affected types, functions, and relationships
- Note any existing patterns to follow

**Documentation:**
- Use Context7 for relevant library/framework docs
- Web search for APIs, patterns, or techniques discussed
- Pull specific code snippets and API signatures

**For each piece of documentation, include:**
- The relevant snippet or signature
- Why it applies to this implementation
- Link for deeper reading

### Phase 4: Write Spec

Create a spec file at the project root: `SPEC-[feature-name].md`

This is a temp file — easy to find, easy to delete after implementation.

## Spec Format

```markdown
# Spec: [Feature Name]

## Summary
[1-2 sentences describing what this is]

## Behaviors
- [Each bullet = one clear behavior or requirement]
- [Include edge cases inline]
- [Atomic — one idea per bullet]

## Out of Scope
- [Things explicitly not included]
- [Decisions made against during brainstorming]

## Changes Required

### `Path/To/File.swift:42-58`
**Change:** [Description of what to modify]

### `Path/To/OtherFile.swift:120`
**Add:** [Description of what to add]

### `Path/To/NewFile.swift` (new file)
**Create:** [Description of new file purpose]

## Documentation

### [Topic: e.g., "SwiftUI NavigationStack"]

**Relevant API:**
```swift
NavigationStack(path: $path) { ... }
```

**Why:** [Brief explanation of why this applies]

**Link:** [URL for deeper reading]

---

## Implementation Order
1. [First thing to do]
2. [Second thing]
3. [Continue in logical sequence]
```

## Guidelines

- Spec should be implementable by someone with no prior context
- Every file change must have exact line numbers
- Don't show existing code — just reference locations
- Documentation snippets should be minimal but sufficient
- Implementation order should account for dependencies
- If something was discussed but rejected, put it in "Out of Scope"
