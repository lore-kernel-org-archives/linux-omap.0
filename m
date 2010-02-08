From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 14/17] OMAP: DSS2: move enable/disable/suspend/resume
Date: Mon,  8 Feb 2010 17:57:38 +0200
Message-ID: <1265644661-3694-15-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-6-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-7-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-8-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-9-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-10-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-11-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-12-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-13-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-14-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45861 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab0BHPzr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:47 -0500
In-Reply-To: <1265644661-3694-14-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Move enable/disable/suspend/resume from omap_dss_device to
omap_dss_driver.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h          |   18 +-
 drivers/video/omap2/displays/panel-generic.c       |   56 ++++-
 .../video/omap2/displays/panel-sharp-lq043t1dg01.c |   67 ++++-
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   42 +++-
 drivers/video/omap2/displays/panel-taal.c          |   76 +++++-
 .../video/omap2/displays/panel-toppoly-tdo35s.c    |   56 ++++-
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |   61 ++++-
 drivers/video/omap2/dss/dispc.c                    |   12 +-
 drivers/video/omap2/dss/display.c                  |   14 +-
 drivers/video/omap2/dss/dpi.c                      |  102 +-------
 drivers/video/omap2/dss/dsi.c                      |  136 +----------
 drivers/video/omap2/dss/rfbi.c                     |   22 +--
 drivers/video/omap2/dss/sdi.c                      |   75 +------
 drivers/video/omap2/dss/venc.c                     |  251 ++++++++------------
 drivers/video/omap2/omapfb/omapfb-main.c           |   12 +-
 15 files changed, 462 insertions(+), 538 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 46b3ff0..cc2b4e3 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -465,12 +465,6 @@ struct omap_dss_device {
 
 	enum omap_dss_display_state state;
 
-	int (*enable)(struct omap_dss_device *dssdev);
-	void (*disable)(struct omap_dss_device *dssdev);
-
-	int (*suspend)(struct omap_dss_device *dssdev);
-	int (*resume)(struct omap_dss_device *dssdev);
-
 	int (*check_timings)(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings);
 	void (*set_timings)(struct omap_dss_device *dssdev,
@@ -573,11 +567,21 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h,
 		void (*callback)(int, void *), void *data);
 
+int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
+void omapdss_dsi_display_disable(struct omap_dss_device *dssdev);
+
+int omapdss_dpi_display_enable(struct omap_dss_device *dssdev);
+void omapdss_dpi_display_disable(struct omap_dss_device *dssdev);
+
+int omapdss_sdi_display_enable(struct omap_dss_device *dssdev);
+void omapdss_sdi_display_disable(struct omap_dss_device *dssdev);
+
+int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev);
+void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev);
 int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 		u16 *x, u16 *y, u16 *w, u16 *h);
 int omap_rfbi_update(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h,
 		void (*callback)(void *), void *data);
 
-
 #endif
diff --git a/drivers/video/omap2/displays/panel-generic.c b/drivers/video/omap2/displays/panel-generic.c
index eb48d1a..c59e4ba 100644
--- a/drivers/video/omap2/displays/panel-generic.c
+++ b/drivers/video/omap2/displays/panel-generic.c
@@ -35,6 +35,35 @@ static struct omap_video_timings generic_panel_timings = {
 	.vbp		= 7,
 };
 
