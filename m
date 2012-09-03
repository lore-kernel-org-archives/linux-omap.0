From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 3/3] ASoC: first stab at converting OMAP PCM driver to use
 dmaengine
Date: Mon, 03 Sep 2012 17:59:53 +0100
Message-ID: <E1T8a09-0002vz-Bl@rmk-PC.arm.linux.org.uk>
References: <20120903165832.GA31511@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51006 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362Ab2ICQ77 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Sep 2012 12:59:59 -0400
In-Reply-To: <20120903165832.GA31511@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org

Note that certain features of the original driver are not supported:
1. Non-packet mode sync
2. No period wakeup mode
   DMA engine has no way to communicate this information through
   standard channels.

3. Pause
4. Resume
   OMAP DMA engine backend does not support pausing and resuming
   an in-progress transfer.  It is unclear from the specs what
   effect clearing the enable bit has on the DMA position of a
   destination synchronized transfer, and whether the transfer
   can be restarted from the exact point that it was paused (or
   whether the data in the FIFO read from memory is simply
   discarded.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/omap/Kconfig    |    1 +
 sound/soc/omap/omap-pcm.c |  173 ++++++++++++--------------------------------
 2 files changed, 48 insertions(+), 126 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 57a2fa7..8a92d5b 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -1,6 +1,7 @@
 config SND_OMAP_SOC
 	tristate "SoC Audio for the Texas Instruments OMAP chips"
 	depends on ARCH_OMAP
+	select SND_SOC_DMAENGINE_PCM
 
 config SND_OMAP_SOC_DMIC
 	tristate
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index f0feb06..50ae048 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -25,21 +25,23 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/omap-dma.h>
 #include <sound/core.h>
+#include <sound/dmaengine_pcm.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <plat/dma.h>
+#include <plat/dma.h> /* needed just for OMAP_DMA_SYNC_PACKET */
 #include "omap-pcm.h"
 
 static const struct snd_pcm_hardware omap_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
-				  SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_INTERLEAVED /* |
 				  SNDRV_PCM_INFO_PAUSE |
 				  SNDRV_PCM_INFO_RESUME |
-				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
+				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP */,
 	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
 				  SNDRV_PCM_FMTBIT_S32_LE,
 	.period_bytes_min	= 32,
@@ -50,51 +52,9 @@ static const struct snd_pcm_hardware omap_pcm_hardware = {
 };
 
 struct omap_runtime_data {
-	spinlock_t			lock;
 	struct omap_pcm_dma_data	*dma_data;
-	int				dma_ch;
-	int				period_index;
 };
 
-static void omap_pcm_dma_irq(int ch, u16 stat, void *data)
-{
-	struct snd_pcm_substream *substream = data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct omap_runtime_data *prtd = runtime->private_data;
-	unsigned long flags;
-
-	if ((cpu_is_omap1510())) {
-		/*
-		 * OMAP1510 doesn't fully support DMA progress counter
-		 * and there is no software emulation implemented yet,
-		 * so have to maintain our own progress counters
-		 * that can be used by omap_pcm_pointer() instead.
-		 */
-		spin_lock_irqsave(&prtd->lock, flags);
-		if ((stat == OMAP_DMA_LAST_IRQ) &&
-				(prtd->period_index == runtime->periods - 1)) {
-			/* we are in sync, do nothing */
-			spin_unlock_irqrestore(&prtd->lock, flags);
-			return;
-		}
-		if (prtd->period_index >= 0) {
-			if (stat & OMAP_DMA_BLOCK_IRQ) {
-				/* end of buffer reached, loop back */
-				prtd->period_index = 0;
-			} else if (stat & OMAP_DMA_LAST_IRQ) {
-				/* update the counter for the last period */
-				prtd->period_index = runtime->periods - 1;
-			} else if (++prtd->period_index >= runtime->periods) {
-				/* end of buffer missed? loop back */
-				prtd->period_index = 0;
-			}
-		}
-		spin_unlock_irqrestore(&prtd->lock, flags);
-	}
-
-	snd_pcm_period_elapsed(substream);
-}
-
 /* this may get called several times by oss emulation */
 static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params)
