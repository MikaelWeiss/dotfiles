# Implement GitHub Issue

You are implementing a GitHub issue. Follow this structured process from understanding through verification.

## Input
Issue number: $ARGUMENTS

---

## Phase 1: Understand

### Fetch the Issue
```bash
gh issue view $ARGUMENTS
```

### Analyze the Issue
- [ ] Read the problem description thoroughly
- [ ] Identify specifications and requirements
- [ ] Note any implementation details provided
- [ ] Check related issues or context
- [ ] Review labels and metadata

### Determine Issue Type
- **Bug**: Issue describes unexpected behavior or a defect
- **Feature**: Issue requests new functionality or enhancement

---

## Phase 2: Explore

Use the **EnterPlanMode** tool to enter plan mode, then investigate the codebase.

### Codebase Investigation
- [ ] Identify files that need to be modified
- [ ] Understand existing patterns and architecture
- [ ] Trace related code and dependencies
- [ ] Locate relevant test files

### If Bug
- [ ] Reproduce the bug locally if possible
- [ ] Identify the root cause
- [ ] Determine where a regression test should live

### If Feature
- [ ] Identify where the feature fits in the architecture
- [ ] Look for similar patterns to follow
- [ ] Consider API/interface implications

---

## Phase 3: Plan

### Design the Approach
- [ ] Determine what changes need to be made
- [ ] List files to create or modify
- [ ] Define the order of operations
- [ ] Identify edge cases to handle

### Write the Plan

**For Bugs:**
1. Create a test that reproduces the bug (test should fail initially)
2. Fix the bug in the code
3. Verify the test now passes
4. Check for related edge cases

**For Features:**
1. Implement core functionality
2. Add appropriate tests
3. Update documentation if needed
4. Handle edge cases

### Plan Checklist
- [ ] Step-by-step implementation tasks are clear
- [ ] Files to create/modify are listed
- [ ] Key technical decisions are documented
- [ ] Assumptions or open questions are noted

### Exit Plan Mode
Use **ExitPlanMode** when the plan is ready for user approval.

---

## Phase 4: Implement

After user approves the plan:

### For Bugs
- [ ] Write the failing test first
- [ ] Confirm the test fails for the expected reason
- [ ] Implement the fix
- [ ] Confirm the test passes

### For Features
- [ ] Implement changes in planned order
- [ ] Write tests alongside implementation
- [ ] Keep commits focused and atomic

---

## Phase 5: Verify

- [ ] Run the full test suite
- [ ] Confirm all new tests pass
- [ ] Confirm no existing tests broke
- [ ] Manually verify the fix/feature if applicable
- [ ] Review changes against the original issue requirements

---

## Guidelines

- **Always use EnterPlanMode** - Do not skip the planning phase
- **Be thorough** - Explore before planning, plan before implementing
- **Ask questions** - If the issue is unclear, ask before proceeding
- **Stay aligned** - Keep implementation matched to issue requirements
- **Test first for bugs** - Never fix a bug without a reproducing test