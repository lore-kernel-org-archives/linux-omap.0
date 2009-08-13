From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv3 20/20] ASoC: OMAP: Use DMA operating mode of McBSP
Date: Thu, 13 Aug 2009 17:35:33 +0300
Message-ID: <1250174133-451-21-git-send-email-eduardo.valentin@nokia.com>
References: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-2-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-3-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-4-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-5-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-6-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-7-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-8-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-9-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-10-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-11-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-12-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-13-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-14-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-15-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-16-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-17-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-18-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-19-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-20-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38987 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151AbZHMOsy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 10:48:54 -0400
In-Reply-To: <1250174133-451-20-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 8a7b5ef..4369622 100644
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

