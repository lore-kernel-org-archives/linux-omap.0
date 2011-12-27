From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 14/29] OMAPDSS: DISPC: Allow both upscaling and downscaling of chroma
Date: Tue, 27 Dec 2011 18:06:57 +0530
Message-ID: <1324989432-3625-15-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58048 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab1L0MjP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:39:15 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Make the function dispc_ovl_set_scaling_uv() take a boolean argument which tells
if we want to upscale or downscale the chroma plane.

Downscaling of chroma is required by writeback pipeline for converting the input
YUV444 color format to YUV422 or NV12.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 231369a..dfbb39b 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1219,7 +1219,7 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 		u16 out_width, u16 out_height,
 		bool ilace, bool five_taps,
 		bool fieldmode, enum omap_color_mode color_mode,
-		u8 rotation)
+		u8 rotation, bool chroma_upscale)
 {
 	int scale_x = out_width != orig_width;
 	int scale_y = out_height != orig_height;
@@ -1236,9 +1236,11 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 	switch (color_mode) {
 	case OMAP_DSS_COLOR_NV12:
 		/* UV is subsampled by 2 vertically*/
-		orig_height >>= 1;
+		orig_height = chroma_upscale ?
+			orig_height >> 1 : orig_height << 1;
 		/* UV is subsampled by 2 horz.*/
-		orig_width >>= 1;
+		orig_width = chroma_upscale ?
+			orig_width >> 1 : orig_width << 1;
 		break;
 	case OMAP_DSS_COLOR_YUV2:
 	case OMAP_DSS_COLOR_UYVY:
@@ -1248,7 +1250,8 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 		if (rotation == OMAP_DSS_ROT_0 ||
 			rotation == OMAP_DSS_ROT_180)
 			/* UV is subsampled by 2 hrz*/
-			orig_width >>= 1;
+			orig_width = chroma_upscale ?
+				orig_width >> 1 : orig_width << 1;
 		/* must use FIR for YUV422 if rotated */
 		if (rotation != OMAP_DSS_ROT_0)
 			scale_x = scale_y = true;
@@ -1282,7 +1285,7 @@ static void dispc_ovl_set_scaling(enum omap_plane plane,
 		u16 out_width, u16 out_height,
 		bool ilace, bool five_taps,
 		bool fieldmode, enum omap_color_mode color_mode,
-		u8 rotation)
+		u8 rotation, bool chroma_upscale)
 {
 	BUG_ON(plane == OMAP_DSS_GFX);
 
@@ -1298,7 +1301,7 @@ static void dispc_ovl_set_scaling(enum omap_plane plane,
 		out_width, out_height,
 		ilace, five_taps,
 		fieldmode, color_mode,
-		rotation);
+		rotation, chroma_upscale);
 }
 
 static void dispc_ovl_set_rotation_attrs(enum omap_plane plane, u8 rotation,
@@ -1888,7 +1891,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 		dispc_ovl_set_scaling(plane, oi->width, oi->height,
 				   outw, outh,
 				   ilace, five_taps, fieldmode,
-				   oi->color_mode, oi->rotation);
+				   oi->color_mode, oi->rotation, true);
 		dispc_ovl_set_vid_size(plane, outw, outh);
 		dispc_ovl_set_vid_color_conv(plane, cconv);
 	}
-- 
1.7.4.1

