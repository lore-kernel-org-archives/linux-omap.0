From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 18/23] OMAPDSS: HDMI: Add dssdev pointer as an argument to all functions used by hdmi panel driver
Date: Thu, 30 Aug 2012 17:10:40 +0530
Message-ID: <1346326845-16583-19-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34306 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754772Ab2H3LnY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:43:24 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

All functions of an output driver used by a panel driver should have an
omap_dss_device pointer as an argument. This is needed as the function would
somehow need to retrieve the output driver's private data. It may not be needed
by some of the outputs for now as driver data is globally visible within them.
The correct way to retrieve driver data is to extract the platform device from
the output, and then extract the driver data from the platform device.

Add dssdev arguments to functions used by panel drivers which currently miss it.
This will come to use when the HDMI functions retrieve the driver data in the
correct manner.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.h        |   17 +++++++++--------
 drivers/video/omap2/dss/hdmi.c       |   17 +++++++++--------
 drivers/video/omap2/dss/hdmi_panel.c |   20 ++++++++++----------
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index de2fb9d..11c245d 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -506,17 +506,18 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings);
 int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 					struct omap_video_timings *timings);
-int omapdss_hdmi_read_edid(u8 *buf, int len);
-bool omapdss_hdmi_detect(void);
+int omapdss_hdmi_read_edid(struct omap_dss_device *dssdev, u8 *buf, int len);
+bool omapdss_hdmi_detect(struct omap_dss_device *dssdev);
 int hdmi_panel_init(void);
 void hdmi_panel_exit(void);
 #ifdef CONFIG_OMAP4_DSS_HDMI_AUDIO
-int hdmi_audio_enable(void);
-void hdmi_audio_disable(void);
-int hdmi_audio_start(void);
-void hdmi_audio_stop(void);
-bool hdmi_mode_has_audio(void);
-int hdmi_audio_config(struct omap_dss_audio *audio);
+int hdmi_audio_enable(struct omap_dss_device *dssdev);
+void hdmi_audio_disable(struct omap_dss_device *dssdev);
+int hdmi_audio_start(struct omap_dss_device *dssdev);
+void hdmi_audio_stop(struct omap_dss_device *dssdev);
+bool hdmi_mode_has_audio(struct omap_dss_device *dssdev);
+int hdmi_audio_config(struct omap_dss_device *dssdev,
+		struct omap_dss_audio *audio);
 #endif
 
 /* RFBI */
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 3c89904..2d3b959 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -608,7 +608,7 @@ static void hdmi_dump_regs(struct seq_file *s)
 	mutex_unlock(&hdmi.lock);
 }
 
-int omapdss_hdmi_read_edid(u8 *buf, int len)
+int omapdss_hdmi_read_edid(struct omap_dss_device *dssdev, u8 *buf, int len)
 {
 	int r;
 
@@ -625,7 +625,7 @@ int omapdss_hdmi_read_edid(u8 *buf, int len)
 	return r;
 }
 
-bool omapdss_hdmi_detect(void)
+bool omapdss_hdmi_detect(struct omap_dss_device *dssdev)
 {
 	int r;
 
@@ -833,35 +833,35 @@ int hdmi_compute_acr(u32 sample_freq, u32 *n, u32 *cts)
 	return 0;
 }
 
-int hdmi_audio_enable(void)
+int hdmi_audio_enable(struct omap_dss_device *dssdev)
 {
 	DSSDBG("audio_enable\n");
 
 	return hdmi.ip_data.ops->audio_enable(&hdmi.ip_data);
 }
 
-void hdmi_audio_disable(void)
+void hdmi_audio_disable(struct omap_dss_device *dssdev)
 {
 	DSSDBG("audio_disable\n");
 
 	hdmi.ip_data.ops->audio_disable(&hdmi.ip_data);
 }
 
-int hdmi_audio_start(void)
+int hdmi_audio_start(struct omap_dss_device *dssdev)
 {
 	DSSDBG("audio_start\n");
 
 	return hdmi.ip_data.ops->audio_start(&hdmi.ip_data);
 }
 
