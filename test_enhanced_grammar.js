#!/usr/bin/env node

const Parser = require('tree-sitter');
const COBOL = require('./bindings/node');

const parser = new Parser();
parser.setLanguage(COBOL);

// Test cases for enhanced COBOL grammar
const testCases = [
  {
    name: "Enhanced CORRESPONDING support",
    code: `
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-CORRESPONDING.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 GROUP-1.
          05 FIELD-A PIC X(10).
          05 FIELD-B PIC 9(5).
       01 GROUP-2.
          05 FIELD-A PIC X(10).
          05 FIELD-B PIC 9(5).
       PROCEDURE DIVISION.
       MAIN-PARA.
           ADD CORRESPONDING GROUP-1 TO GROUP-2.
           SUBTRACT CORRESPONDING GROUP-2 FROM GROUP-1.
           MOVE CORRESPONDING GROUP-1 TO GROUP-2.
    `
  },
  {
    name: "EVALUATE statement",
    code: `
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-EVALUATE.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 TEST-VAR PIC 9.
       PROCEDURE DIVISION.
       MAIN-PARA.
           EVALUATE TEST-VAR
               WHEN 1
                   DISPLAY 'One'
               WHEN 2
                   DISPLAY 'Two'
               WHEN OTHER
                   DISPLAY 'Other'
           END-EVALUATE.
    `
  },
  {
    name: "IF statement with enhanced syntax",
    code: `
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-IF.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 TEST-VAR PIC 9.
       PROCEDURE DIVISION.
       MAIN-PARA.
           IF TEST-VAR = 1 THEN
               DISPLAY 'Equal to one'
           ELSE
               DISPLAY 'Not equal to one'
           END-IF.
    `
  },
  {
    name: "EXEC SQL statement",
    code: `
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-SQL.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 EMPLOYEE-ID PIC 9(5).
       PROCEDURE DIVISION.
       MAIN-PARA.
           EXEC SQL
               SELECT EMPLOYEE_ID
               INTO :EMPLOYEE-ID
               FROM EMPLOYEE
               WHERE EMPLOYEE_NAME = 'SMITH'
           END-EXEC.
    `
  },
  {
    name: "Line continuation support",
    code: `
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-CONTINUATION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 VERY-LONG-VARIABLE-NAME-THAT-CONTINUES
-         -ON-NEXT-LINE PIC X(50) VALUE "TEST-
-    "CONTINUATION".
       PROCEDURE DIVISION.
       MAIN-PARA.
           DISPLAY VERY-LONG-VARIABLE-NAME-THAT-CONTINUES
-         -ON-NEXT-LINE.
    `
  },
  {
    name: "Enhanced PICTURE patterns",
    code: `
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-PICTURE.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 VARIOUS-PICTURES.
          05 EDITED-FIELD  PIC $,$$$,$$9.99.
          05 SIGNED-FIELD  PIC S9(5)V99 COMP-3.
          05 TEXT-FIELD    PIC X(10) VALUE "HELLO".
          05 SPECIAL-FIELD PIC A(5)BBBB9(3).
    `
  }
];

function runTests() {
  let passed = 0;
  let failed = 0;

  console.log('🧪 Testing Enhanced COBOL Grammar\n');

  testCases.forEach((testCase, index) => {
    console.log(`📋 Test ${index + 1}: ${testCase.name}`);
    
    try {
      const tree = parser.parse(testCase.code);
      
      if (tree.rootNode.hasError()) {
        console.log('❌ FAILED - Parse errors found');
        console.log('Errors:', findErrors(tree.rootNode));
        failed++;
      } else {
        console.log('✅ PASSED - No parse errors');
        passed++;
      }
    } catch (error) {
      console.log('❌ FAILED - Exception:', error.message);
      failed++;
    }
    
    console.log('');
  });

  console.log(`📊 Results: ${passed} passed, ${failed} failed`);
  
  if (failed === 0) {
    console.log('🎉 All tests passed! Grammar enhancements working correctly.');
  } else {
    console.log(`⚠️  ${failed} test(s) failed. Grammar needs more work.`);
  }
}

function findErrors(node) {
  const errors = [];
  
  if (node.hasError()) {
    if (node.type === 'ERROR') {
      errors.push({
        type: 'ERROR',
        text: node.text,
        startPosition: node.startPosition,
        endPosition: node.endPosition
      });
    }
    
    for (let i = 0; i < node.childCount; i++) {
      errors.push(...findErrors(node.child(i)));
    }
  }
  
  return errors;
}

if (require.main === module) {
  runTests();
}

module.exports = { runTests }; 