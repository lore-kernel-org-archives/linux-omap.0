From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: Add __arm_ioremap_exec for mapping external
 memory as MT_MEMORY
Date: Fri, 7 Oct 2011 08:11:17 -0700
Message-ID: <20111007151116.GI6324@atomide.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
 <20111005004539.26980.52409.stgit@kaulin.local>
 <alpine.LFD.2.02.1110042059110.9106@xanadu.home>
 <20111005220619.GC6324@atomide.com>
 <4E8E9EE8.8010106@ti.com>
 <20111007144349.GE6324@atomide.com>
 <4E8F14A6.5050402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25768 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab1JGPLW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 11:11:22 -0400
Content-Disposition: inline
In-Reply-To: <4E8F14A6.5050402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111007 07:29]:
> On Friday 07 October 2011 08:13 PM, Tony Lindgren wrote:
> > 
> > ..so I think we should just have a separate static mapping for
> > the omap4 errata fix SO page, and just limit the memory available
> > for SRAM code to ioremap.
> > 
> > How does that sounds to you?
> > 
> That's more or less what the patch is already doing.
> Instead of static mapping, I was dynamically stealing one
> page ( SZ_4K) and mapping it as MT_MEMORY_SO and rest
> of the memory as MT_MEMORY for OMAP4.

Yeah cool.
 
> It should be doable with your updates as well,
> I guess with or without static mapping since the only
> requisite is to keep one page of SRAM free on OMAP4 and
> them map them using  iotable_init() with MT_MEMORY_SO.

How about something like the following, this won't compile
without at least moving the defines around a bit, but shows
what I had in mind:

--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -238,6 +238,14 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
 		.length		= L4_EMU_44XX_SIZE,
 		.type		= MT_DEVICE,
 	},
+#ifdef CONFIG_OMAP4_ERRATA_I688
+	{
+		.virtual	= OMAP4_SRAM_VA,
+		.pfn		= __phys_to_pfn(OMAP4_SRAM_PA),
+		.length		= PAGE_SIZE,
+		.type		= MT_MEMORY_SO,
+	},
+#endif
 };
 #endif
 
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -125,6 +125,9 @@ static void __init omap_detect_sram(void)
 				omap_sram_size = 0x10000; /* 64K */
 			} else if (cpu_is_omap44xx()) {
 				omap_sram_start = OMAP4_SRAM_PA;
+#ifdef CONFIG_OMAP4_ERRATA_I688
+				omap_sram_start += PAGE_SIZE;
+#endif
 				omap_sram_size = 0xe000; /* 56K */
 			} else {
 				omap_sram_start = OMAP2_SRAM_PA;

Eventually the SRAM code will be a generic driver, so let's try
to keep the errata fix out of the SRAM code.

Tony
