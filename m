From: Archit Taneja <archit@ti.com>
Subject: [PATCH 18/33] OMAPDSS: nec-nl8048 panel: handle gpios ins panel driver
Date: Wed, 13 Feb 2013 19:52:10 +0530
Message-ID: <1360765345-19312-19-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40237 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757028Ab3BMOYI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:08 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The nec-nl8048hl11-01 panel driver leaves gpio configurations to the
platform_enable and disable calls in the platform's board file. These should
happen in the panel driver itself.

Create a platform data struct for the panel, this contains the gpio numbers
used by the panel driver, this struct will be passed to the panel driver as
platform data. The driver will request and configure these gpios rather than
leaving it to platform callbacks in board files.

This will help in removing the need for the panel drivers to have platform
related callbacks.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   45 +++++++++++++++-----
 include/video/omap-panel-data.h                    |   10 +++++
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index c197927..3b85e2a 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -20,8 +20,10 @@
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/fb.h>
+#include <linux/gpio.h>
 
 #include <video/omapdss.h>
+#include <video/omap-panel-data.h>
 
 #define LCD_XRES		800
 #define LCD_YRES		480
@@ -31,9 +33,6 @@
  */
 #define LCD_PIXEL_CLOCK		23800
 
-struct nec_8048_data {
-};
-
 static const struct {
 	unsigned char addr;
 	unsigned char dat;
@@ -82,30 +81,46 @@ static struct omap_video_timings nec_8048_panel_timings = {
 	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_RISING_EDGE,
 };
 
+static inline struct panel_nec_nl8048_data
+*get_panel_data(const struct omap_dss_device *dssdev)
+{
+	return (struct panel_nec_nl8048_data *) dssdev->data;
+}
+
 static int nec_8048_panel_probe(struct omap_dss_device *dssdev)
 {
-	struct nec_8048_data *necd;
+	struct panel_nec_nl8048_data *pd = get_panel_data(dssdev);
+	int r;
+
+	if (!pd)
+		return -EINVAL;
 
 	dssdev->panel.timings = nec_8048_panel_timings;
 
-	necd = kzalloc(sizeof(*necd), GFP_KERNEL);
-	if (!necd)
-		return -ENOMEM;
+	if (gpio_is_valid(pd->qvga_gpio)) {
+		r = devm_gpio_request_one(&dssdev->dev, pd->qvga_gpio,
+				GPIOF_OUT_INIT_HIGH, "lcd QVGA");
+		if (r)
+			return r;
+	}
 
-	dev_set_drvdata(&dssdev->dev, necd);
+	if (gpio_is_valid(pd->res_gpio)) {
+		r = devm_gpio_request_one(&dssdev->dev, pd->res_gpio,
+				GPIOF_OUT_INIT_LOW, "lcd RES");
+		if (r)
+			return r;
+	}
 
 	return 0;
 }
 
 static void nec_8048_panel_remove(struct omap_dss_device *dssdev)
 {
-	struct nec_8048_data *necd = dev_get_drvdata(&dssdev->dev);
-
-	kfree(necd);
 }
 
 static int nec_8048_panel_power_on(struct omap_dss_device *dssdev)
 {
+	struct panel_nec_nl8048_data *pd = get_panel_data(dssdev);
 	int r;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
@@ -124,6 +139,9 @@ static int nec_8048_panel_power_on(struct omap_dss_device *dssdev)
 			goto err1;
 	}
 
+	if (gpio_is_valid(pd->res_gpio))
+		gpio_set_value_cansleep(pd->res_gpio, 1);
+
 	return 0;
 err1:
 	omapdss_dpi_display_disable(dssdev);
@@ -133,9 +151,14 @@ err0:
 
 static void nec_8048_panel_power_off(struct omap_dss_device *dssdev)
 {
+	struct panel_nec_nl8048_data *pd = get_panel_data(dssdev);
+
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
 
+	if (gpio_is_valid(pd->res_gpio))
+		gpio_set_value_cansleep(pd->res_gpio, 0);
+
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index 6faf0c7..e7698e2 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -125,4 +125,14 @@ struct panel_acx565akm_data {
 	int reset_gpio;
 };
 
+/**
+ * nec nl8048 panel driver configuration data
+ * @res_gpio: reset signal
+ * @qvga_gpio: selection for resolution(QVGA/WVGA)
+ */
+struct panel_nec_nl8048_data {
+	int res_gpio;
+	int qvga_gpio;
+};
+
 #endif /* __OMAP_PANEL_DATA_H */
-- 
1.7.9.5

