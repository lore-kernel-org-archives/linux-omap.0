From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 3/4] OMAPDSS: HDMI: Create function to enable HDMI audio
Date: Fri, 16 Dec 2011 01:03:12 -0600
Message-ID: <1324018993-31466-4-git-send-email-ricardo.neri@ti.com>
References: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46090 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756033Ab1LPHDo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 02:03:44 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBG73ikX023100
	for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 01:03:44 -0600
In-Reply-To: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: linux-omap@vger.kernel.org, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, Ricardo Neri <ricardo.neri@ti.com>

In order to separate clearly IP-specific code from general DSS code,
a function for OMAP4 audio enable is created. This function is
included in the HDMI IP ops to align with the current implementation
of the DSS HDMI driver. This function is to be used by the ASoC
HDMI audio codec.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss_features.c    |    4 +++
 drivers/video/omap2/dss/ti_hdmi.h         |   10 ++++++++-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   30 +++++++++++++++++-----------
 3 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index b402699..43b6037 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -465,6 +465,10 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	.dump_core		=	ti_hdmi_4xxx_core_dump,
 	.dump_pll		=	ti_hdmi_4xxx_pll_dump,
 	.dump_phy		=	ti_hdmi_4xxx_phy_dump,
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+	.audio_enable		=       ti_hdmi_4xxx_wp_audio_enable,
+#endif
 
 };
 
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 2c3443d..7503f7f 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -110,6 +110,11 @@ struct ti_hdmi_ip_ops {
 
 	void (*dump_phy)(struct hdmi_ip_data *ip_data, struct seq_file *s);
 
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+	void (*audio_enable)(struct hdmi_ip_data *ip_data, bool start);
+#endif
+
 };
 
 struct hdmi_ip_data {
@@ -134,5 +139,8 @@ void ti_hdmi_4xxx_wp_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_pll_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
-
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable);
+#endif
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 3f74f55..220e0ce 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1204,35 +1204,41 @@ int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 	return 0;
 }
 
+void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable)
+{
+	REG_FLD_MOD(hdmi_av_base(ip_data),
+				HDMI_CORE_AV_AUD_MODE, enable, 0, 0);
+	REG_FLD_MOD(hdmi_wp_base(ip_data),
+				HDMI_WP_AUDIO_CTRL, enable, 31, 31);
+	REG_FLD_MOD(hdmi_wp_base(ip_data),
+				HDMI_WP_AUDIO_CTRL, enable, 30, 30);
+}
+
 int hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
+	struct platform_device *pdev = to_platform_device(codec->dev);
 	struct hdmi_ip_data *ip_data = snd_soc_codec_get_drvdata(codec);
 	int err = 0;
 
+	if (!(ip_data->ops) && !(ip_data->ops->audio_enable)) {
+		dev_err(&pdev->dev, "Cannot enable/disable audio\n");
+		return -ENODEV;
+	}
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		REG_FLD_MOD(hdmi_av_base(ip_data),
-					HDMI_CORE_AV_AUD_MODE, 1, 0, 0);
-		REG_FLD_MOD(hdmi_wp_base(ip_data),
-					HDMI_WP_AUDIO_CTRL, 1, 31, 31);
-		REG_FLD_MOD(hdmi_wp_base(ip_data),
-					HDMI_WP_AUDIO_CTRL, 1, 30, 30);
+		ip_data->ops->audio_enable(ip_data, true);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		REG_FLD_MOD(hdmi_av_base(ip_data),
-					HDMI_CORE_AV_AUD_MODE, 0, 0, 0);
-		REG_FLD_MOD(hdmi_wp_base(ip_data),
-					HDMI_WP_AUDIO_CTRL, 0, 30, 30);
-		REG_FLD_MOD(hdmi_wp_base(ip_data),
-					HDMI_WP_AUDIO_CTRL, 0, 31, 31);
+		ip_data->ops->audio_enable(ip_data, false);
 		break;
 	default:
 		err = -EINVAL;
-- 
1.7.0.4

