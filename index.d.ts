declare module 'duration-parser' {
  export type Parser = (input: string) => number;
  export const durationParser: Parser;
}
