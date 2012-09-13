From: Archit Taneja <archit@ti.com>
Subject: [PATCH 21/21] OMAPDSS: DISPC: Configure color conversion coefficients for writeback
Date: Thu, 13 Sep 2012 17:45:05 +0530
Message-ID: <1347538505-25359-22-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39538 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757983Ab2IMMQG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 08:16:06 -0400
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Writeback pipeline receives RGB data from one of the overlays or one of the
overlay managers. If the target color mode is YUV422 or NV12, we need to convert
the RGB pixels to YUV. The scalar in WB then converts it to the target color
mode.

Hence, the color conversion coefficients that need to be programmed are the ones
which convert a RGB24 pixel to YUV444. Program these coefficients for writeback
pipeline.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 1623c9b..5811a18 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -681,20 +681,30 @@ static void dispc_plane_set_scale_coef(enum omap_plane plane, int fir_hinc,
 static void _dispc_setup_color_conv_coef(void)
 {
 	int i;
+	int num_ovl = dss_feat_get_num_ovls();
+	int num_wb = dss_feat_get_num_wbs();
+
 	const struct color_conv_coef {
 		int  ry,  rcr,  rcb,   gy,  gcr,  gcb,   by,  bcr,  bcb;
 		int  full_range;
-	}  ctbl_bt601_5 = {
-		298,  409,    0,  298, -208, -100,  298,    0,  517, 0,
+	}  ctbl_bt601_5[2] = {
+		{ 298,  409, 0, 298, -208, -100, 298, 0, 517, 0, },
+		{ 66, 112, -38, 129, -94, -74, 25, -18, 112, 0, },
 	};
 
 	const struct color_conv_coef *ct;
 
 #define CVAL(x, y) (FLD_VAL(x, 26, 16) | FLD_VAL(y, 10, 0))
+#define YUVTORGB 0
+#define RGBTOYUV 1
 
-	ct = &ctbl_bt601_5;
+	ct = &ctbl_bt601_5[YUVTORGB];
+
+	for (i = 1; i < num_ovl + num_wb; i++) {
+
+		if (i >= num_ovl)
+			ct = &ctbl_bt601_5[RGBTOYUV];
 
-	for (i = 1; i < dss_feat_get_num_ovls(); i++) {
 		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 0),
 			CVAL(ct->rcr, ct->ry));
 		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 1),
@@ -710,6 +720,8 @@ static void _dispc_setup_color_conv_coef(void)
 			11, 11);
 	}
 
+#undef RGBTOYUV
+#undef YUVTORGB
 #undef CVAL
 }
 
-- 
1.7.9.5

