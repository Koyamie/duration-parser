import fs from 'fs';

// Ensure dist directory exists
if (!fs.existsSync('dist')) {
    fs.mkdirSync('dist');
}

// Read the original code
const originalCode = fs.readFileSync('index.js', 'utf8');

// Extract the parser definition
const parserCode = originalCode.split('const parser =')[1].split('export const')[0];

// Create ESM version with proper named exports
const esmCode = `// duration-parser ESM version
const parser = ${parserCode}

parser.parse.SyntaxError = parser.SyntaxError;
const durationParser = parser.parse.bind(parser);
const parseDuration = durationParser;

export { durationParser, parseDuration };
export default { durationParser, parseDuration };`;

// Create CommonJS version
const cjsCode = `// duration-parser CommonJS version
const parser = ${parserCode}

parser.parse.SyntaxError = parser.SyntaxError;
const durationParser = parser.parse.bind(parser);
const parseDuration = durationParser;

module.exports = { durationParser, parseDuration };
module.exports.default = { durationParser, parseDuration };`;

// Write both versions
fs.writeFileSync('dist/index.js', esmCode);
fs.writeFileSync('dist/index.cjs', cjsCode);

console.log('Built ESM and CommonJS versions successfully!');