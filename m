From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 18/18] OMAPDSS: DISPC: Configure color conversion coefficients for writeback
Date: Tue, 25 Sep 2012 11:49:53 +0530
Message-ID: <1348553993-8083-19-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48619 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245Ab2IYGUv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:20:51 -0400
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Writeback pipeline receives RGB data from one of the overlays or one of the
overlay managers. If the target color mode is YUV422 or NV12, we need to convert
the RGB pixels to YUV. The scaler in WB then converts it to the target color
mode.

Hence, the color conversion coefficients that need to be programmed are the ones
which convert a RGB24 pixel to YUV444. Program these coefficients for writeback
pipeline.

Rearrange the code a bit to configure different coefficients for overlays and
writeback.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   61 +++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 034ecb5..1f03690 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -236,6 +236,11 @@ static const struct {
 	},
 };
 
+struct color_conv_coef {
+	int ry, rcr, rcb, gy, gcr, gcb, by, bcr, bcb;
+	int full_range;
+};
+
 static void _omap_dispc_set_irqs(void);
 static unsigned long dispc_plane_pclk_rate(enum omap_plane plane);
 static unsigned long dispc_plane_lclk_rate(enum omap_plane plane);
@@ -674,41 +679,41 @@ static void dispc_ovl_set_scale_coef(enum omap_plane plane, int fir_hinc,
 	}
 }
 
-static void _dispc_setup_color_conv_coef(void)
-{
-	int i;
-	const struct color_conv_coef {
-		int  ry,  rcr,  rcb,   gy,  gcr,  gcb,   by,  bcr,  bcb;
-		int  full_range;
-	}  ctbl_bt601_5 = {
-		298,  409,    0,  298, -208, -100,  298,    0,  517, 0,
-	};
-
-	const struct color_conv_coef *ct;
 
+static void dispc_ovl_write_color_conv_coef(enum omap_plane plane,
+		const struct color_conv_coef *ct)
+{
 #define CVAL(x, y) (FLD_VAL(x, 26, 16) | FLD_VAL(y, 10, 0))
 
-	ct = &ctbl_bt601_5;
+	dispc_write_reg(DISPC_OVL_CONV_COEF(plane, 0), CVAL(ct->rcr, ct->ry));
+	dispc_write_reg(DISPC_OVL_CONV_COEF(plane, 1), CVAL(ct->gy,  ct->rcb));
+	dispc_write_reg(DISPC_OVL_CONV_COEF(plane, 2), CVAL(ct->gcb, ct->gcr));
+	dispc_write_reg(DISPC_OVL_CONV_COEF(plane, 3), CVAL(ct->bcr, ct->by));
+	dispc_write_reg(DISPC_OVL_CONV_COEF(plane, 4), CVAL(0, ct->bcb));
 
-	for (i = 1; i < dss_feat_get_num_ovls(); i++) {
-		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 0),
-			CVAL(ct->rcr, ct->ry));
-		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 1),
-			CVAL(ct->gy,  ct->rcb));
-		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 2),
-			CVAL(ct->gcb, ct->gcr));
-		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 3),
-			CVAL(ct->bcr, ct->by));
-		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 4),
-			CVAL(0, ct->bcb));
-
-		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(i), ct->full_range,
-			11, 11);
-	}
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), ct->full_range, 11, 11);
 
 #undef CVAL
 }
 
+static void dispc_setup_color_conv_coef(void)
+{
+	int i;
+	int num_ovl = dss_feat_get_num_ovls();
+	int num_wb = dss_feat_get_num_wbs();
+	const struct color_conv_coef ctbl_bt601_5_ovl = {
+		298, 409, 0, 298, -208, -100, 298, 0, 517, 0,
+	};
+	const struct color_conv_coef ctbl_bt601_5_wb = {
+		66, 112, -38, 129, -94, -74, 25, -18, 112, 0,
+	};
+
+	for (i = 1; i < num_ovl; i++)
+		dispc_ovl_write_color_conv_coef(i, &ctbl_bt601_5_ovl);
+
+	for (; i < num_wb; i++)
+		dispc_ovl_write_color_conv_coef(i, &ctbl_bt601_5_wb);
+}
 
 static void dispc_ovl_set_ba0(enum omap_plane plane, u32 paddr)
 {
@@ -3973,7 +3978,7 @@ static void _omap_dispc_initial_config(void)
 	if (dss_has_feature(FEAT_FUNCGATED))
 		REG_FLD_MOD(DISPC_CONFIG, 1, 9, 9);
 
-	_dispc_setup_color_conv_coef();
+	dispc_setup_color_conv_coef();
 
 	dispc_set_loadmode(OMAP_DSS_LOAD_FRAME_ONLY);
 
-- 
1.7.9.5

