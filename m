From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/20] OMAPDSS: remove omap_dss_device's suspend/resume
Date: Wed, 24 Oct 2012 12:28:52 +0300
Message-ID: <1351070951-18616-2-git-send-email-tomi.valkeinen@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59697 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756338Ab2JXJ32 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 05:29:28 -0400
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The panel drivers contain enable, disable, suspend and resume calls.
The suspend and resume are effectively identical to disable and enable.

This patch removes panel suspend and enable code from omapdss and the
panel drivers, and replaces their use with enable and disable.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c     |   23 -------
 drivers/video/omap2/displays/panel-generic-dpi.c   |   36 ----------
 .../omap2/displays/panel-lgphilips-lb035q02.c      |   34 ---------
 drivers/video/omap2/displays/panel-n8x0.c          |   50 --------------
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   24 -------
 drivers/video/omap2/displays/panel-picodlp.c       |   44 ------------
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   17 -----
 drivers/video/omap2/displays/panel-taal.c          |   72 --------------------
 drivers/video/omap2/displays/panel-tfp410.c        |   33 ---------
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |   20 ------
 drivers/video/omap2/dss/display.c                  |   15 +---
 drivers/video/omap2/dss/hdmi_panel.c               |   70 +++----------------
 drivers/video/omap2/dss/venc_panel.c               |   19 ------
 drivers/video/omap2/omapfb/omapfb-main.c           |    8 +--
 include/video/omapdss.h                            |    3 -
 15 files changed, 16 insertions(+), 452 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index c835aa7..65eb76c 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -710,27 +710,6 @@ static void acx_panel_disable(struct omap_dss_device *dssdev)
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
-static int acx_panel_suspend(struct omap_dss_device *dssdev)
-{
-	dev_dbg(&dssdev->dev, "%s\n", __func__);
-	acx_panel_power_off(dssdev);
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-	return 0;
-}
-
-static int acx_panel_resume(struct omap_dss_device *dssdev)
-{
-	int r;
-
-	dev_dbg(&dssdev->dev, "%s\n", __func__);
-	r = acx_panel_power_on(dssdev);
-	if (r)
-		return r;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-	return 0;
-}
-
 static void acx_panel_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
@@ -752,8 +731,6 @@ static struct omap_dss_driver acx_panel_driver = {
 
 	.enable		= acx_panel_enable,
 	.disable	= acx_panel_disable,
-	.suspend	= acx_panel_suspend,
-	.resume		= acx_panel_resume,
 
 	.set_timings	= acx_panel_set_timings,
 	.check_timings	= acx_panel_check_timings,
diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 88295c5..54ca8ae 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -688,40 +688,6 @@ static void generic_dpi_panel_disable(struct omap_dss_device *dssdev)
 	mutex_unlock(&drv_data->lock);
 }
 
