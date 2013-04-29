From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/10] OMAPDSS: DPI: use platform_driver_register()
Date: Mon, 29 Apr 2013 13:22:33 +0300
Message-ID: <1367230957-32337-7-git-send-email-tomi.valkeinen@ti.com>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35764 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758062Ab3D2KXM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Apr 2013 06:23:12 -0400
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use platform_driver_register() instead of platform_driver_probe() so
that we can support EPROBE_DEFER.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index e93c4de..2024787 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -520,7 +520,7 @@ void omapdss_dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
 }
 EXPORT_SYMBOL(omapdss_dpi_set_data_lines);
 
-static int __init dpi_verify_dsi_pll(struct platform_device *dsidev)
+static int dpi_verify_dsi_pll(struct platform_device *dsidev)
 {
 	int r;
 
@@ -572,7 +572,7 @@ static enum omap_channel dpi_get_channel(void)
 	}
 }
 
-static int __init dpi_init_display(struct omap_dss_device *dssdev)
+static int dpi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev;
 
@@ -607,7 +607,7 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static struct omap_dss_device * __init dpi_find_dssdev(struct platform_device *pdev)
+static struct omap_dss_device *dpi_find_dssdev(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	const char *def_disp_name = omapdss_get_default_display_name();
@@ -635,7 +635,7 @@ static struct omap_dss_device * __init dpi_find_dssdev(struct platform_device *p
 	return def_dssdev;
 }
 
-static void __init dpi_probe_pdata(struct platform_device *dpidev)
+static void dpi_probe_pdata(struct platform_device *dpidev)
 {
 	struct omap_dss_device *plat_dssdev;
 	struct omap_dss_device *dssdev;
@@ -676,7 +676,7 @@ static void __init dpi_probe_pdata(struct platform_device *dpidev)
 	}
 }
 
-static void __init dpi_init_output(struct platform_device *pdev)
+static void dpi_init_output(struct platform_device *pdev)
 {
 	struct omap_dss_output *out = &dpi.output;
 
@@ -696,7 +696,7 @@ static void __exit dpi_uninit_output(struct platform_device *pdev)
 	dss_unregister_output(out);
 }
 
-static int __init omap_dpi_probe(struct platform_device *pdev)
+static int omap_dpi_probe(struct platform_device *pdev)
 {
 	mutex_init(&dpi.lock);
 
@@ -717,6 +717,7 @@ static int __exit omap_dpi_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_dpi_driver = {
+	.probe		= omap_dpi_probe,
 	.remove         = __exit_p(omap_dpi_remove),
 	.driver         = {
 		.name   = "omapdss_dpi",
@@ -726,7 +727,7 @@ static struct platform_driver omap_dpi_driver = {
 
 int __init dpi_init_platform_driver(void)
 {
-	return platform_driver_probe(&omap_dpi_driver, omap_dpi_probe);
+	return platform_driver_register(&omap_dpi_driver);
 }
 
 void __exit dpi_uninit_platform_driver(void)
-- 
1.7.10.4

