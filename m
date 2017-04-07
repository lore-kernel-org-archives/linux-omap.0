From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] fbdev: omapfb: delete check_required_callbacks()
Date: Fri,  7 Apr 2017 22:04:07 +0300
Message-ID: <20170407190407.30265-1-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Commit 561eb9d09a93 ("fbdev: omap/lcd: Make callbacks optional") made
panel callbacks optional but forgot to update check_required_callbacks().
As a result many (all?) OMAP systems using omapfb will crash at boot.
Fix by deleting the whole function.

Fixes: 561eb9d09a93 ("fbdev: omap/lcd: Make callbacks optional")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/video/fbdev/omap/omapfb_main.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 1abba07..f4cbfb3 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1608,19 +1608,6 @@ static int omapfb_find_ctrl(struct omapfb_device *fbdev)
 	return 0;
 }
 
-static void check_required_callbacks(struct omapfb_device *fbdev)
-{
-#define _C(x) (fbdev->ctrl->x != NULL)
-#define _P(x) (fbdev->panel->x != NULL)
-	BUG_ON(fbdev->ctrl == NULL || fbdev->panel == NULL);
-	BUG_ON(!(_C(init) && _C(cleanup) && _C(get_caps) &&
-		 _C(set_update_mode) && _C(setup_plane) && _C(enable_plane) &&
-		 _P(init) && _P(cleanup) && _P(enable) && _P(disable) &&
-		 _P(get_caps)));
-#undef _P
-#undef _C
-}
-
 /*
  * Called by LDM binding to probe and attach a new device.
  * Initialization sequence:
@@ -1705,8 +1692,6 @@ static int omapfb_do_probe(struct platform_device *pdev,
 		omapfb_ops.fb_mmap = omapfb_mmap;
 	init_state++;
 
-	check_required_callbacks(fbdev);
-
 	r = planes_init(fbdev);
 	if (r)
 		goto cleanup;
-- 
2.9.2
