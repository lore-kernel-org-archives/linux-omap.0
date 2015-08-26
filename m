From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 1/2] OMAPDSS: hdmi: Reconfigure and restart
	audio when display is enabled
Date: Wed, 26 Aug 2015 16:11:39 +0300
Message-ID: <44089dc819903c71e1d0ed0c14dd3ab060ed8c68.1440594174.git.jsarha@ti.com>
References: <cover.1440594174.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <cover.1440594174.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org

Reconfigure and restart audio when display is enabled, if audio
playback was active before. The audio configuration is stored when is
is successfully applied and a boolean is set when playback has started
and unset when stopped. This data is used to reconfigure the audio
when display is re-enabled. Abort audio playback if reconfiguration
fails.

A new spin lock is introduced to in order protect state variables
related to audio playback status. The wp_idlemode protection relies on
PM not touching it after the original initialization. A power
management API for controlling the idlemode would be needed for proper
synchronization.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h  | 10 +++-
 drivers/video/fbdev/omap2/dss/hdmi4.c | 65 ++++++++++++++++++++-----
 drivers/video/fbdev/omap2/dss/hdmi5.c | 89 +++++++++++++++++++++++++++++------
 3 files changed, 137 insertions(+), 27 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index e4a32fe..1e45b84 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -351,12 +351,20 @@ struct omap_hdmi {
 	struct regulator *vdda_reg;
 
 	bool core_enabled;
-	bool display_enabled;
 
 	struct omap_dss_device output;
 
 	struct platform_device *audio_pdev;
 	void (*audio_abort_cb)(struct device *dev);
+
+	bool audio_configured;
+	struct omap_dss_audio audio_config;
+
+	/* This lock should be taken when any one of the three
+	   state variables bellow are touched. */
+	spinlock_t audio_playing_lock;
+	bool audio_playing;
+	bool display_enabled;
 	int wp_idlemode;
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 6d3aa3f..ea1fa64 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -324,6 +324,7 @@ static int read_edid(u8 *buf, int len)
 static int hdmi_display_enable(struct omap_dss_device *dssdev)
 {
 	struct omap_dss_device *out = &hdmi.output;
+	unsigned long flags;
 	int r = 0;
 
 	DSSDBG("ENTER hdmi_display_enable\n");
@@ -342,7 +343,26 @@ static int hdmi_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
+	if (hdmi.audio_configured) {
+		hdmi4_audio_stop(&hdmi.core, &hdmi.wp);
+		hdmi_wp_audio_enable(&hdmi.wp, false);
+
+		r = hdmi4_audio_config(&hdmi.core, &hdmi.wp, &hdmi.audio_config,
+				       hdmi.cfg.timings.pixelclock);
+		if (r) {
+			DSSERR("Error restoring audio configuration: %d", r);
+			hdmi.audio_abort_cb(&hdmi.pdev->dev);
+			hdmi.audio_configured = false;
+		}
+	}
+
+	spin_lock_irqsave(&hdmi.audio_playing_lock, flags);
+	if (hdmi.audio_configured && hdmi.audio_playing) {
+		hdmi_wp_audio_enable(&hdmi.wp, true);
+		hdmi4_audio_start(&hdmi.core, &hdmi.wp);
+	}
 	hdmi.display_enabled = true;
+	spin_unlock_irqrestore(&hdmi.audio_playing_lock, flags);
 
 	mutex_unlock(&hdmi.lock);
 	return 0;
@@ -354,17 +374,18 @@ err0:
 
 static void hdmi_display_disable(struct omap_dss_device *dssdev)
 {
+	unsigned long flags;
+
 	DSSDBG("Enter hdmi_display_disable\n");
 
 	mutex_lock(&hdmi.lock);
 
-	if (hdmi.audio_pdev && hdmi.audio_abort_cb)
-		hdmi.audio_abort_cb(&hdmi.audio_pdev->dev);
+	spin_lock_irqsave(&hdmi.audio_playing_lock, flags);
+	hdmi.display_enabled = false;
+	spin_unlock_irqrestore(&hdmi.audio_playing_lock, flags);
 
 	hdmi_power_off_full(dssdev);
 
-	hdmi.display_enabled = false;
-
 	mutex_unlock(&hdmi.lock);
 }
 
@@ -565,9 +586,14 @@ out:
 static int hdmi_audio_shutdown(struct device *dev)
 {
 	struct omap_hdmi *hd = dev_get_drvdata(dev);
+	unsigned long flags;
 
 	mutex_lock(&hd->lock);
 	hd->audio_abort_cb = NULL;
+	hd->audio_configured = false;
+	spin_lock_irqsave(&hd->audio_playing_lock, flags);
+	hd->audio_playing = false;
+	spin_unlock_irqrestore(&hd->audio_playing_lock, flags);
 	mutex_unlock(&hd->lock);
 
 	return 0;
@@ -576,25 +602,38 @@ static int hdmi_audio_shutdown(struct device *dev)
 static int hdmi_audio_start(struct device *dev)
 {
 	struct omap_hdmi *hd = dev_get_drvdata(dev);
+	unsigned long flags;
 
 	WARN_ON(!hdmi_mode_has_audio(&hd->cfg));
-	WARN_ON(!hd->display_enabled);
 
-	hdmi_wp_audio_enable(&hd->wp, true);
-	hdmi4_audio_start(&hd->core, &hd->wp);
+	spin_lock_irqsave(&hd->audio_playing_lock, flags);
+
+	if (hd->display_enabled) {
+		hdmi_wp_audio_enable(&hd->wp, true);
+		hdmi4_audio_start(&hd->core, &hd->wp);
+	}
+	hd->audio_playing = true;
 
+	spin_unlock_irqrestore(&hd->audio_playing_lock, flags);
 	return 0;
 }
 
 static void hdmi_audio_stop(struct device *dev)
 {
 	struct omap_hdmi *hd = dev_get_drvdata(dev);
+	unsigned long flags;
 
 	WARN_ON(!hdmi_mode_has_audio(&hd->cfg));
-	WARN_ON(!hd->display_enabled);
 
-	hdmi4_audio_stop(&hd->core, &hd->wp);
-	hdmi_wp_audio_enable(&hd->wp, false);
+	spin_lock_irqsave(&hd->audio_playing_lock, flags);
+
+	if (hd->display_enabled) {
+		hdmi4_audio_stop(&hd->core, &hd->wp);
+		hdmi_wp_audio_enable(&hd->wp, false);
+	}
+	hd->audio_playing = false;
+
+	spin_unlock_irqrestore(&hd->audio_playing_lock, flags);
 }
 
 static int hdmi_audio_config(struct device *dev,
@@ -612,7 +651,10 @@ static int hdmi_audio_config(struct device *dev,
 
 	ret = hdmi4_audio_config(&hd->core, &hd->wp, dss_audio,
 				 hd->cfg.timings.pixelclock);
-
+	if (!ret) {
+		hd->audio_configured = true;
+		hd->audio_config = *dss_audio;
+	}
 out:
 	mutex_unlock(&hd->lock);
 
@@ -657,6 +699,7 @@ static int hdmi4_bind(struct device *dev, struct device *master, void *data)
 	dev_set_drvdata(&pdev->dev, &hdmi);
 
 	mutex_init(&hdmi.lock);
+	spin_lock_init(&hdmi.audio_playing_lock);
 
 	if (pdev->dev.of_node) {
 		r = hdmi_probe_of(pdev);
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index 7f87578..f352c4b 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -352,6 +352,7 @@ static int read_edid(u8 *buf, int len)
 static int hdmi_display_enable(struct omap_dss_device *dssdev)
 {
 	struct omap_dss_device *out = &hdmi.output;
+	unsigned long flags;
 	int r = 0;
 
 	DSSDBG("ENTER hdmi_display_enable\n");
@@ -370,7 +371,37 @@ static int hdmi_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
+	if (hdmi.audio_configured) {
+		spin_lock_irqsave(&hdmi.audio_playing_lock, flags);
+		hdmi_wp_audio_core_req_enable(&hdmi.wp, false);
+		hdmi_wp_audio_enable(&hdmi.wp, false);
+		if (hdmi.wp_idlemode > 0)
+			REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG,
+				    hdmi.wp_idlemode, 3, 2);
+		hdmi.wp_idlemode = -1;
+		spin_unlock_irqrestore(&hdmi.audio_playing_lock, flags);
+
+		r = hdmi5_audio_config(&hdmi.core, &hdmi.wp, &hdmi.audio_config,
+				       hdmi.cfg.timings.pixelclock);
+		if (r) {
+			DSSERR("Error restoring audio configuration: %d", r);
+			hdmi.audio_abort_cb(&hdmi.pdev->dev);
+			hdmi.audio_configured = false;
+		}
+	}
+
+	spin_lock_irqsave(&hdmi.audio_playing_lock, flags);
+	if (hdmi.audio_configured && hdmi.audio_playing) {
+		/* No-idle while playing audio, store the old value */
+		hdmi.wp_idlemode =
+			REG_GET(hdmi.wp.base, HDMI_WP_SYSCONFIG, 3, 2);
+		REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG, 1, 3, 2);
+
+		hdmi_wp_audio_enable(&hdmi.wp, true);
+		hdmi_wp_audio_core_req_enable(&hdmi.wp, true);
+	}
 	hdmi.display_enabled = true;
+	spin_unlock_irqrestore(&hdmi.audio_playing_lock, flags);
 
 	mutex_unlock(&hdmi.lock);
 	return 0;
@@ -382,17 +413,18 @@ err0:
 
 static void hdmi_display_disable(struct omap_dss_device *dssdev)
 {
+	unsigned long flags;
+
 	DSSDBG("Enter hdmi_display_disable\n");
 
 	mutex_lock(&hdmi.lock);
 
-	if (hdmi.audio_pdev && hdmi.audio_abort_cb)
-		hdmi.audio_abort_cb(&hdmi.audio_pdev->dev);
+	spin_lock_irqsave(&hdmi.audio_playing_lock, flags);
+	hdmi.display_enabled = false;
+	spin_unlock_irqrestore(&hdmi.audio_playing_lock, flags);
 
 	hdmi_power_off_full(dssdev);
 
-	hdmi.display_enabled = false;
-
 	mutex_unlock(&hdmi.lock);
 }
 
@@ -593,9 +625,14 @@ out:
 static int hdmi_audio_shutdown(struct device *dev)
 {
 	struct omap_hdmi *hd = dev_get_drvdata(dev);
+	unsigned long flags;
 
 	mutex_lock(&hd->lock);
 	hd->audio_abort_cb = NULL;
+	hd->audio_configured = false;
+	spin_lock_irqsave(&hd->audio_playing_lock, flags);
+	hd->audio_playing = false;
+	spin_unlock_irqrestore(&hd->audio_playing_lock, flags);
 	mutex_unlock(&hd->lock);
 
 	return 0;
@@ -604,32 +641,48 @@ static int hdmi_audio_shutdown(struct device *dev)
 static int hdmi_audio_start(struct device *dev)
 {
 	struct omap_hdmi *hd = dev_get_drvdata(dev);
+	unsigned long flags;
 
 	WARN_ON(!hdmi_mode_has_audio(&hd->cfg));
-	WARN_ON(!hd->display_enabled);
 
-	/* No-idle while playing audio, store the old value */
-	hd->wp_idlemode = REG_GET(hdmi.wp.base, HDMI_WP_SYSCONFIG, 3, 2);
-	REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG, 1, 3, 2);
+	spin_lock_irqsave(&hd->audio_playing_lock, flags);
 
-	hdmi_wp_audio_enable(&hd->wp, true);
-	hdmi_wp_audio_core_req_enable(&hd->wp, true);
+	if (hd->display_enabled) {
+		/* No-idle while playing audio, store the old value */
+		hd->wp_idlemode =
+			REG_GET(hdmi.wp.base, HDMI_WP_SYSCONFIG, 3, 2);
+		REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG, 1, 3, 2);
+
+		hdmi_wp_audio_enable(&hd->wp, true);
+		hdmi_wp_audio_core_req_enable(&hd->wp, true);
+	}
+	hd->audio_playing = true;
 
+	spin_unlock_irqrestore(&hd->audio_playing_lock, flags);
 	return 0;
 }
 
 static void hdmi_audio_stop(struct device *dev)
 {
 	struct omap_hdmi *hd = dev_get_drvdata(dev);
+	unsigned long flags;
 
 	WARN_ON(!hdmi_mode_has_audio(&hd->cfg));
-	WARN_ON(!hd->display_enabled);
 
-	hdmi_wp_audio_core_req_enable(&hd->wp, false);
-	hdmi_wp_audio_enable(&hd->wp, false);
+	spin_lock_irqsave(&hd->audio_playing_lock, flags);
 
-	/* Playback stopped, restore original idlemode */
-	REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG, hd->wp_idlemode, 3, 2);
+	if (hd->display_enabled) {
+		hdmi_wp_audio_core_req_enable(&hd->wp, false);
+		hdmi_wp_audio_enable(&hd->wp, false);
+
+		/* Playback stopped, restore original idlemode */
+		REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG, hd->wp_idlemode,
+			    3, 2);
+		hd->wp_idlemode = -1;
+	}
+	hd->audio_playing = false;
+
+	spin_unlock_irqrestore(&hd->audio_playing_lock, flags);
 }
 
 static int hdmi_audio_config(struct device *dev,
@@ -648,6 +701,10 @@ static int hdmi_audio_config(struct device *dev,
 	ret = hdmi5_audio_config(&hd->core, &hd->wp, dss_audio,
 				 hd->cfg.timings.pixelclock);
 
+	if (!ret) {
+		hd->audio_configured = true;
+		hd->audio_config = *dss_audio;
+	}
 out:
 	mutex_unlock(&hd->lock);
 
@@ -692,6 +749,8 @@ static int hdmi5_bind(struct device *dev, struct device *master, void *data)
 	dev_set_drvdata(&pdev->dev, &hdmi);
 
 	mutex_init(&hdmi.lock);
+	spin_lock_init(&hdmi.audio_playing_lock);
+	hdmi.wp_idlemode = -1;
 
 	if (pdev->dev.of_node) {
 		r = hdmi_probe_of(pdev);
-- 
1.9.1
