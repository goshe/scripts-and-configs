# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias kill9='kill -9 '
alias psg='ps aux | grep '
alias ll='ls -la'
alias svn_add="svn status | grep '?' | sed 's/^.* /svn add /' | bash"

# find with md5sum
findm(){
  md5sum `find "$1" -name "$2"`
}


# Show failed tests among all the surefire results.
function failedtests() {
    for DIR in $(find . -maxdepth 3 -type d -name "surefire-reports") ; do
        ruby -ne 'puts "#$FILENAME : #$&" if $_ =~ /(Failures: [1-9][0-9]*.*|Errors: [1-9][0-9]*.*)/' $DIR/*.txt
    done
}

# Show the top tests that took the longest time to run from maven surefire reports
function slowtests() {
    FILES=''
    for DIR in $(find . -maxdepth 10 -type d -name "surefire-reports") ; do
        FILES="$FILES $DIR/*.txt"
    done
    head -q -n 4 $FILES \
        | ruby -ne 'gets; print $_.chomp + " "; gets; print gets' \
        | ruby -ane 'printf "%8.03f sec: ", $F[-2].to_f; puts $_' \
        | sort  \
        | head -10
}
