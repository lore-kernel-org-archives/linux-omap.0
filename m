From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm: omapdrm: remove unused variable
Date: Fri,  9 Jun 2017 12:31:03 +0200
Message-ID: <20170609103143.3095325-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Removing the default display name left a harmless warning:

fbdev/omap2/omapfb/dss/core.c: In function 'omap_dss_probe':
fbdev/omap2/omapfb/dss/core.c:196:30: error: unused variable 'pdata' [-Werror=unused-variable]

This removes the now-unused variable as well.

Fixes: 278cba7eaf54 ("drm: omapdrm: Remove unused default display name support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/omap2/omapfb/dss/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index eecf695c16f4..09e5bb013d28 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -193,7 +193,6 @@ static struct notifier_block omap_dss_pm_notif_block = {
 
 static int __init omap_dss_probe(struct platform_device *pdev)
 {
-	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	int r;
 
 	core.pdev = pdev;
-- 
2.9.0
