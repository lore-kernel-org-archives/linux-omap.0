From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 2/4] ASoC: OMAP: HDMI: Correct signature of ASoC functions
Date: Fri, 16 Dec 2011 01:03:11 -0600
Message-ID: <1324018993-31466-3-git-send-email-ricardo.neri@ti.com>
References: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46091 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756067Ab1LPHDo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 02:03:44 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBG73i98023093
	for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 01:03:44 -0600
In-Reply-To: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: linux-omap@vger.kernel.org, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, Ricardo Neri <ricardo.neri@ti.com>

These functions require access to IP-secific data. However, it is not possible
to pass such data as a function argument as such functions have a specific
signature specified by ASoC. Instead, they will have access to the IP-specific
data by calling snd_soc_codec_get_drvdata. The codec driver data is set
at probe time.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c            |    6 ++++--
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    7 +++++--
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    3 +--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index bd56a8a..a0e254e 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -554,11 +554,13 @@ void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 
-static int hdmi_audio_hw_params(struct hdmi_ip_data *ip_data,
-					struct snd_pcm_substream *substream,
+static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *params,
 				    struct snd_soc_dai *dai)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct hdmi_ip_data *ip_data = snd_soc_codec_get_drvdata(codec);
 	struct hdmi_audio_format audio_format;
 	struct hdmi_audio_dma audio_dma;
 	struct hdmi_core_audio_config core_cfg;
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index e1a6ce5..3f74f55 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1204,11 +1204,14 @@ int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 	return 0;
 }
 
-int hdmi_audio_trigger(struct hdmi_ip_data *ip_data,
-				struct snd_pcm_substream *substream, int cmd,
+int hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
 				struct snd_soc_dai *dai)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct hdmi_ip_data *ip_data = snd_soc_codec_get_drvdata(codec);
 	int err = 0;
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 2040956..eb5e8f7 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -576,8 +576,7 @@ struct hdmi_core_audio_config {
 
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-int hdmi_audio_trigger(struct hdmi_ip_data *ip_data,
-				struct snd_pcm_substream *substream, int cmd,
+int hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
 				struct snd_soc_dai *dai);
 int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 				u32 sample_freq, u32 *n, u32 *cts);
-- 
1.7.0.4

