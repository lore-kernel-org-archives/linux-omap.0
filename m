From: rafiuddin.syed@ti.com
Subject: [PATCH 2/4] ARM: OMAP4: McBSP Support om OMAP4430
Date: Tue,  7 Jul 2009 14:17:08 +0530
Message-ID: <1246956430-24863-2-git-send-email-rafiuddin.syed@ti.com>
References: <1246956430-24863-1-git-send-email-rafiuddin.syed@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47631 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753800AbZGGIr2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jul 2009 04:47:28 -0400
In-Reply-To: <1246956430-24863-1-git-send-email-rafiuddin.syed@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Syed Rafiuddin <rafiuddin.syed@ti.com>

From: Syed Rafiuddin <rafiuddin.syed@ti.com>

This patch adds McBSP support on OMAP4430 development platform. This patch
includes corresponding base address changes for OMAP4.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c             |   41 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/mcbsp.h |    8 +++++-
 2 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index a5c0f04..d49dfb5 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -169,6 +169,42 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 #define OMAP34XX_MCBSP_PDATA_SZ		0
 #endif
 
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
+};
+#define OMAP44XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap44xx_mcbsp_pdata)
+
 static int __init omap2_mcbsp_init(void)
 {
 	if (cpu_is_omap2420())
@@ -177,6 +213,8 @@ static int __init omap2_mcbsp_init(void)
 		omap_mcbsp_count = OMAP2430_MCBSP_PDATA_SZ;
 	if (cpu_is_omap34xx())
 		omap_mcbsp_count = OMAP34XX_MCBSP_PDATA_SZ;
+	if (cpu_is_omap44xx())
+		omap_mcbsp_count = OMAP44XX_MCBSP_PDATA_SZ;
 
 	mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
 								GFP_KERNEL);
@@ -192,6 +230,9 @@ static int __init omap2_mcbsp_init(void)
 	if (cpu_is_omap34xx())
 		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_pdata,
 						OMAP34XX_MCBSP_PDATA_SZ);
+	if (cpu_is_omap44xx())
+		omap_mcbsp_register_board_cfg(omap44xx_mcbsp_pdata,
+						OMAP44XX_MCBSP_PDATA_SZ);
 
 	return omap_mcbsp_init();
 }
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index bb154ea..313c31c 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -53,6 +53,11 @@
 #define OMAP34XX_MCBSP4_BASE	0x49026000
 #define OMAP34XX_MCBSP5_BASE	0x48096000
 
+#define OMAP44XX_MCBSP1_BASE	0x49022000
+#define OMAP44XX_MCBSP2_BASE	0x49024000
+#define OMAP44XX_MCBSP3_BASE	0x49026000
+#define OMAP44XX_MCBSP4_BASE	0x48096000
+
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730)
 
 #define OMAP_MCBSP_REG_DRR2	0x00
@@ -98,7 +103,8 @@
 #define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
 #define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
 
-#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+	defined(CONFIG_ARCH_OMAP4)
 
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x04
-- 
1.5.4.7

