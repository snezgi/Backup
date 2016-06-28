; -------------------------------------------------------------------------
(define-param resl 32);
(define-param nstr 1);
(set-param! num-bands 4)


(define-param eps_top 2.07);
(define-param eps_substrate 2.07);
(define-param eps_strip 2.07);
(define-param eps_np 12.0);

(define-param ap 0.5); 
(define-param wp 0.5); 
(define-param hp 0.5); 

(define-param strip_width 1); width of the strip (in y direction)
(define-param thick 1) ; thickness of the strip (also nanoparticle)

(define-param pz 3);
(define-param py 3);
(define-param sz (+ thick (* 2 pz)));
(define-param sy (+ strip_width (* 2 py)));


(define Gamma (vector3 0.2 0 0))
(define X (vector3 0.5 0 0))
(define-param nki 8) ; number of k points to interpolate
(set! k-points (interpolate nki (list Gamma X)))

(set! default-material (make dielectric (epsilon eps_top)))
(define substrate_material (make dielectric (epsilon eps_substrate)))
(define strip_material (make dielectric (epsilon eps_strip)))
(define np_material (make dielectric (epsilon eps_np)))


(set! geometry-lattice (make lattice (size 1 sy sz))) ; 3d cell
(set! geometry
      (list
       ( make block (material np_material) (size ap hp wp) (center 0 0 0) )
      )
)

(set-param! resolution (vector3 resl resl resl))
(set-param! filename-prefix (string-append "data/alag-" (number->string nstr) "-"))
(begin-time
 "total time for both TE and TM bands: "

(run-yeven-zeven)
(run-yeven-zodd)
(run-yodd-zeven)
(run-yodd-zodd)

)

(display-eigensolver-stats)