-void hdmi_audio_stop(void)
+void hdmi_audio_stop(struct omap_dss_device *dssdev)
 {
 	DSSDBG("audio_stop\n");
 
 	hdmi.ip_data.ops->audio_stop(&hdmi.ip_data);
 }
 
-bool hdmi_mode_has_audio(void)
+bool hdmi_mode_has_audio(struct omap_dss_device *dssdev)
 {
 	if (hdmi.ip_data.cfg.cm.mode == HDMI_HDMI)
 		return true;
@@ -869,7 +869,8 @@ bool hdmi_mode_has_audio(void)
 		return false;
 }
 
-int hdmi_audio_config(struct omap_dss_audio *audio)
+int hdmi_audio_config(struct omap_dss_device *dssdev,
+		struct omap_dss_audio *audio)
 {
 	return hdmi.ip_data.ops->audio_config(&hdmi.ip_data, audio);
 }
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 69fb115..ef3fc86 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -88,13 +88,13 @@ static int hdmi_panel_audio_enable(struct omap_dss_device *dssdev)
 
 	/* enable audio only if the display is active and supports audio */
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE ||
-	    !hdmi_mode_has_audio()) {
+	    !hdmi_mode_has_audio(dssdev)) {
 		DSSERR("audio not supported or display is off\n");
 		r = -EPERM;
 		goto err;
 	}
 
-	r = hdmi_audio_enable();
+	r = hdmi_audio_enable(dssdev);
 
 	if (!r)
 		dssdev->audio_state = OMAP_DSS_AUDIO_ENABLED;
@@ -111,7 +111,7 @@ static void hdmi_panel_audio_disable(struct omap_dss_device *dssdev)
 
 	spin_lock_irqsave(&hdmi.audio_lock, flags);
 
-	hdmi_audio_disable();
+	hdmi_audio_disable(dssdev);
 
 	dssdev->audio_state = OMAP_DSS_AUDIO_DISABLED;
 
@@ -134,7 +134,7 @@ static int hdmi_panel_audio_start(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	r = hdmi_audio_start();
+	r = hdmi_audio_start(dssdev);
 
 	if (!r)
 		dssdev->audio_state = OMAP_DSS_AUDIO_PLAYING;
@@ -150,7 +150,7 @@ static void hdmi_panel_audio_stop(struct omap_dss_device *dssdev)
 
 	spin_lock_irqsave(&hdmi.audio_lock, flags);
 
-	hdmi_audio_stop();
+	hdmi_audio_stop(dssdev);
 	dssdev->audio_state = OMAP_DSS_AUDIO_ENABLED;
 
 	spin_unlock_irqrestore(&hdmi.audio_lock, flags);
@@ -165,7 +165,7 @@ static bool hdmi_panel_audio_supported(struct omap_dss_device *dssdev)
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		goto err;
 
-	if (!hdmi_mode_has_audio())
+	if (!hdmi_mode_has_audio(dssdev))
 		goto err;
 
 	r = true;
@@ -185,13 +185,13 @@ static int hdmi_panel_audio_config(struct omap_dss_device *dssdev,
 
 	/* config audio only if the display is active and supports audio */
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE ||
-	    !hdmi_mode_has_audio()) {
+	    !hdmi_mode_has_audio(dssdev)) {
 		DSSERR("audio not supported or display is off\n");
 		r = -EPERM;
 		goto err;
 	}
 
-	r = hdmi_audio_config(audio);
+	r = hdmi_audio_config(dssdev, audio);
 
 	if (!r)
 		dssdev->audio_state = OMAP_DSS_AUDIO_CONFIGURED;
@@ -388,7 +388,7 @@ static int hdmi_read_edid(struct omap_dss_device *dssdev, u8 *buf, int len)
 			goto err;
 	}
 
-	r = omapdss_hdmi_read_edid(buf, len);
+	r = omapdss_hdmi_read_edid(dssdev, buf, len);
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
 			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
@@ -411,7 +411,7 @@ static bool hdmi_detect(struct omap_dss_device *dssdev)
 			goto err;
 	}
 
-	r = omapdss_hdmi_detect();
+	r = omapdss_hdmi_detect(dssdev);
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
 			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
-- 
1.7.9.5

