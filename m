From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 7/8] OMAPDSS: DISPC: Configure doublestride for NV12 when using 2D Tiler buffers
Date: Tue, 26 Mar 2013 19:15:24 +0530
Message-ID: <1364305525-28496-8-git-send-email-archit@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com>
 <1364305525-28496-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35682 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934405Ab3CZNqr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Mar 2013 09:46:47 -0400
In-Reply-To: <1364305525-28496-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, robdclark@gmail.com, andy.gross@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>

When using a DISPC video pipeline to a fetch a NV12 buffer in a 2D container, we
need to set set a doublestride bit in the video pipe's ATTRIBUTES register. This
is needed because the stride for the UV plane(using a 16 bit Tiler container) is
double the stride for the Y plane(using a 8 bit Tiler container) for the 0 or
180 degree views. The ROW_INC register is meant for the Y plane, and the HW will
calculate the row increment needed for the UV plane by using double the stride
value based on whether this bit is set or not.

Set the bit when we are using a 2D Tiler buffer and when rotation is 0 or 180
degrees. The stride value is the same for 90 and 270 degree Tiler views, hence
the bit shouldn't be set.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 73a730a..ddbf031 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1588,6 +1588,7 @@ static void dispc_ovl_set_scaling(enum omap_plane plane,
 }
 
 static void dispc_ovl_set_rotation_attrs(enum omap_plane plane, u8 rotation,
+		enum omap_dss_rotation_type rotation_type,
 		bool mirroring, enum omap_color_mode color_mode)
 {
 	bool row_repeat = false;
@@ -1638,6 +1639,15 @@ static void dispc_ovl_set_rotation_attrs(enum omap_plane plane, u8 rotation,
 	if (dss_has_feature(FEAT_ROWREPEATENABLE))
 		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane),
 			row_repeat ? 1 : 0, 18, 18);
+
+	if (color_mode == OMAP_DSS_COLOR_NV12) {
+		bool doublestride = (rotation_type == OMAP_DSS_ROT_TILER) &&
+					(rotation == OMAP_DSS_ROT_0 ||
+					rotation == OMAP_DSS_ROT_180);
+		/* DOUBLESTRIDE */
+		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), doublestride, 22, 22);
+	}
+
 }
 
 static int color_mode_to_bpp(enum omap_color_mode color_mode)
@@ -2516,7 +2526,8 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 		dispc_ovl_set_vid_color_conv(plane, cconv);
 	}
 
-	dispc_ovl_set_rotation_attrs(plane, rotation, mirror, color_mode);
+	dispc_ovl_set_rotation_attrs(plane, rotation, rotation_type, mirror,
+			color_mode);
 
 	dispc_ovl_set_zorder(plane, caps, zorder);
 	dispc_ovl_set_pre_mult_alpha(plane, caps, pre_mult_alpha);
-- 
1.7.10.4

