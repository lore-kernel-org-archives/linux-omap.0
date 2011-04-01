From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/5] OMAP: DSS2: use omap_dss_register_driver_probe() in selected drivers
Date: Fri,  1 Apr 2011 13:00:30 +0300
Message-ID: <1301652030-32223-6-git-send-email-tomi.valkeinen@ti.com>
References: <1301652030-32223-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53547 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755322Ab1DAKAw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 06:00:52 -0400
In-Reply-To: <1301652030-32223-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use omap_dss_register_driver_probe() in plain dss panel drivers, which
allows us to use __init for the driver probe functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c   |    6 +++---
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    6 +++---
 drivers/video/omap2/displays/panel-taal.c          |    5 ++---
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index e359f93..010ea4e 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -246,7 +246,7 @@ static void generic_dpi_panel_power_off(struct omap_dss_device *dssdev)
 	omapdss_dpi_display_disable(dssdev);
 }
 
-static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
+static int __init generic_dpi_panel_probe(struct omap_dss_device *dssdev)
 {
 	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
 	struct panel_config *panel_config = NULL;
@@ -357,7 +357,6 @@ static int generic_dpi_panel_check_timings(struct omap_dss_device *dssdev,
 }
 
 static struct omap_dss_driver dpi_driver = {
-	.probe		= generic_dpi_panel_probe,
 	.remove		= __exit_p(generic_dpi_panel_remove),
 
 	.enable		= generic_dpi_panel_enable,
@@ -377,7 +376,8 @@ static struct omap_dss_driver dpi_driver = {
 
 static int __init generic_dpi_panel_drv_init(void)
 {
-	return omap_dss_register_driver(&dpi_driver);
+	return omap_dss_register_driver_probe(&dpi_driver,
+			generic_dpi_panel_probe);
 }
 
 static void __exit generic_dpi_panel_drv_exit(void)
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index c772747..2cf3c9f 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -79,7 +79,7 @@ static const struct backlight_ops sharp_ls_bl_ops = {
 
 
 
-static int sharp_ls_panel_probe(struct omap_dss_device *dssdev)
+static int __init sharp_ls_panel_probe(struct omap_dss_device *dssdev)
 {
 	struct backlight_properties props;
 	struct backlight_device *bl;
@@ -204,7 +204,6 @@ static int sharp_ls_panel_resume(struct omap_dss_device *dssdev)
 }
 
 static struct omap_dss_driver sharp_ls_driver = {
-	.probe		= sharp_ls_panel_probe,
 	.remove		= __exit_p(sharp_ls_panel_remove),
 
 	.enable		= sharp_ls_panel_enable,
@@ -220,7 +219,8 @@ static struct omap_dss_driver sharp_ls_driver = {
 
 static int __init sharp_ls_panel_drv_init(void)
 {
-	return omap_dss_register_driver(&sharp_ls_driver);
+	return omap_dss_register_driver_probe(&sharp_ls_driver,
+			sharp_ls_panel_probe);
 }
 
 static void __exit sharp_ls_panel_drv_exit(void)
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 490998f..d62821e 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -661,7 +661,7 @@ static void taal_hw_reset(struct omap_dss_device *dssdev)
 		msleep(td->panel_config->sleep.hw_reset);
 }
 
-static int taal_probe(struct omap_dss_device *dssdev)
+static int __init taal_probe(struct omap_dss_device *dssdev)
 {
 	struct backlight_properties props;
 	struct taal_data *td;
@@ -1556,7 +1556,6 @@ static enum omap_dss_update_mode taal_get_update_mode(
 }
 
 static struct omap_dss_driver taal_driver = {
-	.probe		= taal_probe,
 	.remove		= __exit_p(taal_remove),
 
 	.enable		= taal_enable,
@@ -1593,7 +1592,7 @@ static struct omap_dss_driver taal_driver = {
 
 static int __init taal_init(void)
 {
-	omap_dss_register_driver(&taal_driver);
+	omap_dss_register_driver_probe(&taal_driver, taal_probe);
 
 	return 0;
 }
-- 
1.7.1

