# Repository Guidelines

## Project Structure & Module Organization
- `grammar.js`: Main Tree-sitter grammar (source of truth).
- `src/`: Generated artifacts (`parser.c`, `scanner.c`, `grammar.json`, `node-types.json`). Do not edit by hand.
- `bindings/`: Language bindings
  - `bindings/node`: Node.js addon (`binding.cc`, `index.js`).
  - `bindings/rust`: Rust crate (`lib.rs`, `build.rs`).
- `queries/`: Highlighting/locals queries (`.scm`).
- `test/`: Tests
  - `test/corpus/*.txt`: Tree-sitter corpus tests.
  - `test/check_tests.sh`: Validates COBOL snippets with `cobc`.
  - `test/cobol85/*`: NIST COBOL85 suite harness.
- `skip_tests.txt`: NIST cases to skip.

## Build, Test, and Development Commands
- `npm install`: Install dev tools (requires Node 20; see README for nvm snippet).
- `npm run build`: Generate parser (`tree-sitter generate`) and build Node addon (`node-gyp`).
- `npm test`: Run corpus tests (`tree-sitter test`).
- `npm run nist`: Parse NIST COBOL85 sources; writes `test/cobol85/summary.txt`.
- `npm run ct`: Lint corpus snippets by compiling with `cobc -fsyntax-only`.
- Ad‑hoc: `npx tree-sitter parse sample/FILE.cbl` or any `.cbl`.
- Rust: `cargo build` builds the Rust binding (no tests here).

## Coding Style & Naming Conventions
- Indentation: 2 spaces, no tabs.
- Grammar rules: `snake_case` (e.g., `procedure_division`).
- Literal/keyword tokens: UPPER_CASE with leading underscore (e.g., `$._PERFORM`).
- Prefer small, composable rules; use `seq`, `choice`, `repeat`, `prec`, `field`.
- Do not edit files in `src/`; instead edit `grammar.js` and regenerate.

## Testing Guidelines
- Corpus tests live in `test/corpus/*.txt` with sections: title, code, `---`, expected S‑expression.
- Add minimal, focused samples per construct; keep titles unique and descriptive.
- Run locally: `npm test` and `npm run ct`. For broad coverage: `npm run nist`.
- If a NIST file is flaky/unrelated, add its base name to `skip_tests.txt` with a short comment in PR.

## Commit & Pull Request Guidelines
- Commit messages: imperative, concise, scope first (e.g., `grammar: handle EVALUATE`).
- PRs must include: summary, rationale, affected constructs, before/after examples, and test updates (corpus and, if applicable, queries).
- Link related issues and note any skipped NIST cases. Attach `npm test` and `npm run nist` summaries.

## Environment & Tooling
- Requires: Node 20+, `tree-sitter-cli`, Python (optional), GNU Cobol (`cobc`) for `ct` script.
- If parser output diverges after edits, run `npm run build` and re-run tests.
