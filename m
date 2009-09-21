From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] DSPBRIDGE: Kill CAMelCaSiNg
Date: Mon, 21 Sep 2009 15:05:50 +0300
Message-ID: <94a0d4530909210505n2871f902yb5b5885547fbaefc@mail.gmail.com>
References: <4AB2464C.6010005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:65046 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345AbZIUMFs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 08:05:48 -0400
Received: by bwz6 with SMTP id 6so1875519bwz.37
        for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2009 05:05:50 -0700 (PDT)
In-Reply-To: <4AB2464C.6010005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Sep 17, 2009 at 5:23 PM, Nishanth Menon <nm@ti.com> wrote:
> Hi All,
> Ref [1] w.r.t some patchset seen on linux driver project having a sim=
ilar
> condition of ton of camelcasing and [2],
>
> Can we consider running the following script for DSPBridge code? or i=
f there
> are some more improvements folks can think of..

Yes, I think we should do that, and make some sort of release,
possibly squashing all the changes... my current branch counts 218
commits.

> -----
> #!/bin/bash
> # Silly little script to replace CaMELCaSInG to lower_casing
> # Half a zillion thoughts later,
> # why not use ctags which has c interpreter already to do
> # function identification for us?
> if [ ! -r 'tags' =C2=A0]; then
> echo "Sorry.. no tags file!"
> exit 1
> fi
> if [ ! -r "$1" ]; then
> echo "I need a directory or a file for replacing.."
> exit 2
> fi
> DIR_FILE=3D`echo "$1"|sed -e "s/\//\\\//g"`
> # tags have the following notation in field 4 (tab seperated)
> # e - enum value
> # d - define
> # f - function
> # F - File itself
> # g - enum type
> # m - structure parameter
> # p - prototype
> # r - kconfig define(refered)
> # s - structure type
> # t - typedefined variable
> # v - variable
> # x - extern defined variable
> # we can choose to have different rules:
> # rename rule i am going to follow:
> # Any define -> convert camelcase to lower_case_define->convert to ca=
ps
> # Any function, enum,struct param,prototype,struct type, typedef var,=
extern
> def ->
> # camel_case to lower_case_define
> # All files will be made unix file only (no point in dos + unix mixtu=
res..)
>
> #**
> #* @brief - changes camel casing to ones with smaller case
> #*
> camel_to_norm(){
> echo $1|tr '\_' '+' |sed 's/\([A-Z]\)/_\l\1/g' | sed 's/^_\([a-z]\)/\=
1/g' |\
> =C2=A0tr 'A-Z' 'a-z' | sed "s/\([a-z][a-z]\+\)/-\1-/g"|tr -d '_'|\
> =C2=A0tr '-' '_'|sed -e "s/_$//g"|sed -e "s/^_//g" | tr '+' '_' |\
> =C2=A0sed -e "s/__*/_/g"|sed -e "s/_\([0-9][0-9]*\)/\1/g"|\
> =C2=A0sed -e "s/^[a-z]\_\([a-z][a-z]\+\)/\1/g"
>
>
> }
>
> #**
> #* @brief - all_to_upper - Moves all to upper case
> #*
> all_to_upper(){
> camel_to_norm $1 | tr 'a-z' 'A-Z'
> }
>
> #**
> #* @brief generate_list - will generate list of symbols from tags mat=
ching
> #*
> generate_list() {
> cut -d' ' -f1,4 $TMPFILE|grep "$1\$"|cut -d' ' -f1|sort|uniq
> }

It looks like my tag file was tabs instead of spaces, so that line
makes everything explode... how about:
awk "\$4 ~ /[$1]/ { print \$1 }" $TMPFILE | sort | uniq

> #**
> #* @brief find_files - finds list of files from tag file matching usa=
ge
> #*
> find_files(){
> cut -d' ' -f1,2 $TMPFILE|grep "^$1"|cut -d' ' -f2|sort|uniq
> }

Maybe:
awk "\$1 ~ /^$1/ { print \$2 }" $TMPFILE | sort | uniq

