;pc book page 128 figure 5 reproduce

(define-param eps 12) ; dielectric constant

(define-param w 1) ;  width 
(define-param h 0.4) ;  thickness/height
(define-param r 0.25) 
(define-param sc-y 4) ; supercell width
(define-param sc-z 2) ; supercell width

(set! geometry-lattice (make lattice (size 1 sc-y sc-z))) ; 3d cell

(set! geometry
      (list ;(make block (material air)
		;  (center 0 0 0)
		;(size infinity infinity infinity))
       (make block (size infinity w h) (center 0 0 0) (material (make dielectric (epsilon eps)))  )
	(make cylinder (material air)
		(center 0) (radius r) (height h) )))


; The k (i.e. beta, i.e. propagation constant) points to look at, in
; units of 2*pi/um.  We'll look at num-k points from k-min to k-max.
(define-param num-k 8)
(define-param k-min 0)
(define-param k-max 0.5)
(set! k-points (interpolate num-k (list (vector3 k-min) (vector3 k-max))))
(set-param! resolution (vector3 32 32 16))
;(set-param! resolution 32)

; Increase this to see more modes.  (The guided ones are the ones below the
; light line, i.e. those with frequencies < kmag / 1, where kmag
; is the corresponding column in the output if you grep for "freqs:".)
(set-param! num-bands 3)

(begin-time
 "total time for both TE and TM bands: "

(run-yeven-zeven)
(run-yeven-zodd)
(run-yodd-zeven)
(run-yodd-zodd)

)

(display-eigensolver-stats)

