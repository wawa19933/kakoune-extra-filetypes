# https://vue-loader.vuejs.org/
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .+\.vue %{
    set-option buffer filetype vuejs
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

define-command -hidden -params 3 vuejs-detect-lang %{
    try %{
        execute-keys -draft <percent> s "^<%arg{1}\b.+?\blang=""%arg{2}""" <ret>
        require-module %arg{3}
    }
}

hook global WinSetOption filetype=vuejs %{
    require-module html
    require-module css
    require-module javascript

    vuejs-detect-lang "template" "pug" "pug"
    vuejs-detect-lang "script" "ts" "typescript"
    vuejs-detect-lang "style" "scss" "scss"
    vuejs-detect-lang "style" "stylus" "css"

    require-module vuejs

    add-highlighter window/vuejs ref vuejs
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/vuejs }
}

provide-module vuejs %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/vuejs regions

add-highlighter shared/vuejs/template region -match-capture '^(\h*)<template>' '^(\h*)</template>' regions
add-highlighter shared/vuejs/template/ default-region fill meta
add-highlighter shared/vuejs/template/inner region '\A<template>[^\n]*\K' '(?=</template>)' ref html

add-highlighter shared/vuejs/pug region -match-capture '^(\h*)<template\b.+?\blang="pug">' '^(\h*)</template>' regions
add-highlighter shared/vuejs/pug/ default-region fill meta
add-highlighter shared/vuejs/pug/inner region '\A<template\b.+?\blang="pug">[^\n]*\K' '(?=</template>)' ref pug

add-highlighter shared/vuejs/css region -match-capture '^(\h*)<style>' '^(\h*)</style>' regions
add-highlighter shared/vuejs/css/ default-region fill meta
add-highlighter shared/vuejs/css/inner region '\A<style>[^\n]*\K' '(?=</style>)' ref css

add-highlighter shared/vuejs/scss region -match-capture '^(\h*)<style\b.+?\blang="scss">' '^(\h*)</style>' regions
add-highlighter shared/vuejs/scss/ default-region fill meta
add-highlighter shared/vuejs/scss/inner region '\A<style\b.+?\blang="scss">[^\n]*\K' '(?=</style>)' ref scss

add-highlighter shared/vuejs/stylus region -match-capture '^(\h*)<style\b.+?\blang="stylus">' '^(\h*)</style>' regions
add-highlighter shared/vuejs/stylus/ default-region fill meta
add-highlighter shared/vuejs/stylus/inner region '\A<style\b.+?\blang="stylus">[^\n]*\K' '(?=</style>)' ref css

add-highlighter shared/vuejs/javascript region -match-capture '^(\h*)<script>' '^(\h*)</script>' regions
add-highlighter shared/vuejs/javascript/ default-region fill meta
add-highlighter shared/vuejs/javascript/inner region '\A<script>[^\n]*\K' '(?=</script>)' ref javascript

add-highlighter shared/vuejs/ts region -match-capture '^(\h*)<script\b.+?\blang="ts">' '^(\h*)</script>' regions
add-highlighter shared/vuejs/ts/ default-region fill meta
add-highlighter shared/vuejs/ts/inner region '\A<script\b.+?\blang="ts">[^\n]*\K' '(?=</script>)' ref typescript

add-highlighter shared/vuejs/js region -match-capture '^(\h*)<script\b.+?\blang="js">' '^(\h*)</script>' regions
add-highlighter shared/vuejs/js/ default-region fill meta
add-highlighter shared/vuejs/js/inner region '\A<script\b.+?\blang="js">[^\n]*\K' '(?=</script>)' ref javascript
}
