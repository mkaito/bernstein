au BufNewFile,BufRead *.d let syntastic_d_compiler_options = "-Isource"
"au BufWritePost,FileWritePost,FileAppendPost app.d !rdmd -Isource -unittest -debug <afile>
"au BufWritePost,FileWritePost,FileAppendPost *.d Shell rdmd -Isource -main -unittest -debug <afile>
nnoremap <F12> :Shell rdmd -Isource -main -unittest -debug %<CR>
