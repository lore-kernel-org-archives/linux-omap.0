From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 07/10] ASoC: OMAP McBSP: Remove redundant accessors
Date: Tue, 28 Feb 2012 09:40:17 +0200
Message-ID: <1330414820-4641-8-git-send-email-peter.ujfalusi@ti.com>
References: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:50276 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756512Ab2B1Hks (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 02:40:48 -0500
Received: by mail-lpp01m010-f47.google.com with SMTP id w12so1768775lag.20
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 23:40:47 -0800 (PST)
In-Reply-To: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>

We no longer need accessor functions for max_tx/rx_threshold, dma_op_mode
or for the FIFO size.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 sound/soc/omap/mcbsp.c      |   36 ------------------------------------
 sound/soc/omap/mcbsp.h      |    3 ---
 sound/soc/omap/omap-mcbsp.c |   14 +++++---------
 3 files changed, 5 insertions(+), 48 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index be92a28..95ba7e0 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -442,29 +442,6 @@ void omap_mcbsp_set_rx_threshold(struct omap_mcbsp *mcbsp, u16 threshold)
 }
 
 /*
- * omap_mcbsp_get_max_tx_thres just return the current configured
- * maximum threshold for transmission
- */
-u16 omap_mcbsp_get_max_tx_threshold(struct omap_mcbsp *mcbsp)
-{
-	return mcbsp->max_tx_thres;
-}
-
-/*
- * omap_mcbsp_get_max_rx_thres just return the current configured
- * maximum threshold for reception
- */
-u16 omap_mcbsp_get_max_rx_threshold(struct omap_mcbsp *mcbsp)
-{
-	return mcbsp->max_rx_thres;
-}
-
-u16 omap_mcbsp_get_fifo_size(struct omap_mcbsp *mcbsp)
-{
-	return mcbsp->pdata->buffer_size;
-}
-
-/*
  * omap_mcbsp_get_tx_delay returns the number of used slots in the McBSP FIFO
  */
 u16 omap_mcbsp_get_tx_delay(struct omap_mcbsp *mcbsp)
@@ -504,19 +481,6 @@ u16 omap_mcbsp_get_rx_delay(struct omap_mcbsp *mcbsp)
 		return threshold - buffstat;
 }
 
-/*
- * omap_mcbsp_get_dma_op_mode just return the current configured
- * operating mode for the mcbsp channel
- */
-int omap_mcbsp_get_dma_op_mode(struct omap_mcbsp *mcbsp)
-{
-	int dma_op_mode;
-
-	dma_op_mode = mcbsp->dma_op_mode;
-
-	return dma_op_mode;
-}
-
 int omap_mcbsp_request(struct omap_mcbsp *mcbsp)
 {
 	void *reg_cache;
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index ec00c27..a991e1d 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -316,9 +316,6 @@ void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
 		       const struct omap_mcbsp_reg_cfg *config);
 void omap_mcbsp_set_tx_threshold(struct omap_mcbsp *mcbsp, u16 threshold);
 void omap_mcbsp_set_rx_threshold(struct omap_mcbsp *mcbsp, u16 threshold);
-u16 omap_mcbsp_get_max_tx_threshold(struct omap_mcbsp *mcbsp);
-u16 omap_mcbsp_get_max_rx_threshold(struct omap_mcbsp *mcbsp);
-u16 omap_mcbsp_get_fifo_size(struct omap_mcbsp *mcbsp);
 u16 omap_mcbsp_get_tx_delay(struct omap_mcbsp *mcbsp);
 u16 omap_mcbsp_get_rx_delay(struct omap_mcbsp *mcbsp);
 int omap_mcbsp_get_dma_op_mode(struct omap_mcbsp *mcbsp);
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 8924002..9c703f1 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -67,13 +67,12 @@ static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
 	struct omap_mcbsp_data *mcbsp_data = &mcbsp->mcbsp_data;
 	struct omap_pcm_dma_data *dma_data;
-	int dma_op_mode = omap_mcbsp_get_dma_op_mode(mcbsp);
 	int words;
 
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
-	if (dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
+	if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
 		/*
 		 * Configure McBSP threshold based on either:
 		 * packet_size, when the sDMA is in packet mode, or
@@ -106,7 +105,7 @@ static int omap_mcbsp_hwrule_min_buffersize(struct snd_pcm_hw_params *params,
 	int size;
 
 	snd_interval_any(&frames);
-	size = omap_mcbsp_get_fifo_size(mcbsp);
+	size = mcbsp->pdata->buffer_size;
 
 	frames.min = size / channels->min;
 	frames.integer = 1;
@@ -255,17 +254,14 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	if (mcbsp->pdata->buffer_size) {
 		dma_data->set_threshold = omap_mcbsp_set_threshold;
 		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
-		if (omap_mcbsp_get_dma_op_mode(mcbsp) ==
-						MCBSP_DMA_MODE_THRESHOLD) {
+		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
 			int period_words, max_thrsh;
 
 			period_words = params_period_bytes(params) / (wlen / 8);
 			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-				max_thrsh = omap_mcbsp_get_max_tx_threshold(
-							    mcbsp);
+				max_thrsh = mcbsp->max_tx_thres;
 			else
-				max_thrsh = omap_mcbsp_get_max_rx_threshold(
-							    mcbsp);
+				max_thrsh = mcbsp->max_rx_thres;
 			/*
 			 * If the period contains less or equal number of words,
 			 * we are using the original threshold mode setup:
-- 
1.7.8.4

