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


a="$(tree -a -C -I ".git" --charset=C | fzf --reverse)"
ok=0
#ignore_check=$(perl -pe 's/^(\|( |`|-)+).*$/$1/' <<<$a)
arr=(${(@f)"$(tree -a -I ".git" --charset=C)"})
for ((i=$#arr; i>=1; i--))
do
    if [[ $ok -eq 0 && $arr[i] == "$a" ]]; then
        ok=1
        echo $arr[i]
        t1="$(perl -pe 's/^(( *\|( |`|-)+)+).*$/$1/' <<<$arr[i])"
    fi

    if [[ $ok -eq 1  ]]; then
        t2="$(perl -pe 's/^(( *\|( |`|-)+)+).*$/$1/' <<<$arr[i])"
        if (( $#t1 <= $#t2 )); then
            continue
        fi
        t1="$(perl -pe 's/^(( *\|( |`|-)+)+).*$/$1/' <<<$arr[i])"
        echo $arr[i]
    fi
    if [[ $ok -eq 1 ]]; then
        if [[ $arr[i] =~ '^(\||`)--' ]]; then
            break
        fi
    fi
done | reverse | sed -e 's/|//g;s/`//g;s/ //g;s/-//g' | paste -sd/ -
