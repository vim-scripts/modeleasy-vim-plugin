" Vim syntax file
" ====================================================================
" Language:	     Modeleasy +
" Maintainer:	     Massimiliano Tripoli <massimiliano.tripoli@gmail.com>
" Last Change:       sab  5 mag 2012, 09:33
" Filenames:	      *.deck
" NOTE: The highlighting of modeleasy functions is defined in the
"       syntax/modeleasyfunctions.vim and syntax/modeasy.vim
"       The utilities of plugin are defined in the
"       plugin/modeleasyutilities.vim
" ====================================================================
" 
" Some lines of code were borrowed from
" Jakson Aquino <jalvesaq@gmail.com> (r-vimplugin)
"
"
"
if exists("g:disable_modeasy_ftplugin") 
  finish
endif


if exists("b:current_syntax")
  finish
endif

setlocal iskeyword=@,48-57,_,.

syn case ignore

" Comment
syn match modeasyComment contains=@Spell "\$.*"

syn match modeasyStrError display contained "\\."

" string enclosed in double quotes
syn region modeasyString contains=modeasySpecial,@Spell start=/"/ skip=/\\\\\|\\"/ end=/"/

" string enclosed in single quotes
syn region modeasyString contains=modeasySpecial,@Spell start=/'/ skip=/\\\\\|\\'/ end=/'/

" New line, carriage modeasyreturn, tab, backspace, bell, feed, vertical tab, backslash
syn match modeasySpecial display contained "\\\(n\|r\|t\|b\|a\|f\|v\|'\|\"\|s\)\|\\\\"

" Hexadecimal and Octal digits
syn match modeasySpecial display contained "\\\(x\x\{1,2}\|[0-8]\{1,3}\)"

" Unicode characters
syn match modeasySpecial display contained "\\u\x\{1,4}"
syn match modeasySpecial display contained "\\U\x\{1,8}"
syn match modeasySpecial display contained "\\u{\x\{1,4}}"
syn match modeasySpecial display contained "\\U{\x\{1,8}}"
" Modeasy special options
syn keyword modeasyOption add all arrays1d arrays2d auto automatic ave backfill baseout blank bottom ca
syn keyword modeasyOption charlits cleanup clear colhead color cumulated datafiles decimals disp display
syn keyword modeasyOption drop dynamic everything far forecast fullnewton henceforth impact instrument 
syn keyword modeasyOption interim interp jacobi linear logarithmic mgs modelfile namelits nave near newton 
syn keyword modeasyOption nsum num objectives off on only outunit print printnull protected rationalize rep 
syn keyword modeasyOption replace rowhead show significance static stock sum suppress system timeseries 
syn keyword modeasyOption title top trace user width word zero        

syn match modeasyBackSpace contained "\s\+"
" Match error at beginning of the text
syn region modeasyStartError contains=modeasyBackSpace start=/\%^/ end=/$/ 
" Match error in if then block
syn region modeasyIfThenError start="then"hs=s+4  contains=modeasyThen,modeasyBackSpace,modeasyComment end="$" oneline 
" Syntax highlighting until end statement
syn region modeasyEndProgram start="end"hs=s+3  contains=modeasyEnd end="\%$"
" Statement

syn keyword modeasyStatement   break 
syn keyword modeasyRepeat      for in repeat while do next endloop endfor endwhile
syn keyword modeasyPause       pause 
syn keyword modeasyConditional if else endif where goto as

syn match  modeasyunitHeader display"\<program\>"
syn match  modeasyunitHeader display "\<model\>"
syn match  modeasyunitHeader display "\<data\>"
syn match  modeasyunitHeader display "\<subroutine\>"
syn match  modeasyunitHeader display "\<return\>"
syn match  modeasyThen display contained "\<then\>"
syn match  modeasyEnd display contained "\<end\>"

" Constant 
syn keyword modeasyConstant pi piover2 piover180 180overpi sqrtpi log10e lnofsqrtof2

" integer
syn match modeasyInteger "\<\d\+L"
syn match modeasyInteger "\<0x\([0-9]\|[a-f]\|[A-F]\)\+L"
syn match modeasyInteger "\<\d\+[Ee]+\=\d\+L"

" number with no fractional part or exponent
syn match modeasyNumber "\<\d\+\>"
" hexadecimal number 
syn match modeasyNumber "\<0x\([0-9]\|[a-f]\|[A-F]\)\+"

