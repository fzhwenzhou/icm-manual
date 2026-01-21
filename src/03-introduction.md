## Chapter 1
# Introduction
ICM is a new general computing machine that is designed to be distinguished from the traditional Von Neumann model. It utilizes Interaction Combinators to simplify the hardware design and provide massive parallel capacity. Our goals of defining this machine are:

- A completely open and free architecture for both academic and industry.
- A real architecture that is suitable for hardware implementation, not for only simulation.
- A flexible architecture that is suitable for any applications from embedded systems to computing clusters.
- A parallel architecture that can parallelize anything that can be parallelized automatically.
- Supports multiple floating point standards, including IEEE 754-2008, Intel x87 FP80, FP8, and FP4, for both scientific and machine learning tasks.
- A fully virtualizable architecture with hypervisor support.

## 1.1 ICM Hardware Platform Terminology
An *ICM hardware platform* can contain one or more ICM processors together with other components, including fixed-function accelerators, various physical-memory architectures, I/O devices, and interconnecting facilities. 

A component is called a *combinator* if it has a type and one or more ports. A component is called a *Redex (Short for Red Expression)* if it is a set of combinators that fits for at least one reduction rule and can be reduced. A component is called a *Redex Execution Unit* if it is the smallest component of storing and executing combinators and Redex. 

An *ICM processor* is a type of processor that includes one or more Redex Execution Units. It can also optionally have other controllers.

An *accelerator* is a type of processor that is not a part of an ICM processor. It is usually a non-programmable fixed-function unit or a core that can operate autonomously but is specialized for certain tasks.

## 1.2 ICM Software Execution Environments
An ICM program is usually a program written in functional-programming languages that are compiled into ICM combinators. The behavior of an ICM program depends on the executing environment it runs on. On each executing environments, ICM programs are expected to perform specific behaviors. Examples of the running environment includes the following:

- "Bare metal" hardware platforms. The programs directly run on an ICM hardware platform without runtime interception or operating systems. Therefore, the program itself should take care of all resource management, I/O management, and handle all the exceptions. The programs can utilize all the resources the hardware has and are the most efficient ones. 
- ICM operating systems. The programs run on a managed environment by operating systems. The program itself does not need to worry about resources and exceptions; instead, the operating system will allocate sufficient amount of resources and handle exceptions for it. 
- ICM emulators. The programs run on an ICM emulator, which is usually on a traditional architecture. Therefore, some features of traditional architectures can be used as dense combinators or I/O combinators to achieve the best performance. ICM emulators will yield the worst performance among the three, so it should only be used for experimental purposes. 

## 1.3 ICM Architecture Overview
The ICM architecture is defined as a set of combinators and reduction operations. With 97IC<sup>1</sup> as the basic set, it provides a minimal Turing-complete architecture that can execute any operations. Any implementation should follow the basic set. By extending the basic set with other standard combinators or other customized extensions, it can perform much more tasks efficiently. The basic unit for this architecture is Redex Execution Unit, which is the place to store and process combinators and Redexes. Each Redex Execution Unit is independent and can be interconnected in any topology. Thus, the architecture is designed for highly-parallelized programs. The term `XLEN` is to refer the length of a single element in a Redex Register, which is commonly the length of the metadata section (indicating how many combinators can be defined) and the length of the port section (indicating how many Redex Registers can be referred to at most).

## 1.4 Memory
The main memory of ICM is the place to store the programs to run and other data. The main memory is different from the internal SRAM. It is usually the place where programs are load from when power-on. Commonly, it should be DDR or HBM memory, but other types (such as external SRAM, SDRAM, and ROM) are also acceptable. The starting address of the main memory should be 0x0, where programs are loaded from, and the hardware location should be defined by the implementer.

## 1.5 Exceptions, Traps, and Interrupts
This part is still under investigation.
*Placeholder*

## 1.6 UNSPECIFIED Behaviors
The architecture fully describes how the ICM architecture should be implemented or what constrains should the implementers follow. In case that there are something not specified in this specification, they are called "UNSPECIFIED Behaviors" and implementers are free to determine how it should work. 
\newpage