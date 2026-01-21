## Chapter 5
# Standard Dense Modules
This chapter mainly discusses about the standard Dense Modules. These modules are typically widely used in common use, including integer multiplications (and division, modulo arithmetics), floating point operations, vector operations, and matrix operations. In the future, there would be extended bit operations, cryptographic operations, etc. Metadata value below 0x1000 are all reserved for standard dense modules. These operations are either much more complex (for example, cannot be finished in one clock cycle), or not so common to put it into the Numerical Combinators. 

## 5.1 M - Integer Multiplication Module
This module defines combinators that are capable for performing integer multiplications, divisions, and modulo operations. While the iterative way is acceptable, it is recommended to implement the multiplication process as a single-cycle operation. These combinators all have two Auxiliary Ports, with the combinator connecting to the first Auxiliary Port the first operand, and the combinator connecting to the second Auxiliary Port the second operand. 

The following combinators are defined for integer multiplication arithmetics: 

| Metadata Encoding   | Sub-Type |    Explanation    |
|:-------------------:|:--------:|:-----------------:|
| 0x0020              |   MUL    | Signed Multiplication|
| 0x0021              |   MULU   | Unsigned Multiplication|
| 0x0022              |   DIV    | Signed Division        |
| 0x0023              |   DIVU   | Unsigned Division      |
| 0x0024              |   MOD    | Signed Remainder       |
| 0x0025              |   MODU   | Unsigned Remainder     |
Table 1. Integer Multiplication Combinators

If one operator, whose two Auxiliary Ports are all connected with number combinators, they together form a Redex and can be reduced. The results should be identical to the C language model. When the two operands are of different integer length, the result would be the one with the greatest integer length. Whether the operands are signed or unsigned is not determined by the number combinators, but by the operators themselves. 

## 5.2 F - Floating Point Module

### 5.2.1 F32 - IEEE 754 32-bit Floating Point

### 5.2.2 F64 - IEEE 754 64-bit Floating Point

### 5.2.3 F16 - IEEE 754 16-bit Floating Point

## 5.3 V - Vector Module

### 5.3.1 Vs - Small Vectors

### 5.3.2 Vl - Large Vectors

## 5.4 Ma - Matrix Module

### 5.4.1 Mas - Small Matrices

### 5.4.2 Mal - Large Matrices

\newpage