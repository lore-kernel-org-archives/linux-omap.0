From: Archit Taneja <archit@ti.com>
Subject: [PATCH 18/23] OMAPDSS: HDMI: Add output pointers as arguments to all functions used by hdmi panel driver
Date: Tue, 21 Aug 2012 11:28:25 +0530
Message-ID: <1345528711-27801-19-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60149 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293Ab2HUGB1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:01:27 -0400
In-Reply-To: <1345528711-27801-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com, Archit Taneja <archit@ti.com>

All functions of an output driver used by a panel driver should have an
omap_dss_output pointer as an argument. This is needed as the function would
somehow need to retrieve the output driver's private data. It may not be needed
by some of the outputs for now as driver data is globally visible within them.
The correct way to retrieve driver data is to extract the platform device from
the output, and then extract the driver data from the platform device.

Add output arguments from functions used by panel drivers which currently miss
it. This will come to use when the HDMI functions retrieve the driver data
in the correct manner.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.h        |   17 ++++++++-------
 drivers/video/omap2/dss/hdmi.c       |   16 +++++++-------
 drivers/video/omap2/dss/hdmi_panel.c |   38 +++++++++++++++++++++++++---------
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index bfa8b4d..dfbc3d9 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -509,17 +509,18 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_output *out,
 		struct omap_video_timings *timings);
 int omapdss_hdmi_display_check_timing(struct omap_dss_output *out,
 		struct omap_video_timings *timings);
-int omapdss_hdmi_read_edid(u8 *buf, int len);
-bool omapdss_hdmi_detect(void);
+int omapdss_hdmi_read_edid(struct omap_dss_output *out, u8 *buf, int len);
+bool omapdss_hdmi_detect(struct omap_dss_output *out);
 int hdmi_panel_init(void);
 void hdmi_panel_exit(void);
 #ifdef CONFIG_OMAP4_DSS_HDMI_AUDIO
-int hdmi_audio_enable(void);
-void hdmi_audio_disable(void);
-int hdmi_audio_start(void);
-void hdmi_audio_stop(void);
-bool hdmi_mode_has_audio(void);
-int hdmi_audio_config(struct omap_dss_audio *audio);
+int hdmi_audio_enable(struct omap_dss_output *out);
+void hdmi_audio_disable(struct omap_dss_output *out);
+int hdmi_audio_start(struct omap_dss_output *out);
+void hdmi_audio_stop(struct omap_dss_output *out);
+bool hdmi_mode_has_audio(struct omap_dss_output *out);
+int hdmi_audio_config(struct omap_dss_output *out,
+		struct omap_dss_audio *audio);
 #endif
 
 /* RFBI */
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 16b745c..39dfc2b 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -602,7 +602,7 @@ static void hdmi_dump_regs(struct seq_file *s)
 	mutex_unlock(&hdmi.lock);
 }
 
-int omapdss_hdmi_read_edid(u8 *buf, int len)
+int omapdss_hdmi_read_edid(struct omap_dss_output *out, u8 *buf, int len)
 {
 	int r;
 
@@ -619,7 +619,7 @@ int omapdss_hdmi_read_edid(u8 *buf, int len)
 	return r;
 }
 
-bool omapdss_hdmi_detect(void)
+bool omapdss_hdmi_detect(struct omap_dss_output *out)
 {
 	int r;
 
@@ -829,35 +829,35 @@ int hdmi_compute_acr(u32 sample_freq, u32 *n, u32 *cts)
 	return 0;
 }
 
-int hdmi_audio_enable(void)
+int hdmi_audio_enable(struct omap_dss_output *out)
 {
 	DSSDBG("audio_enable\n");
 
 	return hdmi.ip_data.ops->audio_enable(&hdmi.ip_data);
 }
 
-void hdmi_audio_disable(void)
+void hdmi_audio_disable(struct omap_dss_output *out)
 {
 	DSSDBG("audio_disable\n");
 
 	hdmi.ip_data.ops->audio_disable(&hdmi.ip_data);
 }
 
-int hdmi_audio_start(void)
+int hdmi_audio_start(struct omap_dss_output *out)
 {
 	DSSDBG("audio_start\n");
 
 	return hdmi.ip_data.ops->audio_start(&hdmi.ip_data);
 }
 
-void hdmi_audio_stop(void)
+void hdmi_audio_stop(struct omap_dss_output *out)
 {
 	DSSDBG("audio_stop\n");
 
 	hdmi.ip_data.ops->audio_stop(&hdmi.ip_data);
 }
 
-bool hdmi_mode_has_audio(void)
+bool hdmi_mode_has_audio(struct omap_dss_output *out)
 {
 	if (hdmi.ip_data.cfg.cm.mode == HDMI_HDMI)
 		return true;
@@ -865,7 +865,7 @@ bool hdmi_mode_has_audio(void)
 		return false;
 }
 