> TMPFILE=3D/tmp/cleaner.$$.tmp
> TMPFILE1=3D/tmp/cleaner.$$.1.tmp
> # grab the output for only the ones we want..
> grep =C2=A0"$DIR_FILE" tags |grep -v "^\!"|sed -e
> "s/\/\^.*\"/REPLACE_1/g">$TMPFILE
>
> replace_pattern(){
> echo "=3D=3D=3D=3D=3D>Search and replace for pattern $1 with $2"
> # Convert the functions back to smaller case and replace them in the =
files
> for token in `generate_list "[$1]"`
> do
> =C2=A0if [ $2 -eq "1" ]; then
> =C2=A0new=3D`camel_to_norm $token`
> =C2=A0else
> =C2=A0new=3D`all_to_upper $token`
> =C2=A0fi
> =C2=A0if [ "$new" !=3D "$token" ]; then
> =C2=A0echo "=3D=3D>Replacing $token with $low"

There's no $low, I guess you meant $new.

> =C2=A0for file in `find_files $low`

Did you mean $token?

> =C2=A0do
> =C2=A0 echo "->replacing $token to $new in file $file"
> =C2=A0 cp $file $TMPFILE1
> =C2=A0 dos2unix $TMPFILE1

This is simpler:
dos2unix -n $file $TMPFILE1

However, I think dos2unix should be run separately.

> =C2=A0 sed -e "s/\(W*\)$token\(\W*\)/\1$new\2/g" $TMPFILE1>$file

This is simpler:
sed -e "s/\<$token\>/$new/g" $TMPFILE1 > $file

> =C2=A0done
> =C2=A0else
> =C2=A0echo "=3D=3D>not replacing $token"

No need to say that.

> =C2=A0fi
> done
> }
> echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Replacing D=
efines =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
> replace_pattern d 2
> echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Replacing F=
unctions =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
> replace_pattern efgmpstvx 1
> rm -f $TMPFILE $TMPFILE1

I did a few more cleanups (yeah, I'm too picky) and here's the result.
Unfortunately I still think it needs some work in the camel conversion
(E_FOO, __FOOBAR__, etc.)

----
#!/bin/bash

# Silly little script to replace CaMELCaSInG to lower_casing
# Half a zillion thoughts later,
# why not use ctags which has c interpreter already to do
# function identification for us?

if [ ! -r 'tags'  ]; then
	echo "Sorry.. no tags file!"
	exit 1
fi

if [ ! -r "$1" ]; then
	echo "I need a directory or a file for replacing.."
	exit 2
fi

DIR_FILE=3D`echo "$1" | sed -e "s/\//\\\//g"`

# tags have the following notation in field 4 (tab seperated)
# e - enum value
# d - define
# f - function
# F - File itself
# g - enum type
# m - structure parameter
# p - prototype
# r - kconfig define(refered)
# s - structure type
# t - typedefined variable
# v - variable
# x - extern defined variable
# we can choose to have different rules:
# rename rule i am going to follow:
# Any define -> convert camelcase to lower_case_define->convert to caps
# Any function, enum,struct param,prototype,struct type, typedef
var,extern def ->
# camel_case to lower_case_define
# All files will be made unix file only (no point in dos + unix mixture=
s..)

#**
#* @brief - changes camel casing to ones with smaller case
#*
camel_to_norm() {
	echo $1 | tr '\_' '+' | sed 's/\([A-Z]\)/_\l\1/g' | sed
's/^_\([a-z]\)/\1/g' | \
	tr 'A-Z' 'a-z' | sed "s/\([a-z][a-z]\+\)/-\1-/g" | tr -d '_'| \
	tr '-' '_' | sed -e "s/_$//g" | sed -e "s/^_//g" | tr '+' '_' | \
	sed -e "s/__*/_/g" | sed -e "s/_\([0-9][0-9]*\)/\1/g" | \
	sed -e "s/^[a-z]\_\([a-z][a-z]\+\)/\1/g"
}

#**
#* @brief - all_to_upper - Moves all to upper case
#*
all_to_upper() {
	camel_to_norm $1 | tr 'a-z' 'A-Z'
}

#**
#* @brief generate_list - will generate list of symbols from tags match=
ing
#*
generate_list() {
	awk "\$4 ~ /[$1]/ { print \$1 }" $TMPFILE | sort | uniq
}

#**
#* @brief find_files - finds list of files from tag file matching usage
#*
find_files() {
	awk "\$1 ~ /^$1/ { print \$2 }" $TMPFILE | sort | uniq
}

TMPFILE=3D/tmp/cleaner.$$.tmp
TMPFILE1=3D/tmp/cleaner.$$.1.tmp

# grab the output for only the ones we want..
grep "$DIR_FILE" tags | grep -v "^\!" | sed -e
"s/\/\^.*\"/REPLACE_1/g" > $TMPFILE

replace_pattern() {
	echo "=3D=3D=3D=3D=3D> Search and replace for pattern $1 with $2"
	# Convert the functions back to smaller case and replace them in the f=
iles
	for token in `generate_list $1`
	do
		if [ $2 -eq "1" ]; then
			new=3D`camel_to_norm $token`
		else
			new=3D`all_to_upper $token`
		fi
		if [ "$new" !=3D "$token" ]; then
			# echo "=3D=3D> Replacing '$token' with '$new'"
			for file in `find_files $token`
			do
				echo "=3D=3D> Replacing $token to $new in file $file"
				dos2unix -n $file $TMPFILE1
				sed -e "s/\<$token\>/$new/g" $TMPFILE1 > $file
			done
		fi
	done
}

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Replacing Def=
ines =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
replace_pattern d 2
echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Replacing Fun=
ctions =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
replace_pattern efgmpstvx 1

rm -f $TMPFILE $TMPFILE1
----

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
