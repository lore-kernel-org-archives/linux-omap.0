From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] [RFC] ASoC: OMAP: fix OMAP1510 broken PCM
	pointer callback
Date: Sun, 28 Jun 2009 00:21:05 +0200
Message-ID: <200906280021.05931.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch tries to work around the problem of broken OMAP1510 PCM playback 
pointer calculation by replacing DMA function call that incorrectly tries to 
read the value form DMA hardware with a value computed locally from an 
already maintained variable omap_runtime_data.period_index.

Tested on OMAP5910 based Amstrad Delta (E3) using work in progress ASoC 
driver.

Based on linux-2.6-asoc.git v2.6.31-rc1.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
It seems that on OMAP1510, DMA Channel Progress Counter registers 
(DMA_CPC_CH[0-8]) always contain values derived from DMA channels destination 
port address, even if constant, and there are no DMA registers available that 
would follow DMA channels source port address. Because of this limitation, 
current implementation of omap_get_dma_src_pos() for OMAP1510 is broken and 
doesn't seem to be easy correctable.

--- linux-2.6.31-rc1/sound/soc/omap/omap-pcm.c.orig	2009-06-27 
20:20:16.000000000 +0200
+++ linux-2.6.31-rc1/sound/soc/omap/omap-pcm.c	2009-06-27 23:21:42.000000000 
+0200
@@ -216,12 +216,15 @@ static snd_pcm_uframes_t omap_pcm_pointe
 	dma_addr_t ptr;
 	snd_pcm_uframes_t offset;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		ptr = omap_get_dma_src_pos(prtd->dma_ch);
-	else
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		ptr = omap_get_dma_dst_pos(prtd->dma_ch);
+		offset = bytes_to_frames(runtime, ptr - runtime->dma_addr);
+	} else if (!(cpu_is_omap1510())) {
+		ptr = omap_get_dma_src_pos(prtd->dma_ch);
+		offset = bytes_to_frames(runtime, ptr - runtime->dma_addr);
+	} else
+		offset = prtd->period_index * runtime->period_size;
 
-	offset = bytes_to_frames(runtime, ptr - runtime->dma_addr);
 	if (offset >= runtime->buffer_size)
 		offset = 0;
