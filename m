From: "chandra shekhar" <x0044955@ti.com>
Subject: [PATCH 1/2]  McBSP preamble patch for 34xx support,
Date: Fri, 8 Aug 2008 11:35:14 +0530 (IST)
Message-ID: <65174.192.168.10.89.1218175514.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55328 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527AbYHHGFU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2008 02:05:20 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7865FVH026196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 8 Aug 2008 01:05:20 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7865BXt000201
	for <linux-omap@vger.kernel.org>; Fri, 8 Aug 2008 01:05:13 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This Patch adds base address for all the instances on OMAP34xx and defines some
relevant register.
It also populates McBSP structure for all the instances for 34xx.

Regards,
Chandra Shekhar

Signed-off-by: Chandra Shekhar< x0044955@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c       |   53 +++++++++++++++++++++++++++++++++++---
 include/asm-arm/arch-omap/mcbsp.h |   22 +++++++++++++++
 2 files changed, 71 insertions(+), 4 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/mcbsp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/mcbsp.c	2008-06-25
15:55:52.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/mcbsp.c	2008-06-25 16:01:00.000000000 +0530
@@ -89,6 +89,30 @@
 			.disable	= omap_mcbsp_clk_disable,
 		},
 	},
+	{
+		.clk = {
+			.name		= "mcbsp_clk",
+			.id		= 3,
+			.enable		= omap_mcbsp_clk_enable,
+			.disable	= omap_mcbsp_clk_disable,
+		},
+	},
+	{
+		.clk = {
+			.name		= "mcbsp_clk",
+			.id		= 4,
+			.enable		= omap_mcbsp_clk_enable,
+			.disable	= omap_mcbsp_clk_disable,
+		},
+	},
+	{
+		.clk = {
+			.name		= "mcbsp_clk",
+			.id		= 5,
+			.enable		= omap_mcbsp_clk_enable,
+			.disable	= omap_mcbsp_clk_disable,
+		},
+	},
 };

 #define omap_mcbsp_clks_size	ARRAY_SIZE(omap_mcbsp_clks)
@@ -124,7 +148,7 @@
 #ifdef CONFIG_ARCH_OMAP24XX
 static struct omap_mcbsp_platform_data omap24xx_mcbsp_pdata[] = {
 	{
-		.virt_base	= IO_ADDRESS(OMAP24XX_MCBSP1_BASE),
+		.virt_base	= OMAP2_IO_ADDRESS(OMAP24XX_MCBSP1_BASE),
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
@@ -133,7 +157,7 @@
 		.clk_name	= "mcbsp_clk",
 	},
 	{
-		.virt_base	= IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
+		.virt_base	= OMAP2_IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
@@ -151,7 +175,7 @@
 #ifdef CONFIG_ARCH_OMAP34XX
 static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 	{
-		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP1_BASE),
+		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP1_BASE),
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
@@ -160,7 +184,7 @@
 		.clk_name	= "mcbsp_clk",
 	},
 	{
-		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP2_BASE),
+		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP2_BASE),
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
@@ -168,6 +192,27 @@
 		.ops		= &omap2_mcbsp_ops,
 		.clk_name	= "mcbsp_clk",
 	},
+	{
+		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP3_BASE),
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+	{
+		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP4_BASE),
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+	{
+		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP5_BASE),
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
 };
 #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
 #else
Index: linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h	2008-06-25
15:55:52.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h	2008-06-25
16:03:31.000000000 +0530
@@ -46,6 +46,9 @@

 #define OMAP34XX_MCBSP1_BASE	0x48074000
 #define OMAP34XX_MCBSP2_BASE	0x49022000
+#define OMAP34XX_MCBSP3_BASE	0x49024000
+#define OMAP34XX_MCBSP4_BASE	0x49026000
+#define OMAP34XX_MCBSP5_BASE	0x48096000

 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) ||
defined(CONFIG_ARCH_OMAP730)

@@ -94,6 +97,8 @@
 #define OMAP_MCBSP_REG_DRR1	0x04
 #define OMAP_MCBSP_REG_DXR2	0x08
 #define OMAP_MCBSP_REG_DXR1	0x0C
+#define OMAP_MCBSP_REG_DRR	0x00
+#define OMAP_MCBSP_REG_DXR	0x08
 #define OMAP_MCBSP_REG_SPCR2	0x10
 #define OMAP_MCBSP_REG_SPCR1	0x14
 #define OMAP_MCBSP_REG_RCR2	0x18
@@ -121,6 +126,9 @@
 #define OMAP_MCBSP_REG_RCERH	0x70
 #define OMAP_MCBSP_REG_XCERG	0x74
 #define OMAP_MCBSP_REG_XCERH	0x78
+#define OMAP_MCBSP_REG_SYSCON	0x8C
+#define OMAP_MCBSP_REG_XCCR	0xAC
+#define OMAP_MCBSP_REG_RCCR	0xB0

 #define AUDIO_MCBSP_DATAWRITE	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
 #define AUDIO_MCBSP_DATAREAD	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
@@ -145,6 +153,7 @@
 #define DXENA			0x0080
 #define CLKSTP(value)		((value)<<11)	/* bits 11:12 */
 #define RJUST(value)		((value)<<13)	/* bits 13:14 */
+#define ALB			0x8000
 #define DLB			0x8000

 /************************** McBSP SPCR2 bit definitions ***********************/
@@ -222,6 +231,17 @@
 #define XPABLK(value)		((value)<<5)	/* Bits 5:6 */
 #define XPBBLK(value)		((value)<<7)	/* Bits 7:8 */

+/*********************** McBSP XCCR bit definitions *************************/
+#define DILB			0x0020
+#define XDMAEN			0x0008
+#define XDISABLE		0x0001
+
+/********************** McBSP RCCR bit definitions *************************/
+#define RDMAEN			0x0008
+#define RDISABLE		0x0001
+
+/********************** McBSP SYSCONFIG bit definitions ********************/
+#define SOFTRST			0x0002

 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
@@ -254,6 +274,8 @@
 	OMAP_MCBSP1 = 0,
 	OMAP_MCBSP2,
 	OMAP_MCBSP3,
+	OMAP_MCBSP4,
+	OMAP_MCBSP5
 } omap_mcbsp_id;

 typedef int __bitwise omap_mcbsp_io_type_t;


