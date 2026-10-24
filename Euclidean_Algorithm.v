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

(* 
  If d = gcd a b (as defined above), to prove we really
  found the gcd, we need to show that:
  1. d divides a 
  2. d divides b 
  3. if d' divides both a and b, then d' divides d.
*)

(* 
  Nat.divide_add_r:
    forall n m p : nat, 
    Nat.divide n m -> 
    Nat.divide n p -> 
    Nat.divide n (m + p)
  Nat.divide_mul_r: 
    forall n m p : nat, 
    Nat.divide n p -> 
    Nat.divide n (m * p)
  Nat.divide_mul_l: 
    forall n m p : nat, 
    Nat.divide n m -> 
    Nat.divide n (m * p)
  Nat.div_mod_eq x y: 
    forall x y : nat, 
    y <> 0 -> 
    x = y * (x / y) + x mod y
*)

Theorem gcd_div_a_and_b : forall (a b : nat), 
  Nat.divide (gcd a b) a /\ Nat.divide (gcd a b) b.
Proof.
  intros a b.
  funelim (gcd a b).
  - (* b = 0 *)
    split.
    + (* d | a *) exists 1. lia.
    + (* d | b *) exists 0. lia.
  - (* gcd a b => gcd b r
      b = S n. Assuming statement is true for gcd b r, 
      show it is true for gcd a b. However, we will go ahead
      and rewrite your goal using gcd_S.
    *)  
    destruct H as [Ha Hb]. split.
    + (* d | a *)
      rewrite (Nat.div_mod a (S n)) at 2.
      * (* 
          a = bq + r, 
          b = S n, Ha -> exists x such that b = d x, 
          r = a mod S n, Hb -> exists y such that r = d y.
        *)
        apply Nat.divide_add_r.
        -- (* d | bq *) apply Nat.divide_mul_l. exact Ha.
        -- (* d | r *) exact Hb.
      * discriminate.
    + (* d | b *) exact Ha.
Qed.

Theorem gcd_div_a : forall (a b : nat), 
  Nat.divide (gcd a b) a.
Proof.
  intros a b.
  apply (proj1 (gcd_div_a_and_b a b)).
Qed.

Theorem gcd_div_b : forall (a b : nat),
  Nat.divide (gcd a b) b.
Proof.
  intros a b.
  apply (proj2 (gcd_div_a_and_b a b)).
Qed.

(* 
  Nat.divide_add_cancel_r : forall n m p : nat,
    Nat.divide n m ->
    Nat.divide n (m + p) ->
    Nat.divide n p
*)

Theorem gcd_maximal : forall (a b d' : nat),
  Nat.divide d' a ->
  Nat.divide d' b ->
  Nat.divide d' (gcd a b).
Proof.
  intros a b d' Hda Hdb.
  funelim (gcd a b).
  - (* b = 0 *) exact Hda.
  - (* b = S n *)
    apply H.
    + exact Hdb.
    + assert (Ha : exists x, a = (S n) * x + (a mod S n)).
      * exists (a / S n). apply (Nat.div_mod_eq a (S n)).
      * destruct Ha.
        apply (Nat.divide_add_cancel_r d' (S n * x) (a mod S n)).
        -- apply Nat.divide_mul_l. exact Hdb.
        -- rewrite <- H0. exact Hda.
Qed. 
