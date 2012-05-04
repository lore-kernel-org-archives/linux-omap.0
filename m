From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 06/14] OMAPDSS: HDMI: Decouple wrapper enable/disable and audio start/stop
Date: Thu, 3 May 2012 20:44:00 -0500
Message-ID: <1336095848-6923-7-git-send-email-ricardo.neri@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37433 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757372Ab2EDBob (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 21:44:31 -0400
In-Reply-To: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

From: Axel Castaneda Gonzalez <x0055901@ti.com>

Decouple the enable/disable operation of the HDMI audio wrapper from
audio start/stop. Otherwise, an audio FIFO underflow may occur. The
audio wrapper enablement must be done after configuration and
before audio playback is started.

Signed-off-by: Axel Castaneda Gonzalez <x0055901@ti.com>
Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss_features.c    |    2 ++
 drivers/video/omap2/dss/ti_hdmi.h         |    6 ++++++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   19 ++++++++++++++-----
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index c677095..8005128 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -571,6 +571,8 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 	.audio_enable		=       ti_hdmi_4xxx_wp_audio_enable,
 	.audio_disable		=       ti_hdmi_4xxx_wp_audio_disable,
+	.audio_start		=       ti_hdmi_4xxx_audio_start,
+	.audio_stop		=       ti_hdmi_4xxx_audio_stop,
 #endif
 
 };
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 4c84a9c..8afdd0b 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -113,6 +113,10 @@ struct ti_hdmi_ip_ops {
 	int (*audio_enable)(struct hdmi_ip_data *ip_data);
 
 	void (*audio_disable)(struct hdmi_ip_data *ip_data);
+
+	int (*audio_start)(struct hdmi_ip_data *ip_data);
+
+	void (*audio_stop)(struct hdmi_ip_data *ip_data);
 #endif
 
 };
@@ -190,5 +194,7 @@ void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 int ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data);
 void ti_hdmi_4xxx_wp_audio_disable(struct hdmi_ip_data *ip_data);
+int ti_hdmi_4xxx_audio_start(struct hdmi_ip_data *ip_data);
+void ti_hdmi_4xxx_audio_stop(struct hdmi_ip_data *ip_data);
 #endif
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 985caf9..12c21d3 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1256,22 +1256,31 @@ int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 
 int ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data)
 {
-	REG_FLD_MOD(hdmi_av_base(ip_data),
-		    HDMI_CORE_AV_AUD_MODE, true, 0, 0);
 	REG_FLD_MOD(hdmi_wp_base(ip_data),
 		    HDMI_WP_AUDIO_CTRL, true, 31, 31);
+	return 0;
+}
+
+void ti_hdmi_4xxx_wp_audio_disable(struct hdmi_ip_data *ip_data)
+{
+	REG_FLD_MOD(hdmi_wp_base(ip_data),
+		    HDMI_WP_AUDIO_CTRL, false, 31, 31);
+}
+
+int ti_hdmi_4xxx_audio_start(struct hdmi_ip_data *ip_data)
+{
+	REG_FLD_MOD(hdmi_av_base(ip_data),
+		    HDMI_CORE_AV_AUD_MODE, true, 0, 0);
 	REG_FLD_MOD(hdmi_wp_base(ip_data),
 		    HDMI_WP_AUDIO_CTRL, true, 30, 30);
 	return 0;
 }
 
-void ti_hdmi_4xxx_wp_audio_disable(struct hdmi_ip_data *ip_data)
+void ti_hdmi_4xxx_audio_stop(struct hdmi_ip_data *ip_data)
 {
 	REG_FLD_MOD(hdmi_av_base(ip_data),
 		    HDMI_CORE_AV_AUD_MODE, false, 0, 0);
 	REG_FLD_MOD(hdmi_wp_base(ip_data),
-		    HDMI_WP_AUDIO_CTRL, false, 31, 31);
-	REG_FLD_MOD(hdmi_wp_base(ip_data),
 		    HDMI_WP_AUDIO_CTRL, false, 30, 30);
 }
 #endif
-- 
1.7.5.4

