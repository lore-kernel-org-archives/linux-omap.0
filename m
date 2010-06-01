From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v3 4/5] ASoC: omap-mcbsp: Save, and use wlen for threshold configuration
Date: Tue,  1 Jun 2010 14:18:23 +0300
Message-ID: <1275391104-26387-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1275391104-26387-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35788 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378Ab0FALSw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 07:18:52 -0400
In-Reply-To: <1275391104-26387-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, jhnikula@gmail.com, tony@atomide.com, ext-eero.nurkkala@nokia.com, eduardo.valentin@nokia.com

Save the word length configuration of McBSP, and use that information
to calculate, and configure the threshold in McBSP.
Previously the calculation was only correct when the stream had 16bit
audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 6f44cb4..b06d8f1 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -59,6 +59,7 @@ struct omap_mcbsp_data {
 	int				configured;
 	unsigned int			in_freq;
 	int				clk_div;
+	int				wlen;
 };
 
 #define to_mcbsp(priv)	container_of((priv), struct omap_mcbsp_data, bus_id)
@@ -155,19 +156,21 @@ static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 	int dma_op_mode = omap_mcbsp_get_dma_op_mode(mcbsp_data->bus_id);
-	int samples;
+	int words;
 
 	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
 	if (dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
-		samples = snd_pcm_lib_period_bytes(substream) >> 1;
+		/* The FIFO size depends on the McBSP word configuration */
+		words = snd_pcm_lib_period_bytes(substream) /
+							(mcbsp_data->wlen / 8);
 	else
-		samples = 1;
+		words = 1;
 
 	/* Configure McBSP internal buffer usage */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		omap_mcbsp_set_tx_threshold(mcbsp_data->bus_id, samples - 1);
+		omap_mcbsp_set_tx_threshold(mcbsp_data->bus_id, words);
 	else
-		omap_mcbsp_set_rx_threshold(mcbsp_data->bus_id, samples - 1);
+		omap_mcbsp_set_rx_threshold(mcbsp_data->bus_id, words);
 }
 
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
@@ -409,6 +412,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	omap_mcbsp_config(bus_id, &mcbsp_data->regs);
+	mcbsp_data->wlen = wlen;
 	mcbsp_data->configured = 1;
 
 	return 0;
-- 
1.7.1