-int hdmi_audio_config(struct omap_dss_audio *audio)
+int hdmi_audio_config(struct omap_dss_output *out, struct omap_dss_audio *audio)
 {
 	return hdmi.ip_data.ops->audio_config(&hdmi.ip_data, audio);
 }
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index fb35bbb..532882d 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -78,21 +78,25 @@ static void hdmi_panel_remove(struct omap_dss_device *dssdev)
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 static int hdmi_panel_audio_enable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	unsigned long flags;
 	int r;
 
+	if (out == NULL)
+		return -ENODEV;
+
 	mutex_lock(&hdmi.lock);
 	spin_lock_irqsave(&hdmi.audio_lock, flags);
 
 	/* enable audio only if the display is active and supports audio */
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE ||
-	    !hdmi_mode_has_audio()) {
+	    !hdmi_mode_has_audio(out)) {
 		DSSERR("audio not supported or display is off\n");
 		r = -EPERM;
 		goto err;
 	}
 
-	r = hdmi_audio_enable();
+	r = hdmi_audio_enable(out);
 
 	if (!r)
 		dssdev->audio_state = OMAP_DSS_AUDIO_ENABLED;
@@ -105,11 +109,12 @@ err:
 
 static void hdmi_panel_audio_disable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	unsigned long flags;
 
 	spin_lock_irqsave(&hdmi.audio_lock, flags);
 
-	hdmi_audio_disable();
+	hdmi_audio_disable(out);
 
 	dssdev->audio_state = OMAP_DSS_AUDIO_DISABLED;
 
@@ -118,9 +123,13 @@ static void hdmi_panel_audio_disable(struct omap_dss_device *dssdev)
 
 static int hdmi_panel_audio_start(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	unsigned long flags;
 	int r;
 
+	if (out == NULL)
+		return -ENODEV;
+
 	spin_lock_irqsave(&hdmi.audio_lock, flags);
 	/*
 	 * No need to check the panel state. It was checked when trasitioning
@@ -132,7 +141,7 @@ static int hdmi_panel_audio_start(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	r = hdmi_audio_start();
+	r = hdmi_audio_start(out);
 
 	if (!r)
 		dssdev->audio_state = OMAP_DSS_AUDIO_PLAYING;
@@ -144,11 +153,12 @@ err:
 
 static void hdmi_panel_audio_stop(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	unsigned long flags;
 
 	spin_lock_irqsave(&hdmi.audio_lock, flags);
 
-	hdmi_audio_stop();
+	hdmi_audio_stop(out);
 	dssdev->audio_state = OMAP_DSS_AUDIO_ENABLED;
 
 	spin_unlock_irqrestore(&hdmi.audio_lock, flags);
@@ -156,14 +166,18 @@ static void hdmi_panel_audio_stop(struct omap_dss_device *dssdev)
 
 static bool hdmi_panel_audio_supported(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	bool r = false;
 
+	if (out == NULL)
+		return r;
+
 	mutex_lock(&hdmi.lock);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		goto err;
 
-	if (!hdmi_mode_has_audio())
+	if (!hdmi_mode_has_audio(out))
 		goto err;
 
 	r = true;
@@ -175,21 +189,25 @@ err:
 static int hdmi_panel_audio_config(struct omap_dss_device *dssdev,
 		struct omap_dss_audio *audio)
 {
+	struct omap_dss_output *out = dssdev->output;
 	unsigned long flags;
 	int r;
 
+	if (out == NULL)
+		return -ENODEV;
+
 	mutex_lock(&hdmi.lock);
 	spin_lock_irqsave(&hdmi.audio_lock, flags);
 
 	/* config audio only if the display is active and supports audio */
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE ||
-	    !hdmi_mode_has_audio()) {
+	    !hdmi_mode_has_audio(out)) {
 		DSSERR("audio not supported or display is off\n");
 		r = -EPERM;
 		goto err;
 	}
 
-	r = hdmi_audio_config(audio);
+	r = hdmi_audio_config(out, audio);
 
 	if (!r)
 		dssdev->audio_state = OMAP_DSS_AUDIO_CONFIGURED;
@@ -407,7 +425,7 @@ static int hdmi_read_edid(struct omap_dss_device *dssdev, u8 *buf, int len)
 			goto err;
 	}
 
-	r = omapdss_hdmi_read_edid(buf, len);
+	r = omapdss_hdmi_read_edid(out, buf, len);
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
 			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
@@ -434,7 +452,7 @@ static bool hdmi_detect(struct omap_dss_device *dssdev)
 			goto err;
 	}
 
-	r = omapdss_hdmi_detect();
+	r = omapdss_hdmi_detect(out);
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
 			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
-- 
1.7.9.5

