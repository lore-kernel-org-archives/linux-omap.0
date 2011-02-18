From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 12/13] ASoC: McBSP: get hw params from McBSP driver
Date: Fri, 18 Feb 2011 19:52:27 +0530
Message-ID: <1298038948-19871-13-git-send-email-kishon@ti.com>
References: <1298038948-19871-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49629 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758246Ab1BRO2R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 09:28:17 -0500
In-Reply-To: <1298038948-19871-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, jhnikula@gmail.com, peter.ujfalusi@nokia.com
Cc: p-basak2@ti.com, kishon@ti.com, charu@ti.com, shubhrajyoti@ti.com

Removed the use of macros to obtain base address and DMA channel number.
Instead use the McBSP driver API's that passes base address and DMA
channel number to the client driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap-mcbsp.c |  126 ++-----------------------------------------
 1 files changed, 4 insertions(+), 122 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index ede6afd..2175f09 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -69,110 +69,6 @@ static struct omap_mcbsp_data mcbsp_data[NUM_LINKS];
  */
 static struct omap_pcm_dma_data omap_mcbsp_dai_dma_params[NUM_LINKS][2];
 
-#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
-static const int omap1_dma_reqs[][2] = {
-	{ OMAP_DMA_MCBSP1_TX, OMAP_DMA_MCBSP1_RX },
-	{ OMAP_DMA_MCBSP2_TX, OMAP_DMA_MCBSP2_RX },
-	{ OMAP_DMA_MCBSP3_TX, OMAP_DMA_MCBSP3_RX },
-};
-static const unsigned long omap1_mcbsp_port[][2] = {
-	{ OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1,
-	  OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1 },
-	{ OMAP1510_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1,
-	  OMAP1510_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1 },
-	{ OMAP1510_MCBSP3_BASE + OMAP_MCBSP_REG_DXR1,
-	  OMAP1510_MCBSP3_BASE + OMAP_MCBSP_REG_DRR1 },
-};
-#else
-static const int omap1_dma_reqs[][2] = {};
-static const unsigned long omap1_mcbsp_port[][2] = {};
-#endif
-
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-static const int omap24xx_dma_reqs[][2] = {
-	{ OMAP24XX_DMA_MCBSP1_TX, OMAP24XX_DMA_MCBSP1_RX },
-	{ OMAP24XX_DMA_MCBSP2_TX, OMAP24XX_DMA_MCBSP2_RX },
-#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
-	{ OMAP24XX_DMA_MCBSP3_TX, OMAP24XX_DMA_MCBSP3_RX },
-	{ OMAP24XX_DMA_MCBSP4_TX, OMAP24XX_DMA_MCBSP4_RX },
-	{ OMAP24XX_DMA_MCBSP5_TX, OMAP24XX_DMA_MCBSP5_RX },
-#endif
-};
-#else
-static const int omap24xx_dma_reqs[][2] = {};
-#endif
-
-#if defined(CONFIG_ARCH_OMAP4)
-static const int omap44xx_dma_reqs[][2] = {
-	{ OMAP44XX_DMA_MCBSP1_TX, OMAP44XX_DMA_MCBSP1_RX },
-	{ OMAP44XX_DMA_MCBSP2_TX, OMAP44XX_DMA_MCBSP2_RX },
-	{ OMAP44XX_DMA_MCBSP3_TX, OMAP44XX_DMA_MCBSP3_RX },
-	{ OMAP44XX_DMA_MCBSP4_TX, OMAP44XX_DMA_MCBSP4_RX },
-};
-#else
-static const int omap44xx_dma_reqs[][2] = {};
-#endif
-
-#if defined(CONFIG_SOC_OMAP2420)
-static const unsigned long omap2420_mcbsp_port[][2] = {
-	{ OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1,
-	  OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1 },
-	{ OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1,
-	  OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1 },
-};
-#else
-static const unsigned long omap2420_mcbsp_port[][2] = {};
-#endif
-
-#if defined(CONFIG_SOC_OMAP2430)
-static const unsigned long omap2430_mcbsp_port[][2] = {
-	{ OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR },
-	{ OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR },
-	{ OMAP2430_MCBSP3_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP2430_MCBSP3_BASE + OMAP_MCBSP_REG_DRR },
-	{ OMAP2430_MCBSP4_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP2430_MCBSP4_BASE + OMAP_MCBSP_REG_DRR },
-	{ OMAP2430_MCBSP5_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP2430_MCBSP5_BASE + OMAP_MCBSP_REG_DRR },
-};
-#else
-static const unsigned long omap2430_mcbsp_port[][2] = {};
-#endif
-
-#if defined(CONFIG_ARCH_OMAP3)
-static const unsigned long omap34xx_mcbsp_port[][2] = {
-	{ OMAP34XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP34XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR },
-	{ OMAP34XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP34XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR },
-	{ OMAP34XX_MCBSP3_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP34XX_MCBSP3_BASE + OMAP_MCBSP_REG_DRR },
-	{ OMAP34XX_MCBSP4_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP34XX_MCBSP4_BASE + OMAP_MCBSP_REG_DRR },
-	{ OMAP34XX_MCBSP5_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP34XX_MCBSP5_BASE + OMAP_MCBSP_REG_DRR },
-};
-#else
-static const unsigned long omap34xx_mcbsp_port[][2] = {};
-#endif
-
-#if defined(CONFIG_ARCH_OMAP4)
-static const unsigned long omap44xx_mcbsp_port[][2] = {
-	{ OMAP44XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP44XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR },
-	{ OMAP44XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP44XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR },
-	{ OMAP44XX_MCBSP3_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP44XX_MCBSP3_BASE + OMAP_MCBSP_REG_DRR },
-	{ OMAP44XX_MCBSP4_BASE + OMAP_MCBSP_REG_DXR,
-	  OMAP44XX_MCBSP4_BASE + OMAP_MCBSP_REG_DRR },
-};
-#else
-static const unsigned long omap44xx_mcbsp_port[][2] = {};
-#endif
-
 static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -346,24 +242,10 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int format, div, framesize, master;
 
 	dma_data = &omap_mcbsp_dai_dma_params[cpu_dai->id][substream->stream];
-	if (cpu_class_is_omap1()) {
-		dma = omap1_dma_reqs[bus_id][substream->stream];
-		port = omap1_mcbsp_port[bus_id][substream->stream];
-	} else if (cpu_is_omap2420()) {
-		dma = omap24xx_dma_reqs[bus_id][substream->stream];
-		port = omap2420_mcbsp_port[bus_id][substream->stream];
-	} else if (cpu_is_omap2430()) {
-		dma = omap24xx_dma_reqs[bus_id][substream->stream];
-		port = omap2430_mcbsp_port[bus_id][substream->stream];
-	} else if (cpu_is_omap343x()) {
-		dma = omap24xx_dma_reqs[bus_id][substream->stream];
-		port = omap34xx_mcbsp_port[bus_id][substream->stream];
-	 } else if (cpu_is_omap44xx()) {
-		dma = omap44xx_dma_reqs[bus_id][substream->stream];
-		port = omap44xx_mcbsp_port[bus_id][substream->stream];
-	} else {
-		return -ENODEV;
-	}
+
+	dma = omap_mcbsp_dma_ch_params(bus_id, substream->stream);
+	port = omap_mcbsp_dma_reg_params(bus_id, substream->stream);
+
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		dma_data->data_type = OMAP_DMA_DATA_TYPE_S16;
-- 
1.7.0.4

