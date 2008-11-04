From: Rick Bronson <rick@efn.org>
Subject: Re: What happened to the serial console on BeagleBoard with 2.6.28-rc2?
Date: Tue, 04 Nov 2008 13:08:24 -0800
Message-ID: <E1KxT8S-0003jm-KJ@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:53945 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031AbYKDVI0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Nov 2008 16:08:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: david-b@pacbell.net, linux-omap@vger.kernel.org, nmonson@gmail.com, felipe.contreras@gmail.com, tom.leiming@gmail.com

Hi Tony,

  I tried your patch to drivers/serial/8250.c and it works fine.  I
was concerned that I would start seeing:

omapfb: omapfb blah blah interrupt 0x4000

  (sorry, can't remember the exact verbage) because I saw them at one
point during the many reboots I did while working on the serial port
problem.  But I didn't see any after about 20 reboots.

  I assume you mean the patch below but why do you want this one if
your 8250.c patch works?

  Rick


Signed-off-by: Rick Bronson <rick@efn.org>

--- linux-omap-2.6/arch/arm/mach-omap2/io.c.~1~	2008-10-28 10:10:25.000000000 -0700
+++ linux-omap-2.6/arch/arm/mach-omap2/io.c	2008-11-01 14:58:35.000000000 -0700
@@ -155,7 +155,7 @@ static struct map_desc omap34xx_io_desc[
 		.virtual	= L4_PER_34XX_VIRT,
 		.pfn		= __phys_to_pfn(L4_PER_34XX_PHYS),
 		.length		= L4_PER_34XX_SIZE,
-		.type		= MT_DEVICE
+		.type		= MT_MEMORY_SO  /* debug only */
 	},
 	{
 		.virtual	= L4_EMU_34XX_VIRT,


> Rick, can you please reply with your Signed-off-by for your patch?
> 
> Let's push that one, then continue thinking about the so/device
> issues.
> 
> Tony
> 
