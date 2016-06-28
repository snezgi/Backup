
(define Si (make dielectric (index 3.45)))
(define SiO2 (make dielectric (index 1.45)))

(define-param theta 0)
(define-param d 0.3) ;  width 
(define-param h infinity) ;  thickness/height
(define-param r 0.1) 
(define-param sc-y 4) ; supercell width
;(define-param sc-z 2) ; supercell width
(define-param pi 3.14159265)

(define-param cx1 (* (/ d 0.85065) (cos (+ (- (/ (* 3 pi) 10)) theta) )))
(define-param cy1 (* (/ d 0.85065) (sin (+ (- (/ (* 3 pi) 10)) theta) )))
(define-param cx2 (* (/ d 0.85065) (cos (+ (- (/ (* 7 pi) 10)) theta) )))
(define-param cy2 (* (/ d 0.85065) (sin (+ (- (/ (* 7 pi) 10)) theta) )))
(define-param cx3 (* (/ d 0.85065) (cos (+ (/ (* 9 pi) 10) theta) )))
(define-param cy3 (* (/ d 0.85065) (sin (+ (/ (* 9 pi) 10) theta) )))
(define-param cx4 (* (/ d 0.85065) (cos (+ (/ pi 2) theta) )))
(define-param cy4 (* (/ d 0.85065) (sin (+ (/ pi 2) theta) )))
(define-param cx5 (* (/ d 0.85065) (cos (+ (/ pi 10) theta) )))
(define-param cy5 (* (/ d 0.85065) (sin (+ (/ pi 10) theta) )))

;(set! geometry-lattice (make lattice (size 1 sc-y sc-z))) ; 3d cell
(set! geometry-lattice (make lattice (size 1 sc-y no-size))) ; 2d cell

(set! geometry
      (list (make block (material SiO2)
		  (center 0 0 0)
		(size infinity infinity infinity) )
	(make cylinder (material Si)
		(center cx1 cy1 0 ) (radius r) (height h) )
	(make cylinder (material Si)
		(center cx2 cy2 0 ) (radius r) (height h) )
	(make cylinder (material Si)
		(center cx3 cy3 0 ) (radius r) (height h) )
	(make cylinder (material Si)
		(center cx4 cy4 0 ) (radius r) (height h) )
	(make cylinder (material Si)
		(center cx5 cy5 0 ) (radius r) (height h) )))


; The k (i.e. beta, i.e. propagation constant) points to look at, in
; units of 2*pi/um.  We'll look at num-k points from k-min to k-max.
(define-param num-k 8)
(define-param k-min 0)
(define-param k-max 0.5)
(set! k-points (interpolate num-k (list (vector3 k-min) (vector3 k-max))))
;(set-param! resolution (vector3 32 32 16))
(set-param! resolution 32)

; Increase this to see more modes.  (The guided ones are the ones below the
; light line, i.e. those with frequencies < kmag / 1, where kmag
; is the corresponding column in the output if you grep for "freqs:".)
(set-param! num-bands 3)

(begin-time
 "total time for both TE and TM bands: "

;(run-yeven-zeven)
;(run-yeven-zodd)
;(run-yodd-zeven)
;(run-yodd-zodd)
(run-tm-yeven)
(run-tm-yodd)

)

(display-eigensolver-stats)

