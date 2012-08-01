From: Archit Taneja <archit@ti.com>
Subject: [RFC 04/17] OMAPDSS: DPI: Add locking for DPI interface
Date: Wed, 1 Aug 2012 16:01:15 +0530
Message-ID: <1343817088-29645-5-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50138 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab2HAKdK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 06:33:10 -0400
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

The DPI interface driver currently relies on the panel driver to ensure calls
like omapdss_dpi_display_enable() and omapdss_dpi_display_disable() are executed
sequentially. Also, currently, there is no way to protect the DPI driver data.

All DPI panel drivers don't ensure this, and in general, a DPI panel driver
should use it's lock to that ensure it's own driver data and omap_dss_device
states are taken care of, and not worry about the DPI interface.

Add mutex locking in the DPI enable/disable/set_timings ops.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dpi.c |   26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index c20fe23..add47fe 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -39,6 +39,8 @@ static struct {
 	struct regulator *vdds_dsi_reg;
 	struct platform_device *dsidev;
 
+	struct mutex lock;
+
 	struct dss_lcd_mgr_config mgr_config;
 } dpi;
 
@@ -184,14 +186,18 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r;
 
+	mutex_lock(&dpi.lock);
+
 	if (cpu_is_omap34xx() && !dpi.vdds_dsi_reg) {
 		DSSERR("no VDSS_DSI regulator\n");
-		return -ENODEV;
+		r = -ENODEV;
+		goto err_no_reg;
 	}
 
 	if (dssdev->manager == NULL) {
 		DSSERR("failed to enable display: no manager\n");
-		return -ENODEV;
+		r = -ENODEV;
+		goto err_no_mgr;
 	}
 
 	if (dpi_use_dsi_pll(dssdev)) {
@@ -238,6 +244,8 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_mgr_enable;
 
+	mutex_unlock(&dpi.lock);
+
 	return 0;
 
 err_mgr_enable:
@@ -255,12 +263,17 @@ err_get_dispc:
 err_reg_enable:
 	omap_dss_stop_device(dssdev);
 err_start_dev:
+err_no_mgr:
+err_no_reg:
+	mutex_unlock(&dpi.lock);
 	return r;
 }
 EXPORT_SYMBOL(omapdss_dpi_display_enable);
 
 void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 {
+	mutex_lock(&dpi.lock);
+
 	dss_mgr_disable(dssdev->manager);
 
 	if (dpi_use_dsi_pll(dssdev)) {
@@ -275,6 +288,8 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 		regulator_disable(dpi.vdds_dsi_reg);
 
 	omap_dss_stop_device(dssdev);
+
+	mutex_unlock(&dpi.lock);
 }
 EXPORT_SYMBOL(omapdss_dpi_display_disable);
 
@@ -284,6 +299,9 @@ void dpi_set_timings(struct omap_dss_device *dssdev,
 	int r;
 
 	DSSDBG("dpi_set_timings\n");
+
+	mutex_lock(&dpi.lock);
+
 	dssdev->panel.timings = *timings;
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		r = dispc_runtime_get();
@@ -296,6 +314,8 @@ void dpi_set_timings(struct omap_dss_device *dssdev,
 	} else {
 		dss_mgr_set_timings(dssdev->manager, timings);
 	}
+
+	mutex_unlock(&dpi.lock);
 }
 EXPORT_SYMBOL(dpi_set_timings);
 
@@ -392,6 +412,8 @@ static void __init dpi_probe_pdata(struct platform_device *pdev)
 
 static int __init omap_dpi_probe(struct platform_device *pdev)
 {
+	mutex_init(&dpi.lock);
+
 	dpi_probe_pdata(pdev);
 
 	return 0;
-- 
1.7.9.5

