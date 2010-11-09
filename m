From: Rick Bronson <rick@efn.org>
Subject: RE: Mistral AM37x (with AM3715) devel board networking broken
Date: Mon, 08 Nov 2010 20:53:39 -0800
Message-ID: <E1PFgDD-0002jm-KX@amazonia.comcast.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from efn.org ([206.192.230.249]:34961 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418Ab0KIExj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 23:53:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: premi@ti.com

Hi Sanjeev,

  Thanks much for the help.

> I tried building the latest on l-o master and was able to boot consistently
> in 4 times I tried. Didn't notice the gpio clock related error I noticed in
> your boot log.
> 
> 
> U-Boot 2010.09 (Nov 08 2010 - 17:11:45)
> 
> OMAP3630/3730-GP ES2.0, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
> OMAP3 EVM board + LPDDR/NAND

 Note that mine is ES1.0 (yours is ES2.0):

OMAP3630/3730-GP ES1.0, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz                

  Not sure if that's any clue.

  Tonight I got the latest stuff:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

  and built it up with:

make omap2plus_defconfig ARCH=arm

  And got this

http://www.efn.org/~rick/pub/boot6.log

  It's basically the same, I get the 3 warnings and sometimes eth0 works
and sometimes it doesn't.  Note that my board works flawlessly with
the kernel on the SD Card.

  What compiler are you using?  I tried CodeSourcery
2009q1 and 2010q1 with the same results.

  How did you configure your u-boot?

  Could you send me your boot up text?  Could you send me your
u-boot.bin (and or your uImage) so I can try it?  I might help me
figure out what's going on.

 Thanks again.

 Rick
