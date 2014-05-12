From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 03/19] OMAPDSS: hdmi4: Remove callbacks for an external ASoC DAI driver
Date: Mon, 12 May 2014 12:12:14 +0300
Message-ID: <c467e814144cd16e4e9f6180064a0f27b9adaf19.1399884780.git.jsarha@ti.com>
References: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40776 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbaELJMs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 05:12:48 -0400
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Removes the OMAP4 HDMI audio callbacks for an external audio driver and
the old external DAI driver does not work anymore after this patch.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4.c |  113 ---------------------------------
 1 file changed, 113 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 626aad2..71f9175 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -509,112 +509,6 @@ static int hdmi_read_edid(struct omap_dss_device *dssdev,
 	return r;
 }
 
-#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
-static int hdmi_audio_enable(struct omap_dss_device *dssdev)
-{
-	int r;
-
-	mutex_lock(&hdmi.lock);
-
-	if (!hdmi_mode_has_audio(hdmi.cfg.cm.mode)) {
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
-	return hdmi4_audio_start(&hdmi.core, &hdmi.wp);
-}
-
-static void hdmi_audio_stop(struct omap_dss_device *dssdev)
-{
-	hdmi4_audio_stop(&hdmi.core, &hdmi.wp);
-}
-
-static bool hdmi_audio_supported(struct omap_dss_device *dssdev)
-{
-	bool r;
-
-	mutex_lock(&hdmi.lock);
-
-	r = hdmi_mode_has_audio(hdmi.cfg.cm.mode);
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
-	if (!hdmi_mode_has_audio(hdmi.cfg.cm.mode)) {
-		r = -EPERM;
-		goto err;
-	}
-
-	r = hdmi4_audio_config(&hdmi.core, &hdmi.wp, audio, pclk);
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
 static const struct omapdss_hdmi_ops hdmi_ops = {
 	.connect		= hdmi_connect,
 	.disconnect		= hdmi_disconnect,
@@ -627,13 +521,6 @@ static const struct omapdss_hdmi_ops hdmi_ops = {
 	.get_timings		= hdmi_display_get_timings,
 
 	.read_edid		= hdmi_read_edid,
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

