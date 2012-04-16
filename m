From: Archit Taneja <archit@ti.com>
Subject: [PATCH 4/6] OMAPDSS: MANAGER: Make DISPC timings a manager_info parameter
Date: Mon, 16 Apr 2012 12:53:45 +0530
Message-ID: <1334561027-28569-5-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36427 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765Ab2DPHYi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 03:24:38 -0400
In-Reply-To: <1334561027-28569-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

DISPC manager size and DISPC manager blanking parameters(for LCD managers)
follow the shadow register programming model. Currently, they are programmed
directly by the interface drivers.

Make timings(omap_video_timing struct) an overlay_manager_info member, they are
now programmed via the apply mechanism used for programming shadow registers.

The interface driver now call the function dss_mgr_set_timings() which applies
the new timing parameters, rather than directly writing to DISPC registers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |    5 ++++-
 drivers/video/omap2/dss/dpi.c     |    4 +++-
 drivers/video/omap2/dss/dsi.c     |   11 +++++++++--
 drivers/video/omap2/dss/dss.h     |    4 ++--
 drivers/video/omap2/dss/hdmi.c    |    5 ++++-
 drivers/video/omap2/dss/manager.c |   21 +++++++++++++++++++++
 drivers/video/omap2/dss/rfbi.c    |    7 +++++--
 drivers/video/omap2/dss/sdi.c     |    5 ++++-
 drivers/video/omap2/dss/venc.c    |   12 +++++++-----
 include/video/omapdss.h           |    2 ++
 10 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 46bcb55..63de49d 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -120,6 +120,8 @@ enum omap_color_component {
 };
 
 static void _omap_dispc_set_irqs(void);
+static void dispc_mgr_set_timings(enum omap_channel channel,
+		struct omap_video_timings *timings);
 
 static inline void dispc_write_reg(const u16 idx, u32 val)
 {
@@ -2211,6 +2213,7 @@ void dispc_mgr_setup(enum omap_channel channel,
 		dispc_mgr_enable_cpr(channel, info->cpr_enable);
 		dispc_mgr_set_cpr_coef(channel, &info->cpr_coefs);
 	}
+	dispc_mgr_set_timings(channel, &info->timings);
 }
 
 void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
@@ -2348,7 +2351,7 @@ static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 }
 
 /* change name to mode? */
-void dispc_mgr_set_timings(enum omap_channel channel,
+static void dispc_mgr_set_timings(enum omap_channel channel,
 		struct omap_video_timings *timings)
 {
 	unsigned xtot, ytot;
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index cec1166..76e2cae 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -156,7 +156,9 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 		t->pixel_clock = pck;
 	}
 
-	dispc_mgr_set_timings(dssdev->manager->id, t);
+	r = dss_mgr_set_timings(dssdev->manager, t);
+	if (r)
+		return r;
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b6cf03c..fbca76c 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4219,13 +4219,20 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		dispc_mgr_enable_stallmode(dssdev->manager->id, true);
 		dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 1);
 
-		dispc_mgr_set_timings(dssdev->manager->id, &timings);
+		r = dss_mgr_set_timings(dssdev->manager, &timings);
+		if (r) {
+			omap_dispc_unregister_isr(dsi_framedone_irq_callback,
+				(void *) dssdev, irq);
+			return r;
+		}
 	} else {
 		dispc_mgr_enable_stallmode(dssdev->manager->id, false);
 		dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 0);
 
-		dispc_mgr_set_timings(dssdev->manager->id,
+		r = dss_mgr_set_timings(dssdev->manager,
 			&dssdev->panel.timings);
+		if (r)
+			return r;
 	}
 
 		dispc_mgr_set_lcd_display_type(dssdev->manager->id,
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 1dc336b..0bff325 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -210,6 +210,8 @@ int dss_mgr_check(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev,
 		struct omap_overlay_manager_info *info,
 		struct omap_overlay_info **overlay_infos);
+int dss_mgr_set_timings(struct omap_overlay_manager *mgr,
+		struct omap_video_timings *timings);
 
 /* overlay */
 void dss_init_overlays(struct platform_device *pdev);
@@ -442,8 +444,6 @@ void dispc_mgr_enable_stallmode(enum omap_channel channel, bool enable);
 void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines);
 void dispc_mgr_set_lcd_display_type(enum omap_channel channel,
 		enum omap_lcd_display_type type);
