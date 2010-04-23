From: Peter Barada <peter.barada@gmail.com>
Subject: Need help understanding sporadic errors on OMAP35x YAFFS/NAND system
Date: Fri, 23 Apr 2010 10:29:03 -0400
Message-ID: <l2p738b3f7e1004230729ib7c69d04uad3e9cb2cca89309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.211.194]:54666 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0DWO3F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 10:29:05 -0400
Received: by ywh32 with SMTP id 32so5688285ywh.33
        for <linux-omap@vger.kernel.org>; Fri, 23 Apr 2010 07:29:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I've got a sporadic problem that I'm seeing using NAND/YAFFS on a
Logic LV SOM using a 1928 block YAFFS filesystem.

I've got the 2.6.32 kernel (L23 Poky from
http://www.omappedia.org/wiki/OMAP_Poky) up and running, and
sporadically in testing I
observe an error where 0xff30 shows up in the data read back from the
file - looks somewhat
similar to: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg23103.html

Testing involves using "dd if=/dev/zero of=/mnt/yaffs/<file> bs=1
seek=30M count=0" to create a 30MB file of
zeros and then copies the file around on the flash, md5sum, syncing,
etc to thrash the cache.

The error I'm seeing is that when I read the file back, its md5sum
does not match that of what a 30MB file of zeros should generate.
To verify, I copy the file from the NAND to a temporary file in RAM,
then md5sum that file and if the md5sum mimsmatches, then I hexdump
the file to see where the data mismatches. This all runs fin in my
test shell script, except after a while (somewhere around 30+GB read
from NAND), I see:

somefile.7: mismatch 666896a98683a364c10aeba0649f119c != 281ed1d5ae50e8419f9b978
aab16de83
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
1107800 ff30 ff30 ff30 ff30 ff30 ff30 ff30 ff30
*
1107a00 0000 0000 0000 0000 0000 0000 0000 0000
*
1e00000

instead of the zeros I'd expect.  Originally I thought the problem was
in the NAND where somehow the driver tried to read a sector of data
before it was ready, but if this was the case, I'd expect an ECC error
from the comparison (using Hardware generated ECC, prefetch and DMA).
This is not the case (I added a printk that triggers if
omap_compare_ecc() returns non-zero).  So if no ECC error is reported
then the data should be valid on NAND.  To test if the data was not
written correctly I unmounted the filesystem and remounted it, but
then the md5sum does match.

This is not the first I've seen of the problem.  I've see it in a
2.6.28-rc8 kernel, and in the 2.6.32 kernel I've tried turning off
DMA, prefetch, and that hastens when the error turns up (and the
number of 0xff30 shorts seein).  I modified my testing to use a unique
pattern intead of zeros and found when the 0xff30 shows up, it repeats
for a number of shorts at the start of a page, then I see the data
that I expected from the page. I've also modified the NAND driver to
use a dev_ready function (as well as statistics to track how long it
waits polling the R/B# line on WAIT0 that indicate its 21.2uS +/-
8.29uS once the call to omap_device_ready is made), and still no joy.

I've also run this code on a 2.6.33-rc3 kernel with the same driver
set and there it works flawlessly.  Unfortunately I need the Poky
kernel...

At this point I'm at a loss to explain what is happening:

1) Has anyone seen this type of error before?

2) Are there any OMAP35x errata that could possibly explain what I'm seeing?

3) Has anyone done exhaustive testing of NAND-based filesystem on an
OMAP35x board?