+static int generic_panel_power_on(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	r = omapdss_dpi_display_enable(dssdev);
+	if (r)
+		goto err0;
+
+	if (dssdev->platform_enable) {
+		r = dssdev->platform_enable(dssdev);
+		if (r)
+			goto err1;
+	}
+
+	return 0;
+err1:
+	omapdss_dpi_display_disable(dssdev);
+err0:
+	return r;
+}
+
+static void generic_panel_power_off(struct omap_dss_device *dssdev)
+{
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+
+	omapdss_dpi_display_disable(dssdev);
+}
+
 static int generic_panel_probe(struct omap_dss_device *dssdev)
 {
 	dssdev->panel.config = OMAP_DSS_LCD_TFT;
@@ -51,27 +80,40 @@ static int generic_panel_enable(struct omap_dss_device *dssdev)
 {
 	int r = 0;
 
-	if (dssdev->platform_enable)
-		r = dssdev->platform_enable(dssdev);
+	r = generic_panel_power_on(dssdev);
+	if (r)
+		return r;
 
-	return r;
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
 }
 
 static void generic_panel_disable(struct omap_dss_device *dssdev)
 {
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
+	generic_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
 static int generic_panel_suspend(struct omap_dss_device *dssdev)
 {
-	generic_panel_disable(dssdev);
+	generic_panel_power_off(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 	return 0;
 }
 
 static int generic_panel_resume(struct omap_dss_device *dssdev)
 {
-	return generic_panel_enable(dssdev);
+	int r = 0;
+
+	r = generic_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
 }
 
 static struct omap_dss_driver generic_driver = {
diff --git a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c b/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
index e75798e..1026746 100644
--- a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
+++ b/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
@@ -39,6 +39,41 @@ static struct omap_video_timings sharp_lq_timings = {
 	.vbp		= 2,
 };
 
+static int sharp_lq_panel_power_on(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	r = omapdss_dpi_display_enable(dssdev);
+	if (r)
+		goto err0;
+
+	/* wait couple of vsyncs until enabling the LCD */
+	msleep(50);
+
+	if (dssdev->platform_enable) {
+		r = dssdev->platform_enable(dssdev);
+		if (r)
+			goto err1;
+	}
+
+	return 0;
+err1:
+	omapdss_dpi_display_disable(dssdev);
+err0:
+	return r;
+}
+
+static void sharp_lq_panel_power_off(struct omap_dss_device *dssdev)
+{
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+
+	/* wait at least 5 vsyncs after disabling the LCD */
+	msleep(100);
+
+	omapdss_dpi_display_disable(dssdev);
+}
+
 static int sharp_lq_panel_probe(struct omap_dss_device *dssdev)
 {
 
@@ -58,36 +93,40 @@ static int sharp_lq_panel_enable(struct omap_dss_device *dssdev)
 {
 	int r = 0;
 
+	r = sharp_lq_panel_power_on(dssdev);
+	if (r)
+		return r;
 
-	/* wait couple of vsyncs until enabling the LCD */
-	msleep(50);
-
-	if (dssdev->platform_enable)
-		r = dssdev->platform_enable(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
-	return r;
+	return 0;
 }
 
 static void sharp_lq_panel_disable(struct omap_dss_device *dssdev)
 {
+	sharp_lq_panel_power_off(dssdev);
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
-	/* wait at least 5 vsyncs after disabling the LCD */
-
-	msleep(100);
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
 static int sharp_lq_panel_suspend(struct omap_dss_device *dssdev)
 {
-	sharp_lq_panel_disable(dssdev);
+	sharp_lq_panel_power_off(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 	return 0;
 }
 
 static int sharp_lq_panel_resume(struct omap_dss_device *dssdev)
 {
-	return sharp_lq_panel_enable(dssdev);
+	int r = 0;
+
+	r = sharp_lq_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
 }
 
 static struct omap_dss_driver sharp_lq_driver = {
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index e207d66..8d51a5e 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -20,7 +20,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/regulator/consumer.h>
 #include <linux/err.h>
 
 #include <plat/display.h>
@@ -54,20 +53,31 @@ static void sharp_ls_panel_remove(struct omap_dss_device *dssdev)
 {
 }
 
-static int sharp_ls_panel_enable(struct omap_dss_device *dssdev)
+static int sharp_ls_power_on(struct omap_dss_device *dssdev)
 {
 	int r = 0;
 
+	r = omapdss_dpi_display_enable(dssdev);
+	if (r)
+		goto err0;
+
 	/* wait couple of vsyncs until enabling the LCD */
 	msleep(50);
 
-	if (dssdev->platform_enable)
+	if (dssdev->platform_enable) {
 		r = dssdev->platform_enable(dssdev);
+		if (r)
+			goto err1;
+	}
 
+	return 0;
+err1:
+	omapdss_dpi_display_disable(dssdev);
+err0:
 	return r;
 }
 
-static void sharp_ls_panel_disable(struct omap_dss_device *dssdev)
+static void sharp_ls_power_off(struct omap_dss_device *dssdev)
 {
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
@@ -75,17 +85,37 @@ static void sharp_ls_panel_disable(struct omap_dss_device *dssdev)
 	/* wait at least 5 vsyncs after disabling the LCD */
 
 	msleep(100);
+
+	omapdss_dpi_display_disable(dssdev);
+}
+
+static int sharp_ls_panel_enable(struct omap_dss_device *dssdev)
+{
+	int r;
+	r = sharp_ls_power_on(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+	return r;
+}
+
+static void sharp_ls_panel_disable(struct omap_dss_device *dssdev)
+{
+	sharp_ls_power_off(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
 static int sharp_ls_panel_suspend(struct omap_dss_device *dssdev)
 {
-	sharp_ls_panel_disable(dssdev);
+	sharp_ls_power_off(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 	return 0;
 }
 
 static int sharp_ls_panel_resume(struct omap_dss_device *dssdev)
 {
-	return sharp_ls_panel_enable(dssdev);
+	int r;
+	r = sharp_ls_power_on(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+	return r;
 }
 
 static struct omap_dss_driver sharp_ls_driver = {
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index cb94596..cdb7617 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -620,14 +620,12 @@ static void taal_remove(struct omap_dss_device *dssdev)
 	kfree(td);
 }
 
-static int taal_enable(struct omap_dss_device *dssdev)
+static int taal_power_on(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	u8 id1, id2, id3;
 	int r;
 
-	dev_dbg(&dssdev->dev, "enable\n");
-
 	if (dssdev->platform_enable) {
 		r = dssdev->platform_enable(dssdev);
 		if (r)
@@ -637,6 +635,16 @@ static int taal_enable(struct omap_dss_device *dssdev)
 	/* it seems we have to wait a bit until taal is ready */
 	msleep(5);
 
+	dsi_bus_lock();
+
+	r = omapdss_dsi_display_enable(dssdev);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to enable DSI\n");
+		goto err0;
+	}
+
+	omapdss_dsi_vc_enable_hs(TCH, false);
+
 	r = taal_sleep_out(td);
 	if (r)
 		goto err;
@@ -675,19 +683,27 @@ static int taal_enable(struct omap_dss_device *dssdev)
 		td->intro_printed = true;
 	}
 
+	omapdss_dsi_vc_enable_hs(TCH, true);
+
+	dsi_bus_unlock();
+
 	return 0;
 err:
+	dsi_bus_unlock();
+
+	omapdss_dsi_display_disable(dssdev);
+err0:
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
 	return r;
 }
 
-static void taal_disable(struct omap_dss_device *dssdev)
+static void taal_power_off(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 
-	dev_dbg(&dssdev->dev, "disable\n");
+	dsi_bus_lock();
 
 	cancel_delayed_work(&td->esd_work);
 
@@ -697,32 +713,64 @@ static void taal_disable(struct omap_dss_device *dssdev)
 	/* wait a bit so that the message goes through */
 	msleep(10);
 
+	omapdss_dsi_display_disable(dssdev);
+
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
 	td->enabled = 0;
+
+	dsi_bus_unlock();
+}
+
+static int taal_enable(struct omap_dss_device *dssdev)
+{
+	int r;
+	dev_dbg(&dssdev->dev, "enable\n");
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)
+		return -EINVAL;
+
+	r = taal_power_on(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return r;
+}
+
+static void taal_disable(struct omap_dss_device *dssdev)
+{
+	dev_dbg(&dssdev->dev, "disable\n");
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+		taal_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
 static int taal_suspend(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	struct backlight_device *bldev = td->bldev;
+	dev_dbg(&dssdev->dev, "suspend\n");
 
-	bldev->props.power = FB_BLANK_POWERDOWN;
-	taal_bl_update_status(bldev);
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+		return -EINVAL;
+
+	taal_power_off(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 
 	return 0;
 }
 
 static int taal_resume(struct omap_dss_device *dssdev)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	struct backlight_device *bldev = td->bldev;
+	int r;
+	dev_dbg(&dssdev->dev, "resume\n");
 
-	bldev->props.power = FB_BLANK_UNBLANK;
-	taal_bl_update_status(bldev);
+	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED)
+		return -EINVAL;
 
-	return 0;
+	r = taal_power_on(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+	return r;
 }
 
 static void taal_framedone_cb(int err, void *data)
diff --git a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
index e744b8c..fa434ca 100644
--- a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
+++ b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
@@ -42,6 +42,35 @@ static struct omap_video_timings toppoly_tdo_panel_timings = {
 	.vbp		= 2,
 };
 
+static int toppoly_tdo_panel_power_on(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	r = omapdss_dpi_display_enable(dssdev);
+	if (r)
+		goto err0;
+
+	if (dssdev->platform_enable) {
+		r = dssdev->platform_enable(dssdev);
+		if (r)
+			goto err1;
+	}
+
+	return 0;
+err1:
+	omapdss_dpi_display_disable(dssdev);
+err0:
+	return r;
+}
+
+static void toppoly_tdo_panel_power_off(struct omap_dss_device *dssdev)
+{
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+
+	omapdss_dpi_display_disable(dssdev);
+}
+
 static int toppoly_tdo_panel_probe(struct omap_dss_device *dssdev)
 {
 	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
@@ -59,27 +88,40 @@ static int toppoly_tdo_panel_enable(struct omap_dss_device *dssdev)
 {
 	int r = 0;
 
-	if (dssdev->platform_enable)
-		r = dssdev->platform_enable(dssdev);
+	r = toppoly_tdo_panel_power_on(dssdev);
+	if (r)
+		return r;
 
-	return r;
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
 }
 
 static void toppoly_tdo_panel_disable(struct omap_dss_device *dssdev)
 {
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
+	toppoly_tdo_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
 static int toppoly_tdo_panel_suspend(struct omap_dss_device *dssdev)
 {
-	toppoly_tdo_panel_disable(dssdev);
+	toppoly_tdo_panel_power_off(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 	return 0;
 }
 
 static int toppoly_tdo_panel_resume(struct omap_dss_device *dssdev)
 {
-	return toppoly_tdo_panel_enable(dssdev);
+	int r = 0;
+
+	r = toppoly_tdo_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
 }
 
 static struct omap_dss_driver generic_driver = {
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index f297a46..c6e4a7e 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -262,18 +262,20 @@ static const struct omap_video_timings tpo_td043_timings = {
 	.vbp		= 34,
 };
 
-static int tpo_td043_enable(struct omap_dss_device *dssdev)
+static int generic_panel_power_on(struct omap_dss_device *dssdev)
 {
 	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(&dssdev->dev);
 	int nreset_gpio = dssdev->reset_gpio;
-	int ret;
+	int r;
 
-	dev_dbg(&dssdev->dev, "enable\n");
+	r = omapdss_dpi_display_enable(dssdev);
+	if (r)
+		goto err0;
 
 	if (dssdev->platform_enable) {
-		ret = dssdev->platform_enable(dssdev);
-		if (ret)
-			return ret;
+		r = dssdev->platform_enable(dssdev);
+		if (r)
+			goto err1;
 	}
 
 	regulator_enable(tpo_td043->vcc_reg);
@@ -294,15 +296,17 @@ static int tpo_td043_enable(struct omap_dss_device *dssdev)
 	tpo_td043_write_gamma(tpo_td043->spi, tpo_td043->gamma);
 
 	return 0;
+err1:
+	omapdss_dpi_display_disable(dssdev);
+err0:
+	return r;
 }
 
-static void tpo_td043_disable(struct omap_dss_device *dssdev)
+static void generic_panel_power_off(struct omap_dss_device *dssdev)
 {
 	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(&dssdev->dev);
 	int nreset_gpio = dssdev->reset_gpio;
 
-	dev_dbg(&dssdev->dev, "disable\n");
-
 	tpo_td043_write(tpo_td043->spi, 3,
 			TPO_R03_VAL_STANDBY | TPO_R03_EN_PWM);
 
@@ -318,17 +322,52 @@ static void tpo_td043_disable(struct omap_dss_device *dssdev)
 
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
+
+	omapdss_dpi_display_disable(dssdev);
+}
+
+static int tpo_td043_enable(struct omap_dss_device *dssdev)
+{
+	int ret;
+
+	dev_dbg(&dssdev->dev, "enable\n");
+
+	ret = generic_panel_power_on(dssdev);
+	if (ret)
+		return ret;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void tpo_td043_disable(struct omap_dss_device *dssdev)
+{
+	dev_dbg(&dssdev->dev, "disable\n");
+
+	generic_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
 static int tpo_td043_suspend(struct omap_dss_device *dssdev)
 {
-	tpo_td043_disable(dssdev);
+	generic_panel_power_off(dssdev);
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 	return 0;
 }
 
 static int tpo_td043_resume(struct omap_dss_device *dssdev)
 {
-	return tpo_td043_enable(dssdev);
+	int r = 0;
+
+	r = generic_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
 }
 
 static int tpo_td043_probe(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 68edc32..63636aa 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2872,12 +2872,13 @@ static void dispc_error_worker(struct work_struct *work)
 				manager = mgr;
 				enable = mgr->device->state ==
 						OMAP_DSS_DISPLAY_ACTIVE;
-				mgr->device->disable(mgr->device);
+				mgr->device->driver->disable(mgr->device);
 				break;
 			}
 		}
 
 		if (manager) {
+			struct omap_dss_device *dssdev = manager->device;
 			for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
 				struct omap_overlay *ovl;
 				ovl = omap_dss_get_overlay(i);
@@ -2892,7 +2893,7 @@ static void dispc_error_worker(struct work_struct *work)
 			dispc_go(manager->id);
 			mdelay(50);
 			if (enable)
-				manager->device->enable(manager->device);
+				dssdev->driver->enable(dssdev);
 		}
 	}
 
@@ -2910,12 +2911,13 @@ static void dispc_error_worker(struct work_struct *work)
 				manager = mgr;
 				enable = mgr->device->state ==
 						OMAP_DSS_DISPLAY_ACTIVE;
-				mgr->device->disable(mgr->device);
+				mgr->device->driver->disable(mgr->device);
 				break;
 			}
 		}
 
 		if (manager) {
+			struct omap_dss_device *dssdev = manager->device;
 			for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
 				struct omap_overlay *ovl;
 				ovl = omap_dss_get_overlay(i);
@@ -2930,7 +2932,7 @@ static void dispc_error_worker(struct work_struct *work)
 			dispc_go(manager->id);
 			mdelay(50);
 			if (enable)
-				manager->device->enable(manager->device);
+				dssdev->driver->enable(dssdev);
 		}
 	}
 
@@ -2941,7 +2943,7 @@ static void dispc_error_worker(struct work_struct *work)
 			mgr = omap_dss_get_overlay_manager(i);
 
 			if (mgr->caps & OMAP_DSS_OVL_CAP_DISPC)
-				mgr->device->disable(mgr->device);
+				mgr->device->driver->disable(mgr->device);
 		}
 	}
 
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index dba33cd..bc8ae35 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -53,11 +53,11 @@ static ssize_t display_enabled_store(struct device *dev,
 
 	if (enabled != (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)) {
 		if (enabled) {
-			r = dssdev->enable(dssdev);
+			r = dssdev->driver->enable(dssdev);
 			if (r)
 				return r;
 		} else {
-			dssdev->disable(dssdev);
+			dssdev->driver->disable(dssdev);
 		}
 	}
 
@@ -485,13 +485,13 @@ static int dss_suspend_device(struct device *dev, void *data)
 		return 0;
 	}
 
-	if (!dssdev->suspend) {
+	if (!dssdev->driver->suspend) {
 		DSSERR("display '%s' doesn't implement suspend\n",
 				dssdev->name);
 		return -ENOSYS;
 	}
 
-	r = dssdev->suspend(dssdev);
+	r = dssdev->driver->suspend(dssdev);
 	if (r)
 		return r;
 
@@ -520,8 +520,8 @@ static int dss_resume_device(struct device *dev, void *data)
 	int r;
 	struct omap_dss_device *dssdev = to_dss_device(dev);
 
-	if (dssdev->activate_after_resume && dssdev->resume) {
-		r = dssdev->resume(dssdev);
+	if (dssdev->activate_after_resume && dssdev->driver->resume) {
+		r = dssdev->driver->resume(dssdev);
 		if (r)
 			return r;
 	}
@@ -541,7 +541,7 @@ int dss_resume_all_devices(void)
 static int dss_disable_device(struct device *dev, void *data)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	dssdev->disable(dssdev);
+	dssdev->driver->disable(dssdev);
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 48ff7ea..1eef8b7 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -153,7 +153,7 @@ static int dpi_basic_init(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int dpi_display_enable(struct omap_dss_device *dssdev)
+int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r;
 
@@ -163,57 +163,42 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
-	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
-		DSSERR("display already enabled\n");
-		r = -EINVAL;
-		goto err1;
-	}
-
 	if (cpu_is_omap34xx()) {
 		r = regulator_enable(dpi.vdds_dsi_reg);
 		if (r)
-			goto err2;
+			goto err1;
 	}
 
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
 	r = dpi_basic_init(dssdev);
 	if (r)
-		goto err3;
+		goto err2;
 
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
 	dss_clk_enable(DSS_CLK_FCK2);
 	r = dsi_pll_init(dssdev, 0, 1);
 	if (r)
-		goto err4;
+		goto err3;
 #endif
 	r = dpi_set_mode(dssdev);
 	if (r)
-		goto err5;
+		goto err4;
 
 	mdelay(2);
 
 	dssdev->manager->enable(dssdev->manager);
 
-	r = dssdev->driver->enable(dssdev);
-	if (r)
-		goto err6;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
 	return 0;
 
-err6:
-	dssdev->manager->disable(dssdev->manager);
-err5:
+err4:
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
 	dsi_pll_uninit();
-err4:
+err3:
 	dss_clk_disable(DSS_CLK_FCK2);
 #endif
-err3:
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
 err2:
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
 	if (cpu_is_omap34xx())
 		regulator_disable(dpi.vdds_dsi_reg);
 err1:
@@ -221,19 +206,10 @@ err1:
 err0:
 	return r;
 }
+EXPORT_SYMBOL(omapdss_dpi_display_enable);
 
-static int dpi_display_resume(struct omap_dss_device *dssdev);
-
-static void dpi_display_disable(struct omap_dss_device *dssdev)
+void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 {
-	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED)
-		return;
-
-	if (dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
-		dpi_display_resume(dssdev);
-
-	dssdev->driver->disable(dssdev);
-
 	dssdev->manager->disable(dssdev->manager);
 
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
@@ -247,61 +223,9 @@ static void dpi_display_disable(struct omap_dss_device *dssdev)
 	if (cpu_is_omap34xx())
 		regulator_disable(dpi.vdds_dsi_reg);
 
-	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-
 	omap_dss_stop_device(dssdev);
 }
-
-static int dpi_display_suspend(struct omap_dss_device *dssdev)
-{
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
-		return -EINVAL;
-
-	DSSDBG("dpi_display_suspend\n");
-
-	if (dssdev->driver->suspend)
-		dssdev->driver->suspend(dssdev);
-
-	dssdev->manager->disable(dssdev->manager);
-
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
-
-	if (cpu_is_omap34xx())
-		regulator_disable(dpi.vdds_dsi_reg);
-
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-
-	return 0;
-}
-
-static int dpi_display_resume(struct omap_dss_device *dssdev)
-{
-	int r;
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED)
-		return -EINVAL;
-
-	DSSDBG("dpi_display_resume\n");
-
-	if (cpu_is_omap34xx()) {
-		r = regulator_enable(dpi.vdds_dsi_reg);
-		if (r)
-			goto err0;
-	}
-
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
-
-	dssdev->manager->enable(dssdev->manager);
-
-	if (dssdev->driver->resume)
-		dssdev->driver->resume(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
-err0:
-	return r;
-}
+EXPORT_SYMBOL(omapdss_dpi_display_disable);
 
 static void dpi_set_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
@@ -379,10 +303,6 @@ int dpi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
-	dssdev->enable = dpi_display_enable;
-	dssdev->disable = dpi_display_disable;
-	dssdev->suspend = dpi_display_suspend;
-	dssdev->resume = dpi_display_resume;
 	dssdev->set_timings = dpi_set_timings;
 	dssdev->check_timings = dpi_check_timings;
 	dssdev->get_timings = dpi_get_timings;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a29ca43..79d27de 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3099,18 +3099,7 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	dsi_if_enable(1);
 	dsi_force_tx_stop_mode_io();
 
-	if (dssdev->driver->enable) {
-		r = dssdev->driver->enable(dssdev);
-		if (r)
-			goto err4;
-	}
-
-	/* enable high-speed after initial config */
-	omapdss_dsi_vc_enable_hs(0, 1);
-
 	return 0;
-err4:
-	dsi_if_enable(0);
 err3:
 	dsi_complexio_uninit();
 err2:
@@ -3124,9 +3113,6 @@ err0:
 
 static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev)
 {
-	if (dssdev->driver->disable)
-		dssdev->driver->disable(dssdev);
-
 	dss_select_dispc_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
 	dss_select_dsi_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
 	dsi_complexio_uninit();
@@ -3149,14 +3135,15 @@ static int dsi_core_init(void)
 	return 0;
 }
 
-static int dsi_display_enable(struct omap_dss_device *dssdev)
+int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r = 0;
 
 	DSSDBG("dsi_display_enable\n");
 
+	WARN_ON(!dsi_bus_is_locked());
+
 	mutex_lock(&dsi.lock);
-	dsi_bus_lock();
 
 	r = omap_dss_start_device(dssdev);
 	if (r) {
@@ -3164,90 +3151,49 @@ static int dsi_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
-	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
-		DSSERR("dssdev already enabled\n");
-		r = -EINVAL;
-		goto err1;
-	}
-
 	enable_clocks(1);
 	dsi_enable_pll_clock(1);
 
 	r = _dsi_reset();
 	if (r)
-		goto err2;
+		goto err1;
 
 	dsi_core_init();
 
 	r = dsi_display_init_dispc(dssdev);
 	if (r)
-		goto err2;
+		goto err1;
 
 	r = dsi_display_init_dsi(dssdev);
 	if (r)
-		goto err3;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+		goto err2;
 
 	dsi.use_ext_te = dssdev->phy.dsi.ext_te;
 
-	dsi_bus_unlock();
 	mutex_unlock(&dsi.lock);
 
 	return 0;
 
-err3:
-	dsi_display_uninit_dispc(dssdev);
 err2:
+	dsi_display_uninit_dispc(dssdev);
+err1:
 	enable_clocks(0);
 	dsi_enable_pll_clock(0);
-err1:
 	omap_dss_stop_device(dssdev);
 err0:
-	dsi_bus_unlock();
 	mutex_unlock(&dsi.lock);
 	DSSDBG("dsi_display_enable FAILED\n");
 	return r;
 }
+EXPORT_SYMBOL(omapdss_dsi_display_enable);
 
-static void dsi_display_disable(struct omap_dss_device *dssdev)
+void omapdss_dsi_display_disable(struct omap_dss_device *dssdev)
 {
 	DSSDBG("dsi_display_disable\n");
 
-	mutex_lock(&dsi.lock);
-	dsi_bus_lock();
-
-	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
-			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
-		goto end;
-
-	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-
-	dsi_display_uninit_dispc(dssdev);
-
-	dsi_display_uninit_dsi(dssdev);
-
-	enable_clocks(0);
-	dsi_enable_pll_clock(0);
-
-	omap_dss_stop_device(dssdev);
-end:
-	dsi_bus_unlock();
-	mutex_unlock(&dsi.lock);
-}
-
-static int dsi_display_suspend(struct omap_dss_device *dssdev)
-{
-	DSSDBG("dsi_display_suspend\n");
+	WARN_ON(!dsi_bus_is_locked());
 
 	mutex_lock(&dsi.lock);
-	dsi_bus_lock();
-
-	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED ||
-			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
-		goto end;
-
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 
 	dsi_display_uninit_dispc(dssdev);
 
@@ -3255,63 +3201,12 @@ static int dsi_display_suspend(struct omap_dss_device *dssdev)
 
 	enable_clocks(0);
 	dsi_enable_pll_clock(0);
-end:
-	dsi_bus_unlock();
-	mutex_unlock(&dsi.lock);
 
-	return 0;
-}
-
-static int dsi_display_resume(struct omap_dss_device *dssdev)
-{
-	int r;
-
-	DSSDBG("dsi_display_resume\n");
-
-	mutex_lock(&dsi.lock);
-	dsi_bus_lock();
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED) {
-		DSSERR("dssdev not suspended\n");
-		r = -EINVAL;
-		goto err0;
-	}
-
-	enable_clocks(1);
-	dsi_enable_pll_clock(1);
-
-	r = _dsi_reset();
-	if (r)
-		goto err1;
-
-	dsi_core_init();
-
-	r = dsi_display_init_dispc(dssdev);
-	if (r)
-		goto err1;
-
-	r = dsi_display_init_dsi(dssdev);
-	if (r)
-		goto err2;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	dsi_bus_unlock();
-	mutex_unlock(&dsi.lock);
-
-	return 0;
+	omap_dss_stop_device(dssdev);
 
-err2:
-	dsi_display_uninit_dispc(dssdev);
-err1:
-	enable_clocks(0);
-	dsi_enable_pll_clock(0);
-err0:
-	dsi_bus_unlock();
 	mutex_unlock(&dsi.lock);
-	DSSDBG("dsi_display_resume FAILED\n");
-	return r;
 }
+EXPORT_SYMBOL(omapdss_dsi_display_disable);
 
 int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
@@ -3337,11 +3232,6 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("DSI init\n");
 
-	dssdev->enable = dsi_display_enable;
-	dssdev->disable = dsi_display_disable;
-	dssdev->suspend = dsi_display_suspend;
-	dssdev->resume = dsi_display_resume;
-
 	/* XXX these should be figured out dynamically */
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
 		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index a6b3316..cc23f53 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1001,8 +1001,7 @@ void rfbi_exit(void)
 	iounmap(rfbi.base);
 }
 
-/* struct omap_display support */
-static int rfbi_display_enable(struct omap_dss_device *dssdev)
+int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r;
 
@@ -1033,38 +1032,25 @@ static int rfbi_display_enable(struct omap_dss_device *dssdev)
 			 &dssdev->ctrl.rfbi_timings);
 
 
-	if (dssdev->driver->enable) {
-		r = dssdev->driver->enable(dssdev);
-		if (r)
-			goto err2;
-	}
-
 	return 0;
-err2:
-	omap_dispc_unregister_isr(framedone_callback, NULL,
-			DISPC_IRQ_FRAMEDONE);
 err1:
 	omap_dss_stop_device(dssdev);
 err0:
 	return r;
 }
+EXPORT_SYMBOL(omapdss_rfbi_display_enable);
 
-static void rfbi_display_disable(struct omap_dss_device *dssdev)
+void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev)
 {
-	dssdev->driver->disable(dssdev);
 	omap_dispc_unregister_isr(framedone_callback, NULL,
 			DISPC_IRQ_FRAMEDONE);
 	omap_dss_stop_device(dssdev);
 }
+EXPORT_SYMBOL(omapdss_rfbi_display_disable);
 
 int rfbi_init_display(struct omap_dss_device *dssdev)
 {
-	dssdev->enable = rfbi_display_enable;
-	dssdev->disable = rfbi_display_disable;
-
 	rfbi.dssdev[dssdev->phy.rfbi.channel] = dssdev;
-
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
-
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 6bd9b0c..929ceb3 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -41,7 +41,7 @@ static void sdi_basic_init(void)
 	dispc_lcd_enable_signal_polarity(1);
 }
 
-static int sdi_display_enable(struct omap_dss_device *dssdev)
+int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 {
 	struct omap_video_timings *t = &dssdev->panel.timings;
 	struct dss_clock_info dss_cinfo;
@@ -57,12 +57,6 @@ static int sdi_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
-	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
-		DSSERR("dssdev already enabled\n");
-		r = -EINVAL;
-		goto err1;
-	}
-
 	/* In case of skip_init sdi_init has already enabled the clocks */
 	if (!sdi.skip_init)
 		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
@@ -127,8 +121,6 @@ static int sdi_display_enable(struct omap_dss_device *dssdev)
 			goto err3;
 	}
 
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
 	sdi.skip_init = 0;
 
 	return 0;
@@ -141,18 +133,10 @@ err1:
 err0:
 	return r;
 }
+EXPORT_SYMBOL(omapdss_sdi_display_enable);
 
-static int sdi_display_resume(struct omap_dss_device *dssdev);
-
-static void sdi_display_disable(struct omap_dss_device *dssdev)
+void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 {
-	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED)
-		return;
-
-	if (dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
-		if (sdi_display_resume(dssdev))
-			return;
-
 	if (dssdev->driver->disable)
 		dssdev->driver->disable(dssdev);
 
@@ -162,56 +146,9 @@ static void sdi_display_disable(struct omap_dss_device *dssdev)
 
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
-	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-
 	omap_dss_stop_device(dssdev);
 }
-
-static int sdi_display_suspend(struct omap_dss_device *dssdev)
-{
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
-		return -EINVAL;
-
-	if (dssdev->driver->suspend)
-		dssdev->driver->suspend(dssdev);
-
-	dssdev->manager->disable(dssdev->manager);
-
-	dss_sdi_disable();
-
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
-
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-
-	return 0;
-}
-
-static int sdi_display_resume(struct omap_dss_device *dssdev)
-{
-	int r;
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED)
-		return -EINVAL;
-
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
-
-	r = dss_sdi_enable();
-	if (r)
-		goto err;
-	mdelay(2);
-
-	dssdev->manager->enable(dssdev->manager);
-
-	if (dssdev->driver->resume)
-		dssdev->driver->resume(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
-err:
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
-	return r;
-}
+EXPORT_SYMBOL(omapdss_sdi_display_disable);
 
 static void sdi_get_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
@@ -223,10 +160,6 @@ int sdi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("SDI init\n");
 
-	dssdev->enable = sdi_display_enable;
-	dssdev->disable = sdi_display_disable;
-	dssdev->suspend = sdi_display_suspend;
-	dssdev->resume = sdi_display_resume;
 	dssdev->get_timings = sdi_get_timings;
 
 	return 0;
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 0d0dc94..a0ab52c 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -400,6 +400,56 @@ static const struct venc_config *venc_timings_to_config(
 	BUG();
 }
 
+static void venc_power_on(struct omap_dss_device *dssdev)
+{
+	u32 l;
+
+	venc_enable_clocks(1);
+
+	venc_reset();
+	venc_write_config(venc_timings_to_config(&dssdev->panel.timings));
+
+	dss_set_venc_output(dssdev->phy.venc.type);
+	dss_set_dac_pwrdn_bgz(1);
+
+	l = 0;
+
+	if (dssdev->phy.venc.type == OMAP_DSS_VENC_TYPE_COMPOSITE)
+		l |= 1 << 1;
+	else /* S-Video */
+		l |= (1 << 0) | (1 << 2);
+
+	if (dssdev->phy.venc.invert_polarity == false)
+		l |= 1 << 3;
+
+	venc_write_reg(VENC_OUTPUT_CONTROL, l);
+
+	dispc_set_digit_size(dssdev->panel.timings.x_res,
+			dssdev->panel.timings.y_res/2);
+
+	regulator_enable(venc.vdda_dac_reg);
+
+	if (dssdev->platform_enable)
+		dssdev->platform_enable(dssdev);
+
+	dssdev->manager->enable(dssdev->manager);
+}
+
+static void venc_power_off(struct omap_dss_device *dssdev)
+{
+	venc_write_reg(VENC_OUTPUT_CONTROL, 0);
+	dss_set_dac_pwrdn_bgz(0);
+
+	dssdev->manager->disable(dssdev->manager);
+
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+
+	regulator_disable(venc.vdda_dac_reg);
+
+	venc_enable_clocks(0);
+}
+
 
 
 
@@ -420,23 +470,66 @@ static int venc_panel_enable(struct omap_dss_device *dssdev)
 {
 	int r = 0;
 
+	DSSDBG("venc_enable_display\n");
+
+	mutex_lock(&venc.venc_lock);
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
+		r = -EINVAL;
+		goto err1;
+	}
+
+	if (dssdev->platform_enable) {
+		r = dssdev->platform_enable(dssdev);
+		if (r)
+			goto err2;
+	}
+
+	venc_power_on(dssdev);
+
+	venc.wss_data = 0;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
 	/* wait couple of vsyncs until enabling the LCD */
 	msleep(50);
 
-	if (dssdev->platform_enable)
-		r = dssdev->platform_enable(dssdev);
+	mutex_unlock(&venc.venc_lock);
 
 	return r;
+err2:
+	venc_power_off(dssdev);
+err1:
+	mutex_unlock(&venc.venc_lock);
+	return r;
 }
 
 static void venc_panel_disable(struct omap_dss_device *dssdev)
 {
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
+	DSSDBG("venc_disable_display\n");
 
-	/* wait at least 5 vsyncs after disabling the LCD */
+	mutex_lock(&venc.venc_lock);
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED)
+		goto end;
 
+	if (dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED) {
+		/* suspended is the same as disabled with venc */
+		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+		goto end;
+	}
+
+	venc_power_off(dssdev);
+
+	/* wait at least 5 vsyncs after disabling the LCD */
 	msleep(100);
+
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+end:
+	mutex_unlock(&venc.venc_lock);
 }
 
 static int venc_panel_suspend(struct omap_dss_device *dssdev)
@@ -526,146 +619,6 @@ void venc_exit(void)
 	iounmap(venc.base);
 }
 
-static void venc_power_on(struct omap_dss_device *dssdev)
-{
-	u32 l;
-
-	venc_enable_clocks(1);
-
-	venc_reset();
-	venc_write_config(venc_timings_to_config(&dssdev->panel.timings));
-
-	dss_set_venc_output(dssdev->phy.venc.type);
-	dss_set_dac_pwrdn_bgz(1);
-
-	l = 0;
-
-	if (dssdev->phy.venc.type == OMAP_DSS_VENC_TYPE_COMPOSITE)
-		l |= 1 << 1;
-	else /* S-Video */
-		l |= (1 << 0) | (1 << 2);
-
-	if (dssdev->phy.venc.invert_polarity == false)
-		l |= 1 << 3;
-
-	venc_write_reg(VENC_OUTPUT_CONTROL, l);
-
-	dispc_set_digit_size(dssdev->panel.timings.x_res,
-			dssdev->panel.timings.y_res/2);
-
-	regulator_enable(venc.vdda_dac_reg);
-
-	if (dssdev->platform_enable)
-		dssdev->platform_enable(dssdev);
-
-	dssdev->manager->enable(dssdev->manager);
-}
-
-static void venc_power_off(struct omap_dss_device *dssdev)
-{
-	venc_write_reg(VENC_OUTPUT_CONTROL, 0);
-	dss_set_dac_pwrdn_bgz(0);
-
-	dssdev->manager->disable(dssdev->manager);
-
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
-	regulator_disable(venc.vdda_dac_reg);
-
-	venc_enable_clocks(0);
-}
-
-static int venc_enable_display(struct omap_dss_device *dssdev)
-{
-	int r = 0;
-
-	DSSDBG("venc_enable_display\n");
-
-	mutex_lock(&venc.venc_lock);
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
-		r = -EINVAL;
-		goto err;
-	}
-
-	venc_power_on(dssdev);
-
-	venc.wss_data = 0;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-err:
-	mutex_unlock(&venc.venc_lock);
-
-	return r;
-}
-
-static void venc_disable_display(struct omap_dss_device *dssdev)
-{
-	DSSDBG("venc_disable_display\n");
-
-	mutex_lock(&venc.venc_lock);
-
-	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED)
-		goto end;
-
-	if (dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED) {
-		/* suspended is the same as disabled with venc */
-		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-		goto end;
-	}
-
-	venc_power_off(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-end:
-	mutex_unlock(&venc.venc_lock);
-}
-
-static int venc_display_suspend(struct omap_dss_device *dssdev)
-{
-	int r = 0;
-
-	DSSDBG("venc_display_suspend\n");
-
-	mutex_lock(&venc.venc_lock);
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
-		r = -EINVAL;
-		goto err;
-	}
-
-	venc_power_off(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-err:
-	mutex_unlock(&venc.venc_lock);
-
-	return r;
-}
-
-static int venc_display_resume(struct omap_dss_device *dssdev)
-{
-	int r = 0;
-
-	DSSDBG("venc_display_resume\n");
-
-	mutex_lock(&venc.venc_lock);
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED) {
-		r = -EINVAL;
-		goto err;
-	}
-
-	venc_power_on(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-err:
-	mutex_unlock(&venc.venc_lock);
-
-	return r;
-}
-
 static void venc_get_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
@@ -684,8 +637,8 @@ static void venc_set_timings(struct omap_dss_device *dssdev,
 	dssdev->panel.timings = *timings;
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		/* turn the venc off and on to get new timings to use */
-		venc_disable_display(dssdev);
-		venc_enable_display(dssdev);
+		venc_panel_disable(dssdev);
+		venc_panel_enable(dssdev);
 	}
 }
 
