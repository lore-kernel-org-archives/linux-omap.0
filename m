From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] video: fbdev: omapfb_main: Mark expected switch fall-throughs
Date: Fri, 2 Aug 2019 14:15:42 -0500
Message-ID: <20190802191542.GA32751@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>
List-Id: linux-omap@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: omap1_defconfig arm):

drivers/video/fbdev/omap/omapfb_main.c:449:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1549:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1547:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1545:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1543:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1540:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1538:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1535:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 90eca64e3144..702cca59bda1 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -447,6 +447,7 @@ static int set_color_mode(struct omapfb_plane_struct *plane,
 		return 0;
 	case 12:
 		var->bits_per_pixel = 16;
+		/* fall through */
 	case 16:
 		if (plane->fbdev->panel->bpp == 12)
 			plane->color_mode = OMAPFB_COLOR_RGB444;
@@ -1534,20 +1535,27 @@ static void omapfb_free_resources(struct omapfb_device *fbdev, int state)
 	case OMAPFB_ACTIVE:
 		for (i = 0; i < fbdev->mem_desc.region_cnt; i++)
 			unregister_framebuffer(fbdev->fb_info[i]);
+		/* fall through */
 	case 7:
 		omapfb_unregister_sysfs(fbdev);
+		/* fall through */
 	case 6:
 		if (fbdev->panel->disable)
 			fbdev->panel->disable(fbdev->panel);
+		/* fall through */
 	case 5:
 		omapfb_set_update_mode(fbdev, OMAPFB_UPDATE_DISABLED);
+		/* fall through */
 	case 4:
 		planes_cleanup(fbdev);
+		/* fall through */
 	case 3:
 		ctrl_cleanup(fbdev);
+		/* fall through */
 	case 2:
 		if (fbdev->panel->cleanup)
 			fbdev->panel->cleanup(fbdev->panel);
+		/* fall through */
 	case 1:
 		dev_set_drvdata(fbdev->dev, NULL);
 		kfree(fbdev);
-- 
2.22.0
