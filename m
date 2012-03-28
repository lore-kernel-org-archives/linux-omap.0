From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 05/10] OMAPDSS: HDMI: Decouple HDMI audio from ASoC
Date: Wed, 28 Mar 2012 16:38:20 -0600
Message-ID: <1332974305-4578-6-git-send-email-ricardo.neri@ti.com>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59096 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758936Ab2C1Wk6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 18:40:58 -0400
In-Reply-To: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Instead of having OMAPDSS HDMI audio functionality depending on the
ASoC HDMI audio driver, use a new config option so that
potential users, including ASoC,  may select if needed.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/Kconfig           |    4 ++++
 drivers/video/omap2/dss/dss_features.c    |    3 +--
 drivers/video/omap2/dss/ti_hdmi.h         |    6 ++----
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    3 +--
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    5 +----
 5 files changed, 9 insertions(+), 12 deletions(-)

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
index c1839e2..399a28a 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -497,8 +497,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	.dump_core		=	ti_hdmi_4xxx_core_dump,
 	.dump_pll		=	ti_hdmi_4xxx_pll_dump,
 	.dump_phy		=	ti_hdmi_4xxx_phy_dump,
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 	.audio_enable		=       ti_hdmi_4xxx_wp_audio_enable,
 	.audio_start		=       ti_hdmi_4xxx_audio_start,
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 529e227..211da6f 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -110,8 +110,7 @@ struct ti_hdmi_ip_ops {
 
 	void (*dump_phy)(struct hdmi_ip_data *ip_data, struct seq_file *s);
 
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 	void (*audio_enable)(struct hdmi_ip_data *ip_data, bool start);
 
 	void (*audio_start)(struct hdmi_ip_data *ip_data, bool start);
@@ -145,8 +144,7 @@ void ti_hdmi_4xxx_wp_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_pll_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable);
 void ti_hdmi_4xxx_audio_start(struct hdmi_ip_data *ip_data, bool enable);
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index e6fa61d..e06139a 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1030,8 +1030,7 @@ void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s)
 	DUMPPHY(HDMI_TXPHY_PAD_CFG_CTRL);
 }
 
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
 					struct hdmi_audio_format *aud_fmt)
 {
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 9fa5cb1..222cc16 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -26,8 +26,6 @@
 #include "ti_hdmi.h"
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-#include <sound/soc.h>
-#include <sound/pcm_params.h>
 #include <sound/asound.h>
 #include <sound/asoundef.h>
 #endif
@@ -502,8 +500,7 @@ struct hdmi_core_audio_config {
 	bool					en_spdif;
 };
 
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 				u32 sample_freq, u32 *n, u32 *cts);
 void hdmi_core_audio_infoframe_config(struct hdmi_ip_data *ip_data,
-- 
1.7.0.4

