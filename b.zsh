#!/bin/zsh

. $DOTPATH/etc/lib/corelib.sh

#a="$(tree -a -C -I ".git" --charset=C | fzf --reverse)"
#ok=0
#ignore_check=$(perl -pe 's/^(\|( |`|-)+).*$/$1/' <<<$a)
#arr=(${(@f)"$(tree -a -I ".git" --charset=C)"})
#for ((i=$#arr; i>=1; i--));do
#    if [[ $arr[i] == "$a" ]]; then
#        ok=1
#        echo $arr[i]
#    fi
#    if [[ $ok -eq 1  ]]; then
#        #[[ $arr[i] == "$a" ]] && echo $arr[i]
#        if [[ $ignore_check != $(perl -pe 's/^(\|( |`|-)+).*$/$1/' <<<$arr[i]) ]];then
#            echo $arr[i]
#        fi
#    fi
#    if [[ $ok -eq 1 && $arr[i] =~ "^\|--" ]]; then
#        break
#    fi
#done | reverse | sed -e 's/|//g;s/`//g;s/ //g;s/-//g' | paste -sd/ -


#a="$(tree -a -C -I ".git" --charset=C | fzf --reverse)"


    #if [[ $make_dir -eq 0 ]]; then tree -a -C -I ".git" --charset=C; else echo **/* | tr ' ' '\n'; fi \

    #if [[ $make_dir -eq 0 ]]; then tree -a -C -I ".git" --charset=C \
    #    | fzf --ansi --multi --no-sort --reverse --query="$q" \
    #    --print-query --expect=ctrl-v --exit-0; \
    #else \
    #    fzf --ansi --multi --no-sort --reverse --query="$q" \
    #    --print-query --expect=ctrl-v --exit-0; fi
while : ${make_dir:=0}; out="$(
    if [[ $make_dir -eq 0 ]]; then tree -a -C -I ".git" --charset=C ${1:-.}; else find ${1:-.} -path '*.git*' -prune -o -print | sed -e 's|^\./||'; fi \
        | fzf --ansi --multi --no-sort --reverse --query="$q" \
        --print-query --expect=ctrl-v --exit-0
    )"; do
    q="$(head -1 <<< "$out")"
    k="$(head -2 <<< "$out" | tail -1)"
    res="$(sed '1,2d;/^$/d' <<< "$out")"
    [ -z "$res" ] && continue
    if [ "$k" = "ctrl-v" ]; then
        if [ $make_dir -eq 0 ]; then
            make_dir=1
        else
            make_dir=0
        fi
        continue
    else
        if [[ $make_dir -eq 0 ]]; then
            ok=0
            arr=(${(@f)"$(tree -a -I ".git" --charset=C ${1:-.})"})
            for ((i=1; i<=$#arr; i++)); do
                if [[ $arr[i] == $res ]]; then
                    n=$i
                    break
                fi
            done
            arr=(${(@f)"$(tree -a -I ".git" --charset=C -f ${1:-.})"})
            perl -pe 's/^(( *\|( |`|-)+)+)//' <<<$arr[n] \
                | sed -e 's/ -> .*$//'
        else
            echo $res
        fi
        exit
    fi
done

#ok=0
##ignore_check=$(perl -pe 's/^(\|( |`|-)+).*$/$1/' <<<$a)
#arr=(${(@f)"$(tree -a -I ".git" --charset=C)"})
#for ((i=$#arr; i>=1; i--))
#do
#    if [[ $ok -eq 0 && $arr[i] == "$a" ]]; then
#        ok=1
#        echo $arr[i]
#        t1="$(perl -pe 's/^(( *\|( |`|-)+)+).*$/$1/' <<<$arr[i])"
#    fi
#
#    if [[ $ok -eq 1  ]]; then
#        t2="$(perl -pe 's/^(( *\|( |`|-)+)+).*$/$1/' <<<$arr[i])"
#        if (( $#t1 <= $#t2 )); then
#            continue
#        fi
#        t1="$(perl -pe 's/^(( *\|( |`|-)+)+).*$/$1/' <<<$arr[i])"
#        echo $arr[i]
#    fi
#    if [[ $ok -eq 1 ]]; then
#        if [[ $arr[i] =~ '^(\||`)--' ]]; then
#            break
#        fi
#    fi
#done | reverse | sed -e 's/|//g;s/`//g;s/ //g;s/-//g' | paste -sd/ -
