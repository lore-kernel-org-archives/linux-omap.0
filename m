From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC][PATCH] ASoC: OMAP: Fix capture pointer handling for OMAP1510 to work correctly with recent ALSA PCM code
Date: Sun, 28 Mar 2010 22:29:29 +0200
Message-ID: <201003282229.32922.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:33299 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755047Ab0C1U3z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 28 Mar 2010 16:29:55 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

With recent (2.6.34) chnages in PCM handling, capture stopped working on my 
OMAP1510 based Amstrad Delta videophone.

Using 2.6.34-rc2, I was able to correct the problem in 3 different ways:

1. reverting commit 7b3a177b0d4f92b3431b8dca777313a07533a710,
2. enabling additional jiffies check with
	echo 4 >/proc/asound/card0/pcm0c0/xrun_debug
3. applying the patch below.

Since I wasn't able to reproduce the problem on my i686 PC, I guess the 
problem is probably machine specific.

The patch reuses the method for software emulation of missing hardware 
pointer, already implemented for playback on OMAP1510. It's possible that 
event if a hardware pointer is available for capture on this machine, its 
behaviour may be not compatible with what upper layer expects.

If you think the problem may be more general and should be solved differently, 
on a higher level, I can try to work more on it if you give me a hint.

If the patch gets accepted, I suggest it goes as a fix in the current release 
cycle.

Created and tested against linux-2.6.34-rc2.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
--- git/sound/soc/omap/omap-pcm.c.orig	2010-03-25 16:00:13.000000000 +0100
+++ git/sound/soc/omap/omap-pcm.c	2010-03-28 05:16:42.000000000 +0200
@@ -60,12 +60,11 @@ static void omap_pcm_dma_irq(int ch, u16
 	struct omap_runtime_data *prtd = runtime->private_data;
 	unsigned long flags;
 
-	if ((cpu_is_omap1510()) &&
-			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK)) {
+	if ((cpu_is_omap1510())) {
 		/*
 		 * OMAP1510 doesn't fully support DMA progress counter
 		 * and there is no software emulation implemented yet,
-		 * so have to maintain our own playback progress counter
+		 * so have to maintain our own progress counters
 		 * that can be used by omap_pcm_pointer() instead.
 		 */
 		spin_lock_irqsave(&prtd->lock, flags);
@@ -189,8 +188,7 @@ static int omap_pcm_prepare(struct snd_p
 	dma_params.frame_count	= runtime->periods;
 	omap_set_dma_params(prtd->dma_ch, &dma_params);
 
-	if ((cpu_is_omap1510()) &&
-			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK))
+	if ((cpu_is_omap1510()))
 		omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ |
 			      OMAP_DMA_LAST_IRQ | OMAP_DMA_BLOCK_IRQ);
 	else
@@ -248,14 +246,15 @@ static snd_pcm_uframes_t omap_pcm_pointe
 	dma_addr_t ptr;
 	snd_pcm_uframes_t offset;
 
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+	if (cpu_is_omap1510()) {
+		offset = prtd->period_index * runtime->period_size;
+	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		ptr = omap_get_dma_dst_pos(prtd->dma_ch);
 		offset = bytes_to_frames(runtime, ptr - runtime->dma_addr);
-	} else if (!(cpu_is_omap1510())) {
+	} else {
 		ptr = omap_get_dma_src_pos(prtd->dma_ch);
 		offset = bytes_to_frames(runtime, ptr - runtime->dma_addr);
-	} else
-		offset = prtd->period_index * runtime->period_size;
+	}
 
 	if (offset >= runtime->buffer_size)
 		offset = 0;
