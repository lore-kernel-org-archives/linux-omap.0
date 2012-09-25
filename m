From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 02/18] OMAPDSS: DISPC: Simplify function names for setting pipeline input and output sizes
Date: Tue, 25 Sep 2012 11:49:37 +0530
Message-ID: <1348553993-8083-3-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60554 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753105Ab2IYGUF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:20:05 -0400
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The DISPC pipeline register names in the TRM for setting the buffer size and
the output size are a bit misleading, for example, there are different register
names for setting the buffer size for VID and GFX pipes. Things get more
confusing when considering writeback pipeline.

Rename the functions so that they tell whether they are configuring the input
to the scalar or the output. These will be extended later to support writeback
registers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index cd3d532..2c01e13 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -705,7 +705,8 @@ static void dispc_ovl_set_pos(enum omap_plane plane, int x, int y)
 	dispc_write_reg(DISPC_OVL_POSITION(plane), val);
 }
 
-static void dispc_ovl_set_pic_size(enum omap_plane plane, int width, int height)
+static void dispc_ovl_set_input_size(enum omap_plane plane, int width,
+		int height)
 {
 	u32 val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
 
@@ -715,7 +716,8 @@ static void dispc_ovl_set_pic_size(enum omap_plane plane, int width, int height)
 		dispc_write_reg(DISPC_OVL_PICTURE_SIZE(plane), val);
 }
 
-static void dispc_ovl_set_vid_size(enum omap_plane plane, int width, int height)
+static void dispc_ovl_set_output_size(enum omap_plane plane, int width,
+		int height)
 {
 	u32 val;
 
@@ -2384,13 +2386,14 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 
 	dispc_ovl_set_pos(plane, oi->pos_x, pos_y);
 
-	dispc_ovl_set_pic_size(plane, in_width, in_height);
+	dispc_ovl_set_input_size(plane, in_width, in_height);
 
 	if (ovl->caps & OMAP_DSS_OVL_CAP_SCALE) {
 		dispc_ovl_set_scaling(plane, in_width, in_height, out_width,
 				   out_height, ilace, five_taps, fieldmode,
 				   oi->color_mode, oi->rotation);
-		dispc_ovl_set_vid_size(plane, out_width, out_height);
+
+		dispc_ovl_set_output_size(plane, out_width, out_height);
 		dispc_ovl_set_vid_color_conv(plane, cconv);
 	}
 
-- 
1.7.9.5

