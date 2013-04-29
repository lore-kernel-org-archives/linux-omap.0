From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/10] OMAPDSS: DSI: use platform_driver_register()
Date: Mon, 29 Apr 2013 13:22:31 +0300
Message-ID: <1367230957-32337-5-git-send-email-tomi.valkeinen@ti.com>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35761 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758036Ab3D2KXK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Apr 2013 06:23:10 -0400
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use platform_driver_register() instead of platform_driver_probe() so
that we can support EPROBE_DEFER.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 9b1c5ec..55fc0d4 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5225,7 +5225,7 @@ static enum omap_channel dsi_get_channel(int module_id)
 	}
 }
 
-static int __init dsi_init_display(struct omap_dss_device *dssdev)
+static int dsi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev =
 			dsi_get_dsidev_from_id(dssdev->phy.dsi.module);
@@ -5366,7 +5366,7 @@ static int dsi_get_clocks(struct platform_device *dsidev)
 	return 0;
 }
 
-static struct omap_dss_device * __init dsi_find_dssdev(struct platform_device *pdev)
+static struct omap_dss_device *dsi_find_dssdev(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	struct dsi_data *dsi = dsi_get_dsidrv_data(pdev);
@@ -5398,7 +5398,7 @@ static struct omap_dss_device * __init dsi_find_dssdev(struct platform_device *p
 	return def_dssdev;
 }
 
-static void __init dsi_probe_pdata(struct platform_device *dsidev)
+static void dsi_probe_pdata(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct omap_dss_device *plat_dssdev;
@@ -5436,11 +5436,13 @@ static void __init dsi_probe_pdata(struct platform_device *dsidev)
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
 		omapdss_output_unset_device(&dsi->output);
 		dss_put_device(dssdev);
-		return;
+		return r;
 	}
+
+	return 0;
 }
 
-static void __init dsi_init_output(struct platform_device *dsidev)
+static void dsi_init_output(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct omap_dss_output *out = &dsi->output;
@@ -5465,7 +5467,7 @@ static void __exit dsi_uninit_output(struct platform_device *dsidev)
 }
 
 /* DSI1 HW IP initialisation */
-static int __init omap_dsihw_probe(struct platform_device *dsidev)
+static int omap_dsihw_probe(struct platform_device *dsidev)
 {
 	u32 rev;
 	int r, i;
@@ -5632,6 +5634,7 @@ static const struct dev_pm_ops dsi_pm_ops = {
 };
 
 static struct platform_driver omap_dsihw_driver = {
+	.probe		= omap_dsihw_probe,
 	.remove         = __exit_p(omap_dsihw_remove),
 	.driver         = {
 		.name   = "omapdss_dsi",
@@ -5642,7 +5645,7 @@ static struct platform_driver omap_dsihw_driver = {
 
 int __init dsi_init_platform_driver(void)
 {
-	return platform_driver_probe(&omap_dsihw_driver, omap_dsihw_probe);
+	return platform_driver_register(&omap_dsihw_driver);
 }
 
 void __exit dsi_uninit_platform_driver(void)
-- 
1.7.10.4

