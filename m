From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 3/5] OMAPDSS: HDMI: Add audio config functions to HDMI IP ops
Date: Sat, 11 Feb 2012 17:55:28 -0600
Message-ID: <1329004530-28029-4-git-send-email-ricardo.neri@ti.com>
References: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49033 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286Ab2BKX4C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Feb 2012 18:56:02 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1BNu1WY031077
	for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 17:56:01 -0600
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1BNu1op019785
	for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 17:56:01 -0600 (CST)
In-Reply-To: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

DSS defines a set functions to perform HDMI IP-specific operations
that may differ across OMAP versions. Audio needs to be configured
at IP level as well. This patch adds the audio configuration to the
HDMI IP operations and defines them for OMAP4.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss_features.c    |    5 +++++
 drivers/video/omap2/dss/ti_hdmi.h         |   24 ++++++++++++++++++++++++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    8 --------
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index b0b5b00..004d34b 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -500,6 +500,11 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 	.audio_enable		=       ti_hdmi_4xxx_audio_enable,
+	.audio_dma_cfg		=	hdmi_wp_audio_config_dma,
+	.audio_core_cfg		=	ti_hdmi_4xxx_core_audio_config,
+	.audio_fmt_cfg		=	hdmi_wp_audio_config_format,
+	.audio_if_cfg		=
+		ti_hdmi_4xxx_core_audio_infoframe_config,
 #endif
 
 };
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 2080993..c9dac4e 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -22,6 +22,10 @@
 #define _TI_HDMI_H
 
 struct hdmi_ip_data;
+struct hdmi_audio_format;
+struct hdmi_audio_dma;
+struct hdmi_core_audio_config;
+struct hdmi_core_infoframe_audio;
 
 enum hdmi_pll_pwr {
 	HDMI_PLLPWRCMD_ALLOFF = 0,
@@ -113,6 +117,18 @@ struct ti_hdmi_ip_ops {
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 	void (*audio_enable)(struct hdmi_ip_data *ip_data, bool start);
+
+	void (*audio_dma_cfg)(struct hdmi_ip_data *ip_data,
+					struct hdmi_audio_dma *aud_dma);
+
+	void (*audio_core_cfg)(struct hdmi_ip_data *ip_data,
+					struct hdmi_core_audio_config  *cfg);
+
+	void (*audio_fmt_cfg)(struct hdmi_ip_data *ip_data,
+					struct hdmi_audio_format *aud_fmt);
+
+	void (*audio_if_cfg)(struct hdmi_ip_data *ip_data,
+		struct hdmi_core_infoframe_audio *info_aud);
 #endif
 
 };
@@ -142,5 +158,13 @@ void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 void ti_hdmi_4xxx_audio_enable(struct hdmi_ip_data *ip_data, bool enable);
+void ti_hdmi_4xxx_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
+		struct hdmi_core_infoframe_audio *info_aud);
+void ti_hdmi_4xxx_core_audio_config(struct hdmi_ip_data *ip_data,
+					struct hdmi_core_audio_config *cfg);
+void hdmi_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
+					struct hdmi_audio_dma *aud_dma);
+void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
+					struct hdmi_audio_format *aud_fmt);
 #endif
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index bd8b387..43cd783 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -578,13 +578,5 @@ struct hdmi_core_audio_config {
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 				u32 sample_freq, u32 *n, u32 *cts);
-void ti_hdmi_4xxx_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
-		struct hdmi_core_infoframe_audio *info_aud);
-void ti_hdmi_4xxx_core_audio_config(struct hdmi_ip_data *ip_data,
-					struct hdmi_core_audio_config *cfg);
-void hdmi_wp_audio_config_dma(struct hdmi_ip_data *ip_data,
-					struct hdmi_audio_dma *aud_dma);
-void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
-					struct hdmi_audio_format *aud_fmt);
 #endif
 #endif
-- 
1.7.0.4

