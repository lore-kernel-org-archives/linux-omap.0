From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 18/29] OMAPDSS: DISPC: Make chroma_upscale an argument to dispc_plane_setup
Date: Tue, 27 Dec 2011 18:07:01 +0530
Message-ID: <1324989432-3625-19-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52229 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab1L0Mjk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Dec 2011 07:39:40 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Pass chroma_upscale boolean parameter to dispc_plane_setup(), this will be set
to true when dispc_plane_setup() is called from dispc_ovl_setup() and false when
called from dispc_wb_setup().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index eca6157..21d6286 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1789,7 +1789,7 @@ static int dispc_plane_setup(enum omap_plane plane, enum omap_channel channel,
 		u16 out_width, u16 out_height, enum omap_color_mode color_mode,
 		u8 rotation, bool mirror, u8 zorder, u8 pre_mult_alpha,
 		u8 global_alpha, enum omap_dss_rotation_type rotation_type,
-		bool ilace, bool replication)
+		bool chroma_upscale, bool ilace, bool replication)
 {
 	bool five_taps = true;
 	bool fieldmode = 0;
@@ -1887,10 +1887,9 @@ static int dispc_plane_setup(enum omap_plane plane, enum omap_channel channel,
 	dispc_ovl_set_pic_size(plane, width, height);
 
 	if (caps & OMAP_DSS_OVL_CAP_SCALE) {
-		dispc_ovl_set_scaling(plane, width, height,
-				   outw, outh,
-				   ilace, five_taps, fieldmode,
-				   color_mode, rotation, true);
+		dispc_ovl_set_scaling(plane, width, height, outw, outh,
+				ilace, five_taps, fieldmode, color_mode,
+				rotation, chroma_upscale);
 		dispc_ovl_set_vid_size(plane, outw, outh);
 		dispc_ovl_set_vid_color_conv(plane, cconv);
 	}
@@ -1911,6 +1910,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 {
 	int r;
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
+	const bool chroma_upscale = true;
 	enum omap_channel channel;
 
 	channel = dispc_ovl_get_channel_out(plane);
@@ -1927,7 +1927,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 		oi->width, oi->height, oi->out_width, oi->out_height,
 		oi->color_mode, oi->rotation, oi->mirror, oi->zorder,
 		oi->pre_mult_alpha, oi->global_alpha, oi->rotation_type,
-		ilace, replication);
+		chroma_upscale, ilace, replication);
 
 	return r;
 }
-- 
1.7.4.1

