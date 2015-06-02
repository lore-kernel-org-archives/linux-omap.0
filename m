From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3] ASoC: davinci-mcasp: Choose PCM driver based on configured DMA controller
Date: Tue, 2 Jun 2015 23:09:34 +0300
Message-ID: <e5dbf0a5fbb101792fd106461929c4b814dffc06.1433275670.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53804 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbbFBUJq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 16:09:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, misael.lopez@ti.com, Jyri Sarha <jsarha@ti.com>

Find the configured DMA controller by asking for a DMA channel in the
probe phase and releasing it right after. The controller device can be
found via the dma_chan struct and the controller is recognized from
the compatible property of its device node. The patch assumes EDMA if
there is no device node.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
Changes since v2:
- Print only one error message if DMA "probing" fails
  and none in case of -EPROBE_DEFER

Changes since first patch version:
- Change enum names from MCASP_?DMA to PCM_?DMA
- Return PCM_EDMA if !mcasp->dev->of_node
- Do not ignore possible error code returned by
  davinci_mcasp_get_dma_type()

 sound/soc/davinci/davinci-mcasp.c | 70 +++++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index d793494..a73cd57 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1565,6 +1565,49 @@ static int davinci_mcasp_init_ch_constraints(struct davinci_mcasp *mcasp)
 	return ret;
 }
 
+enum {
+	PCM_EDMA,
+	PCM_SDMA,
+};
+static const char *sdma_prefix = "ti,omap";
+
+static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
+{
+	struct dma_chan *chan;
+	const char *tmp;
+	int ret = PCM_EDMA;
+
+	if (!mcasp->dev->of_node)
+		return PCM_EDMA;
+
+	tmp = mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data;
+	chan = dma_request_slave_channel_reason(mcasp->dev, tmp);
+	if (IS_ERR(chan)) {
+		if (PTR_ERR(chan) != -EPROBE_DEFER)
+			dev_err(mcasp->dev,
+				"Can't verify DMA configuration (%ld)\n",
+				PTR_ERR(chan));
+		return PTR_ERR(chan);
+	}
+	BUG_ON(!chan->device || !chan->device->dev);
+
+	if (chan->device->dev->of_node)
+		ret = of_property_read_string(chan->device->dev->of_node,
+					      "compatible", &tmp);
+	else
+		dev_dbg(mcasp->dev, "DMA controller has no of-node\n");
+
+	dma_release_channel(chan);
+	if (ret)
+		return ret;
+
+	dev_dbg(mcasp->dev, "DMA controller compatible = \"%s\"\n", tmp);
+	if (!strncmp(tmp, sdma_prefix, strlen(sdma_prefix)))
+		return PCM_SDMA;
+
+	return PCM_EDMA;
+}
+
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
@@ -1763,27 +1806,34 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (ret != 0)
 		goto err;
 
-	switch (mcasp->version) {
+	ret = davinci_mcasp_get_dma_type(mcasp);
+	switch (ret) {
+	case PCM_EDMA:
 #if IS_BUILTIN(CONFIG_SND_EDMA_SOC) || \
 	(IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
 	 IS_MODULE(CONFIG_SND_EDMA_SOC))
-	case MCASP_VERSION_1:
-	case MCASP_VERSION_2:
-	case MCASP_VERSION_3:
 		ret = edma_pcm_platform_register(&pdev->dev);
-		break;
+#else
+		dev_err(&pdev->dev, "Missing SND_EDMA_SOC\n");
+		ret = -EINVAL;
+		goto err;
 #endif
+		break;
+	case PCM_SDMA:
 #if IS_BUILTIN(CONFIG_SND_OMAP_SOC) || \
 	(IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
 	 IS_MODULE(CONFIG_SND_OMAP_SOC))
-	case MCASP_VERSION_4:
 		ret = omap_pcm_platform_register(&pdev->dev);
-		break;
+#else
+		dev_err(&pdev->dev, "Missing SND_SDMA_SOC\n");
+		ret = -EINVAL;
+		goto err;
 #endif
+		break;
 	default:
-		dev_err(&pdev->dev, "Invalid McASP version: %d\n",
-			mcasp->version);
-		ret = -EINVAL;
+		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
+	case -EPROBE_DEFER:
+		goto err;
 		break;
 	}
 
-- 
1.9.1

