From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 1/2] ARM: OMAP: DMA: Fix DMA channel end definition for OMAP36xx-PLUS devices
Date: Thu, 1 Mar 2012 19:10:21 -0600
Message-ID: <1330650621-10887-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51195 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069Ab2CBBKY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Mar 2012 20:10:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, manjugk@ti.com, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

I recently noticed there are a couple bugs in the OMAP2-PLUS DMA driver code.

1. The CCDN DMA register is valid for all OMAP devices from OMAP3630 onwards.
   For OMAP3630+ devices the CCDN register is the upper register in the DMA
   register map and so is used to define the channel end address for a given
   DMA channel. Today the driver code is written to only use the CCDN as the
   upper address for OMAP3630 and OMAP4430 devices where as it should be used
   for all OMAP3630+ devices. Therefore use the CCDN register as the upper
   address in the DMA register map for devices OMAP3630 and beyond.

2. The OMAP2 DMA driver is using the macro cpu_is_omap4430() and from reviewing
   the plat/cpu.h file I see that cpu_is_omap4430() is defined as 0 even when
   CONFIG_ARCH_OMAP4 is defined. This is another bug in of itself (addressed in
   the 2nd patch of this series), but the DMA driver should not be using this.
   Hence, there is a dependency between this patch and the next.

3. Finally, update the comment for the registers CDP, CNDP and CCDP as registers
   for OMAP3630-PLUS devices and not just OMAP4 devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index a59a45a..4fd26b4 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -81,7 +81,7 @@ static u16 reg_map[] = {
 	[CCFN]			= 0xc0,
 	[COLOR]			= 0xc4,
 
-	/* OMAP4 specific registers */
+	/* OMAP36XX-PLUS specific registers */
 	[CDP]			= 0xd0,
 	[CNDP]			= 0xd4,
 	[CCDN]			= 0xd8,
@@ -227,7 +227,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 
 	dma_stride		= OMAP2_DMA_STRIDE;
 	dma_common_ch_start	= CSDP;
-	if (cpu_is_omap3630() || cpu_is_omap4430())
+	if (!cpu_is_omap24xx() && !cpu_is_omap3430())
 		dma_common_ch_end = CCDN;
 	else
 		dma_common_ch_end = CCFN;
-- 
1.7.1

