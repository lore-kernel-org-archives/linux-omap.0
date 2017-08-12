From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] omapfb: constify omap_video_timings structures
Date: Sat, 12 Aug 2017 08:20:36 +0200
Message-ID: <1502518836-27189-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: kernel-janitors@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

These omap_video_timings structures are only copied into other
structures, so they can be const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c |    2 +-
 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c
index f14691c..6cd759c 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c
@@ -18,7 +18,7 @@
 
 #include <video/omapfb_dss.h>
 
-static struct omap_video_timings lb035q02_timings = {
+static const struct omap_video_timings lb035q02_timings = {
 	.x_res = 320,
 	.y_res = 240,
 
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
index b529a8c..57e9e14 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
@@ -41,7 +41,7 @@ struct panel_drv_data {
 	struct spi_device *spi_dev;
 };
 
-static struct omap_video_timings td028ttec1_panel_timings = {
+static const struct omap_video_timings td028ttec1_panel_timings = {
 	.x_res		= 480,
 	.y_res		= 640,
 	.pixelclock	= 22153000,
