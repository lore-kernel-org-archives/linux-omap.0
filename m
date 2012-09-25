From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 12/18] OMAPDSS: DISPC: Don't set chroma resampling bit for writeback
Date: Tue, 25 Sep 2012 11:49:47 +0530
Message-ID: <1348553993-8083-13-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60581 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172Ab2IYGUc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:20:32 -0400
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The bit YUVCHROMARESAMPLING isn't there for writeback in DISPC_WB_ATTRIBUTES2.
It isn't there because we don't upsample chroma like for video pipelines, we
downsample chroma in writeback to get YUV422 or NV12 formats from the YUV444
input.

Ignore this bit in dispc_ovl_set_scaling_uv() if the plane is OMAP_DSS_WB.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 4f36e83..d9ca7bf 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1468,7 +1468,8 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 			color_mode != OMAP_DSS_COLOR_UYVY &&
 			color_mode != OMAP_DSS_COLOR_NV12)) {
 		/* reset chroma resampling for RGB formats  */
-		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane), 0, 8, 8);
+		if (plane != OMAP_DSS_WB)
+			REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane), 0, 8, 8);
 		return;
 	}
 
@@ -1520,8 +1521,10 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 			out_width, out_height, five_taps,
 				rotation, DISPC_COLOR_COMPONENT_UV);
 
-	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane),
-		(scale_x || scale_y) ? 1 : 0, 8, 8);
+	if (plane != OMAP_DSS_WB)
+		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane),
+			(scale_x || scale_y) ? 1 : 0, 8, 8);
+
 	/* set H scaling */
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), scale_x ? 1 : 0, 5, 5);
 	/* set V scaling */
-- 
1.7.9.5

