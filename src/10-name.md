## Appendix II
# Naming Standard
This chapter explains the naming standard of the Dense Modules. As everyone can design the Dense Modules, they should follow the naming conventions to prevent conflicts and misidentifications.

# General
The naming of a Dense Module should have a full name explaining its purpose, and a shortened name for identification purposes. This would be concise for representing the Dense Modules a processor has. One can combine different shortened name to represent all the Dense Modules. For example "MF32F64VMas" means it has Integer Multiplication Module, Floating Point Module with 32-bit and 64-bit floating points, full Vector Module, and Small Matrix Module. 

A shortened name for a Dense Module should be an upper-case letter, or an upper-case letter followed by one or more lower-case letters, and/or one or more digits, and underlines. Specifically, underlines should not right follow the upper-case letter, be the last character of the name, and be consecutive.

The shortened name of a submodule can be defined by adding lower-case letters and/or numbers after the module's shortened name (for example, F32, Vs, Mal, etc.). If the module's shortened name is used, it implies that all the sub-modules are also implemented. Otherwise, one should state all the submodules used in the extension.

For extensions not defined by ICM Committee, they should only start with "O" or "X."

# Customized Extensions
Customized extensions are extensions not defined by ICM Committee, including individuals and organizations. However, those who define thes extensions are supposed to put it into production, or is willing to promote it. These extensions should have a shortened name starting with "O." If ICM Committee is willing to add them to the standard Dense Modules, they should change their name to the standard names and in the meanwhile, the previous "O" name should be discarded.

# Experimental Extensions
Experimental extensions are extensions not defined by ICM Committee, including individuals and organizations. They are typically for experiments or testing purposes, and not ready for production. These extensions should have a shortened name starting with "X." Once the implementers decide to put it into production or promotion, they should change the prefix into "O," and in the meanwhile, the previous "X" name should be discarded.

\newpage