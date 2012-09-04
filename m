From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC update 2/2] ASoC: omap-pcm: Do not check DMA sync_mode
Date: Tue,  4 Sep 2012 15:08:02 +0300
Message-ID: <1346760482-12794-3-git-send-email-peter.ujfalusi@ti.com>
References: <E1T8a09-0002vz-Bl@rmk-PC.arm.linux.org.uk>
 <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:48324 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756871Ab2IDMIC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 08:08:02 -0400
Received: by obbuo13 with SMTP id uo13so10750196obb.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Sep 2012 05:08:01 -0700 (PDT)
In-Reply-To: <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP dmaengine now supports element mode also in cyclic DMA so we do not
need to block non PACKET modes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-pcm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 50ae048..0f88db3 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -32,7 +32,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <plat/dma.h> /* needed just for OMAP_DMA_SYNC_PACKET */
 #include "omap-pcm.h"
 
 static const struct snd_pcm_hardware omap_pcm_hardware = {
@@ -83,15 +82,6 @@ static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 	prtd->dma_data = dma_data;
 
-	/*
-	 * This is the only parameter we don't handle with DMA
-	 * engine - so we insist on OMAP_DMA_SYNC_PACKET here.
-	 */
-	if (dma_data->sync_mode != OMAP_DMA_SYNC_PACKET) {
-		pr_warn("ALSA: omap-dma: DMA using non-packet mode?\n");
-		return -EINVAL;
-	}
-
 	req = dma_data->dma_req;
 	err = snd_dmaengine_pcm_open(substream, omap_dma_filter_fn, &req);
 	if (err)
-- 
1.7.12

