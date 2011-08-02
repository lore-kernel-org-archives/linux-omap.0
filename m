From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] ASoC: omap-mcpdm: Fix threshold and dma configuration
Date: Tue, 2 Aug 2011 14:34:16 +0300
Message-ID: <1312284857-1774-4-git-send-email-peter.ujfalusi@ti.com>
References: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57473 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab1HBLeb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 07:34:31 -0400
In-Reply-To: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>

DMA packet_size must be configured based on the McPDM FIFO threshold
value, number of channels.
Due to the FIFO operation the DMA muse be configured differently for
playback, and capture.
At the same time fix the McPDM threshold values used for playback, and
capture to avoid broken code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index bed09c2..7727de0 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -46,13 +46,13 @@ static struct omap_mcpdm_link omap_mcpdm_links[] = {
 	/* downlink */
 	{
 		.irq_mask = MCPDM_DN_IRQ_EMPTY | MCPDM_DN_IRQ_FULL,
-		.threshold = 1,
+		.threshold = 2,
 		.format = PDMOUTFORMAT_LJUST,
 	},
 	/* uplink */
 	{
 		.irq_mask = MCPDM_UP_IRQ_EMPTY | MCPDM_UP_IRQ_FULL,
-		.threshold = 1,
+		.threshold = UP_THRES_MAX - 3,
 		.format = PDMOUTFORMAT_LJUST,
 	},
 };
@@ -136,12 +136,11 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 {
 	struct omap_mcpdm_data *mcpdm_priv = snd_soc_dai_get_drvdata(dai);
 	struct omap_mcpdm_link *mcpdm_links = mcpdm_priv->links;
+	struct omap_pcm_dma_data *dma_data;
+	int threshold;
 	int stream = substream->stream;
 	int channels, err, link_mask = 0;
 
-	snd_soc_dai_set_dma_data(dai, substream,
-				 &omap_mcpdm_dai_dma_params[stream]);
-
 	channels = params_channels(params);
 	switch (channels) {
 	case 4:
@@ -164,14 +163,22 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	dma_data = &omap_mcpdm_dai_dma_params[stream];
+	threshold = mcpdm_links[stream].threshold;
+
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		mcpdm_links[stream].channels = link_mask << 3;
+		dma_data->packet_size = (DN_THRES_MAX - threshold) * channels;
+
 		err = omap_mcpdm_playback_open(&mcpdm_links[stream]);
 	} else {
 		mcpdm_links[stream].channels = link_mask << 0;
+		dma_data->packet_size = threshold * channels;
+
 		err = omap_mcpdm_capture_open(&mcpdm_links[stream]);
 	}
 
+	snd_soc_dai_set_dma_data(dai, substream, dma_data);
 	return err;
 }
 
-- 
1.7.6

