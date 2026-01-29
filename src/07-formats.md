## Chapter 4
# Data Formats
This chapters mainly explain the data formats that are stored in the specific data combinators. These data formats are defined for number combinators to process datatypes other than those identified in the Combinators section. Although they are all stored as integers, they can have different behaviors depending on the operators. Here, the standard provides standards how operators should interpret something stored in the number combinators, to prevent different alignments of different Dense Modules and type conversions.

## 4.1 Integer Numbers
Integer numbers are seperated into two categories: signed integers and unsigned integers. Unsigned integers are stored as-is. Signed integers are stored as its two's complement form. The length of the integer is defined by the Metadata value. All integers must begin at the `XLEN-1` bit of the first Data section. The byte order for all integers greater than 8-bit is Little endian. If one integer exceeds one Data section, the next part should begin at the `XLEN-1` bit of the second Data section, as if two Data sections are directly connected together.

## 4.2 Floating Point Numbers
For all floating point numbers, the sign bit should start at the `XLEN-1` position of the first data register. If one floating point number exceeds one Data section, the next bit of the bit at the `0` position of the first Data section should begin at the `XLEN-1` bit of the second Data section, as if two Data sections are directly connected together. For fp32, fp64, and fp16, they should be stored as the integers of the same length, as u32, u64, and u16. 

## 4.3 Small Vectors
Small vectors are vectors that can fill in the standard number combinators without additional space. For all small vectors, the first element should start from the `XLEN-1` position of the first data register. The length of small vectors should be at least 16-bit (therefore it can process two 8-bit elements simultaneously). The length of small vectors are also identified by the Metadata section of number combinators. For a specific vector length `VLEN`, the number of elements it can contain varies from 2 (each element being `VLEN/2` width) and `VLEN/8` (each element being a byte), and should be an exponent of 2. Like the byte order, the element order inside a vector should also be Little endian. 

## 4.4 Small Matrices
Small matrices are matrices that can fill in the standard number combinators without additional space. For small matrices, they follow all the rules of small vectors. So refer to the previous section to get information about small vectors.
\newpage