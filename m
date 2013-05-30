From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 26/32] OMAPDSS: remove omap_dss_start/stop_device()
Date: Thu, 30 May 2013 12:34:47 +0300
Message-ID: <1369906493-27538-27-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41391 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030349Ab3E3Jf4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:56 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The omap_dss_start_device() and omap_dss_stop_device(), called by the
DSS output drivers, are old relics. They originally did something
totally else, but nowadays they increase the module ref count for panels
that are enabled.

This model is quite broken: the panel modules may be used even before
they are enabled. For example, configuring the panel requires calls to
functions located in the panel modules.

In the following patches we try to improve the ref count management for
the modules and display devices. The first step, however, is to remove
the omap_dss_start/stop_device() totally.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c | 20 --------------------
 drivers/video/omap2/dss/dpi.c     | 10 ----------
 drivers/video/omap2/dss/dsi.c     | 10 ----------
 drivers/video/omap2/dss/hdmi.c    | 12 +-----------
 drivers/video/omap2/dss/rfbi.c    |  9 ---------
 drivers/video/omap2/dss/sdi.c     | 10 ----------
 drivers/video/omap2/dss/venc.c    | 12 +-----------
 include/video/omapdss.h           |  3 ---
 8 files changed, 2 insertions(+), 84 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index a9a1d55..8096764 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -233,26 +233,6 @@ struct omap_dss_device *omap_dss_find_device(void *data,
 }
 EXPORT_SYMBOL(omap_dss_find_device);
 
-int omap_dss_start_device(struct omap_dss_device *dssdev)
-{
-	if (!dssdev->driver) {
-		DSSDBG("no driver\n");
-		return -ENODEV;
-	}
-
-	if (!try_module_get(dssdev->dev->driver->owner))
-		return -ENODEV;
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_dss_start_device);
-
-void omap_dss_stop_device(struct omap_dss_device *dssdev)
-{
-	module_put(dssdev->dev->driver->owner);
-}
-EXPORT_SYMBOL(omap_dss_stop_device);
-
 void videomode_to_omap_video_timings(const struct videomode *vm,
 		struct omap_video_timings *ovt)
 {
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 66ba9a6..d369927 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -365,12 +365,6 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 		goto err_no_out_mgr;
 	}
 
-	r = omap_dss_start_device(dssdev);
-	if (r) {
-		DSSERR("failed to start device\n");
-		goto err_start_dev;
-	}
-
 	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI)) {
 		r = regulator_enable(dpi.vdds_dsi_reg);
 		if (r)
@@ -425,8 +419,6 @@ err_get_dispc:
 	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI))
 		regulator_disable(dpi.vdds_dsi_reg);
 err_reg_enable:
-	omap_dss_stop_device(dssdev);
-err_start_dev:
 err_no_out_mgr:
 err_no_reg:
 	mutex_unlock(&dpi.lock);
@@ -453,8 +445,6 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI))
 		regulator_disable(dpi.vdds_dsi_reg);
 
-	omap_dss_stop_device(dssdev);
-
 	mutex_unlock(&dpi.lock);
 }
 EXPORT_SYMBOL(omapdss_dpi_display_disable);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 37ca980..892838e 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4592,12 +4592,6 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&dsi->lock);
 
-	r = omap_dss_start_device(dssdev);
-	if (r) {
-		DSSERR("failed to start device\n");
-		goto err_start_dev;
-	}
-
 	r = dsi_runtime_get(dsidev);
 	if (r)
 		goto err_get_dsi;
@@ -4618,8 +4612,6 @@ err_init_dsi:
 	dsi_enable_pll_clock(dsidev, 0);
 	dsi_runtime_put(dsidev);
 err_get_dsi:
-	omap_dss_stop_device(dssdev);
-err_start_dev:
 	mutex_unlock(&dsi->lock);
 	DSSDBG("dsi_display_enable FAILED\n");
 	return r;
@@ -4648,8 +4640,6 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 	dsi_runtime_put(dsidev);
 	dsi_enable_pll_clock(dsidev, 0);
 
-	omap_dss_stop_device(dssdev);
-
 	mutex_unlock(&dsi->lock);
 }
 EXPORT_SYMBOL(omapdss_dsi_display_disable);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 6d1e97c..e7fe182 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -735,23 +735,15 @@ int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 
 	hdmi.ip_data.hpd_gpio = hdmi.hpd_gpio;
 
