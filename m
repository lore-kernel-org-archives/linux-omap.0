From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 12/13] OMAPDSS: hdmi5: Remove callbacks for an external ASoC DAI driver
Date: Fri, 27 Jun 2014 21:38:54 +0300
Message-ID: <96040dea6d35f827ee9fd17954c2670d3a422c37.1403894190.git.jsarha@ti.com>
References: <cover.1403894190.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44549 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960AbaF0Sj2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 14:39:28 -0400
In-Reply-To: <cover.1403894190.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi, Jyri Sarha <jsarha@ti.com>

Removes the OMAP5 HDMI audio callbacks for an external audio driver and
the old external DAI driver does not work anymore after this patch.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5.c |  113 ---------------------------------
 1 file changed, 113 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index a2b2589..12d449d 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -496,112 +496,6 @@ static int hdmi_read_edid(struct omap_dss_device *dssdev,
 	return r;
 }
 
-#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
-static int hdmi_audio_enable(struct omap_dss_device *dssdev)
-{
-	int r;
-
-	mutex_lock(&hdmi.lock);
-
-	if (!hdmi_mode_has_audio(hdmi.cfg.hdmi_dvi_mode)) {
-		r = -EPERM;
-		goto err;
-	}
-
-	r = hdmi_wp_audio_enable(&hdmi.wp, true);
-	if (r)
-		goto err;
-
-	mutex_unlock(&hdmi.lock);
-	return 0;
-
-err:
-	mutex_unlock(&hdmi.lock);
-	return r;
-}
-
-static void hdmi_audio_disable(struct omap_dss_device *dssdev)
-{
-	hdmi_wp_audio_enable(&hdmi.wp, false);
-}
-
-static int hdmi_audio_start(struct omap_dss_device *dssdev)
-{
-	return hdmi_wp_audio_core_req_enable(&hdmi.wp, true);
-}
-
-static void hdmi_audio_stop(struct omap_dss_device *dssdev)
-{
-	hdmi_wp_audio_core_req_enable(&hdmi.wp, false);
-}
-
-static bool hdmi_audio_supported(struct omap_dss_device *dssdev)
-{
-	bool r;
-
-	mutex_lock(&hdmi.lock);
-
-	r = hdmi_mode_has_audio(hdmi.cfg.hdmi_dvi_mode);
-
-	mutex_unlock(&hdmi.lock);
-	return r;
-}
-
-static int hdmi_audio_config(struct omap_dss_device *dssdev,
-		struct omap_dss_audio *audio)
-{
-	int r;
-	u32 pclk = hdmi.cfg.timings.pixelclock;
-
-	mutex_lock(&hdmi.lock);
-
-	if (!hdmi_mode_has_audio(hdmi.cfg.hdmi_dvi_mode)) {
-		r = -EPERM;
-		goto err;
-	}
-
-	r = hdmi5_audio_config(&hdmi.core, &hdmi.wp, audio, pclk);
-	if (r)
-		goto err;
-
-	mutex_unlock(&hdmi.lock);
-	return 0;
-
-err:
-	mutex_unlock(&hdmi.lock);
-	return r;
-}
-#else
-static int hdmi_audio_enable(struct omap_dss_device *dssdev)
-{
-	return -EPERM;
-}
-
-static void hdmi_audio_disable(struct omap_dss_device *dssdev)
-{
-}
-
-static int hdmi_audio_start(struct omap_dss_device *dssdev)
-{
-	return -EPERM;
-}
-
-static void hdmi_audio_stop(struct omap_dss_device *dssdev)
-{
-}
-
-static bool hdmi_audio_supported(struct omap_dss_device *dssdev)
-{
-	return false;
-}
-
-static int hdmi_audio_config(struct omap_dss_device *dssdev,
-		struct omap_dss_audio *audio)
-{
-	return -EPERM;
-}
-#endif
-
 static int hdmi_set_infoframe(struct omap_dss_device *dssdev,
 		const struct hdmi_avi_infoframe *avi)
 {
@@ -630,13 +524,6 @@ static const struct omapdss_hdmi_ops hdmi_ops = {
 	.read_edid		= hdmi_read_edid,
 	.set_infoframe		= hdmi_set_infoframe,
 	.set_hdmi_mode		= hdmi_set_hdmi_mode,
-
-	.audio_enable		= hdmi_audio_enable,
-	.audio_disable		= hdmi_audio_disable,
-	.audio_start		= hdmi_audio_start,
-	.audio_stop		= hdmi_audio_stop,
-	.audio_supported	= hdmi_audio_supported,
-	.audio_config		= hdmi_audio_config,
 };
 
 static void hdmi_init_output(struct platform_device *pdev)
-- 
1.7.9.5

