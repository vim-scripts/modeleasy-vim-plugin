" Vim Utilities function file 
" ====================================================================
" Language:	      Modeleasy +
" Maintainer:	      Massimiliano Tripoli <massimiliano.tripoli@gmail.com>
" Last Change:	      lun  7 mag 2012, 20:09
" The following functions and key mappings allow for writing
" modeleasy programs inside Vim.
" ====================================================================
" 
" CONFIGURATION
" if you don't want the key map 
" add your vimrc file:
"
" let map_modeasy = 0 
" 

if exists("g:disable_modeasy_ftplugin")
  finish
endif

if exists("s:utilities_modeasy")
  finish
endif

if  &ft != "modeasy"
	finish
endif

if !exists("g:modeasy_lang")

	   if v:lc_time =~ 'it_IT'

		  let g:modeasy_lang = 'IT'
	  else
		  let g:modeasy_lang = 'EN'
	  endif

endif


if !exists("g:map_modeasy") ||   g:map_modeasy == 1 
		
		noremap <silent> <C-k> :call CommentLines() <CR> <Esc>
		noremap <silent> <C-j> A $ 
                noremap <silent> <C-p> :call Pause() <CR> i 
                noremap <silent> <C-u> U <CR>  
                noremap <silent> <C-l> u <CR>  
                noremap <silent> <C-h> :call HelpModeleasy() <CR> <Esc>  
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

" Start Modeleasy help
function HelpModeleasy()

if !exists("g:modeasy_dir_help")

	echo "ERROR set g:modeasy_dir_help before in vimrc file (see documentation)"
return
endif

	let  a:fileword = expand("<cword>:h") 
	let  a:filehelp =  g:modeasy_dir_help . strpart(a:fileword, 0 , 8) . ".html"

if filereadable(a:filehelp)

	if has("win32")
   		exec  "!" . "start explorer " . a:filehelp
        else
   		exec  "!" . g:browser . " " . a:filehelp
	endif
   else 
	       echo "ERROR no help file found"
endif

endfunction



" Menu 
if !exists("g:map_modeasy") ||   g:map_modeasy == 1 

	" English Menu (Default)
	if has("gui_running") && g:modeasy_lang !=? 'IT'

	   :amenu <silent> Modeleasy+.Help.Plugin    :help modeleasy-plugin <CR>
	   :amenu <silent> Modeleasy+.Help.Function\ Modeleasy\ <C-h>  :call HelpModeleasy() <CR>  
	   :nmenu <silent> Modeleasy+.Edit.Comment/\ Uncomment\ lines\ <C-k>  :call CommentLines()  <CR>
	   :vmenu <silent> Modeleasy+.Edit.Comment/\ Uncomment\ lines\ <C-k>  :call CommentLines()  <CR> 
	   :nmenu <silent> Modeleasy+.Edit.Comment/\ at\ end\ of\ line\ <C-j> A $ 
	   :amenu <silent> Modeleasy+.Edit.Insert\ Pause\ <C-p>   :call Pause() <CR> i 

	   :vmenu <silent> Modeleasy+.Edit.Upper/\ to\ lower\ case\ <C-l>  u  <CR> 
	   :vmenu <silent> Modeleasy+.Edit.Lower/\ to\ Upper\ case\ <C-u>  U  <CR> 
	endif
	
	" Italian Menu
	if has("gui_running") && g:modeasy_lang ==? 'IT'


	   :amenu <silent> Modeleasy+.Help.Plugin   :help modeleasy-plugin <CR>
	   :amenu <silent> Modeleasy+.Help.Funzione\ Modeleasy\ <C-h>  :call HelpModeleasy() <CR>  
	   :nmenu <silent> Modeleasy+.Edit.Commentare/\ Decommmentare\ linee\ <C-k>  :call CommentLines()  <CR>
	   :vmenu <silent> Modeleasy+.Edit.Commentare/\ Decommentare\ linee\ <C-k>  :call CommentLines()  <CR> 
	   :nmenu <silent> Modeleasy+.Edit.Commentare/\ alla\ fine\ della\ linea\ <C-j> A $ 
	   :amenu <silent> Modeleasy+.Edit.Inserisci\ Pausa\ <C-p>   :call Pause() <CR> i 

	   :vmenu <silent> Modeleasy+.Edit.Da\ Maiuscolo/\ a\ minuscolo\ <C-l>  u  <CR> 
	   :vmenu <silent> Modeleasy+.Edit.Da\ Minuscolo\ a\ maiuscolo\ <C-u>  U  <CR> 
	endif


endif
" Execute this script only once
let s:utilities_modeasy = 1


