From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH 1/2] OMAPDSS: HDMI: Rid hw_params of extra argument
Date: Tue, 22 Nov 2011 20:53:38 +0530
Message-ID: <1321975418-12784-1-git-send-email-jaswinder.singh@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55845 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203Ab1KVPX4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:23:56 -0500
Received: by ghrr1 with SMTP id r1so264183ghr.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:23:56 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mythripk@ti.com, tomi.valkeinen@ti.com, Jassi Brar <jaswinder.singh@linaro.org>

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/video/omap2/dss/hdmi.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 3262f0f..d3eae98 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -554,8 +554,7 @@ void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 
-static int hdmi_audio_hw_params(struct hdmi_ip_data *ip_data,
-					struct snd_pcm_substream *substream,
+static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *params,
 				    struct snd_soc_dai *dai)
 {
@@ -609,7 +608,7 @@ static int hdmi_audio_hw_params(struct hdmi_ip_data *ip_data,
 		return -EINVAL;
 	}
 
-	err = hdmi_config_audio_acr(ip_data, params_rate(params), &n, &cts);
+	err = hdmi_config_audio_acr(&hdmi.ip_data, params_rate(params), &n, &cts);
 	if (err < 0)
 		return err;
 
@@ -625,8 +624,8 @@ static int hdmi_audio_hw_params(struct hdmi_ip_data *ip_data,
 	audio_dma.mode = HDMI_AUDIO_TRANSF_DMA;
 	audio_dma.fifo_threshold = 0x20; /* in number of samples */
 
-	hdmi_wp_audio_config_dma(ip_data, &audio_dma);
-	hdmi_wp_audio_config_format(ip_data, &audio_format);
+	hdmi_wp_audio_config_dma(&hdmi.ip_data, &audio_dma);
+	hdmi_wp_audio_config_format(&hdmi.ip_data, &audio_format);
 
 	/*
 	 * I2S config
@@ -670,7 +669,7 @@ static int hdmi_audio_hw_params(struct hdmi_ip_data *ip_data,
 	/* Use parallel audio interface */
 	core_cfg.en_parallel_aud_input = true;
 
-	hdmi_core_audio_config(ip_data, &core_cfg);
+	hdmi_core_audio_config(&hdmi.ip_data, &core_cfg);
 
 	/*
 	 * Configure packet
@@ -684,7 +683,7 @@ static int hdmi_audio_hw_params(struct hdmi_ip_data *ip_data,
 	aud_if_cfg.db5_downmix_inh = false;
 	aud_if_cfg.db5_lsv = 0;
 
-	hdmi_core_audio_infoframe_config(ip_data, &aud_if_cfg);
+	hdmi_core_audio_infoframe_config(&hdmi.ip_data, &aud_if_cfg);
 	return 0;
 }
 
-- 
1.7.4.1

