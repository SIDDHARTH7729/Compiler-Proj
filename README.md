This is a simple compiler created using Bison and Flex. It supports basic arithmetic operations and variable assignments.
Prerequisites

Before running this project, you need to have the following tools installed:

    Bison: A parser generator for C. It is used to generate the parser code from a .y file.

        Install Bison (Ubuntu):

    sudo apt-get install bison

Flex: A tool for generating lexical analyzers (scanners) from a .l file.

    Install Flex (Ubuntu):

    sudo apt-get install flex

GCC: The GNU Compiler Collection, used to compile the project.

    Install GCC (Ubuntu):

    sudo apt-get install build-essential

Git: To clone the repository and manage version control.

    Install Git (Ubuntu):

        sudo apt-get install git

    (Optional) VS Code: If you're using Visual Studio Code for development.

        Install VS Code: Download here.

    (Optional) WSL (Windows Subsystem for Linux) if you're using Windows. It is recommended for a seamless Linux-like environment on Windows.

        Install WSL (Windows): Install WSL.

How to Run the Project
1. Clone the Repository

Clone the project repository to your local machine:

git clone https://github.com/YOUR_USERNAME/Compiler-Proj.git

2. Navigate to the Project Directory

cd Compiler-Proj

3. Build the Project

Use the make command to build the project:

make

4. Run the Compiler

After building the project, you can run the compiler with an input file, such as sample.txt:

./compiler < sample.txt

Make sure the sample.txt file is in the root directory and contains valid input for the compiler to parse.
Example Input (sample.txt)

Here’s an example of what your input file (sample.txt) might look like:

a = 10;
b = 20;
c = a + b * 2;
print c;

This will output:

Result: 50
