From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/3] OMAPDSS: Panel NEC: Get rid of nec_80848_data structure
Date: Wed, 16 Jan 2013 13:45:08 +0100
Message-ID: <1358340309-8774-3-git-send-email-peter.ujfalusi@ti.com>
References: <1358340309-8774-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358340309-8774-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

It has only a pointer to the backlight_device in it. We can just add the
pointer to the backlight_device as driver data.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      | 32 +++++-----------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index f43a343..e6589fe 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -32,10 +32,6 @@
  */
 #define LCD_PIXEL_CLOCK		23800
 
-struct nec_8048_data {
-	struct backlight_device *bl;
-};
-
 static const struct {
 	unsigned char addr;
 	unsigned char dat;
@@ -118,30 +114,21 @@ static const struct backlight_ops nec_8048_bl_ops = {
 static int nec_8048_panel_probe(struct omap_dss_device *dssdev)
 {
 	struct backlight_device *bl;
-	struct nec_8048_data *necd;
 	struct backlight_properties props;
 	int r;
 
 	dssdev->panel.timings = nec_8048_panel_timings;
 
-	necd = kzalloc(sizeof(*necd), GFP_KERNEL);
-	if (!necd)
-		return -ENOMEM;
-
-	dev_set_drvdata(&dssdev->dev, necd);
-
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.max_brightness = 255;
 	props.type = BACKLIGHT_RAW;
 
 	bl = backlight_device_register("nec-8048", &dssdev->dev, dssdev,
 			&nec_8048_bl_ops, &props);
-	if (IS_ERR(bl)) {
-		r = PTR_ERR(bl);
-		kfree(necd);
-		return r;
-	}
-	necd->bl = bl;
+	if (IS_ERR(bl))
+		return PTR_ERR(bl);
+
+	dev_set_drvdata(&dssdev->dev, bl);
 
 	bl->props.fb_blank = FB_BLANK_UNBLANK;
 	bl->props.power = FB_BLANK_UNBLANK;
@@ -157,21 +144,17 @@ static int nec_8048_panel_probe(struct omap_dss_device *dssdev)
 
 static void nec_8048_panel_remove(struct omap_dss_device *dssdev)
 {
-	struct nec_8048_data *necd = dev_get_drvdata(&dssdev->dev);
-	struct backlight_device *bl = necd->bl;
+	struct backlight_device *bl = dev_get_drvdata(&dssdev->dev);
 
 	bl->props.power = FB_BLANK_POWERDOWN;
 	nec_8048_bl_update_status(bl);
 	backlight_device_unregister(bl);
-
-	kfree(necd);
 }
 
 static int nec_8048_panel_power_on(struct omap_dss_device *dssdev)
 {
+	struct backlight_device *bl = dev_get_drvdata(&dssdev->dev);
 	int r;
-	struct nec_8048_data *necd = dev_get_drvdata(&dssdev->dev);
-	struct backlight_device *bl = necd->bl;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
@@ -202,8 +185,7 @@ err0:
 
 static void nec_8048_panel_power_off(struct omap_dss_device *dssdev)
 {
-	struct nec_8048_data *necd = dev_get_drvdata(&dssdev->dev);
-	struct backlight_device *bl = necd->bl;
+	struct backlight_device *bl = dev_get_drvdata(&dssdev->dev);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
-- 
1.8.1
