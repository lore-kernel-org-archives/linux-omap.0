From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC rev2] ARM: OMAP: Add support for OMAP2430 in McBSP
Date: Mon,  8 Sep 2008 13:29:43 +0300
Message-ID: <1220869784-16607-2-git-send-email-jarkko.nikula@nokia.com>
References: <20080905165641.GI24202@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62374 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbYIHKab (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 06:30:31 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m88ATecK013118
	for <linux-omap@vger.kernel.org>; Mon, 8 Sep 2008 05:30:29 -0500
In-Reply-To: <20080905165641.GI24202@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/mcbsp.c             |   73 ++++++++++++++++++++++++++----
 arch/arm/plat-omap/include/mach/mcbsp.h |    3 +
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 7addc5a..afbe1e6 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -145,8 +145,8 @@ static struct omap_mcbsp_ops omap2_mcbsp_ops = {
 	.request	= omap2_mcbsp_request,
 };
 
-#ifdef CONFIG_ARCH_OMAP24XX
-static struct omap_mcbsp_platform_data omap24xx_mcbsp_pdata[] = {
+#ifdef CONFIG_ARCH_OMAP2420
+static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
 	{
 		.phys_base	= OMAP24XX_MCBSP1_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
@@ -166,10 +166,58 @@ static struct omap_mcbsp_platform_data omap24xx_mcbsp_pdata[] = {
 		.clk_name	= "mcbsp_clk",
 	},
 };
-#define OMAP24XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap24xx_mcbsp_pdata)
+#define OMAP2420_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2420_mcbsp_pdata)
 #else
-#define omap24xx_mcbsp_pdata		NULL
-#define OMAP24XX_MCBSP_PDATA_SZ		0
+#define omap2420_mcbsp_pdata		NULL
+#define OMAP2420_MCBSP_PDATA_SZ		0
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2430
+static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
+	{
+		.phys_base	= OMAP24XX_MCBSP1_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
+		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+	{
+		.phys_base	= OMAP24XX_MCBSP2_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
+		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+	{
+		.phys_base	= OMAP2430_MCBSP3_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+	{
+		.phys_base	= OMAP2430_MCBSP4_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+	{
+		.phys_base	= OMAP2430_MCBSP5_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+};
+#define OMAP2430_MCBSP_PDATA_SZ		ARRAY_SIZE(omap2430_mcbsp_pdata)
+#else
+#define omap2430_mcbsp_pdata		NULL
+#define OMAP2430_MCBSP_PDATA_SZ		0
 #endif
 
 #ifdef CONFIG_ARCH_OMAP34XX
@@ -230,8 +278,10 @@ static int __init omap2_mcbsp_init(void)
 		clk_register(&omap_mcbsp_clks[i].clk);
 	}
 
-	if (cpu_is_omap24xx())
-		omap_mcbsp_count = OMAP24XX_MCBSP_PDATA_SZ;
+	if (cpu_is_omap2420())
+		omap_mcbsp_count = OMAP2420_MCBSP_PDATA_SZ;
+	if (cpu_is_omap2430())
+		omap_mcbsp_count = OMAP2430_MCBSP_PDATA_SZ;
 	if (cpu_is_omap34xx())
 		omap_mcbsp_count = OMAP34XX_MCBSP_PDATA_SZ;
 
@@ -240,9 +290,12 @@ static int __init omap2_mcbsp_init(void)
 	if (!mcbsp_ptr)
 		return -ENOMEM;
 
-	if (cpu_is_omap24xx())
-		omap_mcbsp_register_board_cfg(omap24xx_mcbsp_pdata,
-						OMAP24XX_MCBSP_PDATA_SZ);
+	if (cpu_is_omap2420())
+		omap_mcbsp_register_board_cfg(omap2420_mcbsp_pdata,
+						OMAP2420_MCBSP_PDATA_SZ);
+	if (cpu_is_omap2430())
+		omap_mcbsp_register_board_cfg(omap2430_mcbsp_pdata,
+						OMAP2430_MCBSP_PDATA_SZ);
 	if (cpu_is_omap34xx())
 		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_pdata,
 						OMAP34XX_MCBSP_PDATA_SZ);
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index f4e7980..6a0d1a0 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -43,6 +43,9 @@
 
 #define OMAP24XX_MCBSP1_BASE	0x48074000
 #define OMAP24XX_MCBSP2_BASE	0x48076000
+#define OMAP2430_MCBSP3_BASE	0x4808c000
+#define OMAP2430_MCBSP4_BASE	0x4808e000
+#define OMAP2430_MCBSP5_BASE	0x48096000
 
 #define OMAP34XX_MCBSP1_BASE	0x48074000
 #define OMAP34XX_MCBSP2_BASE	0x49022000
-- 
1.5.6.5

