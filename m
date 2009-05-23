From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: [RESUBMIT][PATCH 1/2 ][RFC] OMAP4: McBSP support for OMAP_4430SDP
Date: Sat, 23 May 2009 16:26:54 +0530 (IST)
Message-ID: <55650.192.168.10.89.1243076214.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57758 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166AbZEWK46 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 23 May 2009 06:56:58 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4NAutQw015542
	for <linux-omap@vger.kernel.org>; Sat, 23 May 2009 05:57:00 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n4NAurjm022715
	for <linux-omap@vger.kernel.org>; Sat, 23 May 2009 05:56:54 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


This patch creates McBSP support on OMAP4430 development platform. This patch
includes corresponding base address changes for OMAP4.

Signed-off-by: <rafiuddin.syed@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c             |   46
+++++++++++++++++++++++++++++++- arch/arm/plat-omap/include/mach/mcbsp.h |  
11 ++++++-
 2 files changed, 54 insertions(+), 3 deletions(-)

Index: omap4_dev/arch/arm/mach-omap2/mcbsp.c
=================================================================== ---
omap4_dev.orig/arch/arm/mach-omap2/mcbsp.c
+++ omap4_dev/arch/arm/mach-omap2/mcbsp.c
@@ -169,6 +169,46 @@ static struct omap_mcbsp_platform_data o
 #define OMAP34XX_MCBSP_PDATA_SZ		0
 #endif

+#ifdef CONFIG_ARCH_OMAP4
+static struct omap_mcbsp_platform_data omap44xx_mcbsp_pdata[] = { +	{
+		.phys_base	= OMAP44XX_MCBSP1_BASE,
+		.dma_rx_sync	= OMAP44XX_DMA_MCBSP1_RX,
+		.dma_tx_sync	= OMAP44XX_DMA_MCBSP1_TX,
+		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+	},
+	{
+		.phys_base	= OMAP44XX_MCBSP2_BASE,
+		.dma_rx_sync	= OMAP44XX_DMA_MCBSP2_RX,
+		.dma_tx_sync	= OMAP44XX_DMA_MCBSP2_TX,
+		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+	},
+	{
+		.phys_base	= OMAP44XX_MCBSP3_BASE,
+		.dma_rx_sync	= OMAP44XX_DMA_MCBSP3_RX,
+		.dma_tx_sync	= OMAP44XX_DMA_MCBSP3_TX,
+		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+	},
+	{
+		.phys_base	= OMAP44XX_MCBSP4_BASE,
+		.dma_rx_sync	= OMAP44XX_DMA_MCBSP4_RX,
+		.dma_tx_sync	= OMAP44XX_DMA_MCBSP4_TX,
+		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+	},
+};
+#define OMAP44XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap44xx_mcbsp_pdata) +#else
+#define omap44xx_mcbsp_pdata		NULL
+#define OMAP44XX_MCBSP_PDATA_SZ		0
+#endif
 static int __init omap2_mcbsp_init(void)
 {
 	if (cpu_is_omap2420())
@@ -177,6 +217,8 @@ static int __init omap2_mcbsp_init(void)
 		omap_mcbsp_count = OMAP2430_MCBSP_PDATA_SZ;
 	if (cpu_is_omap34xx())
 		omap_mcbsp_count = OMAP34XX_MCBSP_PDATA_SZ;
+	if (cpu_is_omap44xx())
+		omap_mcbsp_count = OMAP44XX_MCBSP_PDATA_SZ;

 	mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
 								GFP_KERNEL);
@@ -192,7 +234,9 @@ static int __init omap2_mcbsp_init(void)
 	if (cpu_is_omap34xx())
 		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_pdata,
 						OMAP34XX_MCBSP_PDATA_SZ);
-
+	if (cpu_is_omap44xx())
+		omap_mcbsp_register_board_cfg(omap44xx_mcbsp_pdata,
+						OMAP44XX_MCBSP_PDATA_SZ);
 	return omap_mcbsp_init();
 }
 arch_initcall(omap2_mcbsp_init);
Index: omap4_dev/arch/arm/plat-omap/include/mach/mcbsp.h
=================================================================== ---
omap4_dev.orig/arch/arm/plat-omap/include/mach/mcbsp.h
+++ omap4_dev/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -53,7 +53,13 @@
 #define OMAP34XX_MCBSP4_BASE	0x49026000
 #define OMAP34XX_MCBSP5_BASE	0x48096000

-#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) ||
defined(CONFIG_ARCH_OMAP730) +#define OMAP44XX_MCBSP1_BASE	0x49022000
+#define OMAP44XX_MCBSP2_BASE	0x49024000
+#define OMAP44XX_MCBSP3_BASE	0x49026000
+#define OMAP44XX_MCBSP4_BASE	0x48074000
+
+#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || \
+defined(CONFIG_ARCH_OMAP730)

 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x02
@@ -98,7 +104,8 @@
 #define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
 #define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX

-#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) +#elif
defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+defined(CONFIG_ARCH_OMAP4)

 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x04



