#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const { execFileSync } = require('child_process');

const BIN = path.join(__dirname, '..', 'node_modules', '.bin', 'tree-sitter');
const SAMPLE_DIR = path.join(__dirname, '..', 'sample', 'Processed');

function listFiles(dir) {
  return fs.existsSync(dir)
    ? fs.readdirSync(dir).filter(f => /\.(cbl|txt)$/i.test(f)).map(f => path.join(dir, f)).sort()
    : [];
}

function parsesClean(file) {
  try {
    const out = execFileSync(BIN, ['parse', file], { encoding: 'utf8' });
    // Consider any occurrence of ERROR or MISSING as a failure
    return !/\b(ERROR|MISSING)\b/.test(out);
  } catch (e) {
    return false;
  }
}

function main() {
  const files = listFiles(SAMPLE_DIR);
  if (files.length === 0) {
    console.log('No sample files found in sample/Processed.');
    process.exit(0);
  }

  let ok = 0, bad = 0;
  const failures = [];
  for (const f of files) {
    if (parsesClean(f)) ok++; else { bad++; failures.push(path.basename(f)); }
  }

  console.log(`Parsed ${files.length} files. Clean: ${ok}, With errors: ${bad}`);
  if (failures.length) {
    console.log('First 20 failures:');
    for (const f of failures.slice(0, 20)) console.log(' - ' + f);
  }

  process.exitCode = failures.length ? 1 : 0;
}

if (require.main === module) main();

