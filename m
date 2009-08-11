From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 16/20] ASoC: OMAP: Use DMA operating mode of McBSP
Date: Tue, 11 Aug 2009 16:05:27 +0300
Message-ID: <1249995931-26015-17-git-send-email-eduardo.valentin@nokia.com>
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
 <1249995931-26015-16-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46177 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492AbZHKNSm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 09:18:42 -0400
In-Reply-To: <1249995931-26015-16-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    8 ++++++--
 sound/soc/omap/omap-pcm.c   |   13 +++++++++++--
 sound/soc/omap/omap-pcm.h   |    1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 8d8500f..42a1956 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -166,6 +166,7 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 		err = omap_mcbsp_request(bus_id);
 
 	if (cpu_is_omap343x()) {
+		int dma_op_mode = omap_mcbsp_get_dma_op_mode(bus_id);
 		int max_period;
 
 		/*
@@ -187,7 +188,8 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 		max_period++;
 		max_period <<= 1;
 
-		snd_pcm_hw_constraint_minmax(substream->runtime,
+		if (dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
+			snd_pcm_hw_constraint_minmax(substream->runtime,
 						SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 						32, max_period);
 	}
@@ -246,7 +248,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	int dma, bus_id = mcbsp_data->bus_id, id = cpu_dai->id;
-	int wlen, channels, wpf;
+	int wlen, channels, wpf, dma_mode = MCBSP_DMA_MODE_ELEMENT;
 	unsigned long port;
 	unsigned int format;
 
@@ -262,6 +264,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	} else if (cpu_is_omap343x()) {
 		dma = omap24xx_dma_reqs[bus_id][substream->stream];
 		port = omap34xx_mcbsp_port[bus_id][substream->stream];
+		dma_mode = omap_mcbsp_get_dma_op_mode(bus_id);
 		omap_mcbsp_dai_dma_params[id][substream->stream].set_threshold =
 						omap_mcbsp_set_threshold;
 	} else {
@@ -271,6 +274,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		substream->stream ? "Audio Capture" : "Audio Playback";
 	omap_mcbsp_dai_dma_params[id][substream->stream].dma_req = dma;
 	omap_mcbsp_dai_dma_params[id][substream->stream].port_addr = port;
+	omap_mcbsp_dai_dma_params[id][substream->stream].dma_op_mode = dma_mode;
 	cpu_dai->dma_data = &omap_mcbsp_dai_dma_params[id][substream->stream];
 
 	if (mcbsp_data->configured) {
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 0c1ba0f..d8f52e8 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -144,7 +144,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 
 	memset(&dma_params, 0, sizeof(dma_params));
 
-	if (cpu_is_omap34xx())
+	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
+	if (cpu_is_omap34xx() &&
+			(dma_data->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD))
 		sync_mode = OMAP_DMA_SYNC_FRAME;
 	else
 		sync_mode = OMAP_DMA_SYNC_ELEMENT;
@@ -193,9 +195,16 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct omap_pcm_dma_data *dma_data = prtd->dma_data;
 	unsigned long flags;
 	int ret = 0;
-	int samples = snd_pcm_lib_period_bytes(substream) >> 1;
+	int samples;
 
 	spin_lock_irqsave(&prtd->lock, flags);
+
+	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
+	if (dma_data->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
+		samples = snd_pcm_lib_period_bytes(substream) >> 1;
+	else
+		samples = 1;
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
index 6fda34d..4b77487 100644
--- a/sound/soc/omap/omap-pcm.h
+++ b/sound/soc/omap/omap-pcm.h
@@ -29,6 +29,7 @@ struct omap_pcm_dma_data {
 	char		*name;		/* stream identifier */
 	int		dma_req;	/* DMA request line */
 	unsigned long	port_addr;	/* transmit/receive register */
+	int		dma_op_mode;	/* DMA operation mode: element, frame */
 	void (*set_threshold)(struct snd_pcm_substream *substream, int thres);
 };
 
-- 
1.6.2.GIT

