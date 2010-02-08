From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 03/17] OMAP: DSS2: move run_test()
Date: Mon,  8 Feb 2010 17:57:27 +0200
Message-ID: <1265644661-3694-4-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-3-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45835 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab0BHPzT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:19 -0500
In-Reply-To: <1265644661-3694-3-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Move run_test() from omap_dss_device to omap_dss_driver.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    1 -
 drivers/video/omap2/displays/panel-taal.c |   12 +++++++--
 drivers/video/omap2/dss/dsi.c             |   38 -----------------------------
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    8 +++---
 4 files changed, 13 insertions(+), 46 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 8c3688b..7c6413a 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -498,7 +498,6 @@ struct omap_dss_device {
 	bool (*get_mirror)(struct omap_dss_device *dssdev);
 	int (*set_mirror)(struct omap_dss_device *dssdev, bool enable);
 
-	int (*run_test)(struct omap_dss_device *dssdev, int test);
 	int (*memory_read)(struct omap_dss_device *dssdev,
 			void *buf, size_t size,
 			u16 x, u16 y, u16 w, u16 h);
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 0aaaa8a..e6d0954 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -820,17 +820,23 @@ static int taal_run_test(struct omap_dss_device *dssdev, int test_num)
 	u8 id1, id2, id3;
 	int r;
 
+	dsi_bus_lock();
+
 	r = taal_dcs_read_1(DCS_GET_ID1, &id1);
 	if (r)
-		return r;
+		goto err;
 	r = taal_dcs_read_1(DCS_GET_ID2, &id2);
 	if (r)
-		return r;
+		goto err;
 	r = taal_dcs_read_1(DCS_GET_ID3, &id3);
 	if (r)
-		return r;
+		goto err;
 
+	dsi_bus_unlock();
 	return 0;
+err:
+	dsi_bus_unlock();
+	return r;
 }
 
 static int taal_memory_read(struct omap_dss_device *dssdev,
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a6ea8c8..f7d494e 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3582,43 +3582,6 @@ static bool dsi_display_get_mirror(struct omap_dss_device *dssdev)
 	return dssdev->driver->get_mirror(dssdev);
 }
 
-static int dsi_display_run_test(struct omap_dss_device *dssdev, int test_num)
-{
-	int r;
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
-		return -EIO;
-
-	DSSDBGF("%d", test_num);
-
-	dsi_bus_lock();
-
-	/* run test first in low speed mode */
-	omapdss_dsi_vc_enable_hs(0, 0);
-
-	if (dssdev->driver->run_test) {
-		r = dssdev->driver->run_test(dssdev, test_num);
-		if (r)
-			goto end;
-	}
-
-	/* then in high speed */
-	omapdss_dsi_vc_enable_hs(0, 1);
-
-	if (dssdev->driver->run_test) {
-		r = dssdev->driver->run_test(dssdev, test_num);
-		if (r)
-			goto end;
-	}
-
-end:
-	omapdss_dsi_vc_enable_hs(0, 1);
-
-	dsi_bus_unlock();
-
-	return r;
-}
-
 static int dsi_display_memory_read(struct omap_dss_device *dssdev,
 		void *buf, size_t size,
 		u16 x, u16 y, u16 w, u16 h)
@@ -3681,7 +3644,6 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 	dssdev->get_mirror = dsi_display_get_mirror;
 	dssdev->set_mirror = dsi_display_set_mirror;
 
-	dssdev->run_test = dsi_display_run_test;
 	dssdev->memory_read = dsi_display_memory_read;
 
 	/* XXX these should be figured out dynamically */
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 56e3ec2..b5657be 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -721,12 +721,12 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 			r = -EFAULT;
 			break;
 		}
-		if (!display || !display->run_test) {
+		if (!display || !display->driver->run_test) {
 			r = -EINVAL;
 			break;
 		}
 
-		r = display->run_test(display, p.test_num);
+		r = display->driver->run_test(display, p.test_num);
 
 		break;
 
@@ -736,12 +736,12 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 			r = -EFAULT;
 			break;
 		}
-		if (!display || !display->run_test) {
+		if (!display || !display->driver->run_test) {
 			r = -EINVAL;
 			break;
 		}
 
-		r = display->run_test(display, p.test_num);
+		r = display->driver->run_test(display, p.test_num);
 
 		break;
 
-- 
1.6.5

