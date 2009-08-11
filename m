From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 15/20] ASoC: OMAP: Use McBSP threshold to playback and capture
Date: Tue, 11 Aug 2009 16:05:26 +0300
Message-ID: <1249995931-26015-16-git-send-email-eduardo.valentin@nokia.com>
References: <1249995931-26015-1-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-2-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-3-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-4-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-5-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-6-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-7-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-8-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-9-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-10-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-11-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-12-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-13-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-14-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-15-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19806 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbZHKNSl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 09:18:41 -0400
In-Reply-To: <1249995931-26015-15-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch changes the way DMA is done in omap-pcm.c
in order to reduce power consumption. There is no need
to have so much SW control in order to have DMA in idle
state during audio streaming. Configuring McBSP threshold value
and DMA to FRAME_SYNC are sufficient.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   43 ++++++++++++++++++++++++++++++++++++++-----
 sound/soc/omap/omap-pcm.c   |   17 +++++++++++++++--
 sound/soc/omap/omap-pcm.h   |    1 +
 3 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index a5d46a7..8d8500f 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -139,28 +139,59 @@ static const unsigned long omap34xx_mcbsp_port[][2] = {
 static const unsigned long omap34xx_mcbsp_port[][2] = {};
 #endif
 
+static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream,
+					int thres)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+
+	/* Configure McBSP internal buffer usage */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		omap_mcbsp_set_tx_threshold(mcbsp_data->bus_id, thres);
+	else
+		omap_mcbsp_set_rx_threshold(mcbsp_data->bus_id, thres);
+}
+
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	int bus_id = mcbsp_data->bus_id;
 	int err = 0;
 
-	if (cpu_is_omap343x() && mcbsp_data->bus_id == 1) {
+	if (!cpu_dai->active)
+		err = omap_mcbsp_request(bus_id);
+
+	if (cpu_is_omap343x()) {
+		int max_period;
+
 		/*
 		 * McBSP2 in OMAP3 has 1024 * 32-bit internal audio buffer.
 		 * Set constraint for minimum buffer size to the same than FIFO
 		 * size in order to avoid underruns in playback startup because
 		 * HW is keeping the DMA request active until FIFO is filled.
 		 */
+		if (bus_id == 1)
+			snd_pcm_hw_constraint_minmax(substream->runtime,
+					SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+					4096, UINT_MAX);
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			max_period = omap_mcbsp_get_max_tx_threshold(bus_id);
+		else
+			max_period = omap_mcbsp_get_max_rx_threshold(bus_id);
+
+		max_period++;
+		max_period <<= 1;
+
 		snd_pcm_hw_constraint_minmax(substream->runtime,
-			SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 4096, UINT_MAX);
+						SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+						32, max_period);
 	}
 
-	if (!cpu_dai->active)
-		err = omap_mcbsp_request(mcbsp_data->bus_id);
-
 	return err;
 }
 
@@ -231,6 +262,8 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	} else if (cpu_is_omap343x()) {
 		dma = omap24xx_dma_reqs[bus_id][substream->stream];
 		port = omap34xx_mcbsp_port[bus_id][substream->stream];
+		omap_mcbsp_dai_dma_params[id][substream->stream].set_threshold =
+						omap_mcbsp_set_threshold;
 	} else {
 		return -ENODEV;
 	}
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 84a1950..0c1ba0f 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -31,7 +31,7 @@
 #include <mach/dma.h>
 #include "omap-pcm.h"
 
-static const struct snd_pcm_hardware omap_pcm_hardware = {
+static struct snd_pcm_hardware omap_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_INTERLEAVED |
@@ -135,6 +135,7 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 	struct omap_runtime_data *prtd = runtime->private_data;
 	struct omap_pcm_dma_data *dma_data = prtd->dma_data;
 	struct omap_dma_channel_params dma_params;
+	int sync_mode;
 
 	/* return if this is a bufferless transfer e.g.
 	 * codec <--> BT codec or GSM modem -- lg FIXME */
@@ -142,13 +143,19 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
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
@@ -183,8 +190,10 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct omap_runtime_data *prtd = runtime->private_data;
+	struct omap_pcm_dma_data *dma_data = prtd->dma_data;
 	unsigned long flags;
 	int ret = 0;
+	int samples = snd_pcm_lib_period_bytes(substream) >> 1;
 
 	spin_lock_irqsave(&prtd->lock, flags);
 	switch (cmd) {
@@ -192,6 +201,10 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		prtd->period_index = 0;
+		/* Configure McBSP internal buffer usage */
+		if (dma_data->set_threshold)
+			dma_data->set_threshold(substream, samples - 1);
+
 		omap_start_dma(prtd->dma_ch);
 		break;
 
diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
index 8d9d269..6fda34d 100644
--- a/sound/soc/omap/omap-pcm.h
+++ b/sound/soc/omap/omap-pcm.h
@@ -29,6 +29,7 @@ struct omap_pcm_dma_data {
 	char		*name;		/* stream identifier */
 	int		dma_req;	/* DMA request line */
 	unsigned long	port_addr;	/* transmit/receive register */
+	void (*set_threshold)(struct snd_pcm_substream *substream, int thres);
 };
 
 extern struct snd_soc_platform omap_soc_platform;
-- 
1.6.2.GIT

