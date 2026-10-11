# Mathematics

The greatest common divisor of $a$ and $b$, denoted $\gcd(a, b)$, is the largest positive integer that divides both $a$ and $b$. 

For the proof of the Euclidean Algorithm, we really rely on the divisibility properties below. For all properties, let $a$, $b$, and $c$ be integers. Then:
1. If $c$ divides $a$ and $c$ divides $b$, then $c$ divides any linear combination of $a$ and $b$.
2. If $a$ divides $c$ and $c$ divides $a$, then $a = \pm c$ (if $a$ and $c$ are integers).


## Euclidean Algorithm
Given positive integers $a$ and $b$ with $a \geq b$, write $a = bq + r$. Then $\gcd(a, b) = \gcd(b, r)$ and $0 \leq r < b$. The idea behind the Euclidean Algorithm is to iterate this process.
1. Let $r_0 = a$, $r_1 = b$, and $i = 1$.
2. Divide $r_{i - 1}$ by $r_i$ with remainder, to get $r_{i - 1} = r_i \cdot q_i + r_{i + 1}$ where $0 \leq r_{i + 1} < r_i$.
3. If $r_{i + 1} = 0$, then $\gcd(a, b) = r_i$ and we are done. Otherwise, increase $i$ by 1 and go to step 2.

Note that when programming, you do not need to determine whether $a$ or $b$ is actually bigger. If you started with $a < b$, then the first iteration will give you $r_1 = b$, $q_1 = 0$, and $r_2 = a$, and you will then be set up correctly for the remainder of the algorithm. The tradeoff is that it will add an extra iteration to your computation.


### Example 
Compute $\gcd(3214, 487)$. 
1. $r_0 = 3214$, $r_1 = 487$. Then $3214 = 487 \cdot 6 + 292$, so $r_2 = 292$.
2. $r_1 = 487$, $r_2 = 292$. Then $487 = 292 \cdot 1 + 195$, so $r_3 = 195$.
3. $r_2 = 292$, $r_3 = 195$. Then $292 = 195 \cdot 1 + 97$, so $r_4 = 97$.
4. $r_3 = 195$, $r_4 = 97$. Then $195 = 97 \cdot 2 + 1$, so $r_5 = 1$
5. $r_4 = 97$, $r_5 = 1$. then $97 = 1 \cdot 97 + 0$, so $r_6 = 0$.
6. Since $r_6 = 0$, the algorithm terminates and $\gcd(3214, 487) = r_5 = 1$.

### Why it works 
The key part of the algorithm is that if we write $a = b \cdot q + r$, then $\gcd(a, b) = \gcd(b, r)$. So let's prove this.

Note that $\gcd (a, b)$ divides both $a$ and $b$. Therefore $\gcd(a, b)$ divides $r = a - b \cdot q$. Since $\gcd(a, b)$ divides both $b$ and $r$, it must also divide $gcd (b, r)$. 

Now let's look at $\gcd(b, r)$. This divides both $b$ and $r$, so divides $a = b \cdot q + r$. Since $\gcd(b, r)$ divides both $a$ and $b$, it must also divide $\gcd(a, b)$. 

Since $\gcd (a, b)$ and $\gcd(b, r)$ both divide each other, they must be equal up to associates. In the integers, this means that 
$\gcd (a, b) = u \cdot \gcd(b, r)$ where $u = \pm 1$. If we assume $\gcd$ is always positive, then they are in fact equal. 

The other important part to note is that $0 \leq r < b$, so as we iterate this, with $\gcd (a, b) = \gcd (b, r) = \gcd (r, r_1) = \gcd(r_1, r_2) = \dots$ then for all i, $0 \leq r_{i + 1} < r_i$ until we reach 0, so the algorithm must terminate.

## Extended Euclidean Algorithm 
(Extending to find the linear combination)

### Example

### Application: Finding modular inverses

### Time complexity

## References and Further Reading