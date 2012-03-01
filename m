From: "Graham, Jeff" <Jeff.Graham@brukeroptics.com>
Subject: omap4 rotation support
Date: Thu, 1 Mar 2012 14:55:43 -0500
Message-ID: <F752F64AD8BC1D42B49B877FEE3CD34901FD4F05@USTED.BOPTUS.OPTIK.LAN>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.bruker.com ([173.13.75.234]:46866 "EHLO mx1.bruker.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856Ab2CAUFd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 15:05:33 -0500
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap Mailing List <linux-omap@vger.kernel.org>
Cc: "Graham, Jeff" <Jeff.Graham@brukeroptics.com>

Hello,

I have a variscite OM44 (omap4 4460 SOM) that I need to rotate the
display on but I cannot make it work.

I am currently using kernel 3.1.5 and the Ubuntu 11.10 from Linaro.

I have tried each of these ways to make it work:

1. From the command line as root the command 'xrandr -o left'
   This fails with an error

2. From uboot I tried adding: 'omapfb.tiler=y omapfb.mirror=y
omapfb.rotate=1'
   This seems to have no effect at all. I also tried using omapdss
instead of omapfb in the above
   three lines, but I am not certain which is correct for what.

   I saw a comment that omap dss rotate does not work for omap4 for
Linux but does work for Android.
   Bummer.

3. I tried steps from this website:
http://omappedia.org/wiki/Bootargs_for_enabling_display
     echo "1" > /sys/class/graphics/fb0/mirror  (this fails because
mirror does not exist)

     cat /sys/class/graphics/fb0/rotate_type     (this fails because
rotate_type does not exist)

     echo "1" > /sys/class/graphics/fb0/rotate   (as root this seems to
be accepted, but nothing
                                                  happens. Tried
stopping lightdm before and
                                                  restarting after this
command but no effect)


Can anyone say if this should be possible (and in what kernel or uboot
versions) or perhaps more important WHEN it might be usable?

Thanks,
Jeff


