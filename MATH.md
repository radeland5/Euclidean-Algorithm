# Mathematics

The greatest common divisor of $a$ and $b$, denoted $\gcd(a, b)$, is the largest positive integer that divides both $a$ and $b$. 

For the proof of the Euclidean algorithm, we really rely on the divisibility properties below. For all properties, let $a$, $b$, and $c$ be integers. Then:
1. If $c$ divides $a$ and $c$ divides $b$, then $c$ divides any linear combination of $a$ and $b$.
2. If $a$ divides $c$ and $c$ divides $a$, then $a = \pm c$ (if $a$ and $c$ are integers).


## Euclidean Algorithm
Given positive integers $a$ and $b$ with $a \geq b$, write $a = bq + r$. Then $\gcd(a, b) = \gcd(b, r)$ and $0 \leq r < b$. The idea behind the Euclidean algorithm is to iterate this process.
1. Let $r_0 = a$, $r_1 = b$, and $i = 1$.
2. Divide $r_{i - 1}$ by $r_i$ with remainder, to get $r_{i - 1} = r_i \cdot q_i + r_{i + 1}$ where $0 \leq r_{i + 1} < r_i$.
3. If $r_{i + 1} = 0$, then $\gcd(a, b) = r_i$ and we are done. Otherwise, increase $i$ by 1 and go to step 2.

Note that when programming, you do not need to determine whether $a$ or $b$ is actually bigger. If you started with $a < b$, then the first iteration will give you $r_1 = b$, $q_1 = 0$, and $r_2 = a$, and you will then be set up correctly for the remainder of the algorithm. The tradeoff is that it will add an extra iteration to your computation.


### Example 
Compute $\gcd(3214, 487)$. 
1. $r_0 = 3214$, $r_1 = 487$. Then $3214 = 487 \cdot 6 + 292$, so $r_2 = 292$.
2. $r_1 = 487$, $r_2 = 292$. Then $487 = 292 \cdot 1 + 195$, so $r_3 = 195$.
3. $r_2 = 292$, $r_3 = 195$. Then $292 = 195 \cdot 1 + 97$, so $r_4 = 97$.
4. $r_3 = 195$, $r_4 = 97$. Then $195 = 97 \cdot 2 + 1$, so $r_5 = 1$.
5. $r_4 = 97$, $r_5 = 1$. Then $97 = 1 \cdot 97 + 0$, so $r_6 = 0$.
6. Since $r_6 = 0$, the algorithm terminates and $\gcd(3214, 487) = r_5 = 1$.

### Why it works 
The key part of the algorithm is that if we write $a = b \cdot q + r$, then $\gcd(a, b) = \gcd(b, r)$. So let's prove this.

Note that $\gcd (a, b)$ divides both $a$ and $b$. Therefore $\gcd(a, b)$ divides $r = a - b \cdot q$. Since $\gcd(a, b)$ divides both $b$ and $r$, it must also divide $\gcd (b, r)$. 

Now let's look at $\gcd(b, r)$. Since $\gcd(b, r)$ divides both $b$ and $r$, $\gcd(b, r)$ must also divide $a$ (as $a = b \cdot q + r$). Since $\gcd(b, r)$ divides both $a$ and $b$, it must also divide $\gcd(a, b)$. 

Since $\gcd (a, b)$ and $\gcd(b, r)$ both divide each other, they must be equal up to associates. In the integers, this means that 
$\gcd (a, b) = u \cdot \gcd(b, r)$ where $u = \pm 1$. If we assume $\gcd$ is always positive, then they are in fact equal. 

The other important part to note is that $0 \leq r < b$, so as we iterate this, with $\gcd (a, b) = \gcd (r_0, r_1) = \gcd(r_1, r_2) = \dots$ then for all $i$, $0 \leq r_{i + 1} < r_i$ until we reach 0, so the algorithm must terminate.

## Extended Euclidean Algorithm 
One property of $\gcd(a, b)$ is that it can be written as a linear combination of $a$ and $b$. That is, there exist integers $x$ and $y$ such that $ax + by = \gcd(a, b)$. Given $a$ and $b$, the extended Euclidean algorithm returns $\gcd(a, b)$, $x$, and $y$.

The extended Euclidean algorithm is computed in a very similar manner to the Euclidean algorithm. Intuitively, the main difference is that now we also will solve each equation of the form $$r_{i - 1} = r_i \cdot q_i + r_{i + 1}$$ for $r_{i + 1}$ (for equations where $r_{i + 1}\neq 0$), and substitute in the linear combinations as appropriate. This is best demonstrated by example.

### Example
Compute $\gcd(3214, 487)$ and find the values for $x$ and $y$ such that $3214 \cdot x + 487 \cdot y = \gcd(3214, 487)$. 

