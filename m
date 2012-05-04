From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 14/14] OMAPDSS: HDMI: Implement DSS driver interface for audio
Date: Thu, 3 May 2012 20:44:08 -0500
Message-ID: <1336095848-6923-15-git-send-email-ricardo.neri@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44594 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759212Ab2EDBod (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 21:44:33 -0400
In-Reply-To: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Implement the DSS device driver audio support interface in the HDMI
panel driver and generic driver. The implementation relies on the
IP-specific functions that are defined at DSS probe time.

At the moment, a hardirq-safe spinlock is used to protect the audio
functions. This is because such functions might be called while
holding a lock (this especially true for audio_start/stop). For the
rest of the audio functions, a mutex could be used in the future as
the enablement of resources might take too much time.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss.h        |    8 +++
 drivers/video/omap2/dss/hdmi.c       |   42 ++++++++++++++
 drivers/video/omap2/dss/hdmi_panel.c |  100 ++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index d4b3dff..ec4aa14 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -514,6 +514,14 @@ int omapdss_hdmi_read_edid(u8 *buf, int len);
 bool omapdss_hdmi_detect(void);
 int hdmi_panel_init(void);
 void hdmi_panel_exit(void);
+#ifdef CONFIG_OMAP4_DSS_HDMI_AUDIO
+int hdmi_audio_enable(void);
+void hdmi_audio_disable(void);
+int hdmi_audio_start(void);
+void hdmi_audio_stop(void);
+bool hdmi_mode_has_audio(void);
+int hdmi_audio_config(struct omap_dss_audio *audio);
+#endif
 
 /* RFBI */
 #ifdef CONFIG_OMAP2_DSS_RFBI
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index aee0acf..388301e 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -673,6 +673,48 @@ int hdmi_compute_acr(u32 sample_freq, u32 *n, u32 *cts)
 
 	return 0;
 }
+
+int hdmi_audio_enable(void)
+{
+	DSSDBG("audio_enable\n");
+
+	return hdmi.ip_data.ops->audio_enable(&hdmi.ip_data);
+}
+
+void hdmi_audio_disable(void)
+{
+	DSSDBG("audio_disable\n");
+
+	hdmi.ip_data.ops->audio_disable(&hdmi.ip_data);
+}
+
+int hdmi_audio_start(void)
+{
+	DSSDBG("audio_start\n");
+
+	return hdmi.ip_data.ops->audio_start(&hdmi.ip_data);
+}
+
+void hdmi_audio_stop(void)
+{
+	DSSDBG("audio_stop\n");
+
+	hdmi.ip_data.ops->audio_stop(&hdmi.ip_data);
+}
+
+bool hdmi_mode_has_audio(void)
+{
+	if (hdmi.ip_data.cfg.cm.mode == HDMI_HDMI)
+		return true;
+	else
+		return false;
+}
+
+int hdmi_audio_config(struct omap_dss_audio *audio)
+{
+	return hdmi.ip_data.ops->audio_config(&hdmi.ip_data, audio);
+}
+
 #endif
 
 /* HDMI HW IP initialisation */
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 5e215d6..8c17daa 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -32,6 +32,10 @@
 static struct {
 	/* This protects the panel ops, mainly when accessing the HDMI IP. */
 	struct mutex lock;
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	/* This protects the audio ops, specifically. */
+	spinlock_t audio_lock;
+#endif
 } hdmi;
 
 
@@ -223,6 +227,90 @@ err:
 	return r;
 }
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+static int hdmi_panel_audio_enable(struct omap_dss_device *dssdev)
+{
+	unsigned long flags;
+	int r;
+
+	spin_lock_irqsave(&hdmi.audio_lock, flags);
+
+	r = hdmi_audio_enable();
+
+	spin_unlock_irqrestore(&hdmi.audio_lock, flags);
+	return r;
+}
+
+static void hdmi_panel_audio_disable(struct omap_dss_device *dssdev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hdmi.audio_lock, flags);
+
+	hdmi_audio_disable();
+
+	spin_unlock_irqrestore(&hdmi.audio_lock, flags);
+}
+
+static int hdmi_panel_audio_start(struct omap_dss_device *dssdev)
+{
+	unsigned long flags;
+	int r;
+
+	spin_lock_irqsave(&hdmi.audio_lock, flags);
+
+	r = hdmi_audio_start();
+
+	spin_unlock_irqrestore(&hdmi.audio_lock, flags);
+	return r;
+}
+
+static void hdmi_panel_audio_stop(struct omap_dss_device *dssdev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hdmi.audio_lock, flags);
+
+	hdmi_audio_stop();
+
+	spin_unlock_irqrestore(&hdmi.audio_lock, flags);
+}
+
+static bool hdmi_panel_audio_supported(struct omap_dss_device *dssdev)
+{
+	unsigned long flags;
+	bool r = false;
+
+	spin_lock_irqsave(&hdmi.audio_lock, flags);
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+		goto err;
+
+	if (!hdmi_mode_has_audio())
+		goto err;
+
+	r = true;
+err:
+	spin_unlock_irqrestore(&hdmi.audio_lock, flags);
+	return r;
+}
+
+static int hdmi_panel_audio_config(struct omap_dss_device *dssdev,
+		struct omap_dss_audio *audio)
+{
+	unsigned long flags;
+	int r;
+
+	spin_lock_irqsave(&hdmi.audio_lock, flags);
+
+	r = hdmi_audio_config(audio);
+
+	spin_unlock_irqrestore(&hdmi.audio_lock, flags);
+	return r;
+}
+
+#endif
+
 static struct omap_dss_driver hdmi_driver = {
 	.probe		= hdmi_panel_probe,
 	.remove		= hdmi_panel_remove,
@@ -235,6 +323,14 @@ static struct omap_dss_driver hdmi_driver = {
 	.check_timings	= hdmi_check_timings,
 	.read_edid	= hdmi_read_edid,
 	.detect		= hdmi_detect,
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	.audio_enable	= hdmi_panel_audio_enable,
+	.audio_disable	= hdmi_panel_audio_disable,
+	.audio_start	= hdmi_panel_audio_start,
+	.audio_stop	= hdmi_panel_audio_stop,
+	.audio_supported	= hdmi_panel_audio_supported,
+	.audio_config	= hdmi_panel_audio_config,
+#endif
 	.driver			= {
 		.name   = "hdmi_panel",
 		.owner  = THIS_MODULE,
@@ -245,6 +341,10 @@ int hdmi_panel_init(void)
 {
 	mutex_init(&hdmi.lock);
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	spin_lock_init(&hdmi.audio_lock);
+#endif
+
 	omap_dss_register_driver(&hdmi_driver);
 
 	return 0;
-- 
1.7.5.4

