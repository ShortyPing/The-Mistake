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
      01 width pic 9(3) value 200.
      01 height pic 9(3) value 200.                                     
      01 X pic 9(3).
      01 Y pic 9(3).
      01 Z pic 9(3).        
      01 r pic 9(3).
      01 g pic 9(3).
      01 b pic 9(3).                           
procedure division.
       open output out-file
       move "P3" to out-rec
       write out-rec
       move "200 200" to out-rec
       write out-rec
       move "255" to out-rec
       write out-rec
       perform varying y from 1 by 1 until y > height
           perform varying x from 1 by 1 until x > width
               compute r = (x * 255) / width
               compute g = (y * 255) / height
               compute b = 128
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
