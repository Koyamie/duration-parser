import { readFileSync, writeFileSync } from 'node:fs';
import { dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

import peggy from 'peggy';

const __dirname = dirname(fileURLToPath(import.meta.url));

const pkg = JSON.parse(readFileSync(__dirname + '/package.json', 'utf-8'));

const grammar = readFileSync(__dirname + '/grammar.pegjs', 'utf-8');

const parser = peggy.generate(grammar, {output: 'source'});

writeFileSync(__dirname + '/index.js',
  '// duration-parser ' + pkg.version + '\n' +
  '// ' + pkg.homepage + '\n\n' +
  'const parser = ' + parser + ';\n\n' +
  'parser.parse.SyntaxError = parser.SyntaxError;\n' +
  'export const durationParser = parser.parse.bind(parser);\n'
  ,
  'utf-8'
);

console.log('built version: ' + pkg.version);