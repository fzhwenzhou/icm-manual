## Chapter 6
# Standard Types
This chapter explains four standard types of ICM. The implementer is supposed to choose one type when implementing ICM, whether as hardwares or software emulators. Choosing other combinations of different sections of combinators is allowed but not recommended. 

If one type includes any of the 4.6.2 and 4.6.3, it implies that it also includes 4.6.1.

## 6.1 Core Type
This is the simpliest type to make ICM work. This is to ensure that the architecture has Turing-completeness, and is able to execute any programs that should be able to run on a Turing machine. However, the processing speed cannot be ensured. Only use it as testing and educating purposes.

The implementers are required to implement the only set of combinators:

- 4.1 Core Combinators

## 6.2 HVM2 Type
This type is for running and accelerating existing HVM2<sup>3</sup> programs on ICM. With these components, HVM2 programs can directly run on this machine without much performance lose. However, it is still too simple for practical usages, as it is lack of a bunch of operators commonly used in reality. Only use it for accelerating HVM2 programs.

The implementers are required to implement these combinators:

- 4.1 Core Combinators
- 4.2 Numerical Combinators
- 4.3 Control Combinators
- 4.6.2 REF Type

## 6.3 MCU Type
This type is for implementing MCUs (Micro Control Units). These processors typically requires low power and low performance, and are usually special-purpose. The implementers have enough freedom to define it themselves and do not need to worry about the compability issues. 

The implementers are required to implement these combinators:

- 4.1 Core Combinators
- 4.2 Numerical Combinators
- 4.3 Control Combinators
- 4.5 Dense Combinators (Optional)

## 6.4 Coprocessor Type
This type is for implementing hardware accelerators for high-performance systems. These systems are commonly running computer graphics jobs or AI training and inference. This is the main goal of ICM, which would provide a huge increase of performance in computer graphics and AI related fields compared with traditional architectures. This type should be highly standardized to provide high compability with each others and ease software and compiler development.  

The implementers are required to implement these combinators:

- 4.1 Core Combinators
- 4.2 Numerical Combinators
- 4.3 Control Combinators
- 4.5 Dense Combinators
- 4.6.2 REF Type
- 4.6.3 DREF Type

\newpage