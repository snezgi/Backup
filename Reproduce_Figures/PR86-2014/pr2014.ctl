;physical revies b 89 2014 fig 2 rep

(define-param eps 16) ; dielectric constant

(define-param r 0.5) 
;r=0.35 for figure (a)
;r=0.5 for f'gure (b)
(define-param sc-y 4) ; supercell width
(define-param sc-z 4) ; supercell width

(set! geometry-lattice (make lattice (size 1 sc-y sc-z))) ; 3d cell

(set! geometry
      (list  (make sphere (center 0 0 0) (radius r) 
			   (material (make dielectric (epsilon eps))  ) )))


; The k (i.e. beta, i.e. propagation constant) points to look at, in
; units of 2*pi/um.  We'll look at num-k points from k-min to k-max.
(define-param num-k 12)
(define-param k-min 0)
(define-param k-max 0.5)
(set! k-points (interpolate num-k (list (vector3 k-min) (vector3 k-max))))
(set-param! resolution (vector3 32 32 16))
;(set-param! resolution 32)

; Increase this to see more modes.  (The guided ones are the ones below the
; light line, i.e. those with frequencies < kmag / 1, where kmag
; is the corresponding column in the output if you grep for "freqs:".)
(set-param! num-bands 2)

(begin-time
 "total time for both TE and TM bands: "

(run-yeven-zeven)
(run-yeven-zodd)
(run-yodd-zeven)
(run-yodd-zodd)

)

(display-eigensolver-stats)

