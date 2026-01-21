## Appendix I
# Metadata Table
This is a fast reference table for different encodings of the Metadata sections of the Redex Registers. To see the detailed explanations of these combinators, see *Chapter 3*.

| Metadata Encoding | Type | Sub-Type |    Explanation       |
|:-----------------:|:----:|:--------:|:--------------------:|
| 0x0001              | CON  |    N/A   |   97IC Constructor   |
| 0x0002              | DUP  |    N/A   |   97IC Duplicator    |
| 0x0003              | ERA  |    N/A   |   97IC Eraser        |
| 0x0004              | NUM  |    u8    |   8-bit Integer   |
| 0x0005              | NUM  |    u16   |   16-bit Integer  |
| 0x0006              | NUM  |    u32   |   32-bit Integer  |
| 0x0007              | NUM  |    u64   |   64-bit Integer (for ICM32 and above) |
| 0x0008              | NUM  |    u128  |   128-bit Integer (for ICM64 and above) |
| 0x0009              | OPR  |   ADD    |   Integer Addition |
| 0x000A              | OPR  |   SUB    | Integer Subtraction|
| 0x000B              | OPR  |   EQ     | Equals             |
| 0x000C              | OPR  |   NEQ    | Not Equals         |
| 0x000D              | OPR  |   LT     | Less Than       |
| 0x000E              | OPR  |   LE     | Less Than or Equals|
| 0x000F              | OPR  |   AND    | Bitwise And        |
| 0x0010              | OPR  |   OR     | Bitwise Or         |
| 0x0011              | OPR  |   XOR    | Bitwise Xor        |
| 0x0012              | OPR  |   SLL    | Shift Left         |
| 0x0013              | OPR  |   SRL    | Logical Shift Right|
| 0x0014              | OPR  |   SRA    | Arithmetic Shift Right|
| 0x0015              | SWI  |   N/A    | Switch            |
| 0x0016              | FAN  |   N/A    | Reserved          |
| 0x0017              | BRA  |   N/A    | Reserved          |
| 0x0018              | REF  |   N/A    | Reserved          |
| 0x0019              | DREF |   N/A    | Reserved          |
| 0x0020              | VCON |   MUL    | Signed Multiplication|
| 0x0021              | VCON |   MULU   | Unsigned Multiplication|
| 0x0022              | VCON |   DIV    | Signed Division        |
| 0x0023              | VCON |   DIVU   | Unsigned Division      |
| 0x0024              | VCON |   MOD    | Signed Remainder       |
| 0x0025              | VCON |   MODU   | Unsigned Remainder     |
Table 1. Metadata Table
\newpage