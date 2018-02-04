#lang racket

(require 2htdp/universe 2htdp/image)

;; --------------------------------------------------------------------------------
(struct posn (x y) #:transparent)

;; (posn=? posn posn) -> boolean
(define (posn=? p1 p2)
  (and (equal? (posn-x p1) (posn-x p2))
       (equal? (posn-y p1) (posn-y p2))))

;; (posn/plus posn posn) -> posn 
(define (posn/plus p1 p2)
  (posn (+ (posn-x p1) (posn-x p2))
        (+ (posn-y p1) (posn-y p2))))

;; (posn/minus posn posn) -> posn
(define (posn/minus p1 p2)
  (posn (+ (posn-x p1) (* -1 (posn-x p2)))
        (+ (posn-y p1) (* -1 (posn-y p2)))))


;; (posn/in-bounds? posn number number number number boolean)
(define (posn/in-bounds? p x-min x-max y-min y-max inclusive?)
  (define x (posn-x p)) 
  (define y (posn-y p))
  (if inclusive?
      (and (>= x x-min) (<= x x-max)
           (>= y y-min) (<= y y-max))
      (and (> x x-min) (< x x-max)
           (> y y-min) (< y y-max))))

(define (distance p1 p2)
  (define dx (- (posn-x p1) (posn-x p2)))
  (define dy (- (posn-y p1) (posn-y p2)))
  (sqrt (- (* dx dx) (* dy dy))))

;; --------------------------------------------------------------------------------

;; DEFINITIONS

(define WIDTH 1000)
(define HEIGHT 500)
(define TICK-RATE (/ 1 8))

(struct arrow (loc vel angle) #:transparent)

(struct target (loc img) #:transparent)

(struct runner (loc img misc) #:transparent)

(struct world (runner obstacles state) #:transparent)

(define (fire-obstacle)
  (runner (posn WIDTH (- HEIGHT 100)) (rectangle 20 (random 50) "solid" "green") '()))


(define initial-runner (runner
                        (posn (/ WIDTH 2) (- HEIGHT 100))
                        (square 20 "solid" "red") '()))

(define (start)
  (big-bang (world initial-runner (list (fire-obstacle)) "START")
    
    (on-tick next-tick TICK-RATE)
    (on-key key-handler)
    (to-draw render-game)
    (stop-when game-over?)
    ))


(define (next-tick w)
  (world (world-runner w) (move (world-obstacles w)) (world-state w)))


(define (move obs)
  (cond [(empty? obs) obs]
        [else (cons (runner 
                     (posn/plus (runner-loc (first obs)) (posn -1 0))
                     (runner-img (first obs))
                     (runner-misc (first obs)))
                    (move (rest obs)))]))
;;[(posn/in-bounds? (first obs) 0 WIDTH 0 HEIGHT #t) )]))



(define (key-handler key w)
  w)



(define (render-game w)
  (define state (world-state w))
  (foldr (λ (val acc)
           (place-image (runner-img val)
                        (posn-x (runner-loc val))
                        (posn-y (runner-loc val)) acc))
         (empty-scene WIDTH HEIGHT)
         (cons (world-runner w)
               (world-obstacles w))))



(define (game-over? w)
  #f)

















