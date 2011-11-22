From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 65/65] OMAPDSS: check the return value of dss_mgr_enable()
Date: Tue, 22 Nov 2011 11:22:04 +0200
Message-ID: <1321953724-6350-66-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:58746 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758262Ab1KVJY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:58 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that dss_mgr_enable returns an error value, check it in all the
places dss_mgr_enable is used, and bail out properly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |    5 ++++-
 drivers/video/omap2/dss/dsi.c  |   11 ++++++++++-
 drivers/video/omap2/dss/hdmi.c |    9 ++++++++-
 drivers/video/omap2/dss/sdi.c  |    6 +++++-
 drivers/video/omap2/dss/venc.c |   26 +++++++++++++++++++++++---
 5 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 79c4df3..395d658 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -223,10 +223,13 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 
 	mdelay(2);
 
-	dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(dssdev->manager);
+	if (r)
+		goto err_mgr_enable;
 
 	return 0;
 
+err_mgr_enable:
 err_set_mode:
 	if (dpi_use_dsi_pll(dssdev))
 		dsi_pll_uninit(dpi.dsidev, true);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a35f3fb..57fda24 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3945,6 +3945,7 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 	int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
 	u8 data_type;
 	u16 word_count;
+	int r;
 
 	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		switch (dssdev->panel.dsi_pix_fmt) {
@@ -3979,7 +3980,15 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 		dsi_if_enable(dsidev, true);
 	}
 
-	dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(dssdev->manager);
+	if (r) {
+		if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
+			dsi_if_enable(dsidev, false);
+			dsi_vc_enable(dsidev, channel, false);
+		}
+
+		return r;
+	}
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index e245a2b..b064762 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -387,9 +387,16 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 1);
 
-	dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(dssdev->manager);
+	if (r)
+		goto err_mgr_enable;
 
 	return 0;
+
+err_mgr_enable:
+	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 0);
+	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
+	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
 err:
 	hdmi_runtime_put();
 	return -EIO;
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 02da8be..8266ca0 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -123,10 +123,14 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 		goto err_sdi_enable;
 	mdelay(2);
 
-	dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(dssdev->manager);
+	if (r)
+		goto err_mgr_enable;
 
 	return 0;
 
+err_mgr_enable:
+	dss_sdi_disable();
 err_sdi_enable:
 err_set_dispc_clock_div:
 err_set_dss_clock_div:
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 101fcd7..b3e9f90 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -417,9 +417,10 @@ static const struct venc_config *venc_timings_to_config(
 	BUG();
 }
 
-static void venc_power_on(struct omap_dss_device *dssdev)
+static int venc_power_on(struct omap_dss_device *dssdev)
 {
 	u32 l;
+	int r;
 
 	venc_reset();
 	venc_write_config(venc_timings_to_config(&dssdev->panel.timings));
@@ -447,7 +448,22 @@ static void venc_power_on(struct omap_dss_device *dssdev)
 	if (dssdev->platform_enable)
 		dssdev->platform_enable(dssdev);
 
-	dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(dssdev->manager);
+	if (r)
+		goto err;
+
+	return 0;
+
+err:
+	venc_write_reg(VENC_OUTPUT_CONTROL, 0);
+	dss_set_dac_pwrdn_bgz(0);
+
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+
+	regulator_disable(venc.vdda_dac_reg);
+
+	return r;
 }
 
 static void venc_power_off(struct omap_dss_device *dssdev)
@@ -504,7 +520,9 @@ static int venc_panel_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err1;
 
-	venc_power_on(dssdev);
+	r = venc_power_on(dssdev);
+	if (r)
+		goto err2;
 
 	venc.wss_data = 0;
 
@@ -512,6 +530,8 @@ static int venc_panel_enable(struct omap_dss_device *dssdev)
 
 	mutex_unlock(&venc.venc_lock);
 	return 0;
+err2:
+	venc_runtime_put();
 err1:
 	omap_dss_stop_device(dssdev);
 err0:
-- 
1.7.4.1

