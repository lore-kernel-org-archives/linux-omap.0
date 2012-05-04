From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 01/14] OMAPDSS: HDMI: Split audio_enable into audio_enable/disable
Date: Thu, 3 May 2012 20:43:55 -0500
Message-ID: <1336095848-6923-2-git-send-email-ricardo.neri@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37431 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755737Ab2EDBob (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 21:44:31 -0400
In-Reply-To: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

To improve readability, split the audio_enable HDMI IP operation
into two separate functions for enabling and disabling audio.
The audio_enable function is also modified to return an error value.

While there, update these operations for the OMAP4 IP accordingly.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss_features.c    |    1 +
 drivers/video/omap2/dss/hdmi.c            |    4 ++--
 drivers/video/omap2/dss/ti_hdmi.h         |    7 +++++--
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   19 +++++++++++++++----
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index ce14aa6..52fbc72 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -569,6 +569,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 	.audio_enable		=       ti_hdmi_4xxx_wp_audio_enable,
+	.audio_disable		=       ti_hdmi_4xxx_wp_audio_disable,
 #endif
 
 };
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index c4b4f69..9a8b32c 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -576,12 +576,12 @@ static int hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ip_data->ops->audio_enable(ip_data, true);
+		ip_data->ops->audio_enable(ip_data);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		ip_data->ops->audio_enable(ip_data, false);
+		ip_data->ops->audio_disable(ip_data);
 		break;
 	default:
 		err = -EINVAL;
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 1f58b84..88fdc1c 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -108,7 +108,9 @@ struct ti_hdmi_ip_ops {
 
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-	void (*audio_enable)(struct hdmi_ip_data *ip_data, bool start);
+	int (*audio_enable)(struct hdmi_ip_data *ip_data);
+
+	void (*audio_disable)(struct hdmi_ip_data *ip_data);
 #endif
 
 };
@@ -183,6 +185,7 @@ void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file *s);
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable);
+int ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data);
+void ti_hdmi_4xxx_wp_audio_disable(struct hdmi_ip_data *ip_data);
 #endif
 #endif
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index bfe6fe6..b25b519 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1249,13 +1249,24 @@ int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 	return 0;
 }
 
-void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool enable)
+int ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data)
 {
 	REG_FLD_MOD(hdmi_av_base(ip_data),
-				HDMI_CORE_AV_AUD_MODE, enable, 0, 0);
+		    HDMI_CORE_AV_AUD_MODE, true, 0, 0);
 	REG_FLD_MOD(hdmi_wp_base(ip_data),
-				HDMI_WP_AUDIO_CTRL, enable, 31, 31);
+		    HDMI_WP_AUDIO_CTRL, true, 31, 31);
 	REG_FLD_MOD(hdmi_wp_base(ip_data),
-				HDMI_WP_AUDIO_CTRL, enable, 30, 30);
+		    HDMI_WP_AUDIO_CTRL, true, 30, 30);
+	return 0;
+}
+
+void ti_hdmi_4xxx_wp_audio_disable(struct hdmi_ip_data *ip_data)
+{
+	REG_FLD_MOD(hdmi_av_base(ip_data),
+		    HDMI_CORE_AV_AUD_MODE, false, 0, 0);
+	REG_FLD_MOD(hdmi_wp_base(ip_data),
+		    HDMI_WP_AUDIO_CTRL, false, 31, 31);
+	REG_FLD_MOD(hdmi_wp_base(ip_data),
+		    HDMI_WP_AUDIO_CTRL, false, 30, 30);
 }
 #endif
-- 
1.7.5.4

