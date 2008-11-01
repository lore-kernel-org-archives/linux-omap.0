From: Rick Bronson <rick@efn.org>
Subject: Re: What happened to the serial console on BeagleBoard with 2.6.28-rc2?
Date: Sat, 01 Nov 2008 15:25:12 -0700
Message-ID: <E1KwOu8-0005NM-LE@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:44265 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbYKAWZQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 1 Nov 2008 18:25:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nmonson@gmail.com


  Ignore the last patch I posted.

  I'm not sure this is the right fix for this problem but it seems to
work ;-)  Here is what's happening

  In drivers/serial/8250.c size_fifo() miscalculates the fifo size of
the 3rd UART.  The first 2 UART's calculations are okay.  The 3rd's
miscalculation causes the console port to be messed up.  When I tried
putting debug code in, the problem would sometimes go away (or come
back) depending on what debug code I put in.  So I thought maybe it
was the memory mapping type that was chosen for the UART io memory
range.  That's what led to this patch.  Try it out and tell me if it
works for you.

  I have to wonder if L4_WK_34XX_VIRT needs to be classified as
MT_MEMORY_SO also?

  Rick

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
