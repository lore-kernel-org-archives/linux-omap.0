From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 12/15] ASoC: OMAP: mcbsp, mcpdm, dmic: Let omap-pcm to pick the dma_type
Date: Thu, 13 Sep 2012 16:38:02 +0300
Message-ID: <1347543485-339-13-git-send-email-peter.ujfalusi@ti.com>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:37272 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755529Ab2IMNiV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 09:38:21 -0400
Received: by obbuo13 with SMTP id uo13so4469627obb.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 06:38:19 -0700 (PDT)
In-Reply-To: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Ricardo Neri <ricardo.neri@ti.com>, Lars-Peter Clausen <lars@metafoo.de>

omap-pcm can figure out the correct dma_type based on the stream's format.
In this way we can get rid of the plat/dma.h include from these drivers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-dmic.c  | 2 --
 sound/soc/omap/omap-mcbsp.c | 3 ---
 sound/soc/omap/omap-mcpdm.c | 3 ---
 3 files changed, 8 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 60b7b8c..df0ff24 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -33,7 +33,6 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_device.h>
-#include <plat/dma.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -63,7 +62,6 @@ struct omap_dmic {
  */
 static struct omap_pcm_dma_data omap_dmic_dai_dma_params = {
 	.name		= "DMIC capture",
-	.data_type	= OMAP_DMA_DATA_TYPE_S32,
 };
 
 static inline void omap_dmic_write(struct omap_dmic *dmic, u16 reg, u32 val)
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 5b3bacc..a230646 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -34,7 +34,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#include <plat/dma.h>
 #include <plat/mcbsp.h>
 #include "mcbsp.h"
 #include "omap-mcbsp.h"
@@ -234,11 +233,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-		dma_data->data_type = OMAP_DMA_DATA_TYPE_S16;
 		wlen = 16;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
-		dma_data->data_type = OMAP_DMA_DATA_TYPE_S32;
 		wlen = 32;
 		break;
 	default:
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index f90d5de..84743d4 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -40,7 +40,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include "omap-mcpdm.h"
 #include "omap-pcm.h"
@@ -71,11 +70,9 @@ struct omap_mcpdm {
 static struct omap_pcm_dma_data omap_mcpdm_dai_dma_params[] = {
 	{
 		.name = "Audio playback",
-		.data_type = OMAP_DMA_DATA_TYPE_S32,
 	},
 	{
 		.name = "Audio capture",
-		.data_type = OMAP_DMA_DATA_TYPE_S32,
 	},
 };
 
-- 
1.7.12

