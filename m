From: Mohamed Thalib H <hmthalib@gmail.com>
Subject: Error while rotating LCD fb - detected fb_set_par error, error code:
 -22
Date: Fri, 27 May 2011 15:40:19 +0530
Message-ID: <4DDF788B.5030906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:47387 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758691Ab1E0KKc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 May 2011 06:10:32 -0400
Received: by pxi16 with SMTP id 16so988216pxi.4
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 03:10:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi,

I am using a omap3530 
<http://focus-webapps.ti.com/general/docs/sitesearch/searchdevice.tsp?partNumber=omap3530> 
based board. I am trying to rotate the LCD 
using*/sys/class/graphics/fb0/rotate*. The rotation works only for 0 
degree and 270 degrees.

When trying to rotate for 90 or 180 degree it give error message 
*detected fb_set_par error, error code: -22 *and does not rotate.

The log output is below.*
*

/ # cat /proc/cmdline
omapdss.def_disp=lcd30 console=ttyS2,115200n8 root=/dev/mmcblk0p2 rw 
rootfstype=ext3
  rootwait lpj=1949696 omapfb.rotate=1 omapfb.rotate_type=1 
omap_vout.vid1_static_vrf
b_alloc=y omapfb.vrfb=y
/ # echo "0" > /sys/class/graphics/fb0/rotate
detected fb_set_par error, error code: -22
/ # echo "1" > /sys/class/graphics/fb0/rotate
/ # echo "2" > /sys/class/graphics/fb0/rotate
detected fb_set_par error, error code: -22
/ # echo "3" > /sys/class/graphics/fb0/rotate
/ # echo "1" > /sys/class/graphics/fb0/rotate

Can some one help me in solving this issue.

Regards,
HM Thalib

