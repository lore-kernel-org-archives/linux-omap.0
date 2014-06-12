From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V2 2/2] ARM: DRA7: hwmod: remove interrupts for DMA
Date: Thu, 12 Jun 2014 17:15:23 +0530
Message-ID: <1402573523-13814-3-git-send-email-r.sricharan@ti.com>
References: <1402573523-13814-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60703 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbaFLLrq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jun 2014 07:47:46 -0400
In-Reply-To: <1402573523-13814-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, r.sricharan@ti.com

From: Nishanth Menon <nm@ti.com>

DMA interrupts are now available in of, and the definitions are
duplicates in hwmod. This prevents us from dynamically allocating
interrupt resources for dma from devicetree.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 20b4398..31fd260 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -343,19 +343,10 @@ static struct omap_dma_dev_attr dma_dev_attr = {
 };
 
 /* dma_system */
-static struct omap_hwmod_irq_info dra7xx_dma_system_irqs[] = {
-	{ .name = "0", .irq = 12 + DRA7XX_IRQ_GIC_START },
-	{ .name = "1", .irq = 13 + DRA7XX_IRQ_GIC_START },
-	{ .name = "2", .irq = 14 + DRA7XX_IRQ_GIC_START },
-	{ .name = "3", .irq = 15 + DRA7XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod dra7xx_dma_system_hwmod = {
 	.name		= "dma_system",
 	.class		= &dra7xx_dma_hwmod_class,
 	.clkdm_name	= "dma_clkdm",
-	.mpu_irqs	= dra7xx_dma_system_irqs,
 	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
-- 
1.7.9.5

