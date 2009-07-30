From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 19/20] ASoC: OMAP: Use DMA operating mode of McBSP
Date: Thu, 30 Jul 2009 15:49:42 +0300
Message-ID: <1248958183-15015-20-git-send-email-eduardo.valentin@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-14-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-15-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-16-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-17-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-18-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-19-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25933 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZG3NBK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 09:01:10 -0400
In-Reply-To: <1248958183-15015-19-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-pcm.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index a30e7a0..f4903e0 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -51,6 +51,7 @@ struct omap_runtime_data {
 	struct omap_pcm_dma_data	*dma_data;
 	int				dma_ch;
 	int				period_index;
+	int				dma_op_mode;
 };
 
 static void omap_pcm_dma_irq(int ch, u16 stat, void *data)
@@ -145,7 +146,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 
 	memset(&dma_params, 0, sizeof(dma_params));
 
-	if (cpu_is_omap34xx())
+	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
+	if (cpu_is_omap34xx() &&
+			(prtd->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD))
 		sync_mode = OMAP_DMA_SYNC_FRAME;
 	else
 		sync_mode = OMAP_DMA_SYNC_ELEMENT;
@@ -198,9 +201,16 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	unsigned long flags;
 	int ret = 0;
 	unsigned int bus_id = *(unsigned int *)rtd->dai->cpu_dai->private_data;
-	u16 samples = snd_pcm_lib_period_bytes(substream) >> 1;
+	u16 samples;
 
 	spin_lock_irqsave(&prtd->lock, flags);
+
+	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
+	if (prtd->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
+		samples = snd_pcm_lib_period_bytes(substream) >> 1;
+	else
+		samples = 1;
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -257,10 +267,12 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
 	struct omap_runtime_data *prtd;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	unsigned int bus_id = *(unsigned int *)rtd->dai->cpu_dai->private_data;
+	int dma_op_mode = omap_mcbsp_get_dma_op_mode(bus_id);
 	int ret;
 	int max_period;
 
-	if (cpu_is_omap34xx()) {
+	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
+	if (cpu_is_omap34xx() && (dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)) {
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			max_period = omap_mcbsp_get_max_tx_threshold(bus_id);
 		else
@@ -268,7 +280,7 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
 		max_period++;
 		max_period <<= 1;
 	} else {
-		omap_pcm_hardware.period_bytes_max = 64 * 1024;
+		max_period = 64 * 1024;
 	}
 
 	omap_pcm_hardware.period_bytes_max = max_period;
@@ -286,6 +298,7 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
 		ret = -ENOMEM;
 		goto out;
 	}
+	prtd->dma_op_mode = dma_op_mode;
 	spin_lock_init(&prtd->lock);
 	runtime->private_data = prtd;
 
-- 
1.6.2.GIT

