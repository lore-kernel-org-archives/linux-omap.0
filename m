From: Manfred <manfred@student.ethz.ch>
Subject: linux-omap3-2.6.39: spurious irq 95, during heavy SD card load
Date: Thu, 3 Nov 2011 09:46:30 +0000 (UTC)
Message-ID: <loom.20111103T103055-675@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50972 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754871Ab1KCJuK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Nov 2011 05:50:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RLtw0-0007AM-Re
	for linux-omap@vger.kernel.org; Thu, 03 Nov 2011 10:50:08 +0100
Received: from quackm-ifa.ee.ethz.ch ([129.132.29.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 03 Nov 2011 10:50:08 +0100
Received: from manfred by quackm-ifa.ee.ethz.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 03 Nov 2011 10:50:08 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Dear users/developers, 

I am trying to install the xenomai real-time linux on a gumstix overo fire with
an omap3530. 
After some starting problems, I succeed to patch the 2.6.33 kernel and run some
latency tests
 with normal worst case latencies ~60us. However, the overall worst case latency
is very bad (5ms), 
because i occasionally get spurious interrupt errors like this:
Spurious irq 95: 0xffffffdf, please flush posted write for irq 86
Spurious irq 95: 0xffffffdf, please flush posted write for irq 86

I then tried the precompiled development images
(http://cumulus.gumstix.org/images/angstrom/developer/), 
which use kernel 2.6.39, but I also get these messages there. 
To reproduce the error, I did the following:
1.) Boot:
Linux overo 2.6.39 #1 Mon Aug 15 19:04:09 PDT 2011 armv7l GNU/Linux
booting from SD card.

2.)
dd if=/dev/zero of=ddfile bs=100000 count=1000
--> creates a 1GB file in /home/root
3.)
connect to wireless:
iwconfig wlan0 mode ad-hoc
iwconfig wlan0 essid myovero
ifconfig wlan0 192.168.1.33 netmask 255.255.255.0 up
4.)a)
then pull via scp  ddfile onto your dev. machine.
scp scp username@192.168.1.33:/home/root/ddfile .
4.)b)
at the same time create a second empty file on the sd-card:
dd if=/dev/zero of=ddfile2 bs=100000 count=4000

--> output in dmesg:
Spurious irq 95: 0xffffffdf, please flush posted write for irq 86
Spurious irq 95: 0xffffffdf, please flush posted write for irq 86

whenever i write a new file that is bigger then the first one, 
I get two instances of this message:
Spurious irq 95: 0xffffffdf, please flush posted write for irq 86
Spurious irq 95: 0xffffffdf, please flush posted write for irq 86
Spurious irq 95: 0xffffffdf, please flush posted write for irq 86
Spurious irq 95: 0xffffffdf, please flush posted write for irq 86
Spurious irq 95: 0xffffffdf, please flush posted write for irq 86
Spurious irq 95: 0xffffffdf, please flush posted write for irq 86

I am not sure if it is related to the SD-reader driver, or the 
wireless (libertas_SDIO) driver, or only the combination of both.


This issue seemed to have already existed in previous kernel versions, 
there are many posts on the web, some of them saying it has been fixed in kernel
version >2.6.30, 
which seems however not apply to the linux-omap3-2.6.39 kernel.

The latest message about spurious irqs that i could find is related to kernel
3.0-rc1.
Has anyone running an kernel-3.0 on an omap3530 (perhaps overo fire) and could
try to reproduce? 

Or is there a specific patch to resolve this?
I was not able to reproduce this on the NAND-flash, 
but it is also to small to make large continous data transfers. 

Any help with this is appreciated. 

Regards, 
Manfred



