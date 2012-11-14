From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 3/3] ASoC: OMAP: HDMI: Obtain DMA port from resources
Date: Tue, 13 Nov 2012 20:30:49 -0600
Message-ID: <1352860249-26348-4-git-send-email-ricardo.neri@ti.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49145 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932472Ab2KNCbz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 21:31:55 -0500
In-Reply-To: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Instead of defining the address offset of the DMA port for transfers of
audio samples, obtain this information from the resources of the device.
This device and its resources are created by the OMAPDSS HDMI driver.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap-hdmi.c |    3 +--
 sound/soc/omap/omap-hdmi.h |    2 --
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index 6592d6f..306fbfb 100644
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
1.7.5.4

