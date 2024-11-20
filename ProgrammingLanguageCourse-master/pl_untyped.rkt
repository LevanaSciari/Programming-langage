#lang pl untyped ;; static scoping and dynamic-typing

(define x 22)
(define (getx) x)
(define (bar1 x) (getx))
(define (bar2 y) (getx))

(test (getx) => 22)
(test (let ([x 45]) (getx)) => 22)
(test (getx) => 22)
(test (bar1 999) => 22)
(test (bar2 999) => 22)

(define foo (let ([+ *]) 
                 (lambda (x y) (+ x y)))) 
(test (foo 6 7) => 42)

(define (foo2 x)
	(define (helper) (+ x 1))
  helper)

(test ((foo2 0)) => 1)

(define (mycons f s)
  (define (mypair selector)
    (selector f s))
  mypair)


(define (myfirst p)
  (define (first-selector f s) f)
  (p first-selector))


(define (mysecond p)
  (define (second-selector f s) s)
  (p second-selector))

(test (myfirst (mycons 1 2)) => 1) ;; reference to undefined identifier: f
