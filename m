From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 20/20] OMAPDSS: Taal: remove rotate & mirror support
Date: Fri, 8 Mar 2013 13:51:55 +0200
Message-ID: <1362743515-10152-21-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56473 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933492Ab3CHLwd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:33 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Taal panel driver has support to set rotation and mirroring. However,
these features cannot be used without causing tearing, and are never
used. The code is just extra bloat, so let's remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |  170 +----------------------------
 1 file changed, 2 insertions(+), 168 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 038a815..bc4c95e 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -76,8 +76,6 @@ struct taal_data {
 
 	/* runtime variables */
 	bool enabled;
-	u8 rotate;
-	bool mirror;
 
 	bool te_enabled;
 
@@ -202,49 +200,6 @@ static int taal_get_id(struct taal_data *td, u8 *id1, u8 *id2, u8 *id3)
 	return 0;
 }
 
-static int taal_set_addr_mode(struct taal_data *td, u8 rotate, bool mirror)
-{
-	int r;
-	u8 mode;
-	int b5, b6, b7;
-
-	r = taal_dcs_read_1(td, MIPI_DCS_GET_ADDRESS_MODE, &mode);
-	if (r)
-		return r;
-
-	switch (rotate) {
-	default:
-	case 0:
-		b7 = 0;
-		b6 = 0;
-		b5 = 0;
-		break;
-	case 1:
-		b7 = 0;
-		b6 = 1;
-		b5 = 1;
-		break;
-	case 2:
-		b7 = 1;
-		b6 = 1;
-		b5 = 0;
-		break;
-	case 3:
-		b7 = 1;
-		b6 = 0;
-		b5 = 1;
-		break;
-	}
-
-	if (mirror)
-		b6 = !b6;
-
-	mode &= ~((1<<7) | (1<<6) | (1<<5));
-	mode |= (b7 << 7) | (b6 << 6) | (b5 << 5);
-
-	return taal_dcs_write_1(td, MIPI_DCS_SET_ADDRESS_MODE, mode);
-}
-
 static int taal_set_update_window(struct taal_data *td,
 		u16 x, u16 y, u16 w, u16 h)
 {
@@ -455,15 +410,8 @@ static const struct backlight_ops taal_bl_ops = {
 static void taal_get_resolution(struct omap_dss_device *dssdev,
 		u16 *xres, u16 *yres)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-
-	if (td->rotate == 0 || td->rotate == 2) {
-		*xres = dssdev->panel.timings.x_res;
-		*yres = dssdev->panel.timings.y_res;
-	} else {
-		*yres = dssdev->panel.timings.x_res;
-		*xres = dssdev->panel.timings.y_res;
-	}
+	*xres = dssdev->panel.timings.x_res;
+	*yres = dssdev->panel.timings.y_res;
 }
 
 static ssize_t taal_num_errors_show(struct device *dev,
@@ -1025,10 +973,6 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		goto err;
 
-	r = taal_set_addr_mode(td, td->rotate, td->mirror);
-	if (r)
-		goto err;
-
 	if (!td->cabc_broken) {
 		r = taal_dcs_write_1(td, DCS_WRITE_CABC, td->cabc_mode);
 		if (r)
@@ -1340,112 +1284,6 @@ static int taal_get_te(struct omap_dss_device *dssdev)
 	return r;
 }
 
-static int taal_rotate(struct omap_dss_device *dssdev, u8 rotate)
-{
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	u16 dw, dh;
-	int r;
-
-	dev_dbg(&dssdev->dev, "rotate %d\n", rotate);
-
-	mutex_lock(&td->lock);
-
-	if (td->rotate == rotate)
-		goto end;
-
-	dsi_bus_lock(dssdev);
-
-	if (td->enabled) {
-		r = taal_wake_up(dssdev);
-		if (r)
-			goto err;
-
-		r = taal_set_addr_mode(td, rotate, td->mirror);
-		if (r)
-			goto err;
-	}
-
-	if (rotate == 0 || rotate == 2) {
-		dw = dssdev->panel.timings.x_res;
-		dh = dssdev->panel.timings.y_res;
-	} else {
-		dw = dssdev->panel.timings.y_res;
-		dh = dssdev->panel.timings.x_res;
-	}
-
-	omapdss_dsi_set_size(dssdev, dw, dh);
-
-	td->rotate = rotate;
-
-	dsi_bus_unlock(dssdev);
-end:
-	mutex_unlock(&td->lock);
-	return 0;
-err:
-	dsi_bus_unlock(dssdev);
-	mutex_unlock(&td->lock);
-	return r;
-}
-
-static u8 taal_get_rotate(struct omap_dss_device *dssdev)
-{
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	int r;
-
-	mutex_lock(&td->lock);
-	r = td->rotate;
-	mutex_unlock(&td->lock);
-
-	return r;
-}
-
-static int taal_mirror(struct omap_dss_device *dssdev, bool enable)
-{
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	int r;
-
-	dev_dbg(&dssdev->dev, "mirror %d\n", enable);
-
-	mutex_lock(&td->lock);
-
-	if (td->mirror == enable)
-		goto end;
-
-	dsi_bus_lock(dssdev);
-	if (td->enabled) {
-		r = taal_wake_up(dssdev);
-		if (r)
-			goto err;
-
-		r = taal_set_addr_mode(td, td->rotate, enable);
-		if (r)
-			goto err;
-	}
-
-	td->mirror = enable;
-
-	dsi_bus_unlock(dssdev);
-end:
-	mutex_unlock(&td->lock);
-	return 0;
-err:
-	dsi_bus_unlock(dssdev);
-	mutex_unlock(&td->lock);
-	return r;
-}
-
-static bool taal_get_mirror(struct omap_dss_device *dssdev)
-{
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	int r;
-
-	mutex_lock(&td->lock);
-	r = td->mirror;
-	mutex_unlock(&td->lock);
-
-	return r;
-}
-
 static int taal_run_test(struct omap_dss_device *dssdev, int test_num)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
@@ -1679,10 +1517,6 @@ static struct omap_dss_driver taal_driver = {
 	.enable_te	= taal_enable_te,
 	.get_te		= taal_get_te,
 
-	.set_rotate	= taal_rotate,
-	.get_rotate	= taal_get_rotate,
-	.set_mirror	= taal_mirror,
-	.get_mirror	= taal_get_mirror,
 	.run_test	= taal_run_test,
 	.memory_read	= taal_memory_read,
 
-- 
1.7.10.4

