From: Nishanth Menon <nm@ti.com>
Subject: [RFC] DSPBRIDGE: Kill CAMelCaSiNg
Date: Thu, 17 Sep 2009 09:23:08 -0500
Message-ID: <4AB2464C.6010005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50569 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbZIQOXG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Sep 2009 10:23:06 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8HENA6a012270
	for <linux-omap@vger.kernel.org>; Thu, 17 Sep 2009 09:23:10 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n8HEN9TL025433
	for <linux-omap@vger.kernel.org>; Thu, 17 Sep 2009 09:23:09 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n8HEN9R4014543
	for <linux-omap@vger.kernel.org>; Thu, 17 Sep 2009 09:23:09 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi All,
Ref [1] w.r.t some patchset seen on linux driver project having a 
similar condition of ton of camelcasing and [2],

Can we consider running the following script for DSPBridge code? or if 
there are some more improvements folks can think of..

-----
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
DIR_FILE=`echo "$1"|sed -e "s/\//\\\//g"`
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
# All files will be made unix file only (no point in dos + unix mixtures..)

#**
#* @brief - changes camel casing to ones with smaller case
#*
camel_to_norm(){
echo $1|tr '\_' '+' |sed 's/\([A-Z]\)/_\l\1/g' | sed 's/^_\([a-z]\)/\1/g' |\
  tr 'A-Z' 'a-z' | sed "s/\([a-z][a-z]\+\)/-\1-/g"|tr -d '_'|\
  tr '-' '_'|sed -e "s/_$//g"|sed -e "s/^_//g" | tr '+' '_' |\
  sed -e "s/__*/_/g"|sed -e "s/_\([0-9][0-9]*\)/\1/g"|\
  sed -e "s/^[a-z]\_\([a-z][a-z]\+\)/\1/g"


}

#**
#* @brief - all_to_upper - Moves all to upper case
#*
all_to_upper(){
camel_to_norm $1 | tr 'a-z' 'A-Z'
}

#**
#* @brief generate_list - will generate list of symbols from tags matching
#*
generate_list() {
cut -d' ' -f1,4 $TMPFILE|grep "$1\$"|cut -d' ' -f1|sort|uniq
}

#**
#* @brief find_files - finds list of files from tag file matching usage
#*
find_files(){
cut -d' ' -f1,2 $TMPFILE|grep "^$1"|cut -d' ' -f2|sort|uniq
}
TMPFILE=/tmp/cleaner.$$.tmp
TMPFILE1=/tmp/cleaner.$$.1.tmp
# grab the output for only the ones we want..
grep  "$DIR_FILE" tags |grep -v "^\!"|sed -e 
"s/\/\^.*\"/REPLACE_1/g">$TMPFILE

replace_pattern(){
echo "=====>Search and replace for pattern $1 with $2"
# Convert the functions back to smaller case and replace them in the files
for token in `generate_list "[$1]"`
do
  if [ $2 -eq "1" ]; then
   new=`camel_to_norm $token`
  else
   new=`all_to_upper $token`
  fi
  if [ "$new" != "$token" ]; then
   echo "==>Replacing $token with $low"
   for file in `find_files $low`
   do
    echo "->replacing $token to $new in file $file"
    cp $file $TMPFILE1
    dos2unix $TMPFILE1
    sed -e "s/\(W*\)$token\(\W*\)/\1$new\2/g" $TMPFILE1>$file
   done
  else
   echo "==>not replacing $token"
  fi
done
}
echo "================= Replacing Defines ==============="
replace_pattern d 2
echo "================= Replacing Functions ==============="
replace_pattern efgmpstvx 1
rm -f $TMPFILE $TMPFILE1

-----

-- 
Regards,
Nishanth Menon
Ref:
[1] 
http://driverdev.linuxdriverproject.org/pipermail/devel/2009-September/002482.html
[2] 
http://nishanthmenon.blogspot.com/2009/08/replace-camelcasing-with-lowercasing.html
