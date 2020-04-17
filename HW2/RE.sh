2.	You can use the command egrep to search for multiple matches at once.
Just separate each item with the ‘|’ (bar) character… it means “or”.
For example, egrep 'cow|dog' will find either cow or dog in any line.
For example, to get you started:

egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo
egrep "\[Term\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | perl -p -e 's/\n//g'
egrep ^id:|^name:|^def:|^namespace:" goslim_plant.obo
3.	At some point you may want to remove the invisible linefeeds (\n) at the end of each line.
Sed does not make this easy to do, here’s the command to do it:

sed ':a;N;$!ba;s/\n//g'

That’s not pretty, but it works.
A more intuitive way is to use Perl’s regular expression support.
Rather than use sed you can use this Perl command:

perl -p -e 's/\n//g'

4.	To solve this, you will need both sed and egrep.
But remember that both have slight differences in how they use regular expressions.
If you get confused about how their regular expressions are formed,
take some time to look it up, ask on Slack or use the cheat sheets provided.

5.	A completed solution will have multiple piped commands of egrep and sed (and maybe the Perl hint).


egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | cut -d \n -f  4
# this will split into groups and then split on line every 4th new line


egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed '/\[Typedef\]/,/external/ d' | perl -p -e 's/\n//g' | sed /id/{s/id//;G;G;G;G;}

egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed '/\[Typedef\]/,/external/ d' | perl -p -e 's/\n//g' | sed '{s/\(id\)/g/;G;G;G;G;}'


egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | perl -p -e 's/\n//g' | sed -e 's/Term/Term \
/g' -e 's/GO\:\d+/GO\:\d+ \
/g' -e 's/namespace'
's/name/ \
name/g' -e 's/namespace/ \
namespace/g' -e 's/def/ \
def/g'

egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | perl -p -e 's/\n//g' | perl -p -e 's/id/\nid/g'  | perl -p -e 's/name/\nname/g' | perl -p -e 's/namespace/\nnamespace/g' | perl -p -e 's/def/\ndef/g'
awk '{ print $1 "\t" $2 "\t" $3 "\t" $4 "\n"}'

egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | awk '/id/||/name/'
| awk -F\n '{ print $0 "\t" $1

egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | awk '/id/||/name/||/namespace/||def  { print $1 "\t" $2 "\t" $3 "\t" $4}'


egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | awk 'match($0||$1||$2||$3, /id\:.*/||/name:/||/namespace:/||/def/) { print $0 "\t" $1 }'




egrep "\[Term\]|\[Typedef\]|^id:.*\d$|^name:.*\w$|^def:.*\]$|^namespace:.*\w$" goslim_plant.obo | sed '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | perl -p -e 's/\n//g' |  awk 'match($0||$1||$2||$3, /id.*\d$/||/name.*\w$/||/namespace.*\w$/||/def.*\]$/) { print $0 "\t" $1 "\t" $2 "\t" $3}'

egrep "\[Term\]|\[Typedef\]|^id:.*\d+$|^name:.*\w$|^def:.*\]$|^namespace:.*\w$" goslim_plant.obo | sed '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | perl -p -e 's/\n//g' |  awk 'match($0, /id.*\d+$/) { print $0 }'

egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | awk 'match($0||$1, /id.*$/||/name\:.*\Z) { print $0 "\t" $1 }'





egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | perl -p -e 's/\n/\t/g' | perl -p -e 's/\s/,/'

egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | perl -p -e 's/\n//g' | awk -F'\n'  'match($0, /id.*\t/) { print $0 }'



egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed  '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | perl -p -e 's/\s/\*/g' | perl -p -e 's/id\:/\nid\:/g' | perl -p -e 's/name\:/\nname\:/g' | perl -p -e 's/namespace/\nnamespace/g' | perl -p -e 's/def\:/\ndef\:/g' | column -t'4' -s'\t'



egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed  '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:"
perl -p -e 's/\s/\*/g' | perl -p -e 's/id\:/\nid\:/g' | perl -p -e 's/name\:/\nname\:/g' | perl -p -e 's/namespace/\nnamespace/g' | perl -p -e 's/def\:/\ndef\:/g' | awk 'match($0||$1||$2||$3, /id\:.*\*$/||/name\:.*\*$/||/namespace\:.*\*$/||/def\:.*\*$/) { print $0 "\t" $1 "\t" $2 "\t" $3 "\n"}'


egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed  '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | perl -p -e 's/\s/\*/g' | perl -p -e 's/id\:/\nid\:/g' | perl -p -e 's/name\:/\nname\:/g' | perl -p -e 's/namespace/\nnamespace/g' | perl -p -e 's/def\:/\ndef\:/g' |  awk 'match($1||$2||$3||$4, /id\:.*\*$/||/name\:.*\*$/||/namespace\:.*\*$/||/def\:.*\*$/) { print $1 "\t" $2 "\t" $3 "\t" $4 }'

awk '!NF || !seen[$0]++' |

egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed  '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | perl -p -e 's/\s/\*/g' | perl -p -e 's/id\:/\tid\:/g' | perl -p -e 's/name\:/\tname\:/g' | perl -p -e 's/namespace/\tnamespace/g' | perl -p -e 's/def\:/\tdef\:/g' |  awk -F'\t' '{print $1 "\t" $2 "\t" $3 "\t" $4}'

egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed  '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | perl -p -e 's/\s/\*/g' | awk 'match($1||$2||$3||$4, /id\:.*\*/||/name\:.*/||/namespace\:.*/||/def\:.*/) { print $1 "\t" $2 "\t" $3 "\t" $4}'

egrep "\[Term\]|\[Typedef\]|^id:|^name:|^def:|^namespace:" goslim_plant.obo | sed  '/\[Typedef\]/,/external/ d' | sed '/\[Term\]/d' | perl -p -e 's/\n//g' | perl -p -e 's/id\:/\nid\:/g' | perl -p -e 's/name\:/\tname\:/g' | perl -p -e 's/namespace\:/\tnamespace\:/g' | perl -p -e 's/def\:/\tdef\:/g' | awk -F'\t' '{ print $1 "\t" $2 "\t" $3 "\t" $4}'