4) Any suggestions where to look next? (YAFFS testing with nandsim on
an x86 doesn't exhibit the problem).

The following is the original test script (cd into the mountpoint of
the NAND filesystem before running):

#!/bin/bash

# MD5sum of 30M and 1K of zeros
md5_30M=281ed1d5ae50e8419f9b978aab16de83
md5_1K=0f343b0931126a20f133d67c2b018a3b

# temp file to use as intermediary copy
tmpfile=/dev/tmp/junk
#tmpfile=/tmp/junk
mkdir -p `dirname $tmpfile`

mismatches=0
pass=0
passes=120
if [ "$1" != "" ]; then
    passes="$1"
fi


# $1 is file
# $2 is good checksum
    chk_md5sum() {
	for cmf in $1
	do
	    cp $cmf $tmpfile
	    ret=`md5sum $tmpfile | cut -d" " -f1`
	    if [ "$ret" != "$2" ]; then
		echo "$cmf: mismatch $ret != $2"
		hexdump < $tmpfile | head -100
		mismatches=`expr $mismatches + 1`
	    else
		echo "$cmf: match $ret"
	    fi
	done
    }

# $1 is src
# $2 is destination
# $3 is expected md5sum of source
    chk_cp() {
	cp $1 $tmpfile
	cp $tmpfile $2
	ret=`md5sum $tmpfile | cut -d" " -f1`
	if [ "$ret" != "$3" ]; then
	    echo "$1: mismatch $ret != $3"
	    hexdump < $tmpfile | head -100
	    mismatches=`expr $mismatches + 1`
	fi
    }

while [ $pass -lt $passes ]; do
    pass=`expr $pass + 1`
    echo "Pass: $pass Errors: $mismatches"
    date

# create a 30 M file
    echo "Create 30M file of zeros and get md5sum"
    dd if=/dev/zero of=somefile.1 bs=1 seek=30M count=0

    chk_md5sum somefile.1 $md5_30M

# create copies of file
    for f in 2 3 4 ;
    do
	cp somefile.1 somefile.$f
    done

    echo "Calculate md5sums for copied files"
    chk_md5sum "somefile.*" $md5_30M
    if [ "$mismatches" != "0" ]; then
	break;
    fi

    echo "execute sync and recalculate md5sums"
    sync
    chk_md5sum "somefile.*" $md5_30M
    if [ "$mismatches" != "0" ]; then
	break;
    fi

    echo "Delete one of the files"
    rm somefile.2

    echo "recopy the deleted file"
    cp somefile.1 somefile.7
    chk_md5sum "somefile.*" $md5_30M
    if [ "$mismatches" != "0" ]; then
	break;
    fi

    echo "Creating test folder and some junk files in that folder"
    mkdir -p test

    cd test

    dd if=/dev/random of=junk.1 bs=1 count=0 seek=1k

    chk_md5sum junk.1 $md5_1K
    if [ "$mismatches" != "0" ]; then
	break;
    fi

    for f in 2 3 4 5 6 7 8 9;
    do
	chk_cp junk.1 junk.$f $md5_1K
	if [ "$mismatches" != "0" ]; then
	    break;
	fi
    done

    echo "md5sums of all files in test folder"
    chk_md5sum "junk.*" $md5_1K
    if [ "$mismatches" != "0" ]; then
	break;
    fi

    echo "execute sync and recalculate md5sums"
    sync

    chk_md5sum "junk.*" $md5_1K
    if [ "$mismatches" != "0" ]; then
	break;
    fi

    echo "Remove some files and recreate them"
    for f in  3 5 8;
    do
	rm junk.$f
    done

    for f in  8 3 5;
    do
	chk_cp junk.1 junk.$f $md5_1K
	if [ "$mismatches" != "0" ]; then
	    break;
	fi
    done

    cd ..

    echo "Calculate md5sums for 30M files again"
    chk_md5sum "somefile.*" $md5_30M
    if [ "$mismatches" != "0" ]; then
	break;
    fi

    echo "execute sync and recalculate md5sums"
    sync
    chk_md5sum "somefile.*" $md5_30M
    if [ "$mismatches" != "0" ]; then
	break;
    fi

    if [ -f /proc/yaffs ]; then
	cat /proc/yaffs
    fi
    if [ -f /proc/nand-wait-stats ]; then
	cat /proc/nand-wait-stats
    fi
done
