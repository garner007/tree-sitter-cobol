# COBOL Grammar TODOs and Progress

## Current Progress
- Corpus: All existing suites pass (CICS, EVALUATE, PERFORM, GOTO, minimal program, data_description, select, pic_x/pic_9, redefines, source/object computer).
- New tests added and passing:
  - Procedure: ADD/COMPUTE, STRING/UNSTRING, INSPECT.
  - Data: packed decimals + COMP-3 (with spaced V), record lists with interleaved comments, 88 condition-names.
  - EXEC: basic EXEC SQL/DLI/SQLIMS recognition with END-EXEC.
- Tolerance improvements:
  - Accepts “ID DIVISION.” abbreviation.
  - AUTHOR/INSTALLATION/DATE-WRITTEN/DATE-COMPILED/SECURITY without trailing comments.
  - Area A line comments ‘*’/‘/’ (cols 1–7) recognized.
  - Right-margin sequence numbers treated as suffix/ident area.

## In-Flight Focus (Real Samples)
- DDPAYADD.cbl
  - Period-less sentences inside paragraphs (multiple statements ending at next header).
  - Interleaved comment lines between 03 entries.
  - Action: Add alignment-sensitive corpus case mirroring first failing block; adjust procedure-division grouping if needed.
- DDBNKDAT.cbl
  - Similar pattern near CLOSE-IT./FORMAT-DATE. (sentence termination by header).
  - Action: Add corpus test; ensure headers terminate sentences without requiring periods.

## Next High-Value Tasks
- COPY and REPLACING
  - Basic COPY … REPLACING (LEADING/TRAILING BY), optional library (OF/IN), SUPPRESS.
  - Add minimal corpus cases and implement tolerant parsing.
- OCCURS / REDEFINES / DEPENDING ON
  - Nested 01/03/05 patterns with OCCURS DEPENDING ON, REDEFINES, RENAMES, SIGN/JUSTIFIED/SYNCHRONIZED.
  - Add focused tests and fill gaps.
- EXEC bodies (opaque)
  - Multi-line EXEC SQL/DLI/SQLIMS with host variables and literals; keep body opaque, focus on END-EXEC boundaries.
  - Add corpus examples; maintain stable AST.
- Procedure Division
  - MOVE CORRESPONDING (already partially supported; expand coverage).
  - Additional I/O variants (READ/WRITE/REWRITE/START/RETURN/CLOSE) with options.

## Scanner/Formatting Tolerance
- Continuations (hyphen in column 7): extend tests covering statement/data split lines.
- Right margin sequence numbers: continue verifying threshold doesn’t trim code in edge cases.
- Area A/B alignment: more tests for near-boundary paragraph/section headers.

## NIST Suite Tracking
- Current: 382 tests (Success: 20, Fail: 351, Skip: 11).
- Plan: After stabilizing real samples, triage recurring NIST failures (categories: EXEC, complex Data Division clauses) and add corpus tests that capture representative patterns.

## Developer Tooling
- scripts/parse_samples_cli.js: summarises parse errors across sample/Processed.
- Consider optional tree-sitter CLI config (tree-sitter init-config) to silence warnings locally.

## Short-Term Action Items
- [ ] Add corpus test: DDPAYADD first failing block (verbatim alignment + comments).
- [ ] Adjust procedure division sentence grouping to allow header-terminated sentences (no period).
- [ ] Re-parse DDPAYADD and iterate until clean; repeat for DDBNKDAT.
- [ ] Add tests + support for COPY … REPLACING (basic variants).
- [ ] Add tests for OCCURS DEPENDING ON + REDEFINES combos; patch gaps.
- [ ] Add multi-line EXEC SQL/DLI body tests (opaque content), confirm END-EXEC handling.
- [ ] Periodic NIST runs to track improvements.

## Medium-Term Items
- Broaden Data Division clauses (JUSTIFIED, SYNCHRONIZED nuances; edited pictures).
- More EXEC flavors (IMS calls, vendor-specific tokens) as opaque segments.
- Performance profiling on large sources; adjust precedence only where needed.

