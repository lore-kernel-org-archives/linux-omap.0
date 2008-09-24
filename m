From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] ARM: OMAP: Add support for McBSP devices 3 - 5 on 34xx
Date: Wed, 24 Sep 2008 16:29:13 +0300
Message-ID: <1222262955-13599-4-git-send-email-tony@atomide.com>
References: <1222262955-13599-1-git-send-email-tony@atomide.com>
 <1222262955-13599-2-git-send-email-tony@atomide.com>
 <1222262955-13599-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61935 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbYIXN3o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 09:29:44 -0400
In-Reply-To: <1222262955-13599-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Chandra Shekhar <x0044955@ti.com>, Tony Lindgren <tony@atomide.com>

From: Chandra Shekhar <x0044955@ti.com>

Based on Chandra's earlier patches in linux-omap tree.

Signed-off-by: Chandra Shekhar <x0044955@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mcbsp.c             |   56 ++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/mcbsp.h |    5 +++
 2 files changed, 60 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 73f2279..b4fe0f3 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -28,7 +28,7 @@ struct mcbsp_internal_clk {
 	int n_childs;
 };
 
-#if defined(CONFIG_ARCH_OMAP24XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 static void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
 {
 	const char *clk_names[] = { "mcbsp_ick", "mcbsp_fck" };
@@ -89,6 +89,30 @@ static struct mcbsp_internal_clk omap_mcbsp_clks[] = {
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
@@ -168,6 +192,33 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.ops		= &omap2_mcbsp_ops,
 		.clk_name	= "mcbsp_clk",
 	},
+	{
+		.phys_base	= OMAP34XX_MCBSP3_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
+		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+	{
+		.phys_base	= OMAP34XX_MCBSP4_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
+		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+	{
+		.phys_base	= OMAP34XX_MCBSP5_BASE,
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
+		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
 };
 #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
 #else
@@ -198,6 +249,9 @@ static int __init omap2_mcbsp_init(void)
 	if (cpu_is_omap24xx())
 		omap_mcbsp_register_board_cfg(omap24xx_mcbsp_pdata,
 						OMAP24XX_MCBSP_PDATA_SZ);
+	if (cpu_is_omap34xx())
+		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_pdata,
+						OMAP34XX_MCBSP_PDATA_SZ);
 
 	return omap_mcbsp_init();
 }
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 46898fa..f4e7980 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -46,6 +46,9 @@
 
 #define OMAP34XX_MCBSP1_BASE	0x48074000
 #define OMAP34XX_MCBSP2_BASE	0x49022000
+#define OMAP34XX_MCBSP3_BASE	0x49024000
+#define OMAP34XX_MCBSP4_BASE	0x49026000
+#define OMAP34XX_MCBSP5_BASE	0x48096000
 
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730)
 
@@ -267,6 +270,8 @@ typedef enum {
 	OMAP_MCBSP1 = 0,
 	OMAP_MCBSP2,
 	OMAP_MCBSP3,
+	OMAP_MCBSP4,
+	OMAP_MCBSP5
 } omap_mcbsp_id;
 
 typedef int __bitwise omap_mcbsp_io_type_t;
-- 
1.5.6.rc3.21.g8c6b5