@@ -103,6 +63,9 @@ static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct omap_runtime_data *prtd = runtime->private_data;
 	struct omap_pcm_dma_data *dma_data;
+	struct dma_slave_config config;
+	struct dma_chan *chan;
+	unsigned req;
 
 	int err = 0;
 
@@ -119,17 +82,36 @@ static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (prtd->dma_data)
 		return 0;
 	prtd->dma_data = dma_data;
-	err = omap_request_dma(dma_data->dma_req, dma_data->name,
-			       omap_pcm_dma_irq, substream, &prtd->dma_ch);
-	if (!err) {
-		/*
-		 * Link channel with itself so DMA doesn't need any
-		 * reprogramming while looping the buffer
-		 */
-		omap_dma_link_lch(prtd->dma_ch, prtd->dma_ch);
+
+	/*
+	 * This is the only parameter we don't handle with DMA
+	 * engine - so we insist on OMAP_DMA_SYNC_PACKET here.
+	 */
+	if (dma_data->sync_mode != OMAP_DMA_SYNC_PACKET) {
+		pr_warn("ALSA: omap-dma: DMA using non-packet mode?\n");
+		return -EINVAL;
 	}
 
-	return err;
+	req = dma_data->dma_req;
+	err = snd_dmaengine_pcm_open(substream, omap_dma_filter_fn, &req);
+	if (err)
+		return err;
+
+	chan = snd_dmaengine_pcm_get_chan(substream);
+	if (!chan)
+		return -EINVAL;
+
+	/* fills in addr_width and direction */
+	err = snd_hwparams_to_dma_slave_config(substream, params, &config);
+	if (err)
+		return err;
+
+	config.src_addr = dma_data->port_addr;
+	config.dst_addr = dma_data->port_addr;
+	config.src_maxburst = dma_data->packet_size;
+	config.dst_maxburst = dma_data->packet_size;
+
+	return dmaengine_slave_config(chan, &config);
 }
 
 static int omap_pcm_hw_free(struct snd_pcm_substream *substream)
@@ -140,8 +122,6 @@ static int omap_pcm_hw_free(struct snd_pcm_substream *substream)
 	if (prtd->dma_data == NULL)
 		return 0;
 
-	omap_dma_unlink_lch(prtd->dma_ch, prtd->dma_ch);
-	omap_free_dma(prtd->dma_ch);
 	prtd->dma_data = NULL;
 
 	snd_pcm_set_runtime_buffer(substream, NULL);
@@ -151,48 +131,12 @@ static int omap_pcm_hw_free(struct snd_pcm_substream *substream)
 
 static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct omap_runtime_data *prtd = runtime->private_data;
-	struct omap_pcm_dma_data *dma_data = prtd->dma_data;
-	struct omap_dma_channel_params dma_params;
-	int bytes;
-
-	/* return if this is a bufferless transfer e.g.
-	 * codec <--> BT codec or GSM modem -- lg FIXME */
-	if (!prtd->dma_data)
-		return 0;
-
-	memset(&dma_params, 0, sizeof(dma_params));
-	dma_params.data_type			= dma_data->data_type;
-	dma_params.trigger			= dma_data->dma_req;
-	dma_params.sync_mode			= dma_data->sync_mode;
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		dma_params.src_amode		= OMAP_DMA_AMODE_POST_INC;
-		dma_params.dst_amode		= OMAP_DMA_AMODE_CONSTANT;
-		dma_params.src_or_dst_synch	= OMAP_DMA_DST_SYNC;
-		dma_params.src_start		= runtime->dma_addr;
-		dma_params.dst_start		= dma_data->port_addr;
-		dma_params.dst_port		= OMAP_DMA_PORT_MPUI;
-		dma_params.dst_fi		= dma_data->packet_size;
-	} else {
-		dma_params.src_amode		= OMAP_DMA_AMODE_CONSTANT;
-		dma_params.dst_amode		= OMAP_DMA_AMODE_POST_INC;
-		dma_params.src_or_dst_synch	= OMAP_DMA_SRC_SYNC;
-		dma_params.src_start		= dma_data->port_addr;
-		dma_params.dst_start		= runtime->dma_addr;
-		dma_params.src_port		= OMAP_DMA_PORT_MPUI;
-		dma_params.src_fi		= dma_data->packet_size;
-	}
+#if 0
 	/*
-	 * Set DMA transfer frame size equal to ALSA period size and frame
-	 * count as no. of ALSA periods. Then with DMA frame interrupt enabled,
-	 * we can transfer the whole ALSA buffer with single DMA transfer but
-	 * still can get an interrupt at each period bounary
+	 * These remains serve to document the bits which
+	 * DMA engine doesn't handle.
 	 */
