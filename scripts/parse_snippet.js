#!/usr/bin/env node
const Parser = require('tree-sitter');
const COBOL = require('../bindings/node');

const src = `
       identification division.
       program-id. a.
       procedure division.
       evaluate 1
       when 1
         go to aa
       end-evaluate.
       aa.
`;

const parser = new Parser();
parser.setLanguage(COBOL);

const tree = parser.parse(src);
console.log(tree.rootNode.toString());

