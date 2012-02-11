From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 2/5] OMAPDSS: HDMI: Rename audio functions in HDMI IP library
Date: Sat, 11 Feb 2012 17:55:27 -0600
Message-ID: <1329004530-28029-3-git-send-email-ricardo.neri@ti.com>
References: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37989 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755147Ab2BKX4C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Feb 2012 18:56:02 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1BNu1xD017196
	for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 17:56:01 -0600
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1BNu1BO019775
	for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 17:56:01 -0600 (CST)
In-Reply-To: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

The renamed functions are specific to OMAP4. Hence, rename so that
similar functions can be added in the future for other OMAP versions.

Also, remove the reference to the HDMI wrapper in the name of the
_audio_enable function as enabling audio involves both core and
wrapper settings.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss_features.c    |    2 +-
 drivers/video/omap2/dss/hdmi.c            |    4 ++--
 drivers/video/omap2/dss/ti_hdmi.h         |    2 +-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    6 +++---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 162c9a9..b0b5b00 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -499,7 +499,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	.dump_phy		=	ti_hdmi_4xxx_phy_dump,
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-	.audio_enable		=       ti_hdmi_4xxx_wp_audio_enable,
+	.audio_enable		=       ti_hdmi_4xxx_audio_enable,
 #endif
 
 };
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 2ba108f..dfc1487 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -718,7 +718,7 @@ static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 	/* Use parallel audio interface */
 	core_cfg.en_parallel_aud_input = true;
 
-	hdmi_core_audio_config(ip_data, &core_cfg);
+	ti_hdmi_4xxx_core_audio_config(ip_data, &core_cfg);
 
 	/*
 	 * Configure packet
@@ -732,7 +732,7 @@ static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 	aud_if_cfg.db5_downmix_inh = false;
 	aud_if_cfg.db5_lsv = 0;
 
-	hdmi_core_audio_infoframe_config(ip_data, &aud_if_cfg);
+	ti_hdmi_4xxx_core_audio_infoframe_config(ip_data, &aud_if_cfg);
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 7503f7f..2080993 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -141,6 +141,6 @@ void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable);
+void ti_hdmi_4xxx_audio_enable(struct hdmi_ip_data *ip_data, bool enable);
 #endif
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 0150e21..542963b 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1017,7 +1017,7 @@ void hdmi_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_AUDIO_CTRL, r);
 }
 
-void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
+void ti_hdmi_4xxx_core_audio_config(struct hdmi_ip_data *ip_data,
 					struct hdmi_core_audio_config *cfg)
 {
 	u32 r;
@@ -1102,7 +1102,7 @@ void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
 	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_MODE, r);
 }
 
-void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
+void ti_hdmi_4xxx_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
 		struct hdmi_core_infoframe_audio *info_aud)
 {
 	u8 val;
@@ -1211,7 +1211,7 @@ int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 	return 0;
 }
 
-void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable)
+void ti_hdmi_4xxx_audio_enable(struct hdmi_ip_data *ip_data, bool enable)
 {
 	REG_FLD_MOD(hdmi_av_base(ip_data),
 				HDMI_CORE_AV_AUD_MODE, enable, 0, 0);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index a442998..bd8b387 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -578,9 +578,9 @@ struct hdmi_core_audio_config {
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 				u32 sample_freq, u32 *n, u32 *cts);
-void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
+void ti_hdmi_4xxx_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
 		struct hdmi_core_infoframe_audio *info_aud);
-void hdmi_core_audio_config(struct hdmi_ip_data *ip_data,
+void ti_hdmi_4xxx_core_audio_config(struct hdmi_ip_data *ip_data,
 					struct hdmi_core_audio_config *cfg);
 void hdmi_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
 					struct hdmi_audio_dma *aud_dma);
-- 
1.7.0.4

