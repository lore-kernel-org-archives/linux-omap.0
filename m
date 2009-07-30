From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 16/20] ASoC: OMAP: Use McBSP threshold again
Date: Thu, 30 Jul 2009 15:49:39 +0300
Message-ID: <1248958183-15015-17-git-send-email-eduardo.valentin@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25915 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbZG3NBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 09:01:04 -0400
In-Reply-To: <1248958183-15015-16-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Now this patch implements again the McBSP threshold
usage for OMAP ASoC.

We figured out that there is no need to have so much
SW control in order to have DMA in idle state during
audio streaming. Configuring McBSP threshold value
and DMA to FRAME_SYNC are sufficient.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-pcm.c |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 84a1950..03cb420 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -28,10 +28,11 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
+#include <mach/mcbsp.h>
 #include <mach/dma.h>
 #include "omap-pcm.h"
 
-static const struct snd_pcm_hardware omap_pcm_hardware = {
+static struct snd_pcm_hardware omap_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_INTERLEAVED |
@@ -135,6 +136,7 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 	struct omap_runtime_data *prtd = runtime->private_data;
 	struct omap_pcm_dma_data *dma_data = prtd->dma_data;
 	struct omap_dma_channel_params dma_params;
+	int sync_mode;
 
 	/* return if this is a bufferless transfer e.g.
 	 * codec <--> BT codec or GSM modem -- lg FIXME */
@@ -142,13 +144,19 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 		return 0;
 
 	memset(&dma_params, 0, sizeof(dma_params));
+
+	if (cpu_is_omap34xx())
+		sync_mode = OMAP_DMA_SYNC_FRAME;
+	else
+		sync_mode = OMAP_DMA_SYNC_ELEMENT;
+
 	/*
 	 * Note: Regardless of interface data formats supported by OMAP McBSP
 	 * or EAC blocks, internal representation is always fixed 16-bit/sample
 	 */
 	dma_params.data_type			= OMAP_DMA_DATA_TYPE_S16;
 	dma_params.trigger			= dma_data->dma_req;
-	dma_params.sync_mode			= OMAP_DMA_SYNC_ELEMENT;
+	dma_params.sync_mode			= sync_mode;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		dma_params.src_amode		= OMAP_DMA_AMODE_POST_INC;
 		dma_params.dst_amode		= OMAP_DMA_AMODE_CONSTANT;
@@ -183,8 +191,11 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct omap_runtime_data *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	unsigned long flags;
 	int ret = 0;
+	unsigned int bus_id = *(unsigned int *)rtd->dai->cpu_dai->private_data;
+	u16 samples = snd_pcm_lib_period_bytes(substream) >> 1;
 
 	spin_lock_irqsave(&prtd->lock, flags);
 	switch (cmd) {
@@ -192,6 +203,12 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		prtd->period_index = 0;
+		/* Configure McBSP internal buffer usage */
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			omap_mcbsp_set_tx_threshold(bus_id, samples - 1);
+		else
+			omap_mcbsp_set_rx_threshold(bus_id, samples - 1);
+
 		omap_start_dma(prtd->dma_ch);
 		break;
 
@@ -235,7 +252,23 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct omap_runtime_data *prtd;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	unsigned int bus_id = *(unsigned int *)rtd->dai->cpu_dai->private_data;
 	int ret;
+	int max_period;
+
+	if (cpu_is_omap34xx()) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			max_period = omap_mcbsp_get_max_tx_threshold(bus_id);
+		else
+			max_period = omap_mcbsp_get_max_rx_threshold(bus_id);
+		max_period++;
+		max_period <<= 1;
+	} else {
+		omap_pcm_hardware.period_bytes_max = 64 * 1024;
+	}
+
+	omap_pcm_hardware.period_bytes_max = max_period;
 
 	snd_soc_set_runtime_hwparams(substream, &omap_pcm_hardware);
 
-- 
1.6.2.GIT

