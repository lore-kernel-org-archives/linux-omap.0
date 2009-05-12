From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: [PATCH 1/2][RFC] OMAP4: McBSP support for OMAP_4430SDP.
Date: Tue, 12 May 2009 11:49:40 +0530 (IST)
Message-ID: <54652.192.168.10.89.1242109180.squirrel@dbdmail.itg.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B4687E57@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36176 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901AbZELGTw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 02:19:52 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B4687E57@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch creates McBSP support on OMAP4430 development platform.
This patch includes corresponding base address changes for OMAP4.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c             |   46 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/mcbsp.h |    8 ++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/arm/mach-omap2/mcbsp.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/mcbsp.c	2009-05-12 10:57:12.000000000 +0530
+++ linux-2.6/arch/arm/mach-omap2/mcbsp.c	2009-05-12 10:57:32.000000000 +0530
@@ -169,6 +169,47 @@
 #define OMAP34XX_MCBSP_PDATA_SZ		0
 #endif

+#ifdef CONFIG_ARCH_OMAP4
+static struct omap_mcbsp_platform_data omap44xx_mcbsp_pdata[] = {
+	{
+		.phys_base      = OMAP44XX_MCBSP1_BASE,
+		.dma_rx_sync    = OMAP44XX_DMA_MCBSP1_RX,
+		.dma_tx_sync    = OMAP44XX_DMA_MCBSP1_TX,
+		.rx_irq         = INT_24XX_MCBSP1_IRQ_RX,
+		.tx_irq         = INT_24XX_MCBSP1_IRQ_TX,
+		.ops            = &omap2_mcbsp_ops,
+	},
+	{
+		.phys_base      = OMAP44XX_MCBSP2_BASE,
+		.dma_rx_sync    = OMAP44XX_DMA_MCBSP2_RX,
+		.dma_tx_sync    = OMAP44XX_DMA_MCBSP2_TX,
+		.rx_irq         = INT_24XX_MCBSP2_IRQ_RX,
+		.tx_irq         = INT_24XX_MCBSP2_IRQ_TX,
+		.ops            = &omap2_mcbsp_ops,
+	},
+	{
+		.phys_base      = OMAP44XX_MCBSP3_BASE,
+		.dma_rx_sync    = OMAP44XX_DMA_MCBSP3_RX,
+		.dma_tx_sync    = OMAP44XX_DMA_MCBSP3_TX,
+		.rx_irq         = INT_24XX_MCBSP3_IRQ_RX,
+		.tx_irq         = INT_24XX_MCBSP3_IRQ_TX,
+		.ops            = &omap2_mcbsp_ops,
+	},
+	{
+		.phys_base      = OMAP44XX_MCBSP4_BASE,
+		.dma_rx_sync    = OMAP44XX_DMA_MCBSP4_RX,
+		.dma_tx_sync    = OMAP44XX_DMA_MCBSP4_TX,
+		.rx_irq         = INT_24XX_MCBSP4_IRQ_RX,
+		.tx_irq         = INT_24XX_MCBSP4_IRQ_TX,
+		.ops            = &omap2_mcbsp_ops,
+	},
+}
+#define OMAP44XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap44xx_mcbsp_pdata)
+#else
+#define omap44xx_mcbsp_pdata		NULL
+#define OMAP44XX_MCBSP_PDATA_SZ		0
+#endif
+
 static int __init omap2_mcbsp_init(void)
 {
 	if (cpu_is_omap2420())
@@ -177,6 +218,8 @@
 		omap_mcbsp_count = OMAP2430_MCBSP_PDATA_SZ;
 	if (cpu_is_omap34xx())
 		omap_mcbsp_count = OMAP34XX_MCBSP_PDATA_SZ;
+	if (cpu_is_omap44xx())
+		omap_mcbsp_count = OMAP44XX_MCBSP_PDATA_SZ;

 	mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
 								GFP_KERNEL);
@@ -192,6 +235,9 @@
 	if (cpu_is_omap34xx())
 		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_pdata,
 						OMAP34XX_MCBSP_PDATA_SZ);
+	if (cpu_is_omap44xx())
+		omap_mcbsp_register_board_cfg(omap44xx_mcbsp_pdata,
+						OMAP44XX_MCBSP_PDATA_SZ);

 	return omap_mcbsp_init();
 }
Index: linux-2.6/arch/arm/plat-omap/include/mach/mcbsp.h
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/include/mach/mcbsp.h	2009-05-12
10:57:12.000000000 +0530
+++ linux-2.6/arch/arm/plat-omap/include/mach/mcbsp.h	2009-05-12
10:58:24.000000000 +0530
@@ -53,6 +53,11 @@
 #define OMAP34XX_MCBSP4_BASE	0x49026000
 #define OMAP34XX_MCBSP5_BASE	0x48096000

+#define OMAP44XX_MCBSP1_BASE	0x49022000
+#define OMAP44XX_MCBSP2_BASE	0x49024000
+#define OMAP44XX_MCBSP3_BASE	0x49026000
+#define OMAP44XX_MCBSP4_BASE	0x48074000
+
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) ||
defined(CONFIG_ARCH_OMAP730)

 #define OMAP_MCBSP_REG_DRR2	0x00
@@ -98,7 +103,8 @@
 #define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
 #define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX

-#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+	defined(CONFIG_ARCH_OMAP4)

 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x04


