From: Gary Thomas <gary@mlbassoc.com>
Subject: DSS: OMAP3530 vs DM3730
Date: Sat, 21 Jan 2012 09:16:38 -0700
Message-ID: <4F1AE4E6.8090000@mlbassoc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040908030504030901000805"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:47549 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab2AUQQk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Jan 2012 11:16:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040908030504030901000805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm running the public 3.0 kernel on my boards.  I have some boards
which can have either OMAP3530 or DM3730 (newer boards have the
newer part, but everything else is the same).

On the OMAP3530, I can enable the graphics overlay on the TV (S-Video)
output via the attached script.  On the DM3730 boards, this crashes
the kernel hard :-(

This same operation seems to be fixed on the 3.2 (public) kernel, but
it's difficult for me to upgrade to that kernel for some other reasons.

Does anyone have an idea why this might happen?  where to look to
isolate the bug(s)?

I tried to back-port the 3.2 DSS code into my 3.0 kernel, but my
simple attempt was pretty much a failure...  If I can, I'd like to
figure out how to just fix the 3.0 code, rather than the full-scale
import of the 3.2 code.

Thanks for any ideas/pointers

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

--------------040908030504030901000805
Content-Type: text/plain;
 name="tv_video"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tv_video"

#! /bin/sh

#
# This script will put the TV (S-Video) into graphics mode,
# mapped onto /dev/fb2
#

ovl0=/sys/devices/platform/omapdss/overlay0
ovl1=/sys/devices/platform/omapdss/overlay1
ovl2=/sys/devices/platform/omapdss/overlay2

mgr0=/sys/devices/platform/omapdss/manager0
mgr1=/sys/devices/platform/omapdss/manager1

lcd=/sys/devices/platform/omapdss/display0
tv=/sys/devices/platform/omapdss/display1

fb0=/sys/class/graphics/fb0
fb1=/sys/class/graphics/fb1
fb2=/sys/class/graphics/fb2

#MODE=${MODE:-ntsc}
MODE=${MODE:-pal}
echo "0" > $tv/enabled
echo ${MODE} >$tv/timings
w=`cat $tv/timings | cut -d "," -f 2 | cut -d "/" -f 1`
h=`cat $tv/timings | cut -d "," -f 3 | cut -d "/" -f 1`
echo "... Setting ${MODE} mode, Width = ${w}, Height = ${h}"

echo "0" > $ovl2/enabled
echo "2" > $fb2/overlays

echo "$w,$h" > $ovl2/output_size
echo "tv" > $ovl2/manager

mem=$((w*h*4))
echo $mem > $fb2/size

echo "1" > $ovl2/enabled
echo "1" > $tv/enabled

fbset -fb /dev/fb2 -nonstd 1


--------------040908030504030901000805--
