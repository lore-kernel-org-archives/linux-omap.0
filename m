From: Archit Taneja <archit@ti.com>
Subject: [RFC 12/17] OMAPDSS: SDI: Create a separate function for timing/clock configurations
Date: Wed, 1 Aug 2012 16:01:23 +0530
Message-ID: <1343817088-29645-13-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48014 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754850Ab2HAKdu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 06:33:50 -0400
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

Create a function sdi_set_mode() which configures the DISPC and DSS(PRCM)
clocks to get the required pixel clock, and configure the manager timings.
This is similar to what's done in the DPI driver in dpi_set_mode().

This makes the code a bit cleaner to read, and makes it easier to reconfigure
timings instead of switching off the whole interface, and then enabling the
interface with the new timings.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/sdi.c |   65 +++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 5d31699..f2d3f45 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -49,40 +49,21 @@ static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
 	dss_mgr_set_lcd_config(dssdev->manager, &sdi.mgr_config);
 }
 
-int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
+static int sdi_set_mode(struct omap_dss_device *dssdev)
 {
+	int r;
 	struct omap_video_timings *t = &dssdev->panel.timings;
 	struct dss_clock_info dss_cinfo;
 	struct dispc_clock_info dispc_cinfo;
 	unsigned long pck;
-	int r;
-
-	if (dssdev->manager == NULL) {
-		DSSERR("failed to enable display: no manager\n");
-		return -ENODEV;
-	}
-
-	r = omap_dss_start_device(dssdev);
-	if (r) {
-		DSSERR("failed to start device\n");
-		goto err_start_dev;
-	}
-
-	r = regulator_enable(sdi.vdds_sdi_reg);
-	if (r)
-		goto err_reg_enable;
-
-	r = dispc_runtime_get();
-	if (r)
-		goto err_get_dispc;
 
 	/* 15.5.9.1.2 */
-	dssdev->panel.timings.data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
-	dssdev->panel.timings.sync_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
+	t->data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
+	t->sync_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
 
 	r = dss_calc_clock_div(t->pixel_clock * 1000, &dss_cinfo, &dispc_cinfo);
 	if (r)
-		goto err_calc_clock_div;
+		return r;
 
 	sdi.mgr_config.clock_info = dispc_cinfo;
 
@@ -96,12 +77,41 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 		t->pixel_clock = pck;
 	}
 
-
 	dss_mgr_set_timings(dssdev->manager, t);
 
 	r = dss_set_clock_div(&dss_cinfo);
 	if (r)
-		goto err_set_dss_clock_div;
+		return r;
+
+	return 0;
+}
+
+int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	if (dssdev->manager == NULL) {
+		DSSERR("failed to enable display: no manager\n");
+		return -ENODEV;
+	}
+
+	r = omap_dss_start_device(dssdev);
+	if (r) {
+		DSSERR("failed to start device\n");
+		goto err_start_dev;
+	}
+
+	r = regulator_enable(sdi.vdds_sdi_reg);
+	if (r)
+		goto err_reg_enable;
+
+	r = dispc_runtime_get();
+	if (r)
+		goto err_get_dispc;
+
+	r = sdi_set_mode(dssdev);
+	if (r)
+		goto err_set_mode;
 
 	sdi_config_lcd_manager(dssdev);
 
@@ -120,8 +130,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 err_mgr_enable:
 	dss_sdi_disable();
 err_sdi_enable:
-err_set_dss_clock_div:
-err_calc_clock_div:
+err_set_mode:
 	dispc_runtime_put();
 err_get_dispc:
 	regulator_disable(sdi.vdds_sdi_reg);
-- 
1.7.9.5

