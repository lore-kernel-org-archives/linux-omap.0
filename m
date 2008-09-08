From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC rev2] ASoC: OMAP: Add support for OMAP2430 and OMAP34xx in McBSP DAI driver
Date: Mon,  8 Sep 2008 13:29:44 +0300
Message-ID: <1220869784-16607-3-git-send-email-jarkko.nikula@nokia.com>
References: <20080905165641.GI24202@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21190 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbYIHKaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 06:30:03 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m88ATaP6018023
	for <linux-omap@vger.kernel.org>; Mon, 8 Sep 2008 13:30:00 +0300
In-Reply-To: <20080905165641.GI24202@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   95 ++++++++++++++++++++++++++++++++++--------
 1 files changed, 77 insertions(+), 18 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 35310e1..a217cf2 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -84,11 +84,22 @@ static const unsigned long omap1_mcbsp_port[][2] = {
 static const int omap1_dma_reqs[][2] = {};
 static const unsigned long omap1_mcbsp_port[][2] = {};
 #endif
-#if defined(CONFIG_ARCH_OMAP2420)
-static const int omap2420_dma_reqs[][2] = {
+
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+static const int omap24xx_dma_reqs[][2] = {
 	{ OMAP24XX_DMA_MCBSP1_TX, OMAP24XX_DMA_MCBSP1_RX },
 	{ OMAP24XX_DMA_MCBSP2_TX, OMAP24XX_DMA_MCBSP2_RX },
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+	{ OMAP24XX_DMA_MCBSP3_TX, OMAP24XX_DMA_MCBSP3_RX },
+	{ OMAP24XX_DMA_MCBSP4_TX, OMAP24XX_DMA_MCBSP4_RX },
+	{ OMAP24XX_DMA_MCBSP5_TX, OMAP24XX_DMA_MCBSP5_RX },
+#endif
 };
+#else
+static const int omap2420_dma_reqs[][2] = {};
+#endif
+
+#if defined(CONFIG_ARCH_OMAP2420)
 static const unsigned long omap2420_mcbsp_port[][2] = {
 	{ OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1,
 	  OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1 },
@@ -96,10 +107,43 @@ static const unsigned long omap2420_mcbsp_port[][2] = {
 	  OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1 },
 };
 #else
-static const int omap2420_dma_reqs[][2] = {};
 static const unsigned long omap2420_mcbsp_port[][2] = {};
 #endif
 
+#if defined(CONFIG_ARCH_OMAP2430)
+static const unsigned long omap2430_mcbsp_port[][2] = {
+	{ OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP2430_MCBSP3_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP2430_MCBSP3_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP2430_MCBSP4_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP2430_MCBSP4_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP2430_MCBSP5_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP2430_MCBSP5_BASE + OMAP_MCBSP_REG_DRR },
+};
+#else
+static const unsigned long omap2430_mcbsp_port[][2] = {};
+#endif
+
+#if defined(CONFIG_ARCH_OMAP34XX)
+static const unsigned long omap34xx_mcbsp_port[][2] = {
+	{ OMAP34XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP34XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP34XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP34XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP34XX_MCBSP3_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP34XX_MCBSP3_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP34XX_MCBSP4_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP34XX_MCBSP4_BASE + OMAP_MCBSP_REG_DRR },
+	{ OMAP34XX_MCBSP5_BASE + OMAP_MCBSP_REG_DXR,
+	  OMAP34XX_MCBSP5_BASE + OMAP_MCBSP_REG_DRR },
+};
+#else
+static const unsigned long omap34xx_mcbsp_port[][2] = {};
+#endif
+
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -167,12 +211,15 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		dma = omap1_dma_reqs[bus_id][substream->stream];
 		port = omap1_mcbsp_port[bus_id][substream->stream];
 	} else if (cpu_is_omap2420()) {
-		dma = omap2420_dma_reqs[bus_id][substream->stream];
+		dma = omap24xx_dma_reqs[bus_id][substream->stream];
 		port = omap2420_mcbsp_port[bus_id][substream->stream];
+	} else if (cpu_is_omap2430()) {
+		dma = omap24xx_dma_reqs[bus_id][substream->stream];
+		port = omap2430_mcbsp_port[bus_id][substream->stream];
+	} else if (cpu_is_omap343x()) {
+		dma = omap24xx_dma_reqs[bus_id][substream->stream];
+		port = omap34xx_mcbsp_port[bus_id][substream->stream];
 	} else {
-		/*
-		 * TODO: Add support for 2430 and 3430
-		 */
 		return -ENODEV;
 	}
 	omap_mcbsp_dai_dma_params[id][substream->stream].dma_req = dma;
@@ -310,7 +357,7 @@ static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
 				       int clk_id)
 {
 	int sel_bit;
-	u16 reg;
+	u16 reg, reg_devconf1 = OMAP243X_CONTROL_DEVCONF1;
 
 	if (cpu_class_is_omap1()) {
 		/* OMAP1's can use only external source clock */
@@ -320,6 +367,12 @@ static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
 			return 0;
 	}
 
+	if (cpu_is_omap2420() && mcbsp_data->bus_id > 1)
+		return -EINVAL;
+
+	if (cpu_is_omap343x())
+		reg_devconf1 = OMAP343X_CONTROL_DEVCONF1;
+
 	switch (mcbsp_data->bus_id) {
 	case 0:
 		reg = OMAP2_CONTROL_DEVCONF0;
@@ -329,20 +382,26 @@ static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
 		reg = OMAP2_CONTROL_DEVCONF0;
 		sel_bit = 6;
 		break;
-	/* TODO: Support for ports 3 - 5 in OMAP2430 and OMAP34xx */
+	case 2:
+		reg = reg_devconf1;
+		sel_bit = 0;
+		break;
+	case 3:
+		reg = reg_devconf1;
+		sel_bit = 2;
+		break;
+	case 4:
+		reg = reg_devconf1;
+		sel_bit = 4;
+		break;
 	default:
 		return -EINVAL;
 	}
 
-	if (cpu_class_is_omap2()) {
-		if (clk_id == OMAP_MCBSP_SYSCLK_CLKS_FCLK) {
-			omap_ctrl_writel(omap_ctrl_readl(reg) &
-					 ~(1 << sel_bit), reg);
-		} else {
-			omap_ctrl_writel(omap_ctrl_readl(reg) |
-					 (1 << sel_bit), reg);
-		}
-	}
+	if (clk_id == OMAP_MCBSP_SYSCLK_CLKS_FCLK)
+		omap_ctrl_writel(omap_ctrl_readl(reg) & ~(1 << sel_bit), reg);
+	else
+		omap_ctrl_writel(omap_ctrl_readl(reg) | (1 << sel_bit), reg);
 
 	return 0;
 }
-- 
1.5.6.5

