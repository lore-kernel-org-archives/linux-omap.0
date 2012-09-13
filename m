From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 13/15] ASoC: omap-pcm, omap-dmic: Change the use of omap_pcm_dma_data->data_type
Date: Thu, 13 Sep 2012 16:38:03 +0300
Message-ID: <1347543485-339-14-git-send-email-peter.ujfalusi@ti.com>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:58049 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755641Ab2IMNiY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 09:38:24 -0400
Received: by oago6 with SMTP id o6so1866993oag.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 06:38:22 -0700 (PDT)
In-Reply-To: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Ricardo Neri <ricardo.neri@ti.com>, Lars-Peter Clausen <lars@metafoo.de>

Instead of the OMAP DMA data type definition the data_type will be used to
specify the number of bits the DMA word should be configured or 0 in case
when based on the stream's format the omap-pcm can decide the needed DMA
word size.
This feature is needed for the omap-hdmi where the sDMA need to be
configured for 32bit word type regardless of the audio format used.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-hdmi.c | 3 +--
 sound/soc/omap/omap-pcm.c  | 3 ++-
 sound/soc/omap/omap-pcm.h  | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index b194646..0951767 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -34,7 +34,6 @@
 #include <sound/asoundef.h>
 #include <video/omapdss.h>
 
-#include <plat/dma.h>
 #include "omap-pcm.h"
 #include "omap-hdmi.h"
 
@@ -100,7 +99,7 @@ static int omap_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	priv->dma_params.data_type = OMAP_DMA_DATA_TYPE_S32;
+	priv->dma_params.data_type = 32;
 
 	snd_soc_dai_set_dma_data(dai, substream,
 				 &priv->dma_params);
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 4c13a5f..74da4b7 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -183,7 +183,8 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 	memset(&dma_params, 0, sizeof(dma_params));
 
 	if (dma_data->data_type)
-		dma_params.data_type = dma_data->data_type;
+		dma_params.data_type = omap_pcm_get_dma_type(
+				dma_data->data_type);
 	else
 		dma_params.data_type = omap_pcm_get_dma_type(
 				snd_pcm_format_physical_width(runtime->format));
diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
index 1bf47e4..cabe74c 100644
--- a/sound/soc/omap/omap-pcm.h
+++ b/sound/soc/omap/omap-pcm.h
@@ -32,7 +32,8 @@ struct omap_pcm_dma_data {
 	int		dma_req;	/* DMA request line */
 	unsigned long	port_addr;	/* transmit/receive register */
 	void (*set_threshold)(struct snd_pcm_substream *substream);
-	int		data_type;	/* data type 8,16,32 */
+	int		data_type;	/* 8, 16, 32 (bits) or 0 to let omap-pcm
+					 * to decide the sDMA data type */
 	int		packet_size;	/* packet size only in PACKET mode */
 };
 
-- 
1.7.12

