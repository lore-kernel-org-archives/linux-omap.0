From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v3] OMAPDSS: HDMI: Implement DSS driver
	interface for audio
Date: Wed, 9 May 2012 22:59:48 -0500
Message-ID: <1336622388-28183-2-git-send-email-ricardo.neri@ti.com>
References: <1336622388-28183-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1336622388-28183-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: x0055901@ti.com, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>, agraf@suse.de, vaibhav.bedia@ti.com, s-chereau@ti.com, peter.ujfalusi@ti.com, research@ottomaneng.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, lrg@ti.com
List-Id: linux-omap@vger.kernel.org

Implement the DSS device driver audio support interface in the HDMI
panel driver and generic driver. The implementation relies on the
IP-specific functions that are defined at DSS probe time.

A mixed locking strategy is used. The panel's mutex is used when
the state of the panel is queried as required by the audio functions.
The audio state is protected using a spinlock as users of DSS HDMI
audio functionality might start/stop audio while holding a spinlock.
The mutex and the spinlock are held and released as needed by each
individual function to protect the panel state and the audio state.

Although the panel's audio_start functions does not check whether
the panel is active, the audio _ENABLED state can be reached only
from audio_enable, which does check the state of the panel. Also,
if the panel is ever disabled, the audio state will transition
to _DISABLED. Transitions are always protected by the audio lock.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss.h        |    8 ++
 drivers/video/omap2/dss/hdmi.c       |   42 ++++++++++
 drivers/video/omap2/dss/hdmi_panel.c |  140 ++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 0 deletions(-)

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
index 5e215d6..a8419c3 100644
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
 
 
@@ -55,6 +59,130 @@ static void hdmi_panel_remove(struct omap_dss_device *dssdev)
 
 }
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+static int hdmi_panel_audio_enable(struct omap_dss_device *dssdev)
+{
+	unsigned long flags;
+	int r;
+
+	mutex_lock(&hdmi.lock);
+	spin_lock_irqsave(&hdmi.audio_lock, flags);
+
+	/* audio can be enabled only if the display is active */
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
+		DSSERR("display is not active\n");
+		r = -EPERM;
+		goto err;
+	}
+
+	r = hdmi_audio_enable();
+
+	if (!r)
+		dssdev->audio_state = OMAP_DSS_AUDIO_ENABLED;
+
+err:
+	spin_unlock_irqrestore(&hdmi.audio_lock, flags);
+	mutex_unlock(&hdmi.lock);
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
+	dssdev->audio_state = OMAP_DSS_AUDIO_DISABLED;
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
+	/*
+	 * No need to check the panel state. It was checked when trasitioning
+	 * to AUDIO_ENABLED.
+	 */
+	if (dssdev->audio_state != OMAP_DSS_AUDIO_ENABLED) {
+		DSSERR("audio start from invalid state\n");
+		r = -EPERM;
+		goto err;
+	}
+
+	r = hdmi_audio_start();
+
+	if (!r)
+		dssdev->audio_state = OMAP_DSS_AUDIO_PLAYING;
+
+err:
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
+	dssdev->audio_state = OMAP_DSS_AUDIO_ENABLED;
+
+	spin_unlock_irqrestore(&hdmi.audio_lock, flags);
+}
+
+static bool hdmi_panel_audio_supported(struct omap_dss_device *dssdev)
+{
+	bool r = false;
+
+	mutex_lock(&hdmi.lock);
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+		goto err;
+
+	if (!hdmi_mode_has_audio())
+		goto err;
+
+	r = true;
+err:
+	mutex_unlock(&hdmi.lock);
+	return r;
+}
+
+static int hdmi_panel_audio_config(struct omap_dss_device *dssdev,
+		struct omap_dss_audio *audio)
+{
+	unsigned long flags;
+	int r;
+
+	mutex_lock(&hdmi.lock);
+	spin_lock_irqsave(&hdmi.audio_lock, flags);
+
+	/* it only makes sense to configure audio if the display is active */
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
+		DSSERR("display is not active\n");
+		r = -EPERM;
+		goto err;
+	}
+
+	r = hdmi_audio_config(audio);
+
+	if (!r)
+		dssdev->audio_state = OMAP_DSS_AUDIO_CONFIGURED;
+
+err:
+	spin_unlock_irqrestore(&hdmi.audio_lock, flags);
+	mutex_unlock(&hdmi.lock);
+	return r;
+}
+#endif
+
 static int hdmi_panel_enable(struct omap_dss_device *dssdev)
 {
 	int r = 0;
@@ -235,6 +363,14 @@ static struct omap_dss_driver hdmi_driver = {
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
@@ -245,6 +381,10 @@ int hdmi_panel_init(void)
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