" floating point number with integer and fractional parts and optional exponent
syn match modeasyFloat "\<\d\+\.\d*\([Ee][-+]\=\d\+\)\="
" floating point number with no integer part and optional exponent
syn match modeasyFloat "\<\.\d\+\([Ee][-+]\=\d\+\)\="
" floating point number with no fractional part and optional exponent
syn match modeasyFloat "\<\d\+[Ee][-+]\=\d\+"

" Complex number
syn match modeasyComplex "\<\d\+i"
syn match modeasyComplex "\<\d\++\d\+i"
syn match modeasyComplex "\<0x\([0-9]\|[a-f]\|[A-F]\)\+i"
syn match modeasyComplex "\<\d\+\.\d*\([Ee][-+]\=\d\+\)\=i"
syn match modeasyComplex "\<\.\d\+\([Ee][-+]\=\d\+\)\=i"
syn match modeasyComplex "\<\d\+[Ee][-+]\=\d\+i"
" Operators
syn match modeasyOperator    '-'
syn match modeasyOperator    '*\{1,2}'
syn match modeasyOperator    '+'
syn match modeasyOperator    '='
syn match modeasyOperator    '=>'
syn match modeasyOperator    "[|!<>^~`/@]"
" Boolean
syn match modeasyBoolean display contained '\.\(true\|false\)\.' 
syn match modeasyBoolean display contained '\.\(and\|or\|not\)\.'
syn match modeasyBoolean display contained '\.\(ge\|et\|eq\|le\|gt\|ne\|lt\)\.'
" Delimiter
syn match modeasyDelimiter "[,;:&]"
syn match modeasyDelimiter "[,;:&]" contained
" Error
syn region modeasyRegion matchgroup=Delimiter start=/(/ matchgroup=Delimiter end=/)/ transparent contains=ALLBUT,modeasyError,modeasyBraceError,modeasyCurlyError 
syn region modeasyRegion matchgroup=Delimiter start=/{/ matchgroup=Delimiter end=/}/ transparent contains=ALLBUT,modeasyError,modeasyBraceError,modeasyParenError
syn region modeasyRegion matchgroup=Delimiter start=/\[/ matchgroup=Delimiter end=/]/ transparent contains=ALLBUT,modeasyError,modeasyCurlyError,modeasyParenError

syn match modeasyError      "[)\]}]"
syn match modeasyBraceError "[)}]" contained
syn match modeasyCurlyError "[)\]]" contained
syn match modeasyParenError "[\]}]" contained
syn match modeasyOperatorError "*\{3,}" 
syn match modeasyOperatorError "+\{2,}" 
syn match modeasyOperatorError "-\{2,}" 
syn match modeasyOperatorError "/\{3,}" 
syn match modeasyError "[\]}]" contained
syn match modeasyOperatorError "\$\{2,}" 

" source list of Modeleasy + functions.

runtime syntax/modeleasyfunctions.vim
  
" Name of object with spaces
 syn region modeasyNameWSpace start="`" end="`"

" Define the default highlighting.
hi def link modeasyBoolean     Boolean
hi def link modeasyBraceError  Error
hi def link modeasyComment     Comment
hi def link modeasyComplex     Number
hi def link modeasyConditional Conditional
hi def link modeasyConstant    Constant
hi def link modeasyCurlyError  Error
hi def link modeasyFloat       Float
hi def link modeasyFunction    Function
hi def link modeasyunitHeader  PreProc
hi def link modeasyInteger     Number
hi def link modeasyNameWSpace  Normal
hi def link modeasyNumber      Number
hi def link modeasyOperator    Operator
hi def link modeasyParenError  Error
hi def link modeasyRepeat      Repeat
hi def link modeasySpecial     SpecialChar
hi def link modeasyStatement   Statement
hi def link modeasyString      String
hi def link modeasyStrError    Error
hi def link modeasyPause       Todo
hi def link modeasyOperatorError Error
hi def link modeasyStartError  Error
hi def link modeasyDelimiter   Delimiter
hi def link modeasyBackSpace   Normal
hi def link modeasyIfThenError Error
hi def link modeasyThen        Conditional
hi def link modeasyEndProgram  Normal
hi def link modeasyEnd         PreProc
hi def link modeasyStart       PreProc	 
hi def link modeasyOption      SpecialChar
let b:current_syntax="modeasy.vim"

