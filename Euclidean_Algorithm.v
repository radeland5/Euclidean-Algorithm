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

Theorem gcd_symm : forall (a b : nat),
  gcd a b = gcd b a.
Proof.
  intros a b. 
  (* 
    Show that gcd a b divides gcd b a and vice versa.
    Then use divisibility properties to show equal (for 
    natural numbers).
  *)
  apply Nat.divide_antisym.
  - (* gcd (a, b) | gcd (b, a) *) apply gcd_maximal.
    + apply gcd_div_b.
    + apply gcd_div_a.
  - (* gcd (b, a) | gcd (a, b) *) apply gcd_maximal.
    + apply gcd_div_b.
    + apply gcd_div_a.
Qed.

(* Defining gcd using inductive/fixpoint only. Need to use
  a 'fuel' to ensure termination...essentially cap the number
  of iterations you are allowed to do. *)
Fixpoint gcd_fixpt_guarded (n a b : nat) : option nat := 
  match n with 
  | 0 => None
  | S n' => match b with 
    | 0 => Some a 
    | S _ => gcd_fixpt_guarded n' b (a mod b) 
    end
  end.

(* 
  Remark: add 1 to guard to deal with following edge cases:
    - if a and b are both 0, would ideally want guarded version to
      return Some 0 instead of None
    - guarded version does not rely on immediately knowing whether 
      b > a, so may need an extra iteration to force the first term
      in gcd to be the larger one.
  This means the 'None' branch is never actually used.
*)
Definition gcd_fixpt (a b : nat) : nat :=
  match (gcd_fixpt_guarded (b + 1) a b) with 
  | None => 0 
  | Some d => d 
  end.

(* 
  First prove that when b < n, (gcd_fixpt_guarded n a b) will never 
  be None. 
*)
Theorem gcd_fixpt_guarded_not_none : forall (n a b : nat),
  b < n ->
  gcd_fixpt_guarded n a b <> None.
Proof.
  intros n.
  induction n as [|n' IH].
  - (* Hypothesis of a + b < 0 doesn't hold if a and b are in N *) 
    lia.
  - (* a + b < S n' *)
    intros a b H. simpl.
    destruct b as [|b'] eqn:Hb.
    + intros contra. discriminate contra.
    + apply IH. rewrite <- Hb. rewrite <- Hb in H.
      apply Nat.lt_le_trans with b.
      * apply Nat.mod_upper_bound. lia.
      * lia.
Qed.

Lemma gcd_fixpt_eq : forall a b,
  exists d, gcd_fixpt_guarded (b + 1) a b = Some d.
Proof.
  intros a b. destruct (gcd_fixpt_guarded (b + 1) a b) eqn:Heq.
  - (* gcd_fixpt_guarded (b + 1) a b = Some n *) exists n. reflexivity.
  - (* gcd_fixpt_guarded (b + 1) a b = None *)
    assert (b < (b + 1)) as Hb.
    + lia.
    + apply (gcd_fixpt_guarded_not_none (b + 1) a b) in Hb.
      rewrite Heq in Hb. destruct Hb. reflexivity.
Qed.    