@@ -738,10 +691,6 @@ int venc_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
-	dssdev->enable = venc_enable_display;
-	dssdev->disable = venc_disable_display;
-	dssdev->suspend = venc_display_suspend;
-	dssdev->resume = venc_display_resume;
 	dssdev->get_timings = venc_get_timings;
 	dssdev->set_timings = venc_set_timings;
 	dssdev->check_timings = venc_check_timings;
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 310d573..f0b304d 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1223,8 +1223,8 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 		if (display->state != OMAP_DSS_DISPLAY_SUSPENDED)
 			goto exit;
 
-		if (display->resume)
-			r = display->resume(display);
+		if (display->driver->resume)
+			r = display->driver->resume(display);
 
 		if (r == 0 && display->driver->get_update_mode &&
 				display->driver->get_update_mode(display) ==
@@ -1242,8 +1242,8 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 		if (display->state != OMAP_DSS_DISPLAY_ACTIVE)
 			goto exit;
 
-		if (display->suspend)
-			r = display->suspend(display);
+		if (display->driver->suspend)
+			r = display->driver->suspend(display);
 
 		break;
 
@@ -1831,7 +1831,7 @@ static void omapfb_free_resources(struct omapfb2_device *fbdev)
 
 	for (i = 0; i < fbdev->num_displays; i++) {
 		if (fbdev->displays[i]->state != OMAP_DSS_DISPLAY_DISABLED)
-			fbdev->displays[i]->disable(fbdev->displays[i]);
+			fbdev->displays[i]->driver->disable(fbdev->displays[i]);
 
 		omap_dss_put_device(fbdev->displays[i]);
 	}
@@ -2192,7 +2192,7 @@ static int omapfb_probe(struct platform_device *pdev)
 #ifndef CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE
 		u16 w, h;
 #endif
-		r = def_display->enable(def_display);
+		r = def_display->driver->enable(def_display);
 		if (r)
 			dev_warn(fbdev->dev, "Failed to enable display '%s'\n",
 					def_display->name);
-- 
1.6.5

