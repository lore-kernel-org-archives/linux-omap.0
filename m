From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH 1/5] ASoC: omap-pcm: Move to generic DMA for DT binding
Date: Thu, 7 Mar 2013 13:43:20 +0100
Message-ID: <1362660204-27074-2-git-send-email-s-guiriec@ti.com>
References: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59370 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab3CGMoN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Mar 2013 07:44:13 -0500
In-Reply-To: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Update in order to use OMAP DMA DT binding for OMAP2+. In case
of DT boot snd_dmaengine_generic_pcm_open function is used.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 sound/soc/omap/omap-pcm.c |   12 ++++++++++--
 sound/soc/omap/omap-pcm.h |    1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index c722c2e..df01a95 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -176,13 +176,21 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct omap_pcm_dma_data *dma_data;
+	int ret;
 
 	snd_soc_set_runtime_hwparams(substream, &omap_pcm_hardware);
 
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	return snd_dmaengine_pcm_open(substream, omap_dma_filter_fn,
-				      &dma_data->dma_req);
+	if (rtd->cpu_dai->dev->of_node)
+		ret = snd_dmaengine_generic_pcm_open(substream,
+						     rtd->cpu_dai->dev,
+						     dma_data->dma_name);
+	else
+		ret = snd_dmaengine_pcm_open(substream, omap_dma_filter_fn,
+					     &dma_data->dma_req);
+
+	return ret;
 }
 
 static int omap_pcm_close(struct snd_pcm_substream *substream)
diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
index cabe74c..06faa38 100644
--- a/sound/soc/omap/omap-pcm.h
+++ b/sound/soc/omap/omap-pcm.h
@@ -29,6 +29,7 @@ struct snd_pcm_substream;
 
 struct omap_pcm_dma_data {
 	char		*name;		/* stream identifier */
+	char		*dma_name;	/* DMA request name */
 	int		dma_req;	/* DMA request line */
 	unsigned long	port_addr;	/* transmit/receive register */
 	void (*set_threshold)(struct snd_pcm_substream *substream);
-- 
1.7.10.4

