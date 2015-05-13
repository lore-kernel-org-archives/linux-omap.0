From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 00/27] ARM: OMAP2+: clock code migration to
 drivers/clk/ti
Date: Wed, 13 May 2015 14:55:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1505131438430.7921@utopia.booyaka.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1505111747460.19833@utopia.booyaka.com> <5551D178.3000904@ti.com> <alpine.DEB.2.02.1505122019220.21747@utopia.booyaka.com> <5552F32C.7060606@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41334 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934300AbbEMOzE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2015 10:55:04 -0400
In-Reply-To: <5552F32C.7060606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Wed, 13 May 2015, Tero Kristo wrote:

> I clipped the boot-loader traces as they contain lots of noise from the
> test-automation system.
> 
> Looking at the farm traces, I see this on the omap3 boards:
> 
> beagleboard-vanilla.txt:ver=U-Boot 2014.04-00071-g8543283 (Apr 22 2014 -
> 15:49:50)
> 
> beagle-xm.txt:U-Boot 2014.10-00004-g9ade0ab-dirty (Dec 16 2014 - 13:40:24)
> 
> craneboard.txt:U-Boot 2009.11-00005-ge83d2db (Dec 07 2010 - 11:55:34)
> 
> ldp.txt:U-Boot 2014.04-00071-g8543283-dirty (Apr 25 2014 - 14:59:48)
> 
> n900.txt:U-Boot 2014.04-00073-g4fa5b9e (Apr 22 2014 - 14:37:10)
> 
> sdp3430.txt:U-Boot 2009.11-rc1-00485-g7d1e865 (Nov 09 2009 - 11:21:55)
> 
> Maybe some DTB issues? When did you update your DTB files?

For all of the uImage+DTB boots, the DTB files in use follow the kernel 
version:

http://www.pwsan.com/omap/testlogs/test_v4.1-rc1/20150426200156/dtbs/

which are then subsequently combined to produce:

http://www.pwsan.com/omap/testlogs/test_v4.1-rc1/20150426200156/dtcat/

So, using the OMAP35xx Beagle as an example, you can prove to yourself 
that the current DTB is in use by observing that U-boot is loading a 
combined uImage+DTB file of 3495180 bytes from here:

http://www.pwsan.com/omap/testlogs/test_v4.1-rc1/20150426200156/boot/3530es3beagle/3530es3beagle_log.txt

and comparing that with the size of this file (3495180 bytes):

http://www.pwsan.com/omap/testlogs/test_v4.1-rc1/20150426200156/dtcat/omap2plus_defconfig/uImage-dtb.omap3-beagle

and observing that this file size is the sum of the DTB file size (63180 
bytes):

http://www.pwsan.com/omap/testlogs/test_v4.1-rc1/20150426200156/dtbs/omap3-beagle.dtb

and the zImage file size (3431936 bytes):

http://www.pwsan.com/omap/testlogs/test_v4.1-rc1/20150426200156/build_z/omap2plus_defconfig/zImage

and the 64 byte uImage header.


The only board that I suspect may be using an old DTB is the 4460 
VAR-SOM-OM.


- Paul
