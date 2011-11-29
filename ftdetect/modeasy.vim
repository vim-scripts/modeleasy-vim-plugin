" Modeleasy autodetect files *.deck or *.dec
" ====================================================================
" Language:	      Modeleasy + 
" Maintainer:	      Massimiliano Tripoli <massimiliano.tripoli@gmail.com>
" Last Change:	      sab 19 nov 2011, 15:41
" ====================================================================

if exists("g:disable_modeasy_ftplugin")
  finish
endif
autocmd BufNewFile,BufRead *.deck,*.dec set ft=modeasy
autocmd BufRead *.deck,*.dec call Checkfiledeck() 