-void dispc_mgr_set_timings(enum omap_channel channel,
-		struct omap_video_timings *timings);
 void dispc_mgr_set_pol_freq(enum omap_channel channel,
 		enum omap_panel_config config, u8 acbi, u8 acb);
 unsigned long dispc_mgr_lclk_rate(enum omap_channel channel);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 56f6e9c..4563781 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -376,7 +376,9 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	dispc_enable_gamma_table(0);
 
 	/* tv size */
-	dispc_mgr_set_timings(dssdev->manager->id, &dssdev->panel.timings);
+	r = dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
+	if (r)
+		goto err_mgr_set_timings;
 
 	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 1);
 
@@ -387,6 +389,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	return 0;
 
 err_mgr_enable:
+err_mgr_set_timings:
 	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 0);
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
 	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index e736460..2c85988 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -684,3 +684,24 @@ int dss_mgr_check(struct omap_overlay_manager *mgr,
 
 	return 0;
 }
+
+int dss_mgr_set_timings(struct omap_overlay_manager *mgr,
+		struct omap_video_timings *timings)
+{
+	int r;
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
+	info.timings = *timings;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return 0;
+}
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index a81ffcb..588160a 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -320,7 +320,7 @@ static void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
 
 	DSSDBG("rfbi_transfer_area %dx%d\n", width, height);
 
-	dispc_mgr_set_timings(dssdev->manager->id, &timings);
+	dss_mgr_set_timings(dssdev->manager, &timings);
 
 	dispc_mgr_enable(dssdev->manager->id, true);
 
@@ -776,6 +776,7 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 		u16 *x, u16 *y, u16 *w, u16 *h)
 {
 	u16 dw, dh;
+	int r;
 	struct omap_video_timings timings = {
 		.hsw		= 1,
 		.hfp		= 1,
@@ -804,7 +805,9 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 	if (*w == 0 || *h == 0)
 		return -EINVAL;
 
-	dispc_mgr_set_timings(dssdev->manager->id, &timings);
+	r = dss_mgr_set_timings(dssdev->manager, &timings);
+	if (r)
+		return r;
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 741b834..2e70f46 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -107,7 +107,9 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	}
 
 
-	dispc_mgr_set_timings(dssdev->manager->id, t);
+	r = dss_mgr_set_timings(dssdev->manager, t);
+	if (r)
+		goto err_set_mgr_timings;
 
 	r = dss_set_clock_div(&dss_cinfo);
 	if (r)
@@ -134,6 +136,7 @@ err_mgr_enable:
 err_sdi_enable:
 err_set_dispc_clock_div:
 err_set_dss_clock_div:
+err_set_mgr_timings:
 err_calc_clock_div:
 	dispc_runtime_put();
 err_get_dispc:
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 30bbb63..073b223 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -444,22 +444,24 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 	timings = dssdev->panel.timings;
 	timings.y_res /= 2;
 
-	dispc_mgr_set_timings(dssdev->manager->id, &timings);
+	r = dss_mgr_set_timings(dssdev->manager, &timings);
+	if (r)
+		goto err0;
 
 	r = regulator_enable(venc.vdda_dac_reg);
 	if (r)
-		goto err;
+		goto err1;
 
 	if (dssdev->platform_enable)
 		dssdev->platform_enable(dssdev);
 
 	r = dss_mgr_enable(dssdev->manager);
 	if (r)
-		goto err;
+		goto err1;
 
 	return 0;
 
-err:
+err1:
 	venc_write_reg(VENC_OUTPUT_CONTROL, 0);
 	dss_set_dac_pwrdn_bgz(0);
 
@@ -467,7 +469,7 @@ err:
 		dssdev->platform_disable(dssdev);
 
 	regulator_disable(venc.vdda_dac_reg);
-
+err0:
 	return r;
 }
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 5f36ddd..dbc62e8 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -429,6 +429,8 @@ struct omap_overlay_manager_info {
 
 	bool cpr_enable;
 	struct omap_dss_cpr_coefs cpr_coefs;
+
+	struct omap_video_timings timings;
 };
 
 struct omap_overlay_manager {
-- 
1.7.5.4

