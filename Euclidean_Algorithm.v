Require Import Program.

From Stdlib Require Import Arith Lia.
From Stdlib Require Import ZArith.

From Equations Require Import Equations.

(* 
  Euclidean Algorithm: Used to systematically find the
  gcd of two natural numbers a and b.

  General algorithm:
  If a = bq + r, then gcd(a, b) = gcd(b, r).
  So compute:
  1. a modulo b 
  2. gcd(a, b) = gcd(b, a modulo b)
  relabel and repeat until you get r = 0.

  Example:
  a = 12, b = 8
  1. 12 mod 8 = 4
  2. gcd(12, 8) = gcd(8, 4)
  3. 8 mod 4 = 0.
  4. gcd(8, 4) = gcd(4, 0) = 4
*)

Equations gcd (a b : nat) : nat by wf b lt :=
  gcd a 0 => a ;
  gcd a b => gcd b (a mod b).
Next Obligation.
  fold (a mod S n).
  (* Nat.mod_upper_bound: forall a b : nat, b <> 0 -> a mod b < b.*)
  apply Nat.mod_upper_bound.
  discriminate.
Qed.

Lemma gcd_0 : forall (a : nat), gcd a 0 = a.
Proof.
  intros a.
  simp gcd.
  reflexivity.
Qed.

Lemma gcd_S : forall (a n : nat), 
  gcd a (S n) = gcd (S n) (a mod (S n)).
Proof.
  intros a n.
  simp gcd.
  reflexivity.
Qed.

