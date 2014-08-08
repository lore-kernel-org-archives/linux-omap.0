From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 14/14] OMAPDSS: Remove all references to obsolete HDMI audio callbacks
Date: Fri, 8 Aug 2014 16:23:55 +0300
Message-ID: <92a16dfe306b70fc346812fd3262e1490f558eb7.1407503813.git.jsarha@ti.com>
References: <cover.1407503813.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47608 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756762AbaHHNYX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2014 09:24:23 -0400
In-Reply-To: <cover.1407503813.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

In new model these callbacks are obsolete since the ASoC component
drivers are integrated into the HDMI drivers and no callbacks are
needed anymore.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../fbdev/omap2/displays-new/connector-hdmi.c      |   99 --------------------
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |   56 -----------
 include/video/omapdss.h                            |   31 ------
 3 files changed, 186 deletions(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c b/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
index 131c6e2..dd36d71 100644
--- a/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
+++ b/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
@@ -170,98 +170,6 @@ static bool hdmic_detect(struct omap_dss_device *dssdev)
 		return in->ops.hdmi->detect(in);
 }
 
-static int hdmic_audio_enable(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-	int r;
-
-	/* enable audio only if the display is active */
-	if (!omapdss_device_is_enabled(dssdev))
-		return -EPERM;
-
-	r = in->ops.hdmi->audio_enable(in);
-	if (r)
-		return r;
-
-	dssdev->audio_state = OMAP_DSS_AUDIO_ENABLED;
-
-	return 0;
-}
-
-static void hdmic_audio_disable(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	in->ops.hdmi->audio_disable(in);
-
-	dssdev->audio_state = OMAP_DSS_AUDIO_DISABLED;
-}
-
-static int hdmic_audio_start(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-	int r;
-
-	/*
-	 * No need to check the panel state. It was checked when trasitioning
-	 * to AUDIO_ENABLED.
-	 */
-	if (dssdev->audio_state != OMAP_DSS_AUDIO_ENABLED)
-		return -EPERM;
-
-	r = in->ops.hdmi->audio_start(in);
-	if (r)
-		return r;
-
-	dssdev->audio_state = OMAP_DSS_AUDIO_PLAYING;
-
-	return 0;
-}
-
-static void hdmic_audio_stop(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	in->ops.hdmi->audio_stop(in);
-
-	dssdev->audio_state = OMAP_DSS_AUDIO_ENABLED;
-}
-
-static bool hdmic_audio_supported(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	if (!omapdss_device_is_enabled(dssdev))
-		return false;
-
-	return in->ops.hdmi->audio_supported(in);
-}
-
-static int hdmic_audio_config(struct omap_dss_device *dssdev,
-		struct omap_dss_audio *audio)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-	int r;
-
-	/* config audio only if the display is active */
-	if (!omapdss_device_is_enabled(dssdev))
-		return -EPERM;
-
-	r = in->ops.hdmi->audio_config(in, audio);
-	if (r)
-		return r;
-
-	dssdev->audio_state = OMAP_DSS_AUDIO_CONFIGURED;
-
-	return 0;
-}
-
 static int hdmic_set_hdmi_mode(struct omap_dss_device *dssdev, bool hdmi_mode)
 {
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
@@ -296,13 +204,6 @@ static struct omap_dss_driver hdmic_driver = {
 	.detect			= hdmic_detect,
 	.set_hdmi_mode		= hdmic_set_hdmi_mode,
 	.set_hdmi_infoframe	= hdmic_set_infoframe,
-
-	.audio_enable		= hdmic_audio_enable,
-	.audio_disable		= hdmic_audio_disable,
-	.audio_start		= hdmic_audio_start,
-	.audio_stop		= hdmic_audio_stop,
-	.audio_supported	= hdmic_audio_supported,
-	.audio_config		= hdmic_audio_config,
 };
 
 static int hdmic_probe_pdata(struct platform_device *pdev)
diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
index c891d8f..235e3d5 100644
--- a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
+++ b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
@@ -193,55 +193,6 @@ static bool tpd_detect(struct omap_dss_device *dssdev)
 	return gpio_get_value_cansleep(ddata->hpd_gpio);
 }
 
