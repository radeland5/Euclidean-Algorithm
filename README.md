# Euclidean-Algorithm

A project implementing the Euclidean Algorithm in Rocq. 

## Description

This is a project to implement the Euclidean Algorithm in Rocq and verify select properties. The Euclidean Algorithm is an algorithm used to find the greatest common divisor of two numbers $a$ and $b$. The extended Euclidean Algorithm allows you to write the greatest common divisor as a linear combination of $a$ and $b$, which is particularly useful for computing modular inverses. Note that Rocq already has gcd incorporated into its natural numbers and integers libraries, so this is purely for educational purposes as part of learning Rocq.

## Prerequisites

To compile or verify these proofs, you need:
*   **Rocq Prover** (Version 9.1+ / Platform 2026.07 or newer)

### Recommended Editors (Optional)
While you can compile the files directly from the command line, this project is best experienced using an interactive proof assistant editor:
*   **VS Code** with the official **Rocq** (VsCoq) extension.
*   **RocqIDE** (the bundled standalone editor).
*   **Emacs** with **Proof General**.

## Installation & Setup

1. **Install Rocq:** Download the official package or binary installer for your operating system from the [Rocq Prover Website](https://rocq-prover.org).
2. **Clone the repository:**
   ```bash
   git clone https://github.com/radeland5/Euclidean-Algorithm
   cd Euclidean-Algorithm
   ```

## Usage

To compile and check the proofs via the command line, run the Rocq compiler on the source file:

```bash
rocqc (Insert_file_name).v
```

*(Alternatively, open the folder in VS Code or RocqIDE to step through the proof tactics interactively!)*