#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const Parser = require('tree-sitter');
const COBOL = require('../bindings/node');

const SAMPLE_DIR = path.join(__dirname, '..', 'sample', 'Processed');

function listFiles(dir) {
  return fs.readdirSync(dir)
    .filter(f => /\.(cbl|txt)$/i.test(f))
    .map(f => path.join(dir, f))
    .sort();
}

function main() {
  const parser = new Parser();
  parser.setLanguage(COBOL);

  const files = listFiles(SAMPLE_DIR);
  if (files.length === 0) {
    console.log('No sample files found in sample/Processed.');
    process.exit(0);
  }

  let ok = 0;
  let bad = 0;
  const failures = [];

  console.log(`Parsing ${files.length} samples from sample/Processed...`);

  for (const file of files) {
    const src = fs.readFileSync(file, 'utf8');
    try {
      const tree = parser.parse(src);
      const hasError = tree.rootNode.hasError();
      if (hasError) {
        bad++;
        failures.push(file);
      } else {
        ok++;
      }
    } catch (e) {
      bad++;
      failures.push(file + ' (exception: ' + e.message + ')');
    }
  }

  console.log(`\nResult: ${ok} parsed cleanly, ${bad} with errors.`);
  if (failures.length) {
    console.log('\nFiles with parse errors:');
    for (const f of failures.slice(0, 20)) {
      console.log(' - ' + path.basename(f));
    }
    if (failures.length > 20) {
      console.log(` ... and ${failures.length - 20} more`);
    }
    process.exitCode = 1;
  }
}

if (require.main === module) {
  main();
}

