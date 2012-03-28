From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 04/10] OMAPDSS: HDMI: OMAP4: Decouple wrapper enable and audio start
Date: Wed, 28 Mar 2012 16:38:19 -0600
Message-ID: <1332974305-4578-5-git-send-email-ricardo.neri@ti.com>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59105 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932250Ab2C1WlG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 18:41:06 -0400
In-Reply-To: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Decouple the enablement of the HDMI audio wrapper from audio start.
Otherwise, an audio FIFO underflow may occur. The audio wrapper
enablement must be done after configuration and before audio playback
is started.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss_features.c    |    1 +
 drivers/video/omap2/dss/ti_hdmi.h         |    3 +++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    8 ++++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 162c9a9..c1839e2 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -500,6 +500,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 	.audio_enable		=       ti_hdmi_4xxx_wp_audio_enable,
+	.audio_start		=       ti_hdmi_4xxx_audio_start,
 #endif
 
 };
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 50dadba..529e227 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -113,6 +113,8 @@ struct ti_hdmi_ip_ops {
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 	void (*audio_enable)(struct hdmi_ip_data *ip_data, bool start);
+
+	void (*audio_start)(struct hdmi_ip_data *ip_data, bool start);
 #endif
 
 };
@@ -146,5 +148,6 @@ void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable);
+void ti_hdmi_4xxx_audio_start(struct hdmi_ip_data *ip_data, bool enable);
 #endif
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 4ab3b19..e6fa61d 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1267,10 +1267,14 @@ int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 
 void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable)
 {
-	REG_FLD_MOD(hdmi_av_base(ip_data),
-				HDMI_CORE_AV_AUD_MODE, enable, 0, 0);
 	REG_FLD_MOD(hdmi_wp_base(ip_data),
 				HDMI_WP_AUDIO_CTRL, enable, 31, 31);
+}
+
+void ti_hdmi_4xxx_audio_start(struct hdmi_ip_data *ip_data, bool enable)
+{
+	REG_FLD_MOD(hdmi_av_base(ip_data),
+				HDMI_CORE_AV_AUD_MODE, enable, 0, 0);
 	REG_FLD_MOD(hdmi_wp_base(ip_data),
 				HDMI_WP_AUDIO_CTRL, enable, 30, 30);
 }
-- 
1.7.0.4

