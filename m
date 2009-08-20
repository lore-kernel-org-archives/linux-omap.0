From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv5 20/20] ASoC: OMAP: Use DMA operating mode of McBSP
Date: Thu, 20 Aug 2009 16:18:26 +0300
Message-ID: <1250774306-7581-20-git-send-email-eduardo.valentin@nokia.com>
References: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35206 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515AbZHTNdJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 09:33:09 -0400
In-Reply-To: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Configures DMA sync mode depending on McBSP operating mode value.
The value is configurable by McBSP instance. So, depending
on McBSP operating mode, the DMA sync mode is passed from
omap-mcbsp to omap-pcm. Besides that, it also configures
McBSP threshold value depending on which McBSP mode is activated.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 580de5a..f5387d9 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -144,7 +144,14 @@ static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
-	int samples = snd_pcm_lib_period_bytes(substream) >> 1;
+	int dma_op_mode = omap_mcbsp_get_dma_op_mode(mcbsp_data->bus_id);
+	int samples;
+
+	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
+	if (dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
+		samples = snd_pcm_lib_period_bytes(substream) >> 1;
+	else
+		samples = 1;
 
 	/* Configure McBSP internal buffer usage */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -166,6 +173,7 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 		err = omap_mcbsp_request(bus_id);
 
 	if (cpu_is_omap343x()) {
+		int dma_op_mode = omap_mcbsp_get_dma_op_mode(bus_id);
 		int max_period;
 
 		/*
@@ -187,7 +195,8 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 		max_period++;
 		max_period <<= 1;
 
-		snd_pcm_hw_constraint_minmax(substream->runtime,
+		if (dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
+			snd_pcm_hw_constraint_minmax(substream->runtime,
 						SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 						32, max_period);
 	}
@@ -269,7 +278,10 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		port = omap34xx_mcbsp_port[bus_id][substream->stream];
 		omap_mcbsp_dai_dma_params[id][substream->stream].set_threshold =
 						omap_mcbsp_set_threshold;
-		sync_mode = OMAP_DMA_SYNC_FRAME;
+		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
+		if (omap_mcbsp_get_dma_op_mode(bus_id) ==
+						MCBSP_DMA_MODE_THRESHOLD)
+			sync_mode = OMAP_DMA_SYNC_FRAME;
 	} else {
 		return -ENODEV;
 	}
-- 
1.6.2.GIT

