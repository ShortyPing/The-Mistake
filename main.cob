identification division.
program-id. themistake.

environment division.
input-output section.
file-control.
       select out-file assign to "output.ppm"
       organization is line sequential.

data division.
      
      file section.
      fd out-file.
      01 out-rec pic x(400000).
      
      working-storage section.
      01 ray-origin.
       05 origin-x pic s9(5)v9(5) value +0.
       05 origin-y pic s9(5)v9(5) value +0.                         
       05 origin-z pic s9(5)v9(5) value +0.                             
      01 ray-direction.
       05 dir-x pic s9(5)v9(5) value +0.
       05 dir-y pic s9(5)v9(5) value +0.
       05 dir-z pic s9(5)v9(5) value +0.
      01 sphere-center.
       05 sphere-x pic s9(5)v9(5) value +0.
       05 sphere-y pic s9(5)v9(5) value +0.
       05 sphere-z pic s9(5)v9(5) value +5.


       01 dx pic s9(5).
       01 dy pic s9(5).
       01 dist2 pic s9(5).
       01 rad2 pic s9(5).
       

      01 T pic s9(5)v9(5).
      01 width pic 9(3) value 200.
      01 height pic 9(3) value 200.     


      01 X pic 9(3).
      01 Y pic 9(3).
      01 Z pic 9(3).        
      01 r pic 9(3).
      01 g pic 9(3).
      01 b pic 9(3).      

      01 shade pic 9(3).                      
procedure division.
       open output out-file
       move "P3" to out-rec
       write out-rec
       move "200 200" to out-rec
       write out-rec
       move "255" to out-rec
       write out-rec
       compute rad2 = 50 * 50
       perform varying y from 1 by 1 until y > height
           perform varying x from 1 by 1 until x > width
               compute dx = x - 100
               compute dy = y - 100
               compute dist2 = (dx * dx) + (dy * dy)
               if dist2 < rad2
                   compute shade = 255 - (dist2 / 10)
                   if shade < 0
                       move 0 to shade
                   end-if
                   move shade to r
                   move 0 to g
                   move 0 to b
               else
                   move 0 to r
                   move 0 to g
                   move 255 to b
               end-if
               string r delimited by size
                   " " delimited by size
                   g delimited by size
                   " " delimited by size
                   b delimited by size
               into out-rec
               write out-rec
           end-perform
       end-perform
       close out-file
       stop run.             
check-hit.
       compute T = (dir-x * sphere-x) + (dir-y * sphere-y) + (dir-z * sphere-z).                                             