-	r = omap_dss_start_device(dssdev);
-	if (r) {
-		DSSERR("failed to start device\n");
-		goto err0;
-	}
-
 	r = hdmi_power_on_full(dssdev);
 	if (r) {
 		DSSERR("failed to power on device\n");
-		goto err1;
+		goto err0;
 	}
 
 	mutex_unlock(&hdmi.lock);
 	return 0;
 
-err1:
-	omap_dss_stop_device(dssdev);
 err0:
 	mutex_unlock(&hdmi.lock);
 	return r;
@@ -765,8 +757,6 @@ void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
 
 	hdmi_power_off_full(dssdev);
 
-	omap_dss_stop_device(dssdev);
-
 	mutex_unlock(&hdmi.lock);
 }
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index cfcb52f..30ff0e0 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -902,12 +902,6 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		return r;
 
-	r = omap_dss_start_device(dssdev);
-	if (r) {
-		DSSERR("failed to start device\n");
-		goto err0;
-	}
-
 	r = dss_mgr_register_framedone_handler(out->manager,
 			framedone_callback, NULL);
 	if (r) {
@@ -924,8 +918,6 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 
 	return 0;
 err1:
-	omap_dss_stop_device(dssdev);
-err0:
 	rfbi_runtime_put();
 	return r;
 }
@@ -937,7 +929,6 @@ void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev)
 
 	dss_mgr_unregister_framedone_handler(out->manager,
 			framedone_callback, NULL);
-	omap_dss_stop_device(dssdev);
 
 	rfbi_runtime_put();
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index e723687..ce37c80 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -139,12 +139,6 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 		return -ENODEV;
 	}
 
-	r = omap_dss_start_device(dssdev);
-	if (r) {
-		DSSERR("failed to start device\n");
-		goto err_start_dev;
-	}
-
 	r = regulator_enable(sdi.vdds_sdi_reg);
 	if (r)
 		goto err_reg_enable;
@@ -216,8 +210,6 @@ err_calc_clock_div:
 err_get_dispc:
 	regulator_disable(sdi.vdds_sdi_reg);
 err_reg_enable:
-	omap_dss_stop_device(dssdev);
-err_start_dev:
 	return r;
 }
 EXPORT_SYMBOL(omapdss_sdi_display_enable);
@@ -233,8 +225,6 @@ void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 	dispc_runtime_put();
 
 	regulator_disable(sdi.vdds_sdi_reg);
-
-	omap_dss_stop_device(dssdev);
 }
 EXPORT_SYMBOL(omapdss_sdi_display_disable);
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index af404b4..bac904c 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -513,23 +513,15 @@ int omapdss_venc_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
-	r = omap_dss_start_device(dssdev);
-	if (r) {
-		DSSERR("failed to start device\n");
-		goto err0;
-	}
-
 	r = venc_power_on(dssdev);
 	if (r)
-		goto err1;
+		goto err0;
 
 	venc.wss_data = 0;
 
 	mutex_unlock(&venc.venc_lock);
 
 	return 0;
-err1:
-	omap_dss_stop_device(dssdev);
 err0:
 	mutex_unlock(&venc.venc_lock);
 	return r;
@@ -543,8 +535,6 @@ void omapdss_venc_display_disable(struct omap_dss_device *dssdev)
 
 	venc_power_off(dssdev);
 
-	omap_dss_stop_device(dssdev);
-
 	mutex_unlock(&venc.venc_lock);
 }
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index f8e0e64..3aa89c4 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -778,9 +778,6 @@ struct omap_dss_device *omap_dss_find_device(void *data,
 		int (*match)(struct omap_dss_device *dssdev, void *data));
 const char *omapdss_get_default_display_name(void);
 
-int omap_dss_start_device(struct omap_dss_device *dssdev);
-void omap_dss_stop_device(struct omap_dss_device *dssdev);
-
 void videomode_to_omap_video_timings(const struct videomode *vm,
 		struct omap_video_timings *ovt);
 void omap_video_timings_to_videomode(const struct omap_video_timings *ovt,
-- 
1.8.1.2

