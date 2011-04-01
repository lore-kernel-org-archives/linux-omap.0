From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/5] OMAP: DSS2: use __exit for selected panel drivers
Date: Fri,  1 Apr 2011 13:00:28 +0300
Message-ID: <1301652030-32223-4-git-send-email-tomi.valkeinen@ti.com>
References: <1301652030-32223-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:36700 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755322Ab1DAKAt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 06:00:49 -0400
In-Reply-To: <1301652030-32223-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We can use __exit for the driver remove function in plain dss panels
(ie. those that do not need i2c or spi).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c   |    4 ++--
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    4 ++--
 drivers/video/omap2/displays/panel-taal.c          |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 4a9b9ff..e359f93 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -285,7 +285,7 @@ static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void generic_dpi_panel_remove(struct omap_dss_device *dssdev)
+static void __exit generic_dpi_panel_remove(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
 
@@ -358,7 +358,7 @@ static int generic_dpi_panel_check_timings(struct omap_dss_device *dssdev,
 
 static struct omap_dss_driver dpi_driver = {
 	.probe		= generic_dpi_panel_probe,
-	.remove		= generic_dpi_panel_remove,
+	.remove		= __exit_p(generic_dpi_panel_remove),
 
 	.enable		= generic_dpi_panel_enable,
 	.disable	= generic_dpi_panel_disable,
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index d2b35d2..c772747 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -120,7 +120,7 @@ static int sharp_ls_panel_probe(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void sharp_ls_panel_remove(struct omap_dss_device *dssdev)
+static void __exit sharp_ls_panel_remove(struct omap_dss_device *dssdev)
 {
 	struct sharp_data *sd = dev_get_drvdata(&dssdev->dev);
 	struct backlight_device *bl = sd->bl;
@@ -205,7 +205,7 @@ static int sharp_ls_panel_resume(struct omap_dss_device *dssdev)
 
 static struct omap_dss_driver sharp_ls_driver = {
 	.probe		= sharp_ls_panel_probe,
-	.remove		= sharp_ls_panel_remove,
+	.remove		= __exit_p(sharp_ls_panel_remove),
 
 	.enable		= sharp_ls_panel_enable,
 	.disable	= sharp_ls_panel_disable,
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index adc9900..490998f 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -819,7 +819,7 @@ err:
 	return r;
 }
 
-static void taal_remove(struct omap_dss_device *dssdev)
+static void __exit taal_remove(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
@@ -1557,7 +1557,7 @@ static enum omap_dss_update_mode taal_get_update_mode(
 
 static struct omap_dss_driver taal_driver = {
 	.probe		= taal_probe,
-	.remove		= taal_remove,
+	.remove		= __exit_p(taal_remove),
 
 	.enable		= taal_enable,
 	.disable	= taal_disable,
-- 
1.7.1

