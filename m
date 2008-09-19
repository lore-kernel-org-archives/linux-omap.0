From: notaz <notasas@gmail.com>
Subject: [PATCH] ARM: OMAP: Add missing McBSP interrupts
Date: Fri, 19 Sep 2008 17:24:36 +0300
Message-ID: <6ed0b2680809190724g717e20f7k446c681ea48deca5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:61059 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbYISOYh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 10:24:37 -0400
Received: by gxk9 with SMTP id 9so715973gxk.13
        for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 07:24:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I was trying to get audio going through McBSP3, and was getting this:

omap-mcbsp omap-mcbsp.3: Unable to request RX IRQ 0 for McBSP3

This patch fixes the problem for me.

-------------------------------------------------------------------------
From: Grazvydas Ignotas <notasas@gmail.com>

Transmit and receive interrupts must be specified for McBSP
driver to work with McBSP 3-5.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/mcbsp.c            |    6 ++++++
 arch/arm/plat-omap/include/mach/irqs.h |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index afbe1e6..81c0d8b 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -244,6 +244,8 @@ static struct omap_mcbsp_platform_data
omap34xx_mcbsp_pdata[] = {
 		.phys_base	= OMAP34XX_MCBSP3_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
+		.rx_irq		= INT_34XX_MCBSP3_IRQ_RX,
+		.tx_irq		= INT_34XX_MCBSP3_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
 		.clk_name	= "mcbsp_clk",
 	},
@@ -251,6 +253,8 @@ static struct omap_mcbsp_platform_data
omap34xx_mcbsp_pdata[] = {
 		.phys_base	= OMAP34XX_MCBSP4_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
+		.rx_irq		= INT_34XX_MCBSP4_IRQ_RX,
+		.tx_irq		= INT_34XX_MCBSP4_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
 		.clk_name	= "mcbsp_clk",
 	},
@@ -258,6 +262,8 @@ static struct omap_mcbsp_platform_data
omap34xx_mcbsp_pdata[] = {
 		.phys_base	= OMAP34XX_MCBSP5_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
+		.rx_irq		= INT_34XX_MCBSP5_IRQ_RX,
+		.tx_irq		= INT_34XX_MCBSP5_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
 		.clk_name	= "mcbsp_clk",
 	},
diff --git a/arch/arm/plat-omap/include/mach/irqs.h
b/arch/arm/plat-omap/include/mach/irqs.h
index e51e5e6..2858847 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -316,11 +316,17 @@
 #define INT_34XX_USIM_IRQ	35
 #define INT_34XX_WDT3_IRQ	36
 #define INT_34XX_SPI4_IRQ	48
+#define INT_34XX_MCBSP4_IRQ_TX	54
+#define INT_34XX_MCBSP4_IRQ_RX	55
 #define INT_34XX_I2C3_IRQ	61
 #define INT_34XX_PBIAS_IRQ	75
 #define INT_34XX_OHCI_IRQ	76
 #define INT_34XX_EHCI_IRQ	77
 #define INT_34XX_TLL_IRQ	78
+#define INT_34XX_MCBSP5_IRQ_TX	81
+#define INT_34XX_MCBSP5_IRQ_RX	82
+#define INT_34XX_MCBSP3_IRQ_TX	89
+#define INT_34XX_MCBSP3_IRQ_RX	90
 #define INT_34XX_MMC3_IRQ	94
 #define INT_34XX_GPT12_IRQ	95

-- 
1.5.4.3