The first version will be recursive in nature, so we will proceed through the $\gcd$ process as we did earlier. However, once we reach 0, rather than terminating, we will retrace our steps to obtain the linear combination. So we have the following (note: steps 1-6 are the same as earlier):
1. $r_0 = 3214$, $r_1 = 487$. Then $3214 = 487 \cdot 6 + 292$, so $r_2 = 292$.
2. $r_1 = 487$, $r_2 = 292$. Then $487 = 292 \cdot 1 + 195$, so $r_3 = 195$.
3. $r_2 = 292$, $r_3 = 195$. Then $292 = 195 \cdot 1 + 97$, so $r_4 = 97$.
4. $r_3 = 195$, $r_4 = 97$. Then $195 = 97 \cdot 2 + 1$, so $r_5 = 1$.
5. $r_4 = 97$, $r_5 = 1$. Then $97 = 1 \cdot 97 + 0$, so $r_6 = 0$.
6. Since $r_6 = 0$, the algorithm for the $\gcd$ portion terminates and $\gcd(3214, 487) = r_5 = 1$. We now work backwards to find $x$ and $y$.
7. From step 4, we have $195 = 97 \cdot 2 + 1$ so $$ 1 = 195 - 2 \cdot 97.$$
8. From step 3, we have $$ 97 = 292 - 195.$$ Substituting into step 7, we then get 
$$
\begin{aligned}
1 &= 195 - 2 \cdot (292 - 195)\\
1 &= 3 \cdot 195 - 2 \cdot 292.
\end{aligned}
$$
9. From step 2, we have $$195 = 487 - 292.$$ Substituting into step 8, we get
$$
\begin{aligned}
1 &= 3 \cdot 195 - 2 \cdot 292\\
1 &= 3 \cdot (487 - 292) - 2 \cdot 292\\
1 &= 3 \cdot 487 - 5 \cdot 292.
\end{aligned}
$$
10. Finally, from step 1, we have $$292 = 3214 - 6 \cdot 487,$$ so substituting into step 9, we have
$$
\begin{aligned}
1 &= 3 \cdot 487 - 5 \cdot 292\\
1 &= 3 \cdot 487 - 5 (3214 - 6 \cdot 487)\\
1 &= 33 \cdot 487 - 5 \cdot 3214
\end{aligned}
$$

Alternatively, we can keep track of coefficients as we step forward through the Euclidean algorithm.

1. $r_0 = 3214$, $r_1 = 487$. Then $3214 = 487 \cdot 6 + 292$, so $r_2 = 292$. Rearranging gives us $$3214 - 487 \cdot 6 = 292.$$
2. $r_1 = 487$, $r_2 = 292$. Then $487 = 292 \cdot 1 + 195$, so $r_3 = 195$. Rearranging and substituting then gives us 
$$
\begin{aligned}
487 - 292 \cdot 1 &= 195\\
487 - (3214 - 487 \cdot 6) \cdot 1 &= 195\\
3214 \cdot -1 + 487 \cdot 7 &= 195.
\end{aligned}
$$
3. $r_2 = 292$, $r_3 = 195$. Then $292 = 195 \cdot 1 + 97$, so $r_4 = 97$. Rearranging and substituting then gives us
$$
\begin{aligned}
292 - 195 \cdot 1 &= 97\\
(3214 - 487 \cdot 6) - (3214 \cdot -1 + 487 \cdot 7) \cdot 1 &= 97\\
3214 \cdot 2 + 487 \cdot -13 &= 97
\end{aligned}
$$
4. $r_3 = 195$, $r_4 = 97$. Then $195 = 97 \cdot 2 + 1$, so $r_5 = 1$. Rearranging and substituting then gives us
$$ 
\begin{aligned}
195 - 97 \cdot 2 &= 1\\
(3214 \cdot -1 + 487 \cdot 7) - (3214 \cdot 2 + 487 \cdot -13) \cdot 2 &= 1\\
3214 \cdot -5 + 487 \cdot 33 &= 1
\end{aligned}
$$
5. $r_4 = 97$, $r_5 = 1$. Then $97 = 1 \cdot 97 + 0$, so $r_6 = 0$.
6. Since $r_6 = 0$, the algorithm terminates and $\gcd(3214, 487) = r_5 = 1$. Moreover, $$3214 \cdot -5 + 487 \cdot 33 = 1,$$ so $x = -5$ and $y = 33$.

The tradeoff to this version is that instead of using recursion, you have to keep track of both of the previous two steps when rewriting so that you can find $x$ and $y$.


### Application: Finding modular inverses

Let's say we want to find the inverse of $a \pmod n$. In general, an inverse will only exist if $\gcd(a, n) = 1$. From the extended Euclidean algorithm, we can therefore write $$a \cdot x + n \cdot y = 1.$$ Looking at this modulo $n$, we then get $$a \cdot x \equiv 1 \pmod{n}.$$ Therefore $x \pmod{n}$ where $x$ is the integer that we found via the extended Euclidean algorithm will be the inverse of $a$ modulo $n$.

### Time complexity

## References and Further Reading