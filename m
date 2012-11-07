From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/3] OMAPDSS: DISPC: Use output width and height to calculate row/pix inc for writeback
Date: Wed, 7 Nov 2012 11:45:04 +0530
Message-ID: <1352268905-31093-4-git-send-email-archit@ti.com>
References: <1352268905-31093-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41457 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2KGGPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 01:15:41 -0500
In-Reply-To: <1352268905-31093-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

When calculating row and pixel increments for graphics and video pipes, we need
to consider the dimensions of the input frame to know how to read from the
buffer. Hence, we need to calculate these parameters from the input to the
pipeline.

For writeback, the row and pixel increments need to be calculated based on the
output of the writeback pipeline, i.e, the dimensions of the frame after
scaling. Ensure that dispc driver uses values of out_width and out_height when
calling calc_dma/calc_tiler_rotation_offset.

For graphics and video pipes, the original code passed the original height as
frame_height to calc_dma_rotation_offset, and not the predecimated height. This
is left as it is for now. We need to figure out why pre decimated height isn't
needed.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 664ac6f..db14f20 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2381,7 +2381,7 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 	unsigned offset0, offset1;
 	s32 row_inc;
 	s32 pix_inc;
-	u16 frame_height = height;
+	u16 frame_width, frame_height;
 	unsigned int field_offset = 0;
 	u16 in_height = height;
 	u16 in_width = width;
@@ -2449,20 +2449,28 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 	row_inc = 0;
 	pix_inc = 0;
 
+	if (plane == OMAP_DSS_WB) {
+		frame_width = out_width;
+		frame_height = out_height;
+	} else {
+		frame_width = in_width;
+		frame_height = height;
+	}
+
 	if (rotation_type == OMAP_DSS_ROT_TILER)
-		calc_tiler_rotation_offset(screen_width, in_width,
+		calc_tiler_rotation_offset(screen_width, frame_width,
 				color_mode, fieldmode, field_offset,
 				&offset0, &offset1, &row_inc, &pix_inc,
 				x_predecim, y_predecim);
 	else if (rotation_type == OMAP_DSS_ROT_DMA)
-		calc_dma_rotation_offset(rotation, mirror,
-				screen_width, in_width, frame_height,
+		calc_dma_rotation_offset(rotation, mirror, screen_width,
+				frame_width, frame_height,
 				color_mode, fieldmode, field_offset,
 				&offset0, &offset1, &row_inc, &pix_inc,
 				x_predecim, y_predecim);
 	else
 		calc_vrfb_rotation_offset(rotation, mirror,
-				screen_width, in_width, frame_height,
+				screen_width, frame_width, frame_height,
 				color_mode, fieldmode, field_offset,
 				&offset0, &offset1, &row_inc, &pix_inc,
 				x_predecim, y_predecim);
-- 
1.7.9.5

