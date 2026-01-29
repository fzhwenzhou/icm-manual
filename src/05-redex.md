## Chapter 3
# Redex Execution Unit
Redex Execution Units are the basic execution units for ICM architecture. Any ICM processor, regardless of its type, should have at least one Redex Execution Unit. 

A Redex Execution Unit should have the following components: Redex Registers, SRAM, Redex Executors, and Communicator. Each Redex Register is supposed to store a single combinator in the format below. SRAM is able to store the rest combinators that do not construct Redexes. Redex Executors are able to identify the Redexes constructed in the Redex Execution Unit and execute the reduction rules. Finally, Communicators are able to send and receive the contents of the Redex Registers to the adjacent Redex Execution Unit to solve the issue of remote Redexes. 

Only the register layout is defined in the following contents. The register length is defined by a constant `XLEN`, which is commonly 16, 32, or 64 (Other numbers like 8 and 128 can also be used but not common). To identify an architecture with a specific `XLEN`, one can add the length after ICM like ICM16, ICM32, or ICM64. Others, including the number of registers in a single unit, the SRAM size, and the number of lanes for a communicator, are all up to the implementers as they are handled by the micro-architecture, and does not affect the programs. It is up to the implementer whether to use ring-based, matrix-based, matrix-based with diagonal, or even cube-based communication lanes.

## 3.1 Basic Register Layout
The basic register layout is as follows, representing a common three-port register:
```
XLEN-1           0
|   Metadata     |
|   Main Port    |
| Auxiliary Port |
| Auxiliary Port |
```
The register is shown as a four-element tuple, with each as a length of `XLEN`. The first element is the Metadata of the register, which usually represents the type of the combinator, and for some combinators, it also represents the data type. The second element is the Main Port of the combinator. It stores the absolute address of the Redex Register that it is connecting to. The next to elements are the Auxiliary Ports of the combinator and stores the absolute address of the Redex Register if it is a three-port register. The absolute address is an `XLEN` bit length address fixed for each Redex Register. A controller is used for multi-processor interconnection and address mapping to prevent address conflict between different devices. The mapping algorithm is not specified and can be defined by the controller itself. 

Sometimes the combinator only has a single main port and no auxiliary port (for example, the eraser). In that case, the auxiliary port section is reserved and not used for any other purposed. In the program, this section can be simply skipped to save the space. The layout therefore is as follows:
```
XLEN-1           0
|   Metadata     |
|   Principal Port    |
|    Reserved    |
|    Reserved    |
```

## 3.2 Variants
The basic register layout can fully represent the core combinators. However, it is far inefficient for most of the combinators and extensions, especially for those storing data. Also, it will sometimes cause the resource waste. The following variants can be implemented by implementers if needed.

The first variant is for erasers. Since keeping the reserved zones in the architecture may waste the hardware resources, implementers can define some registers as two-element pairs. These pairs only have Metadata and Main Port zones, therefore cutting the size of registers needed into half. Like the standard registers, the number of these "compressed" registers are also not specified, so it is up to the implementer whether to put these compressed registers into Redex Execution Units and how many. The format is as follows:
```
XLEN-1           0
|   Metadata     |
|   Principal Port    |
```
The next variant is for storing data including numbers and vectors. Since the Auxiliary Ports are not used for data combinators (as they only have Main Ports), these parts can be used to store data. The maximum length of data a single register can store is `XLEN * 2` bits. The `XLEN-1` position of the second data register should directly follow the `0` position of the first data register to combine them into a larger register. For example, 32-bit ICM can store and process at most 64-bit integers and floating point numbers if not using extensions and other data structures. 

Any data should start at the `XLEN-1` position of the first data register, regardless of its length or type. For integer numbers, they are stored into the data section in the Little-endian order. For floating point numbers, the sign bit should start at the `XLEN-1` position of the first data register. For vectors, the minimum size of a single element is one byte and the maximum size is `XLEN` bits. They are also ordered from the MSB to the LSB in both data registers. For small matrices, the order of elements follow the vectors, and they are all row-majored. 

```
XLEN-1           0
|   Metadata     |
|   Principal Port    |
|      Data      |
|      Data      |
```

Some operations (for example, fused-multiply-add) may have more than two operands. Commonly, it can be achieved by combining two specific combinators and define special operations. However, the implementers can also define some combinators with more than two auxiliary ports. In this case, the standard specifies a special type of combinator which provides three Auxiliary Ports that supports these types of operations. The layout is as follows:

```
XLEN-1           0
|   Metadata     |
|   Principal Port    |
| Auxiliary Port |
| Auxiliary Port |
| Auxiliary Port |
```

Similarly, more Auxiliary Ports can be added. One can also extend the data section of the data combinators in the same way. These are all implementation defined, and can vary between different implementers. However, ICM standard only ensures that zero or two Auxiliary Ports should work in the architecture. Other types are not ensured by the standard, and they should ensure their own compilers and operating systems can handle these conditions well.

\newpage