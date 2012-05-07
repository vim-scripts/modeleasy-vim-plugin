" Modeleasy autodetect files *.deck or *.dec
" =========================================================================
" Language:	      Modeleasy + 
" Maintainer:	      Massimiliano Tripoli <massimiliano.tripoli@gmail.com>
" Last Change:	      mar 24 apr 2012, 22:05
" =========================================================================

if exists("g:disable_modeasy_ftplugin")
  finish
endif

function Checkfiledeck()
                           if getline(1) !~ '^\(program\>\|subroutine\>\|model\>\|data\>\)\|^\s\+\(program\>\|subroutine\>\|model\>\|data\>\)'  
                              echo "WARNING no PROGRAM statement found" 
                           endif

			   if v:lang =~ 'it_IT'
				  let g:modeasy_lang = 'IT'
			  endif
                           runtime plugin/modeleasyutilities.vim
endfunction


autocmd BufNewFile,BufRead *.deck,*.dec set ft=modeasy
autocmd BufRead *.deck,*.dec call Checkfiledeck() 
