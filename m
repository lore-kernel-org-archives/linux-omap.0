From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH V2 2/2] ASoC: OMAP2+: Move McBSP, DMIC and McPDM to generic DMA DT binding
Date: Mon, 11 Mar 2013 08:50:22 +0100
Message-ID: <1362988223-22455-3-git-send-email-s-guiriec@ti.com>
References: <1362988223-22455-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55586 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167Ab3CKHvM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 03:51:12 -0400
In-Reply-To: <1362988223-22455-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Update OMAP2+ driver in order to use OMAP DMA DT binding for OMAP2+.
In case of DT boot snd_dmaengine_generic_pcm_open function is used.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 sound/soc/omap/mcbsp.c      |   26 ++++++++++++++++----------
 sound/soc/omap/omap-dmic.c  |   15 +++++++++------
 sound/soc/omap/omap-mcpdm.c |   22 ++++++++++++++--------
 sound/soc/omap/omap-pcm.c   |   12 ++++++++++--
 sound/soc/omap/omap-pcm.h   |    1 +
 5 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 285c836..16936493 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -1012,24 +1012,30 @@ int omap_mcbsp_init(struct platform_device *pdev)
 		}
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
-	if (!res) {
-		dev_err(&pdev->dev, "invalid rx DMA channel\n");
-		return -ENODEV;
+	if (!pdev->dev.of_node) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
+		if (!res) {
+			dev_err(&pdev->dev, "invalid rx DMA channel\n");
+			return -ENODEV;
+		}
+		mcbsp->dma_data[1].dma_req = res->start;
 	}
 	/* RX DMA request number, and port address configuration */
 	mcbsp->dma_data[1].name = "Audio Capture";
-	mcbsp->dma_data[1].dma_req = res->start;
+	mcbsp->dma_data[1].dma_name = "rx";
 	mcbsp->dma_data[1].port_addr = omap_mcbsp_dma_reg_params(mcbsp, 1);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
-	if (!res) {
-		dev_err(&pdev->dev, "invalid tx DMA channel\n");
-		return -ENODEV;
+	if (!pdev->dev.of_node) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
+		if (!res) {
+			dev_err(&pdev->dev, "invalid tx DMA channel\n");
+			return -ENODEV;
+		}
+		mcbsp->dma_data[0].dma_req = res->start;
 	}
 	/* TX DMA request number, and port address configuration */
 	mcbsp->dma_data[0].name = "Audio Playback";
-	mcbsp->dma_data[0].dma_req = res->start;
+	mcbsp->dma_data[0].dma_name = "tx";
 	mcbsp->dma_data[0].port_addr = omap_mcbsp_dma_reg_params(mcbsp, 0);
 
 	mcbsp->fclk = clk_get(&pdev->dev, "fck");
diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index ba49ccd..8695b32 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -62,6 +62,7 @@ struct omap_dmic {
  */
 static struct omap_pcm_dma_data omap_dmic_dai_dma_params = {
 	.name		= "DMIC capture",
+	.dma_name	= "up_link",
 };
 
 static inline void omap_dmic_write(struct omap_dmic *dmic, u16 reg, u32 val)
@@ -478,13 +479,15 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 	}
 	omap_dmic_dai_dma_params.port_addr = res->start + OMAP_DMIC_DATA_REG;
 
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!res) {
-		dev_err(dmic->dev, "invalid dma resource\n");
-		ret = -ENODEV;
-		goto err_put_clk;
+	if (!pdev->dev.of_node) {
+		res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		if (!res) {
+			dev_err(dmic->dev, "invalid dma resource\n");
+			ret = -ENODEV;
+			goto err_put_clk;
+		}
+		omap_dmic_dai_dma_params.dma_req = res->start;
 	}
-	omap_dmic_dai_dma_params.dma_req = res->start;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
 	if (!res) {
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 5ca11bd..f41bac8 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -71,9 +71,11 @@ struct omap_mcpdm {
 static struct omap_pcm_dma_data omap_mcpdm_dai_dma_params[] = {
 	{
 		.name = "Audio playback",
+		.dma_name = "dn_link",
 	},
 	{
 		.name = "Audio capture",
+		.dma_name = "up_link",
 	},
 };
 
@@ -449,17 +451,21 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 	omap_mcpdm_dai_dma_params[0].port_addr = res->start + MCPDM_REG_DN_DATA;
 	omap_mcpdm_dai_dma_params[1].port_addr = res->start + MCPDM_REG_UP_DATA;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "dn_link");
-	if (!res)
-		return -ENODEV;
+	if (!pdev->dev.of_node) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
+						   "dn_link");
+		if (!res)
+			return -ENODEV;
 
-	omap_mcpdm_dai_dma_params[0].dma_req = res->start;
+		omap_mcpdm_dai_dma_params[0].dma_req = res->start;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "up_link");
-	if (!res)
-		return -ENODEV;
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
+						   "up_link");
+		if (!res)
+			return -ENODEV;
 
-	omap_mcpdm_dai_dma_params[1].dma_req = res->start;
+		omap_mcpdm_dai_dma_params[1].dma_req = res->start;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
 	if (res == NULL)
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

