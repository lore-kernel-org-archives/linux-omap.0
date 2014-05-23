From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 08/13] ASoC: omap-hdmi: Changes for registeing the driver from OMAPDSS
Date: Fri, 23 May 2014 22:07:57 +0300
Message-ID: <d90dd9819cb2d68b50585dede986f5458f3a85f2.1400871999.git.jsarha@ti.com>
References: <cover.1400871999.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58037 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660AbaEWTIf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 May 2014 15:08:35 -0400
In-Reply-To: <cover.1400871999.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The old OMAP HDMI audio registering from arch/arm/mach-omap2/devices.c
was broken. The new approach is to register it from OMAPDSS HDMI
driver. The commit does the necessary changes for this approach to
omap-hdmi-dai driver.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/omap/omap-hdmi.c |   65 ++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 48 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index 537a1ec..ed0a37c 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -35,6 +35,7 @@
 #include <sound/dmaengine_pcm.h>
 #include <video/omapdss.h>
 
+#include <sound/omap-hdmi-dai-pdata.h>
 #include "omap-hdmi.h"
 #include "omap-pcm.h"
 
@@ -65,7 +66,7 @@ static int omap_hdmi_dai_startup(struct snd_pcm_substream *substream,
 		return err;
 	}
 
-	if (!priv->dssdev->driver->audio_supported(priv->dssdev)) {
+	if (!priv->dssdev->ops.hdmi->audio_supported(priv->dssdev)) {
 		dev_err(dai->dev, "audio not supported\n");
 		return -ENODEV;
 	}
@@ -80,7 +81,7 @@ static int omap_hdmi_dai_prepare(struct snd_pcm_substream *substream,
 {
 	struct hdmi_priv *priv = snd_soc_dai_get_drvdata(dai);
 
-	return priv->dssdev->driver->audio_enable(priv->dssdev);
+	return priv->dssdev->ops.hdmi->audio_enable(priv->dssdev);
 }
 
 static int omap_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
@@ -206,7 +207,7 @@ static int omap_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 	priv->dss_audio.iec = iec;
 	priv->dss_audio.cea = cea;
 
-	err = priv->dssdev->driver->audio_config(priv->dssdev,
+	err = priv->dssdev->ops.hdmi->audio_config(priv->dssdev,
 						 &priv->dss_audio);
 
 	return err;
@@ -222,12 +223,12 @@ static int omap_hdmi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		err = priv->dssdev->driver->audio_start(priv->dssdev);
+		err = priv->dssdev->ops.hdmi->audio_start(priv->dssdev);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		priv->dssdev->driver->audio_stop(priv->dssdev);
+		priv->dssdev->ops.hdmi->audio_stop(priv->dssdev);
 		break;
 	default:
 		err = -EINVAL;
@@ -240,7 +241,7 @@ static void omap_hdmi_dai_shutdown(struct snd_pcm_substream *substream,
 {
 	struct hdmi_priv *priv = snd_soc_dai_get_drvdata(dai);
 
-	priv->dssdev->driver->audio_disable(priv->dssdev);
+	priv->dssdev->ops.hdmi->audio_disable(priv->dssdev);
 }
 
 static const struct snd_soc_dai_ops omap_hdmi_dai_ops = {
@@ -267,10 +268,14 @@ static const struct snd_soc_component_driver omap_hdmi_component = {
 
 static int omap_hdmi_probe(struct platform_device *pdev)
 {
-	int ret;
-	struct resource *hdmi_rsrc;
+	struct asoc_omap_hdmi_dai_pdata *pdata = pdev->dev.platform_data;
 	struct hdmi_priv *hdmi_data;
-	bool hdmi_dev_found = false;
+	int ret;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "No platform data, bailing out\n");
+		return -ENODEV;
+	}
 
 	hdmi_data = devm_kzalloc(&pdev->dev, sizeof(*hdmi_data), GFP_KERNEL);
 	if (hdmi_data == NULL) {
@@ -278,48 +283,12 @@ static int omap_hdmi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!hdmi_rsrc) {
-		dev_err(&pdev->dev, "Cannot obtain IORESOURCE_MEM HDMI\n");
-		return -ENODEV;
-	}
-
-	hdmi_data->dma_data.addr = hdmi_rsrc->start + OMAP_HDMI_AUDIO_DMA_PORT;
-
-	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!hdmi_rsrc) {
-		dev_err(&pdev->dev, "Cannot obtain IORESOURCE_DMA HDMI\n");
-		return -ENODEV;
-	}
-
-	hdmi_data->dma_req = hdmi_rsrc->start;
+	hdmi_data->dma_data.addr = pdata->dma_addr;
+	hdmi_data->dma_req = pdata->dma_req;
 	hdmi_data->dma_data.filter_data = &hdmi_data->dma_req;
 	hdmi_data->dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-	/*
-	 * TODO: We assume that there is only one DSS HDMI device. Future
-	 * OMAP implementations may support more than one HDMI devices and
-	 * we should provided separate audio support for all of them.
-	 */
-	/* Find an HDMI device. */
-	for_each_dss_dev(hdmi_data->dssdev) {
-		omap_dss_get_device(hdmi_data->dssdev);
-
-		if (!hdmi_data->dssdev->driver) {
-			omap_dss_put_device(hdmi_data->dssdev);
-			continue;
-		}
-
-		if (hdmi_data->dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
-			hdmi_dev_found = true;
-			break;
-		}
-	}
-
-	if (!hdmi_dev_found) {
-		dev_err(&pdev->dev, "no driver for HDMI display found\n");
-		return -ENODEV;
-	}
+	hdmi_data->dssdev = pdata->dssdev;
 
 	dev_set_drvdata(&pdev->dev, hdmi_data);
 	ret = snd_soc_register_component(&pdev->dev, &omap_hdmi_component,
-- 
1.7.9.5

