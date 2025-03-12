import fs from 'fs';

// Ensure dist directory exists
if (!fs.existsSync('dist')) {
    fs.mkdirSync('dist');
}

// Read the ESM version
const esmCode = fs.readFileSync('index.js', 'utf8');

// Write ESM version to dist
fs.writeFileSync('dist/index.js', esmCode);

// Create CommonJS version
const cjsCode = `// duration-parser CommonJS version
const parser = ${esmCode.split('const parser =')[1].split('export const')[0]}

parser.parse.SyntaxError = parser.SyntaxError;
const durationParser = parser.parse.bind(parser);
const parseDuration = durationParser;

module.exports = {
    durationParser,
    parseDuration
};`;

// Write CommonJS version
fs.writeFileSync('dist/index.cjs', cjsCode);

console.log('Built ESM and CommonJS versions successfully!');