-static int generic_dpi_panel_suspend(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
-
-	mutex_lock(&drv_data->lock);
-
-	generic_dpi_panel_power_off(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-
-	mutex_unlock(&drv_data->lock);
-
-	return 0;
-}
-
-static int generic_dpi_panel_resume(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
-	int r;
-
-	mutex_lock(&drv_data->lock);
-
-	r = generic_dpi_panel_power_on(dssdev);
-	if (r)
-		goto err;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-err:
-	mutex_unlock(&drv_data->lock);
-
-	return r;
-}
-
 static void generic_dpi_panel_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
@@ -769,8 +735,6 @@ static struct omap_dss_driver dpi_driver = {
 
 	.enable		= generic_dpi_panel_enable,
 	.disable	= generic_dpi_panel_disable,
-	.suspend	= generic_dpi_panel_suspend,
-	.resume		= generic_dpi_panel_resume,
 
 	.set_timings	= generic_dpi_panel_set_timings,
 	.get_timings	= generic_dpi_panel_get_timings,
diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index 90c1cab..ace419b 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -143,46 +143,12 @@ static void lb035q02_panel_disable(struct omap_dss_device *dssdev)
 	mutex_unlock(&ld->lock);
 }
 
-static int lb035q02_panel_suspend(struct omap_dss_device *dssdev)
-{
-	struct lb035q02_data *ld = dev_get_drvdata(&dssdev->dev);
-
-	mutex_lock(&ld->lock);
-
-	lb035q02_panel_power_off(dssdev);
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-
-	mutex_unlock(&ld->lock);
-	return 0;
-}
-
-static int lb035q02_panel_resume(struct omap_dss_device *dssdev)
-{
-	struct lb035q02_data *ld = dev_get_drvdata(&dssdev->dev);
-	int r;
-
-	mutex_lock(&ld->lock);
-
-	r = lb035q02_panel_power_on(dssdev);
-	if (r)
-		goto err;
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	mutex_unlock(&ld->lock);
-	return 0;
-err:
-	mutex_unlock(&ld->lock);
-	return r;
-}
-
 static struct omap_dss_driver lb035q02_driver = {
 	.probe		= lb035q02_panel_probe,
 	.remove		= lb035q02_panel_remove,
 
 	.enable		= lb035q02_panel_enable,
 	.disable	= lb035q02_panel_disable,
-	.suspend	= lb035q02_panel_suspend,
-	.resume		= lb035q02_panel_resume,
 
 	.driver         = {
 		.name   = "lgphilips_lb035q02_panel",
diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index 3fc5ad0..2653269 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -574,54 +574,6 @@ static void n8x0_panel_disable(struct omap_dss_device *dssdev)
 	mutex_unlock(&ddata->lock);
 }
 
-static int n8x0_panel_suspend(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = get_drv_data(dssdev);
-
-	dev_dbg(&dssdev->dev, "suspend\n");
-
-	mutex_lock(&ddata->lock);
-
-	rfbi_bus_lock();
-
-	n8x0_panel_power_off(dssdev);
-
-	rfbi_bus_unlock();
-
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-
-	mutex_unlock(&ddata->lock);
-
-	return 0;
-}
-
-static int n8x0_panel_resume(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = get_drv_data(dssdev);
-	int r;
-
-	dev_dbg(&dssdev->dev, "resume\n");
-
-	mutex_lock(&ddata->lock);
-
-	rfbi_bus_lock();
-
-	r = n8x0_panel_power_on(dssdev);
-
-	rfbi_bus_unlock();
-
-	if (r) {
-		mutex_unlock(&ddata->lock);
-		return r;
-	}
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	mutex_unlock(&ddata->lock);
-
-	return 0;
-}
-
 static void n8x0_panel_get_resolution(struct omap_dss_device *dssdev,
 		u16 *xres, u16 *yres)
 {
@@ -683,8 +635,6 @@ static struct omap_dss_driver n8x0_panel_driver = {
 
 	.enable		= n8x0_panel_enable,
 	.disable	= n8x0_panel_disable,
-	.suspend	= n8x0_panel_suspend,
-	.resume		= n8x0_panel_resume,
 
 	.update		= n8x0_panel_update,
 	.sync		= n8x0_panel_sync,
diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index 908fd26..2a79c28 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -236,28 +236,6 @@ static void nec_8048_panel_disable(struct omap_dss_device *dssdev)
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
-static int nec_8048_panel_suspend(struct omap_dss_device *dssdev)
-{
-	nec_8048_panel_power_off(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-
-	return 0;
-}
-
-static int nec_8048_panel_resume(struct omap_dss_device *dssdev)
-{
-	int r;
-
-	r = nec_8048_panel_power_on(dssdev);
-	if (r)
-		return r;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
-}
-
 static int nec_8048_recommended_bpp(struct omap_dss_device *dssdev)
 {
 	return 16;
@@ -268,8 +246,6 @@ static struct omap_dss_driver nec_8048_driver = {
 	.remove			= nec_8048_panel_remove,
 	.enable			= nec_8048_panel_enable,
 	.disable		= nec_8048_panel_disable,
-	.suspend		= nec_8048_panel_suspend,
-	.resume			= nec_8048_panel_resume,
 	.get_recommended_bpp	= nec_8048_recommended_bpp,
 
 	.driver		= {
diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index 9df8764..e3a6c19 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -503,47 +503,6 @@ static void picodlp_panel_disable(struct omap_dss_device *dssdev)
 	dev_dbg(&dssdev->dev, "disabling picodlp panel\n");
 }
 
-static int picodlp_panel_suspend(struct omap_dss_device *dssdev)
-{
-	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
-
-	mutex_lock(&picod->lock);
-	/* Turn off DLP Power */
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
-		mutex_unlock(&picod->lock);
-		dev_err(&dssdev->dev, "unable to suspend picodlp panel,"
-					" panel is not ACTIVE\n");
-		return -EINVAL;
-	}
-
-	picodlp_panel_power_off(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-	mutex_unlock(&picod->lock);
-
-	dev_dbg(&dssdev->dev, "suspending picodlp panel\n");
-	return 0;
-}
-
-static int picodlp_panel_resume(struct omap_dss_device *dssdev)
-{
-	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
-	int r;
-
-	mutex_lock(&picod->lock);
-	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED) {
-		mutex_unlock(&picod->lock);
-		dev_err(&dssdev->dev, "unable to resume picodlp panel,"
-			" panel is not ACTIVE\n");
-		return -EINVAL;
-	}
-
-	r = picodlp_panel_power_on(dssdev);
-	mutex_unlock(&picod->lock);
-	dev_dbg(&dssdev->dev, "resuming picodlp panel\n");
-	return r;
-}
-
 static void picodlp_get_resolution(struct omap_dss_device *dssdev,
 					u16 *xres, u16 *yres)
 {
@@ -560,9 +519,6 @@ static struct omap_dss_driver picodlp_driver = {
 
 	.get_resolution	= picodlp_get_resolution,
 
-	.suspend	= picodlp_panel_suspend,
-	.resume		= picodlp_panel_resume,
-
 	.driver		= {
 		.name	= "picodlp_panel",
 		.owner	= THIS_MODULE,
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index 1ec3b27..cada8c6 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -194,29 +194,12 @@ static void sharp_ls_panel_disable(struct omap_dss_device *dssdev)
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
-static int sharp_ls_panel_suspend(struct omap_dss_device *dssdev)
-{
-	sharp_ls_power_off(dssdev);
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-	return 0;
-}
-
-static int sharp_ls_panel_resume(struct omap_dss_device *dssdev)
-{
-	int r;
-	r = sharp_ls_power_on(dssdev);
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-	return r;
-}
-
 static struct omap_dss_driver sharp_ls_driver = {
 	.probe		= sharp_ls_panel_probe,
 	.remove		= __exit_p(sharp_ls_panel_remove),
 
 	.enable		= sharp_ls_panel_enable,
 	.disable	= sharp_ls_panel_disable,
-	.suspend	= sharp_ls_panel_suspend,
-	.resume		= sharp_ls_panel_resume,
 
 	.driver         = {
 		.name   = "sharp_ls_panel",
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index f2f6446..a32407a 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1245,76 +1245,6 @@ static void taal_disable(struct omap_dss_device *dssdev)
 	mutex_unlock(&td->lock);
 }
 
-static int taal_suspend(struct omap_dss_device *dssdev)
-{
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	int r;
-
-	dev_dbg(&dssdev->dev, "suspend\n");
-
-	mutex_lock(&td->lock);
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
-		r = -EINVAL;
-		goto err;
-	}
-
-	taal_cancel_ulps_work(dssdev);
-	taal_cancel_esd_work(dssdev);
-
-	dsi_bus_lock(dssdev);
-
-	r = taal_wake_up(dssdev);
-	if (!r)
-		taal_power_off(dssdev);
-
-	dsi_bus_unlock(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-
-	mutex_unlock(&td->lock);
-
-	return 0;
-err:
-	mutex_unlock(&td->lock);
-	return r;
-}
-
-static int taal_resume(struct omap_dss_device *dssdev)
-{
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	int r;
-
-	dev_dbg(&dssdev->dev, "resume\n");
-
-	mutex_lock(&td->lock);
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED) {
-		r = -EINVAL;
-		goto err;
-	}
-
-	dsi_bus_lock(dssdev);
-
-	r = taal_power_on(dssdev);
-
-	dsi_bus_unlock(dssdev);
-
-	if (r) {
-		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-	} else {
-		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-		taal_queue_esd_work(dssdev);
-	}
-
-	mutex_unlock(&td->lock);
-
-	return r;
-err:
-	mutex_unlock(&td->lock);
-	return r;
-}
-
 static void taal_framedone_cb(int err, void *data)
 {
 	struct omap_dss_device *dssdev = data;
@@ -1818,8 +1748,6 @@ static struct omap_dss_driver taal_driver = {
 
 	.enable		= taal_enable,
 	.disable	= taal_disable,
-	.suspend	= taal_suspend,
-	.resume		= taal_resume,
 
 	.update		= taal_update,
 	.sync		= taal_sync,
diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index 383811c..8281baa 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -189,37 +189,6 @@ static void tfp410_disable(struct omap_dss_device *dssdev)
 	mutex_unlock(&ddata->lock);
 }
 
-static int tfp410_suspend(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-
-	mutex_lock(&ddata->lock);
-
-	tfp410_power_off(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-
-	mutex_unlock(&ddata->lock);
-
-	return 0;
-}
-
-static int tfp410_resume(struct omap_dss_device *dssdev)
-{
-	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-	int r;
-
-	mutex_lock(&ddata->lock);
-
-	r = tfp410_power_on(dssdev);
-	if (r == 0)
-		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	mutex_unlock(&ddata->lock);
-
-	return r;
-}
-
 static void tfp410_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
@@ -355,8 +324,6 @@ static struct omap_dss_driver tfp410_driver = {
 
 	.enable		= tfp410_enable,
 	.disable	= tfp410_disable,
-	.suspend	= tfp410_suspend,
-	.resume		= tfp410_resume,
 
 	.set_timings	= tfp410_set_timings,
 	.get_timings	= tfp410_get_timings,
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index b5e6dbc..316b3da 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -401,24 +401,6 @@ static void tpo_td043_disable(struct omap_dss_device *dssdev)
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
-static int tpo_td043_suspend(struct omap_dss_device *dssdev)
-{
-	dev_dbg(&dssdev->dev, "suspend\n");
-
-	tpo_td043_disable_dss(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-
-	return 0;
-}
-
-static int tpo_td043_resume(struct omap_dss_device *dssdev)
-{
-	dev_dbg(&dssdev->dev, "resume\n");
-
-	return tpo_td043_enable_dss(dssdev);
-}
-
 static int tpo_td043_probe(struct omap_dss_device *dssdev)
 {
 	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(&dssdev->dev);
@@ -500,8 +482,6 @@ static struct omap_dss_driver tpo_td043_driver = {
 
 	.enable		= tpo_td043_enable,
 	.disable	= tpo_td043_disable,
-	.suspend	= tpo_td043_suspend,
-	.resume		= tpo_td043_resume,
 	.set_mirror	= tpo_td043_set_hmirror,
 	.get_mirror	= tpo_td043_get_hmirror,
 
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index ccf8550..1e58730 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -449,7 +449,6 @@ void dss_uninit_device(struct platform_device *pdev,
 
 static int dss_suspend_device(struct device *dev, void *data)
 {
-	int r;
 	struct omap_dss_device *dssdev = to_dss_device(dev);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
@@ -457,15 +456,7 @@ static int dss_suspend_device(struct device *dev, void *data)
 		return 0;
 	}
 
-	if (!dssdev->driver->suspend) {
-		DSSERR("display '%s' doesn't implement suspend\n",
-				dssdev->name);
-		return -ENOSYS;
-	}
-
-	r = dssdev->driver->suspend(dssdev);
-	if (r)
-		return r;
+	dssdev->driver->disable(dssdev);
 
 	dssdev->activate_after_resume = true;
 
@@ -492,8 +483,8 @@ static int dss_resume_device(struct device *dev, void *data)
 	int r;
 	struct omap_dss_device *dssdev = to_dss_device(dev);
 
-	if (dssdev->activate_after_resume && dssdev->driver->resume) {
-		r = dssdev->driver->resume(dssdev);
+	if (dssdev->activate_after_resume) {
+		r = dssdev->driver->enable(dssdev);
 		if (r)
 			return r;
 	}
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 69fb115..3f9a4b9 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -280,58 +280,6 @@ static void hdmi_panel_disable(struct omap_dss_device *dssdev)
 	mutex_unlock(&hdmi.lock);
 }
 
-static int hdmi_panel_suspend(struct omap_dss_device *dssdev)
-{
-	int r = 0;
-
-	mutex_lock(&hdmi.lock);
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
-		r = -EINVAL;
-		goto err;
-	}
-
-	/*
-	 * TODO: notify audio users that the display was suspended. For now,
-	 * disable audio locally to not break our audio state machine.
-	 */
-	hdmi_panel_audio_disable(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-	omapdss_hdmi_display_disable(dssdev);
-
-err:
-	mutex_unlock(&hdmi.lock);
-
-	return r;
-}
-
-static int hdmi_panel_resume(struct omap_dss_device *dssdev)
-{
-	int r = 0;
-
-	mutex_lock(&hdmi.lock);
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED) {
-		r = -EINVAL;
-		goto err;
-	}
-
-	r = omapdss_hdmi_display_enable(dssdev);
-	if (r) {
-		DSSERR("failed to power on\n");
-		goto err;
-	}
-	/* TODO: notify audio users that the panel resumed. */
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-err:
-	mutex_unlock(&hdmi.lock);
-
-	return r;
-}
-
 static void hdmi_get_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
@@ -379,10 +327,13 @@ static int hdmi_check_timings(struct omap_dss_device *dssdev,
 static int hdmi_read_edid(struct omap_dss_device *dssdev, u8 *buf, int len)
 {
 	int r;
+	bool need_enable;
 
 	mutex_lock(&hdmi.lock);
 
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
+	need_enable = dssdev->state == OMAP_DSS_DISPLAY_DISABLED;
+
+	if (need_enable) {
 		r = omapdss_hdmi_display_enable(dssdev);
 		if (r)
 			goto err;
@@ -390,8 +341,7 @@ static int hdmi_read_edid(struct omap_dss_device *dssdev, u8 *buf, int len)
 
 	r = omapdss_hdmi_read_edid(buf, len);
 
-	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
-			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
+	if (need_enable)
 		omapdss_hdmi_display_disable(dssdev);
 err:
 	mutex_unlock(&hdmi.lock);
@@ -402,10 +352,13 @@ err:
 static bool hdmi_detect(struct omap_dss_device *dssdev)
 {
 	int r;
+	bool need_enable;
 
 	mutex_lock(&hdmi.lock);
 
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
+	need_enable = dssdev->state == OMAP_DSS_DISPLAY_DISABLED;
+
+	if (need_enable) {
 		r = omapdss_hdmi_display_enable(dssdev);
 		if (r)
 			goto err;
@@ -413,8 +366,7 @@ static bool hdmi_detect(struct omap_dss_device *dssdev)
 
 	r = omapdss_hdmi_detect();
 
-	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
-			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
+	if (need_enable)
 		omapdss_hdmi_display_disable(dssdev);
 err:
 	mutex_unlock(&hdmi.lock);
@@ -427,8 +379,6 @@ static struct omap_dss_driver hdmi_driver = {
 	.remove		= hdmi_panel_remove,
 	.enable		= hdmi_panel_enable,
 	.disable	= hdmi_panel_disable,
-	.suspend	= hdmi_panel_suspend,
-	.resume		= hdmi_panel_resume,
 	.get_timings	= hdmi_get_timings,
 	.set_timings	= hdmi_set_timings,
 	.check_timings	= hdmi_check_timings,
diff --git a/drivers/video/omap2/dss/venc_panel.c b/drivers/video/omap2/dss/venc_panel.c
index d55b878..0d2b1a0 100644
--- a/drivers/video/omap2/dss/venc_panel.c
+++ b/drivers/video/omap2/dss/venc_panel.c
@@ -157,12 +157,6 @@ static void venc_panel_disable(struct omap_dss_device *dssdev)
 	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED)
 		goto end;
 
-	if (dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED) {
-		/* suspended is the same as disabled with venc */
-		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-		goto end;
-	}
-
 	omapdss_venc_display_disable(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
@@ -170,17 +164,6 @@ end:
 	mutex_unlock(&venc_panel.lock);
 }
 
-static int venc_panel_suspend(struct omap_dss_device *dssdev)
-{
-	venc_panel_disable(dssdev);
-	return 0;
-}
-
-static int venc_panel_resume(struct omap_dss_device *dssdev)
-{
-	return venc_panel_enable(dssdev);
-}
-
 static void venc_panel_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
@@ -222,8 +205,6 @@ static struct omap_dss_driver venc_driver = {
 
 	.enable		= venc_panel_enable,
 	.disable	= venc_panel_disable,
-	.suspend	= venc_panel_suspend,
-	.resume		= venc_panel_resume,
 
 	.get_resolution	= omapdss_default_get_resolution,
 	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index bc225e4..ba46308 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1258,11 +1258,10 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 
 	switch (blank) {
 	case FB_BLANK_UNBLANK:
-		if (display->state != OMAP_DSS_DISPLAY_SUSPENDED)
+		if (display->state == OMAP_DSS_DISPLAY_ACTIVE)
 			goto exit;
 
-		if (display->driver->resume)
-			r = display->driver->resume(display);
+		r = display->driver->enable(display);
 
 		if ((display->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) &&
 				d->update_mode == OMAPFB_AUTO_UPDATE &&
@@ -1283,8 +1282,7 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 		if (d->auto_update_work_enabled)
 			omapfb_stop_auto_update(fbdev, display);
 
-		if (display->driver->suspend)
-			r = display->driver->suspend(display);
+		display->driver->disable(display);
 
 		break;
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 88c8294..cdfb22e 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -158,7 +158,6 @@ enum omap_display_caps {
 enum omap_dss_display_state {
 	OMAP_DSS_DISPLAY_DISABLED = 0,
 	OMAP_DSS_DISPLAY_ACTIVE,
-	OMAP_DSS_DISPLAY_SUSPENDED,
 };
 
 enum omap_dss_audio_state {
@@ -686,8 +685,6 @@ struct omap_dss_driver {
 
 	int (*enable)(struct omap_dss_device *display);
 	void (*disable)(struct omap_dss_device *display);
-	int (*suspend)(struct omap_dss_device *display);
-	int (*resume)(struct omap_dss_device *display);
 	int (*run_test)(struct omap_dss_device *display, int test);
 
 	int (*update)(struct omap_dss_device *dssdev,
-- 
1.7.9.5

