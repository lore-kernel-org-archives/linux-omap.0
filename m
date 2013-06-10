From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH] ARM: OMAP4: hwmod data: Remove irq entries from mcspi, mmc hwmods
Date: Mon, 10 Jun 2013 12:15:20 +0530
Message-ID: <1370846720-6709-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36587 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336Ab3FJGpz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Jun 2013 02:45:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: r.sricharan@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, paul@pwsan.com, t-kristo@ti.com, ambresh@ti.com

Commit '3b9b10151c6838af52244cec4af41a938bb5b7ec' cleaned up the
data file to remove all irq and dma entries for all hwmods, which
are now populated by DT. But mcspi and mmc irq, dma entries were
retained since MMC, NFS boot was not working. Since it is root caused
to be an issue with only DMA entries [1], irq can be safely removed.

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg90115.html

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   54 ----------------------------
 1 file changed, 54 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 5f5d631..11e579b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1747,11 +1747,6 @@ static struct omap_hwmod_class omap44xx_mcspi_hwmod_class = {
 };
 
 /* mcspi1 */
-static struct omap_hwmod_irq_info omap44xx_mcspi1_irqs[] = {
-	{ .irq = 65 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_dma_info omap44xx_mcspi1_sdma_reqs[] = {
 	{ .name = "tx0", .dma_req = 34 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx0", .dma_req = 35 + OMAP44XX_DMA_REQ_START },
@@ -1773,7 +1768,6 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mcspi1_irqs,
 	.sdma_reqs	= omap44xx_mcspi1_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
@@ -1787,11 +1781,6 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 };
 
 /* mcspi2 */
-static struct omap_hwmod_irq_info omap44xx_mcspi2_irqs[] = {
-	{ .irq = 66 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_dma_info omap44xx_mcspi2_sdma_reqs[] = {
 	{ .name = "tx0", .dma_req = 42 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx0", .dma_req = 43 + OMAP44XX_DMA_REQ_START },
@@ -1809,7 +1798,6 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.name		= "mcspi2",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mcspi2_irqs,
 	.sdma_reqs	= omap44xx_mcspi2_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
@@ -1823,11 +1811,6 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 };
 
 /* mcspi3 */
-static struct omap_hwmod_irq_info omap44xx_mcspi3_irqs[] = {
-	{ .irq = 91 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_dma_info omap44xx_mcspi3_sdma_reqs[] = {
 	{ .name = "tx0", .dma_req = 14 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx0", .dma_req = 15 + OMAP44XX_DMA_REQ_START },
@@ -1845,7 +1828,6 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.name		= "mcspi3",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mcspi3_irqs,
 	.sdma_reqs	= omap44xx_mcspi3_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
@@ -1859,11 +1841,6 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 };
 
 /* mcspi4 */
-static struct omap_hwmod_irq_info omap44xx_mcspi4_irqs[] = {
-	{ .irq = 48 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_dma_info omap44xx_mcspi4_sdma_reqs[] = {
 	{ .name = "tx0", .dma_req = 69 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx0", .dma_req = 70 + OMAP44XX_DMA_REQ_START },
@@ -1879,7 +1856,6 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.name		= "mcspi4",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mcspi4_irqs,
 	.sdma_reqs	= omap44xx_mcspi4_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
@@ -1915,11 +1891,6 @@ static struct omap_hwmod_class omap44xx_mmc_hwmod_class = {
 };
 
 /* mmc1 */
-static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] = {
-	{ .irq = 83 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_dma_info omap44xx_mmc1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 60 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 61 + OMAP44XX_DMA_REQ_START },
@@ -1935,7 +1906,6 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.name		= "mmc1",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.mpu_irqs	= omap44xx_mmc1_irqs,
 	.sdma_reqs	= omap44xx_mmc1_sdma_reqs,
 	.main_clk	= "hsmmc1_fclk",
 	.prcm = {
@@ -1949,11 +1919,6 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 };
 
 /* mmc2 */
-static struct omap_hwmod_irq_info omap44xx_mmc2_irqs[] = {
-	{ .irq = 86 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_dma_info omap44xx_mmc2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 46 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 47 + OMAP44XX_DMA_REQ_START },
@@ -1964,7 +1929,6 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.name		= "mmc2",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.mpu_irqs	= omap44xx_mmc2_irqs,
 	.sdma_reqs	= omap44xx_mmc2_sdma_reqs,
 	.main_clk	= "hsmmc2_fclk",
 	.prcm = {
@@ -1977,11 +1941,6 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 };
 
 /* mmc3 */
-static struct omap_hwmod_irq_info omap44xx_mmc3_irqs[] = {
-	{ .irq = 94 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_dma_info omap44xx_mmc3_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 76 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 77 + OMAP44XX_DMA_REQ_START },
@@ -1992,7 +1951,6 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	.name		= "mmc3",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mmc3_irqs,
 	.sdma_reqs	= omap44xx_mmc3_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
@@ -2005,11 +1963,6 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 };
 
 /* mmc4 */
-static struct omap_hwmod_irq_info omap44xx_mmc4_irqs[] = {
-	{ .irq = 96 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_dma_info omap44xx_mmc4_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 56 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 57 + OMAP44XX_DMA_REQ_START },
@@ -2020,7 +1973,6 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	.name		= "mmc4",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mmc4_irqs,
 	.sdma_reqs	= omap44xx_mmc4_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
@@ -2033,11 +1985,6 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 };
 
 /* mmc5 */
-static struct omap_hwmod_irq_info omap44xx_mmc5_irqs[] = {
-	{ .irq = 59 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_dma_info omap44xx_mmc5_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 58 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 59 + OMAP44XX_DMA_REQ_START },
@@ -2048,7 +1995,6 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	.name		= "mmc5",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mmc5_irqs,
 	.sdma_reqs	= omap44xx_mmc5_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
-- 
1.7.9.5