-static int tpd_audio_enable(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	return in->ops.hdmi->audio_enable(in);
-}
-
-static void tpd_audio_disable(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	in->ops.hdmi->audio_disable(in);
-}
-
-static int tpd_audio_start(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	return in->ops.hdmi->audio_start(in);
-}
-
-static void tpd_audio_stop(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	in->ops.hdmi->audio_stop(in);
-}
-
-static bool tpd_audio_supported(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	return in->ops.hdmi->audio_supported(in);
-}
-
-static int tpd_audio_config(struct omap_dss_device *dssdev,
-		struct omap_dss_audio *audio)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *in = ddata->in;
-
-	return in->ops.hdmi->audio_config(in, audio);
-}
-
 static int tpd_set_infoframe(struct omap_dss_device *dssdev,
 		const struct hdmi_avi_infoframe *avi)
 {
@@ -275,13 +226,6 @@ static const struct omapdss_hdmi_ops tpd_hdmi_ops = {
 	.detect			= tpd_detect,
 	.set_infoframe		= tpd_set_infoframe,
 	.set_hdmi_mode		= tpd_set_hdmi_mode,
-
-	.audio_enable		= tpd_audio_enable,
-	.audio_disable		= tpd_audio_disable,
-	.audio_start		= tpd_audio_start,
-	.audio_stop		= tpd_audio_stop,
-	.audio_supported	= tpd_audio_supported,
-	.audio_config		= tpd_audio_config,
 };
 
 static int tpd_probe_pdata(struct platform_device *pdev)
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 069dfca..9035325 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -635,19 +635,6 @@ struct omapdss_hdmi_ops {
 	int (*set_hdmi_mode)(struct omap_dss_device *dssdev, bool hdmi_mode);
 	int (*set_infoframe)(struct omap_dss_device *dssdev,
 		const struct hdmi_avi_infoframe *avi);
-
-	/*
-	 * Note: These functions might sleep. Do not call while
-	 * holding a spinlock/readlock.
-	 */
-	int (*audio_enable)(struct omap_dss_device *dssdev);
-	void (*audio_disable)(struct omap_dss_device *dssdev);
-	bool (*audio_supported)(struct omap_dss_device *dssdev);
-	int (*audio_config)(struct omap_dss_device *dssdev,
-		struct omap_dss_audio *audio);
-	/* Note: These functions may not sleep */
-	int (*audio_start)(struct omap_dss_device *dssdev);
-	void (*audio_stop)(struct omap_dss_device *dssdev);
 };
 
 struct omapdss_dsi_ops {
@@ -858,24 +845,6 @@ struct omap_dss_driver {
 	int (*set_hdmi_mode)(struct omap_dss_device *dssdev, bool hdmi_mode);
 	int (*set_hdmi_infoframe)(struct omap_dss_device *dssdev,
 		const struct hdmi_avi_infoframe *avi);
-
-	/*
-	 * For display drivers that support audio. This encompasses
-	 * HDMI and DisplayPort at the moment.
-	 */
-	/*
-	 * Note: These functions might sleep. Do not call while
-	 * holding a spinlock/readlock.
-	 */
-	int (*audio_enable)(struct omap_dss_device *dssdev);
-	void (*audio_disable)(struct omap_dss_device *dssdev);
-	bool (*audio_supported)(struct omap_dss_device *dssdev);
-	int (*audio_config)(struct omap_dss_device *dssdev,
-		struct omap_dss_audio *audio);
-	/* Note: These functions may not sleep */
-	int (*audio_start)(struct omap_dss_device *dssdev);
-	void (*audio_stop)(struct omap_dss_device *dssdev);
-
 };
 
 enum omapdss_version omapdss_get_version(void);
-- 
1.7.9.5

