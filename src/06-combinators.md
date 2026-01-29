## Chapter 4
# Combinators
Combinators are the basic components. In the view of ICM, combinators are stored in Redex Registers. The combinations of several combinators may form Redexes, and are able to perform reduction operations. This is the basic way how ICM computes. There are in total six categories of combinators. The first are core combinators. These combinators are mainly derived from 97IC<sup>1</sup> and SIC<sup>2</sup>. The second are numerical combinators, mainly for basic integer storage and operations. The third are switch combinators, which perform selecting operations between different selections, usually for implementing branch operations. The fourth are bookkeeping combinators. These combinators are mainly for load balancing between different Redex Execution Units, and for safety purposes. The fifth are dense combinators, mainly for dense operations. The last are I/O combinators, account for input and output operations. While the first set can be Turing complete, the next few sets make ICM useful and outstanding.  

The Metadata Section 0x0000 is reserved for special purposes.

## 4.1 Core Combinators
### Combinators
The core combinators set has only four combinators: CON (Constructor), DUP (Duplicator), ERA (Eraser), and VAR (Variable). The first three combinators are originally from the IC97<sup>1</sup>. Either CON or DUP has one Principal Port and two Auxiliary Ports. ERA has only one Principal Port and no Auxiliary Port. The functions of these three combinators, however, are identical to the SIC<sup>2</sup> for simplicity. Please refer to the bibliography section to get more information about these combinators.

For the last combinator VAR, it is introduced from HVM2<sup>3</sup> to represent the connections between Auxiliary Ports and Auxiliary Ports in order to represent an Interaction Net easier.

The following is the metadata section of these four combinators:

| Metadata Encoding   | Type |
|:-------------------:|:----:|
| 0x0001              | CON  |
| 0x0002              | DUP  |
| 0x0003              | ERA  |
| 0x0004              | VAR  |

Table 1. Core Combinators

### Reduction Rules
The reduction rules are all from the SIC<sup>2</sup> and HVM2<sup>3</sup> standard. Please refer to the bibliography section to get more information about these reduction rules. The implementation should strictly follow the rules in the original paper. Note that, here, the ERA combinator can not only erase the two binary combinators, but any other binary combinators.

Here is a table briefly showing the reduction rules utilized.

| A\\B | CON | DUP | ERA | VAR |
|------|-----|-----|-----|-----|
|CON   |ANNI |COMM |ERAS |LINK |
|DUP   |COMM |ANNI |ERAS |LINK |
|ERA   |ERAS |ERAS |VOID |LINK |
|VAR   |LINK |LINK |LINK |LINK |

Table 2. Reduction Rules for Core Combinators

Implementing all the combinators and reduction rules in this section will result in a Turing-complete machine (even omitting the VAR combinator, if needed in extreme conditions). However, the efficiency is low in gereral-purpose computing.

## 4.2 Numerical Combinators
### Combinators
These combinators are proposed in order to accelerate numerical operations. There are in total two combinators in this category: NUM and OPR. The NUM combinator is used for storing numerical values. It is a nullary combinator, so the Auxiliary Ports sections of the Redex Register are not used as wires to other ports. Instead, they are used as numerical registers to store number values. The OPR combinator is used for executing arithmetic operations.

There are three types of values that can be stored in a NUM combinator. The format is UNSPECIFIED and is proposed in the extension part.

1. LIT: Literals. Type information is indicated.
2. SYM: Symbols. They are operators in arithmetic.
3. PAR: Literals with partially applied symbols. These are intermediate results of arithmetic operations.

The following is the metadata section of these two combinators:

| Metadata Encoding   | Type |
|:-------------------:|:----:|
| 0x0005              | NUM  |
| 0x0006              | OPR  |

Table 3. Numerical Combinators

### Reduction Rules
The following table shows the reduction rules for these two combinators:

| A\\B | NUM | OPR |
|------|-----|-----|
|NUM   |VOID |OPER |
|OPR   |OPER |ANNI |

Table 4. Reduction Rules for Numerical Combinators

Where the OPER reduction rule is defined as follows:

1. `NUM(N) ~ OPR(NUM(M), A) => OP(N, M) ~ A`
2. `NUM(N) ~ OPR(A, B) => A ~ OPR(NUM(N), B)`

Here, `OP(N, M)` denotes the processing results. Valid OPs should be one of the followings:

1. `OP(SYM, LIT)`: Applying the symbol to the numeral partially, yielding a partially applied literal.
2. `OP(PAR, LIT)`: Combining the partially applied numeral and the literal to finish a calculation. 

"Rotation" operation is done in (2) to prevent blocking by swapping the number and the other branch containing operators. Necessary change in the direction of the operator is needed if the order of the operands matters (like subtraction and division). This may be implemented by setting a tag in the operand field or implement a reverse operand. In this place, the second reduction rule should be rewritten as:

`NUM(N) ~ OPR(A, B) => A ~ OPR'(NUM(N), B)`

## 4.3 Control Combinators
### Combinators
There is only one combinator in this set: SWI. This combinator are defined to combine numerical values and control flow structures. Without this combinator, numbers cannot affect the control flows. 

SWI is a binary combinator that can be reduced to different subnets regarding to the property of the numerical value N. It is from the HVM2<sup>3</sup> and implementers should follow the details in HVM2. The metadata encoding for this operator should be 0x0007. 

### Reduction Rules
The following table shows the reduction rules regarding to the SWI combinator and other numerical combinators:

| A\\B | NUM | OPR | SWI |
|------|-----|-----|-----|
|NUM   |VOID |OPER |SWIT |
|OPR   |OPER |ANNI |COMM |
|SWI   |SWIT |COMM | ANNI|

Table 5. Reduction Rules for SWI

