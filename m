From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 6/9] OMAP: DSS2: Add method for querying display dimensions from DSS drivers
Date: Thu, 31 Mar 2011 13:11:03 +0300
Message-ID: <1301566266-11187-7-git-send-email-tomi.valkeinen@ti.com>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57646 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933885Ab1CaKLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 06:11:35 -0400
In-Reply-To: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Jani Nikula <ext-jani.1.nikula@nokia.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Add get_dimensions() to struct omap_dss_driver. Use the call, if supported
by the driver, in OMAPFB.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    2 ++
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   12 ++++++++++--
 drivers/video/omap2/omapfb/omapfb-main.c  |   12 ++++++++++--
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index e10cfe2..f6e4b87 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -507,6 +507,8 @@ struct omap_dss_driver {
 
 	void (*get_resolution)(struct omap_dss_device *dssdev,
 			u16 *xres, u16 *yres);
+	void (*get_dimensions)(struct omap_dss_device *dssdev,
+			u32 *width, u32 *height);
 	int (*get_recommended_bpp)(struct omap_dss_device *dssdev);
 
 	int (*check_timings)(struct omap_dss_device *dssdev,
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 6f43545..b4636b1 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -895,8 +895,16 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 
 		p.display_info.xres = xres;
 		p.display_info.yres = yres;
-		p.display_info.width = 0;
-		p.display_info.height = 0;
+
+		if (display->driver->get_dimensions) {
+			u32 w, h;
+			display->driver->get_dimensions(display, &w, &h);
+			p.display_info.width = w;
+			p.display_info.height = h;
+		} else {
+			p.display_info.width = 0;
+			p.display_info.height = 0;
+		}
 
 		if (copy_to_user((void __user *)arg, &p.display_info,
 					sizeof(p.display_info)))
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 505ec66..163fb8b 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -702,8 +702,16 @@ int check_fb_var(struct fb_info *fbi, struct fb_var_screeninfo *var)
 			var->xres, var->yres,
 			var->xres_virtual, var->yres_virtual);
 
-	var->height             = -1;
-	var->width              = -1;
+	if (display && display->driver->get_dimensions) {
+		u32 w, h;
+		display->driver->get_dimensions(display, &w, &h);
+		var->width = DIV_ROUND_CLOSEST(w, 1000);
+		var->height = DIV_ROUND_CLOSEST(h, 1000);
+	} else {
+		var->height = -1;
+		var->width = -1;
+	}
+
 	var->grayscale          = 0;
 
 	if (display && display->driver->get_timings) {
-- 
1.7.1