-	bytes = snd_pcm_lib_period_bytes(substream);
-	dma_params.elem_count	= bytes >> dma_data->data_type;
-	dma_params.frame_count	= runtime->periods;
-	omap_set_dma_params(prtd->dma_ch, &dma_params);
+	dma_params.sync_mode			= dma_data->sync_mode;
 
 	if ((cpu_is_omap1510()))
 		omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ |
@@ -207,14 +151,7 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 		 */
 		omap_disable_dma_irq(prtd->dma_ch, OMAP_DMA_BLOCK_IRQ);
 	}
-
-	if (!(cpu_class_is_omap1())) {
-		omap_set_dma_src_burst_mode(prtd->dma_ch,
-						OMAP_DMA_DATA_BURST_16);
-		omap_set_dma_dest_burst_mode(prtd->dma_ch,
-						OMAP_DMA_DATA_BURST_16);
-	}
-
+#endif
 	return 0;
 }
 
@@ -223,56 +160,41 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct omap_runtime_data *prtd = runtime->private_data;
 	struct omap_pcm_dma_data *dma_data = prtd->dma_data;
-	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&prtd->lock, flags);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		prtd->period_index = 0;
 		/* Configure McBSP internal buffer usage */
 		if (dma_data->set_threshold)
 			dma_data->set_threshold(substream);
-
-		omap_start_dma(prtd->dma_ch);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		prtd->period_index = -1;
-		omap_stop_dma(prtd->dma_ch);
 		break;
 	default:
 		ret = -EINVAL;
 	}
-	spin_unlock_irqrestore(&prtd->lock, flags);
+
+	if (ret == 0)
+	    ret = snd_dmaengine_pcm_trigger(substream, cmd);
 
 	return ret;
 }
 
 static snd_pcm_uframes_t omap_pcm_pointer(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct omap_runtime_data *prtd = runtime->private_data;
-	dma_addr_t ptr;
 	snd_pcm_uframes_t offset;
 
 	if (cpu_is_omap1510()) {
-		offset = prtd->period_index * runtime->period_size;
-	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		ptr = omap_get_dma_dst_pos(prtd->dma_ch);
-		offset = bytes_to_frames(runtime, ptr - runtime->dma_addr);
+		offset = snd_dmaengine_pcm_pointer_no_residue(substream);
 	} else {
-		ptr = omap_get_dma_src_pos(prtd->dma_ch);
-		offset = bytes_to_frames(runtime, ptr - runtime->dma_addr);
+		offset = snd_dmaengine_pcm_pointer(substream);
 	}
 
-	if (offset >= runtime->buffer_size)
-		offset = 0;
-
 	return offset;
 }
 
@@ -295,7 +217,6 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
 		ret = -ENOMEM;
 		goto out;
 	}
-	spin_lock_init(&prtd->lock);
 	runtime->private_data = prtd;
 
 out:
@@ -307,7 +228,7 @@ static int omap_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	kfree(runtime->private_data);
-	return 0;
+	return snd_dmaengine_pcm_close(substream);
 }
 
 static int omap_pcm_mmap(struct snd_pcm_substream *substream,
-- 
1.7.4.4

