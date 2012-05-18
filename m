From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 05/11] ASoC: OMAP: HDMI: Use the DSS audio interface
Date: Fri, 18 May 2012 01:42:37 -0500
Message-ID: <1337323363-11449-6-git-send-email-ricardo.neri@ti.com>
References: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60239 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759204Ab2ERGnW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 May 2012 02:43:22 -0400
In-Reply-To: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: x0055901@ti.com, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Instead of accessing the HDMI IP directly, the CPU DAI driver takes
advantage of the audio interface provided by the DSS device driver.
The ASoC driver will link the DSS audio functionality with ALSA by
calling the appropriate DSS device driver functions at the relevant
moments. For this, three new DAI operations are added: trigger, prepare
and shutdown operations.

At the moment, it is assumed that only one HDMI display is available
in the system, as it is the case in OMAP4. However, in the future,
one DAI for each HDMI display should be provided.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/Kconfig     |    1 +
 sound/soc/omap/omap-hdmi.c |   77 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 9ccfa5e..13afb2c 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -114,6 +114,7 @@ config SND_OMAP_SOC_OMAP4_HDMI
 	depends on SND_OMAP_SOC && OMAP4_DSS_HDMI && OMAP2_DSS && ARCH_OMAP4
 	select SND_OMAP_SOC_HDMI
 	select SND_SOC_OMAP_HDMI_CODEC
+	select OMAP4_DSS_HDMI_AUDIO
 	help
 	  Say Y if you want to add support for SoC HDMI audio on Texas Instruments
 	  OMAP4 chips
diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index a6656b2..ff6132a 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -30,6 +30,7 @@
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
+#include <video/omapdss.h>
 
 #include <plat/dma.h>
 #include "omap-pcm.h"
@@ -39,6 +40,7 @@
 
 struct hdmi_priv {
 	struct omap_pcm_dma_data dma_params;
+	struct omap_dss_device *dssdev;
 };
 
 static int omap_hdmi_dai_startup(struct snd_pcm_substream *substream,
@@ -57,6 +59,14 @@ static int omap_hdmi_dai_startup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int omap_hdmi_dai_prepare(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct hdmi_priv *priv = snd_soc_dai_get_drvdata(dai);
+
+	return priv->dssdev->driver->audio_enable(priv->dssdev);
+}
+
 static int omap_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *params,
 				    struct snd_soc_dai *dai)
@@ -83,6 +93,37 @@ static int omap_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
 	return err;
 }
 
+static int omap_hdmi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
+{
+	struct hdmi_priv *priv = snd_soc_dai_get_drvdata(dai);
+	int err = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		err = priv->dssdev->driver->audio_start(priv->dssdev);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		priv->dssdev->driver->audio_stop(priv->dssdev);
+		break;
+	default:
+		err = -EINVAL;
+	}
+	return err;
+}
+
+static void omap_hdmi_dai_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct hdmi_priv *priv = snd_soc_dai_get_drvdata(dai);
+
+	priv->dssdev->driver->audio_disable(priv->dssdev);
+}
+
 static const struct snd_soc_dai_ops omap_hdmi_dai_ops = {
 	.startup	= omap_hdmi_dai_startup,
 	.hw_params	= omap_hdmi_dai_hw_params,
@@ -103,6 +144,7 @@ static __devinit int omap_hdmi_probe(struct platform_device *pdev)
 	int ret;
 	struct resource *hdmi_rsrc;
 	struct hdmi_priv *hdmi_data;
+	bool hdmi_dev_found = false;
 
 	hdmi_data = devm_kzalloc(&pdev->dev, sizeof(*hdmi_data), GFP_KERNEL);
 	if (hdmi_data == NULL) {
@@ -129,14 +171,49 @@ static __devinit int omap_hdmi_probe(struct platform_device *pdev)
 	hdmi_data->dma_params.name = "HDMI playback";
 	hdmi_data->dma_params.sync_mode = OMAP_DMA_SYNC_PACKET;
 
+	/*
+	 * TODO: We assume that there is only one DSS HDMI device. Future
+	 * OMAP implementations may support more than one HDMI devices and
+	 * we should provided separate audio support for all of them.
+	 */
+	/* Find an HDMI device. */
+	for_each_dss_dev(hdmi_data->dssdev) {
+		omap_dss_get_device(hdmi_data->dssdev);
+
+		if (!hdmi_data->dssdev->driver) {
+			omap_dss_put_device(hdmi_data->dssdev);
+			continue;
+		}
+
+		if (hdmi_data->dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
+			hdmi_dev_found = true;
+			break;
+		}
+	}
+
+	if (!hdmi_dev_found) {
+		dev_err(&pdev->dev, "no driver for HDMI display found\n");
+		return -ENODEV;
+	}
+
 	dev_set_drvdata(&pdev->dev, hdmi_data);
 	ret = snd_soc_register_dai(&pdev->dev, &omap_hdmi_dai);
+
 	return ret;
 }
 
 static int __devexit omap_hdmi_remove(struct platform_device *pdev)
 {
+	struct hdmi_priv *hdmi_data = dev_get_drvdata(&pdev->dev);
+
 	snd_soc_unregister_dai(&pdev->dev);
+
+	if (hdmi_data == NULL) {
+		dev_err(&pdev->dev, "cannot obtain HDMi data\n");
+		return -ENODEV;
+	}
+
+	omap_dss_put_device(hdmi_data->dssdev);
 	return 0;
 }
 
-- 
1.7.5.4

