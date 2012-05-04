From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 07/14] OMAPDSS: HDMI: Decouple HDMI audio from ASoC
Date: Thu, 3 May 2012 20:44:01 -0500
Message-ID: <1336095848-6923-8-git-send-email-ricardo.neri@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52863 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759214Ab2EDBoc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 21:44:32 -0400
In-Reply-To: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Instead of having OMAPDSS HDMI audio functionality depending on the
ASoC HDMI audio driver, use a new config option so that
potential users, including ASoC, may select if needed.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/Kconfig           |    4 ++++
 drivers/video/omap2/dss/dss_features.c    |    3 +--
 drivers/video/omap2/dss/ti_hdmi.h         |    6 ++----
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    6 ++----
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    3 +--
 5 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 7be7c06..b492001 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -68,6 +68,10 @@ config OMAP4_DSS_HDMI
 	  HDMI Interface. This adds the High Definition Multimedia Interface.
 	  See http://www.hdmi.org/ for HDMI specification.
 
+config OMAP4_DSS_HDMI_AUDIO
+	bool
+	depends on OMAP4_DSS_HDMI
+
 config OMAP2_DSS_SDI
 	bool "SDI support"
 	depends on ARCH_OMAP3
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 8005128..508cc4a 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -567,8 +567,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	.dump_core		=	ti_hdmi_4xxx_core_dump,
 	.dump_pll		=	ti_hdmi_4xxx_pll_dump,
 	.dump_phy		=	ti_hdmi_4xxx_phy_dump,
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 	.audio_enable		=       ti_hdmi_4xxx_wp_audio_enable,
 	.audio_disable		=       ti_hdmi_4xxx_wp_audio_disable,
 	.audio_start		=       ti_hdmi_4xxx_audio_start,
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 8afdd0b..6aedb89 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -108,8 +108,7 @@ struct ti_hdmi_ip_ops {
 
 	void (*dump_phy)(struct hdmi_ip_data *ip_data, struct seq_file *s);
 
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 	int (*audio_enable)(struct hdmi_ip_data *ip_data);
 
 	void (*audio_disable)(struct hdmi_ip_data *ip_data);
@@ -190,8 +189,7 @@ void ti_hdmi_4xxx_wp_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_pll_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 int ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_wp_audio_disable(struct hdmi_ip_data *ip_data);
 int ti_hdmi_4xxx_audio_start(struct hdmi_ip_data *ip_data);
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 12c21d3..cbda730 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -29,8 +29,7 @@
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <linux/gpio.h>
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 #include <sound/asound.h>
 #endif
 
@@ -1026,8 +1025,7 @@ void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
 	DUMPPHY(HDMI_TXPHY_PAD_CFG_CTRL);
 }
 
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
 					struct hdmi_audio_format *aud_fmt)
 {
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 40b724c..5d6e37a 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -440,8 +440,7 @@ struct hdmi_core_audio_config {
 	bool					en_spdif;
 };
 
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 				u32 sample_freq, u32 *n, u32 *cts);
 void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
-- 
1.7.5.4

