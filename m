From: Ricardo Neri <rneri@dextratech.com>
Subject: [PATCH v3 5/5] ARM: OMAP4+: HDMI: Refine the DMA port resource for audio
Date: Mon, 17 Dec 2012 19:30:43 -0600
Message-ID: <1355794243-32345-6-git-send-email-rneri@dextratech.com>
References: <1355794243-32345-1-git-send-email-rneri@dextratech.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from spamfilter.dextratech.com ([187.141.251.67]:42946 "EHLO
	mail.dextratech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab2LRBmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 20:42:50 -0500
In-Reply-To: <1355794243-32345-1-git-send-email-rneri@dextratech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, tony@atomide.com
Cc: peter.ujfalusi@ti.com, dzuniga@dextratech.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <rneri@dextratech.com>

Instead of passing the complete address space to the platform device for audio,
just pass the address offset of the DMA port for audio samples. Thus, we prevent
that two drivers try to ioremap the same resources. This is to be safe, as the
ASoC HDMI CPU-DAI driver will not need to ioremap such resource.

Signed-off-by: Ricardo Neri <rneri@dextratech.com>
---
 drivers/video/omap2/dss/hdmi.c |    9 ++++++---
 sound/soc/omap/omap-hdmi.c     |    3 +--
 sound/soc/omap/omap-hdmi.h     |    2 --
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 0dde2b5..b758f83 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -829,6 +829,7 @@ static int hdmi_probe_audio(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct platform_device *aud_pdev;
+	u32 port_offset, port_size;
 	struct resource aud_res[2] = {
 		DEFINE_RES_MEM(-1, -1),
 		DEFINE_RES_DMA(-1),
@@ -841,11 +842,13 @@ static int hdmi_probe_audio(struct platform_device *pdev)
 	}
 
 	/*
-	 * Pass this resource to audio drivers to find the DMA port address.
+	 * Pass DMA audio port to audio drivers.
 	 * Audio drivers should not ioremap it.
 	 */
-	aud_res[0].start = res->start;
-	aud_res[0].end = res->end;
+	hdmi.ip_data.ops->audio_get_dma_port(&port_offset, &port_size);
+
+	aud_res[0].start = res->start + port_offset;
+	aud_res[0].end =  aud_res[0].start + port_size - 1;
 
 	res = platform_get_resource(hdmi.pdev, IORESOURCE_DMA, 0);
 	if (!res) {
diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index db08501..33418fc 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -281,8 +281,7 @@ static __devinit int omap_hdmi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start
-		+ OMAP_HDMI_AUDIO_DMA_PORT;
+	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start;
 
 	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!hdmi_rsrc) {
diff --git a/sound/soc/omap/omap-hdmi.h b/sound/soc/omap/omap-hdmi.h
index 6ad2bf4..33d7a93 100644
--- a/sound/soc/omap/omap-hdmi.h
+++ b/sound/soc/omap/omap-hdmi.h
@@ -25,8 +25,6 @@
 #ifndef __OMAP_HDMI_H__
 #define __OMAP_HDMI_H__
 
-#define OMAP_HDMI_AUDIO_DMA_PORT 0x8c
-
 #define OMAP_HDMI_RATES	(SNDRV_PCM_RATE_32000 | \
 				SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | \
 				SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | \
-- 
1.7.10.4

