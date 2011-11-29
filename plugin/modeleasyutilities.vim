" Vim Utilities function file 
" ====================================================================
" The following functions and key mappings allow for writing
" modeleasy programs inside Vim.
" Language:	      Modeleasy +
" Maintainer:	      Massimiliano Tripoli <massimiliano.tripoli@gmail.com>
" Last Change:	      sab 26 nov 2011, 09:57
" ====================================================================
" 
" CONFIGURATION
" if you don't want the key map 
" add your vimrc file:
"
" let map_modeasy = 0 
" 

if exists("g:utilities_modeasy")
  finish
endif


function Checkfiledeck()
                           if getline(1) !~ '^\(program\>\|subroutine\>\|model\>\|data\>\)\|^\s\+\(program\>\|subroutine\>\|model\>\|data\>\)'  
                              echo "Warning no PROGRAM statement founded" 
                           endif
endfunction


if !exists("g:map_modeasy") ||   g:map_modeasy == 1 
		
		noremap <silent> <C-k> :call CommentLines() <CR> <Esc>
		noremap <silent> <C-j> A $ 
                noremap <silent> <C-p> :call Pause() <CR> i 
                noremap <silent> <C-u> U <CR>  
                noremap <silent> <C-l> u <CR>  
endif

" Function to comment (uncomment) lines


function CommentLines() range 

	for line_number in range(a:firstline, a:lastline)


		let line = getline(line_number)
" Comment lines
	    if  line !~ '\$' 

		let replline = substitute(line, '^', "$ ", "")
		call setline(line_number, replline)
	   else
" Uncomment lines		
		let replline = substitute(line, '\$\s\|\$', "", "g")
		call setline(line_number, replline)

	    endif
    endfor

endfunction
" Insert a pause 
function Pause()

     let line_current = getline(".")
     let newline = substitute(line_current,"^","\" \" pause; ","")
     call setline(".", newline)
     call cursor(".",1)
endfunction




" Menu 
if has("gui_running")
   :amenu <silent> Modeleasy.Help   :help modeleasy-plugin <CR>
   :nmenu <silent> Modeleasy.Edit.Comment/\ Uncomment\ lines\ <C-k>  :call CommentLines()  <CR>
   :vmenu <silent> Modeleasy.Edit.Comment/\ Uncomment\ lines\ <C-k>  :call CommentLines()  <CR> 
   :nmenu <silent> Modeleasy.Edit.Comment/\ at\ end\ of\ line\ <C-j> A $ 
   :amenu <silent> Modeleasy.Edit.Insert\ Pause\ <C-p>   :call Pause() <CR> i 

   :vmenu <silent> Modeleasy.Edit.Upper/\ to\ lower\ case\ <C-l>  u  <CR> 
   :vmenu <silent> Modeleasy.Edit.Lower/\ to\ Upper\ case\ <C-u>  U  <CR> 
endif
" Execute this script only once
let g:utilities_modeasy = 1


