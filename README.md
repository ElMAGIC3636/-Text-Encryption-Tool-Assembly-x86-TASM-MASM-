# -Text-Encryption-Tool-Assembly-x86-TASM-MASM-
ext Encryption Tool (Assembly x86 – TASM / MASM) A simple yet effective text encryption tool built using 8086 Assembly language. This program reads any text file, encrypts its contents using a custom algorithm, and writes the encrypted output to a new file — all through an interactive command‑line interface


🔸 Interactive File Input
The program asks the user to enter:

Input file name

Output file name
So there is no need to hardcode file paths.

🔸 Custom Encryption Algorithm
The encryption process performs two operations:

XOR each byte with 55h

Reverse the entire block of bytes before writing

This adds a double layer of obfuscation without making the code overly complex.

🔸 Chunk-Based Processing
Files are encrypted in 4 KB blocks, allowing the program to handle:

Small files

Large files (efficiently and safely)

🔸 Full Error Handling
The program detects and reports:

Missing input file

Failure to create output file

Read/write errors

Clear messages are displayed to help the user understand what went wrong.

📁 How It Works
User enters input and output file names.

The program opens both files using DOS interrupts (INT 21h).

It reads file data into a buffer.

Each byte is XOR-encrypted with 55h.

The buffer is reversed.

Encrypted data is written to the output file.

Steps repeat until EOF.

🧰 Technologies Used
TASM / MASM (8086 Assembly)

DOS interrupts (INT 21h)

Memory buffers for block processing

XOR cryptographic technique


