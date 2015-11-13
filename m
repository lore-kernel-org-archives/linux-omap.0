From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 1/2] video:omap2:dss: fix timings for VENC to match what omapdrm expects
Date: Fri, 13 Nov 2015 11:29:07 +0100
Message-ID: <20ebf7491377ccba18c734c22ae9f361d7fdc165.1447410544.git.hns@goldelico.com>
References: <cover.1447410543.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447410543.git.hns@goldelico.com>
In-Reply-To: <cover.1447410543.git.hns@goldelico.com>
References: <cover.1447410543.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, gta04-owner@goldelico.com, notasas@gmail.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Otherwise check_timings fails and we get a "has no modes" message
from xrandr.

This fix makes the venc assume PAL and NTSC timings that match the
timings synthetized by copy_timings_drm_to_omap() from omapdrm
mode settings so that check_timings() succeeds.

Tested on: BeagleBoard XM, GTA04 and OpenPandora

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/video/fbdev/omap2/dss/venc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/venc.c b/drivers/video/fbdev/omap2/dss/venc.c
index 99ca268..d05a549 100644
--- a/drivers/video/fbdev/omap2/dss/venc.c
+++ b/drivers/video/fbdev/omap2/dss/venc.c
@@ -275,6 +275,12 @@ const struct omap_video_timings omap_dss_pal_timings = {
 	.vbp		= 41,
 
 	.interlace	= true,
+
+	.hsync_level = OMAPDSS_SIG_ACTIVE_LOW,
+	.vsync_level = OMAPDSS_SIG_ACTIVE_LOW,
+	.data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE,
+	.de_level = OMAPDSS_SIG_ACTIVE_HIGH,
+	.sync_pclk_edge = OMAPDSS_DRIVE_SIG_FALLING_EDGE,
 };
 EXPORT_SYMBOL(omap_dss_pal_timings);
 
@@ -290,6 +296,12 @@ const struct omap_video_timings omap_dss_ntsc_timings = {
 	.vbp		= 31,
 
 	.interlace	= true,
+
+	.hsync_level = OMAPDSS_SIG_ACTIVE_LOW,
+	.vsync_level = OMAPDSS_SIG_ACTIVE_LOW,
+	.data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE,
+	.de_level = OMAPDSS_SIG_ACTIVE_HIGH,
+	.sync_pclk_edge = OMAPDSS_DRIVE_SIG_FALLING_EDGE,
 };
 EXPORT_SYMBOL(omap_dss_ntsc_timings);
 
-- 
2.5.1
