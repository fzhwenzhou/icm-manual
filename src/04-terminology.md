## Chapter 2
# Terminology
This chapter explains the terminologies used in the following chapters. These are usually widely used and as a basis of the ICM. 

The following is the table explaining most of the terms used.

| Term                |      Explanation  |
|:-------------------:|:-----------------:|
| Node/Cell           | The basic unit of an interaction net |
| Principal Port       | A port where interactions can happen here. Each Node should have one and only one Principal Port. It is usually denoted as a vertex of a triangle.       |
| Auxiliary Port      | Other ports of a node (usually two). Usually as an input or output port. However, before the reduction happens, it will be lazy.               |
| Wire                | The edge connecting two ports |
| Active Pair/Redex   | The condition meets that two Principal Ports are wired together. This is the only condition for triggering the rewriting rule. |
| Reduction           | The process of substituting a Redex into a subnet indicated by the rules. |
| Vicious Circle      | A Vicious Circle is formed if a set of Nodes forms a closed-loop, and there is no Node whose Principal Port can be connected to the Principle Ports of other Nodes. |
| Cut Free/Normal Form | A Net not containing any Redex. |
| Confluence           | The final result (the Normal Form) should be the same, no matter in what order are these reduction executed. |
| Total Net            | A Net that can be reduced as a Cut Free or run into an infinite loop, but never stuck at a Vicious Circle. |
| Principal Net        | A Net with only one Principal Port exported. Usually represents a value or function |

Table 1. Terminology

\newpage