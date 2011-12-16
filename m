From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 4/4] ASoC: OMAP: HDMI: Move HDMI codec trigger function to generic HDMI driver
Date: Fri, 16 Dec 2011 01:03:13 -0600
Message-ID: <1324018993-31466-5-git-send-email-ricardo.neri@ti.com>
References: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46093 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756127Ab1LPHDo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 02:03:44 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBG73ioT023097
	for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 01:03:44 -0600
In-Reply-To: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: linux-omap@vger.kernel.org, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, Ricardo Neri <ricardo.neri@ti.com>

The function hdmi_audio_trigger is a callback used by ASoC to stop/start
HDMI audio. Also, it does not perform IP-specific configuration directly.
Hence, it should be placed in the general portion of the HDMI driver,
along with the other ASoC callbacks.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c            |   31 ++++++++++++++++++++++++++++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   32 -----------------------------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    2 -
 3 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index a0e254e..5c93041 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -554,6 +554,37 @@ void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 
+int hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct platform_device *pdev = to_platform_device(codec->dev);
+	struct hdmi_ip_data *ip_data = snd_soc_codec_get_drvdata(codec);
+	int err = 0;
+
+	if (!(ip_data->ops) && !(ip_data->ops->audio_enable)) {
+		dev_err(&pdev->dev, "Cannot enable/disable audio\n");
+		return -ENODEV;
+	}
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ip_data->ops->audio_enable(ip_data, true);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ip_data->ops->audio_enable(ip_data, false);
+		break;
+	default:
+		err = -EINVAL;
+	}
+	return err;
+}
+
 static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *params,
 				    struct snd_soc_dai *dai)
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 220e0ce..9af81f1 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1213,36 +1213,4 @@ void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable)
 	REG_FLD_MOD(hdmi_wp_base(ip_data),
 				HDMI_WP_AUDIO_CTRL, enable, 30, 30);
 }
-
-int hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
-				struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
-	struct platform_device *pdev = to_platform_device(codec->dev);
-	struct hdmi_ip_data *ip_data = snd_soc_codec_get_drvdata(codec);
-	int err = 0;
-
-	if (!(ip_data->ops) && !(ip_data->ops->audio_enable)) {
-		dev_err(&pdev->dev, "Cannot enable/disable audio\n");
-		return -ENODEV;
-	}
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ip_data->ops->audio_enable(ip_data, true);
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		ip_data->ops->audio_enable(ip_data, false);
-		break;
-	default:
-		err = -EINVAL;
-	}
-	return err;
-}
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index eb5e8f7..a442998 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -576,8 +576,6 @@ struct hdmi_core_audio_config {
 
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-int hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
-				struct snd_soc_dai *dai);
 int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 				u32 sample_freq, u32 *n, u32 *cts);
 void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
-- 
1.7.0.4