The reduction rule for SWIT is as defined as follows:

The reduction will be triggered if `NUM(N) ~ SWI(A, B)`.

IF `PREDICATE(NUM(N))` then it will be reduced to `A ~ CON(*, B)`. Otherwise, it will be reduced to `A ~ CON(*, CON(NUM(OPERATOR(N)), B))`

Here, PREDICATE is a function taking a numerical value and returning a boolean value. OPERATOR is a function taking a numerical value and returning a numerical value. These can be defined by implementers and indicated in the metadata section. In HVM2, PREDICATE is defined as `N = 0`, and OPERATOR is defined as `N - 1`. Implementers are required to implement these two functions, and other variants are free for them to define.


## 4.4 Bookkeeping Combinators
### Combinators
Bookkeeping combinators are not for adding functionarities to computations, but rather optimizing the existing computation steps. These combinators ensure the correctness and efficiency of the reduction steps. Here, the correctness indicates that all the Lambda closures should be evaluated, while the efficiency indicates that the reduction count should be minimal. 

There is only one combinator that is required to be implemented in this category: FAN. This combinator is a colored variant of DUP. The metadata section should be 0x0008.

In order to perform reductions efficiently and in the optimized way, another combinator can be also introduced: BRA (Bracket). The metadata section should be 0x0009. By combining these two combinators, Lamping algorithm can be directly adopted for bookkeeping.

### Reduction Rules
*Placeholder*

## 4.5 Dense Combinators
### Combinators
Dense Combinators are for representing traditional data structures, including arrays, efficiently. There is only one combinator in this category: VCON (Vector Constructor). This combinator is used for constructing vectors (a data structure with multiple numerical elements). The underlying representation of vectors (whether they are arrays, trees, or linked-lists) depends on the context and implementation. VCON can be either a binary node or a nullary node depending on the context. The internal structure of VCON should be simple, that is, only containing NUMs and VCONs.

A VCON combinator can be encapsulated by MERGE (can be seen as a type of OPR) on NUMs and VCONs. Two NUMs, two VCONs, or one NUM and one VCON can be merged into a single VCON combinator. Also, it can be decapsulated by CON. The layout of a VCON combinator can be array or tree, which should be indicated in the metadata section of the register. The decapsulation process depends on the internal structure of the VCON. If the VCON is a tree node, it will return two sub-tree nodes as VCON and/or NUM. If the VCON is an array, it will return two subarrays divided equally. It is UNSPECIFIED how to divide the array if the number of elements is odd.

The metadata section of VCON is 0x0010.

### Reduction Rules
The following table presents the VCON combinator along with others:

| A\\B | NUM | OPR | SWI | VCON |
|------|-----|-----|-----|------|
|NUM   |VOID |OPER |SWIT | VOID |
|OPR   |OPER |ANNI |COMM | OPER |
|SWI   |SWIT |COMM | ANNI| UNSPECIFIED|
|VCON  |VOID |OPER |UNSPECIFIED|VOID|

Table 6. Reduction Rules for VCON

If the architecture includes VCON, the reduction rule OPER should be changed to the following:

1. `NUM_T(N) ~ OPR(NUM_T(M), A) => OP(N, M) ~ A`
2. `NUM_T(N) ~ OPR(A, B) => A ~ OPR(NUM_T(N), B)`

Here, `NUM_T` can be either `NUM` or `VCON`. Therefore, `VCON` functions as a nullary combinator in `OPR`, which is identical to numerical values.

## 4.6 I/O Combinators
### 4.6.1 General I/O Combinators
General I/O combinators are for introducing "impurity" to the interaction net. These are essential for interacting with the outside world and can process outside events independently without an external controller or scheduler.

There is one combinator essential for I/O operations: IO. The metadata section of it is 0x0011. It is a nullary combinator mainly for data transmission and other impure purposes. Usually, an IO combinator can have the following properties:

1. Linear and shareable.
2. Simplex or Half-duplex.
3. Other properties that might be identified in the metadata section, including whether it can pass through other I/Os, disposable, etc.

#### Reduction Rules
While the IO combinator itself can have plenty semantics, the most important things are the interactions of the IO combinator with other combinators. 

The following are the basic reduction rules for IO combinators (PN is the short for Principal Net):

1. `OPR(C, PN) ~ IO => C ~ IO`: TXD semantic. IO swallows a normal form and send it out.
2. `CON ~ IO => PN`: RXD semantic. IO receives the data and converts it to a normal form.
3. `DUP(A, B) ~ IO => A ~ PN, B ~ PN`: Duplication semantic. Duplicate the IO combinator into two same Principal Nets. If the IO is not duplicatable, the result is UNSPECIFIED and depends on the implementer.
4. `MERGE(C, IO_1) ~ IO_2 => C ~ IO_1 | IO_2`: Multiplexing semantic. Used for constructing multiplexers.
5. `IO_1 ~ IO_2`: Usually it will create a pipe between two IO combinators. However, the exact operation is UNSPECIFIED and should be defined by the implementer.

### 4.6.2 REF Type
REF is a type of I/O combinator that is shareable, crossable, and disposable. There are two sub-types of this combinator: REF-H and REF-S. REF-H points to a serialized data which is possibly external. It uses the RXD semantic to point to its Principal Net. REF-S is a multiplexing half-duplex pipe. The referring side uses RXD semantic to get data and eliminate itself. The referred side uses TXD semantic to duplicate and transfer the data to the referring side.

### 4.6.3 DREF Type
DREF is a type of I/O combinator that is used for representing hardware handles. For example, CSR (Control and Status Register), main memory, and external hardware, etc. Normally, this combinator cannot get through pipes and other DREFs, and is usually linear. The behavior should be defined by the hardware manual.

\newpage