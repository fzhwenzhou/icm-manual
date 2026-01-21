## Chapter 3
# Combinators
Combinators are the basic components. In the view of ICM, combinators are stored in Redex Registers. The combinations of several combinators may form Redexes, and are able to perform reduction operations. This is the basic way how ICM computes. There are in total six categories of combinators. The first are core combinators. These combinators are wholely derived from 97IC. The second are numerical combinators, mainly for basic integer storage and operations. The third are switch combinators, which perform selecting operations between different selections. These are similar to branches in traditional architectures. The fourth are bookkeeping combinators. These combinators are mainly for load balancing between different Redex Execution Units, and for safety purposes. The fifth are dense combinators, mainly for dense operations. The last are I/O combinators, account for input and output operations. While the first set can be Turing complete, the next few sets make 97IC useful and outstanding.  

The Metadata Section 0x0000 is reserved for special purposes.

## 3.1 Core Combinators
### Combinators
The core combinators set only has three combinators: CON (Constructor), DUP (Duplicator), and ERA (Eraser). These three combinators all come from the IC97<sup>1</sup> standard. Either CON or DUP has one Main Port and two Auxiliary Ports. ERA has only one Main Port and no Auxiliary Port. The functions of these three combinators are well defined in the paper. Please refer to the bibliography section to get more information about these combinators.

The following is the metadata section of these three combinators:

| Metadata Encoding   | Type |
|:-------------------:|:----:|
| 0x0001              | CON  |
| 0x0002              | DUP  |
| 0x0003              | ERA  |

Table 1. Core Combinators

### Reduction Rules
The reduction rules are all from the IC97<sup>1</sup> standard. Please refer to the bibliography section to get more information about these reduction rules. The implementation should strictly follow the rules in the original paper. Note that, here, the ERA combinator can not only erase the two binary combinators, but any other binary combinators.

## 3.2 Numerical Combinators
### Combinators
The numerical combinators are for variables and basic integer operations. These combinators can perform calculations as reductions. Firstly, combinators with only Main Ports are defined to represent different numbers. Next, combinators with two Auxiliary Ports are defined as basic operators. Finally, a combinator with only one Auxiliary Port, VAR, is defined to identify a variable. On the Auxiliary Port of this combinator, there could be a single number, or a tree. This is the way ICM identifying variables. Despite its name being variable, it is immutable, which is the common thing in most functional programming languages.

The following combinators are defined to store different types of integer numbers:

| Metadata Encoding   | Sub-Type |    Explanation    |
|:-------------------:|:--------:|:-----------------:|
| 0x0004              |    u8    |   8-bit Integer   |
| 0x0005              |    u16   |   16-bit Integer  |
| 0x0006              |    u32   |   32-bit Integer  |
| 0x0007              |    u64   |   64-bit Integer (for ICM32 and above) |
| 0x0008              |    u128  |   128-bit Integer (for ICM64 and above) |
Table 2. Number Combinators

Note that the metadata only identifies the length of the numerical value. It does not determine whether the number is signed or unsigned. Instead, the operators will determine how to operate with them (whether signed or unsigned). Each integer should start at the `XLEN-1` position of the first Data section. If there are left spaces in the Data section, they are simply ignored in the execution stages. However, it is recommended to set the spaces all zero in the programs. For u64 and u128, if the metadata section is used for architectures that do not support them, the processor will throw "Invalid Metadata Section."

The following combinators are defined for basic integer arithmetics: 

| Metadata Encoding   | Sub-Type |    Explanation    |
|:-------------------:|:--------:|:-----------------:|
| 0x0009              |   ADD    |   Integer Addition |
| 0x000A              |   SUB    | Integer Subtraction|
| 0x000B              |   EQ     | Equals             |
| 0x000C              |   NEQ    | Not Equals         |
| 0x000D              |   LT     | Less Than       |
| 0x000E              |   LE     | Less Than or Equals|
| 0x000F              |   AND    | Bitwise And        |
| 0x0010              |   OR     | Bitwise Or         |
| 0x0011              |   XOR    | Bitwise Xor        |
| 0x0012              |   SLL    | Shift Left         |
| 0x0013              |   SRL    | Logical Shift Right|
| 0x0014              |   SRA    | Arithmetic Shift Right|
Table 3. Operator Combinators

These operations are all binary operations that are easy to implement, and can finish reduction in a single clock cycle. These construct all the basic set of operations, and any other arithmetic operations (MUL, DIV, etc.) can be simulated with the combinations of the above operations. However, in order to perform other arithmetic operations efficiently, they should be implemented as seperate Dense Combinators.


### Reduction Rules
The reduction rules follows the operators. If one operator, whose two Auxiliary Ports are all connected with number combinators, they together can form a Redex and can be reduced. The reduction operations are defined in the table above. The first operand of the operator is connected to the first Auxiliary Port, while the second operand of the operator is connected to the second Auxiliary Port. The reduction result should be a number combinator, storing the final result of the arithmetic operations. When the two operands are of different integer length, the result would be the one with the greatest integer length. 

## 3.3 Control Combinators
### Combinators
There is only one combinator in this category: SWI. This combinator is for selecting a specific branch with a specific condition. It also has two Auxiliary Ports. The first one is required to connect to the Main Port a CON combinator, while the second one is required to connect to a number combinator. The Metadata encoding for this only combinator is: 0x0015.

### Reduction Rules
The reduction rule is simple: If the second Auxiliary Port the combinator connected to is not 0 (boolean true), it will be reduced to the subtree connecting to the first Auxiliary Port of the CON combinator. If it is 0 (boolean false), it will be reduced to the subtree connecting to the second Auxiliary Port of the CON combinator. This provides a simple and straightforward way to create a branch on ICM, like traditional architectures. It can also be useful for building infinite loops.

## 3.4 Bookkeeping Combinators
This part is still under investigation. 
*Placeholder*

## 3.5 Dense Combinators
### Combinators
There is only one category of Dense Combinators: VCON. The specific Metadata Section is defined by specific Dense Module. Starting from 0x20, all encodable Metadata Section can be used to encode Dense Combinators. Most Dense Combinators should define new operations, while some can be used for defining new number combinators (if the standard number combinators are not large enough to contain the data being processed).

### Reduction Rules
The reduction rules are wholely defined by the specific Dense Modules. Some standard Dense Modules are defined in Chapter 5. If one Metadata value is not used by the standard Dense Modules nor reserved, it can be used for customized extensions. 

Usually, Dense operations cannot finish in one clock cycle. In that case, it can adopt the strategy as I/O combinators to block the execution. When the Dense Module finishes its operations, the Redex should finally finish its reduction process.

## 3.6 I/O Combinators
### 3.6.1 REF Type
This part is still under investigation.

### 3.6.2 DREF Type
This part is still under investigation.
*Placeholder*
\newpage