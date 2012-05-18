From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 07/11] ASoC: OMAP: HDMI: Improve how the display state is verified
Date: Fri, 18 May 2012 01:42:39 -0500
Message-ID: <1337323363-11449-8-git-send-email-ricardo.neri@ti.com>
References: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60238 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759019Ab2ERGnW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 May 2012 02:43:22 -0400
In-Reply-To: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: x0055901@ti.com, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Before starting to play audio, we need to make sure that the
display is active and the current video mode supports audio. instead
of using the overlay manager in the machine driver, we use the DSS audio
interface's audio_supported function. As we already have a pointer to
the correct dssdev, we do not have to look for it every time audio is
to be played. Also, the CPU DAI startup function is called earlier
than the card hw_param function. Hence and we can detect the state of
the display earlier.

While there, add a error message if the constraint cannot be applied.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>

squash to improve err
---
 sound/soc/omap/omap-hdmi.c       |    9 ++++++++-
 sound/soc/omap/omap4-hdmi-card.c |   34 ----------------------------------
 2 files changed, 8 insertions(+), 35 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index fc4815a..ec7c7e6 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -51,6 +51,7 @@ struct hdmi_priv {
 static int omap_hdmi_dai_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
+	struct hdmi_priv *priv = snd_soc_dai_get_drvdata(dai);
 	int err;
 	/*
 	 * Make sure that the period bytes are multiple of the DMA packet size.
@@ -58,9 +59,15 @@ static int omap_hdmi_dai_startup(struct snd_pcm_substream *substream,
 	 */
 	err = snd_pcm_hw_constraint_step(substream->runtime, 0,
 				 SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 128);
-	if (err < 0)
+	if (err < 0) {
+		dev_err(dai->dev, "could not apply constraint\n");
 		return err;
+	}
 
+	if (!priv->dssdev->driver->audio_supported(priv->dssdev)) {
+		dev_err(dai->dev, "audio not supported\n");
+		return -ENODEV;
+	}
 	return 0;
 }
 
diff --git a/sound/soc/omap/omap4-hdmi-card.c b/sound/soc/omap/omap4-hdmi-card.c
index 99e96c6..6c3255f 100644
--- a/sound/soc/omap/omap4-hdmi-card.c
+++ b/sound/soc/omap/omap4-hdmi-card.c
@@ -29,39 +29,6 @@
 
 #define DRV_NAME "omap-hdmi-audio"
 
-static int omap4_hdmi_dai_hw_params(struct snd_pcm_substream *substream,
-		struct snd_pcm_hw_params *params)
-{
-	int i;
-	struct omap_overlay_manager *mgr = NULL;
-	struct device *dev = substream->pcm->card->dev;
-
-	/* Find DSS HDMI device */
-	for (i = 0; i < omap_dss_get_num_overlay_managers(); i++) {
-		mgr = omap_dss_get_overlay_manager(i);
-		if (mgr && mgr->device
-			&& mgr->device->type == OMAP_DISPLAY_TYPE_HDMI)
-			break;
-	}
-
-	if (i == omap_dss_get_num_overlay_managers()) {
-		dev_err(dev, "HDMI display device not found!\n");
-		return -ENODEV;
-	}
-
-	/* Make sure HDMI is power-on to avoid L3 interconnect errors */
-	if (mgr->device->state != OMAP_DSS_DISPLAY_ACTIVE) {
-		dev_err(dev, "HDMI display is not active!\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static struct snd_soc_ops omap4_hdmi_dai_ops = {
-	.hw_params = omap4_hdmi_dai_hw_params,
-};
-
 static struct snd_soc_dai_link omap4_hdmi_dai = {
 	.name = "HDMI",
 	.stream_name = "HDMI",
@@ -69,7 +36,6 @@ static struct snd_soc_dai_link omap4_hdmi_dai = {
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "hdmi-audio-codec",
 	.codec_dai_name = "omap-hdmi-hifi",
-	.ops = &omap4_hdmi_dai_ops,
 };
 
 static struct snd_soc_card snd_soc_omap4_hdmi = {
-- 
1.7.5.4

