From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH] OMAPDSS: DISPC: Update Accumulator configuration for chroma plane
Date: Tue, 15 May 2012 13:34:47 +0530
Message-ID: <1337069087-21121-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54348 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757892Ab2EOIFF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 04:05:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

DISPC has two accumulator registers DISPC_VIDp_ACCU_0 and DISPC_VIDp_ACCU_1 each
with horizontal and vertical bit fields. The bit fields can take values in the
range of -1024 to 1023. Based on bit field values DISPC decides on which one out
of 8 phases the filtering starts. DISPC_VIDp_ACCU_0 is used for progressive
output and for interlaced output both DISPC_VIDp_ACCU_0 and DISPC_VIDp_ACCU_1
are used.

The current accumulator values in DISPC scaling logic for chroma plane takes
default values for all color modes and rotation types. So, the horizontal and
vertical up and downsampling accumulator bit field values have been updated for
better performance.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   92 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ee30937..ad779d9 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1185,6 +1185,92 @@ static void dispc_ovl_set_scale_param(enum omap_plane plane,
 	dispc_ovl_set_fir(plane, fir_hinc, fir_vinc, color_comp);
 }
 
+static void dispc_ovl_set_accu_uv(enum omap_plane plane,
+		u16 orig_width,	u16 orig_height, u16 out_width, u16 out_height,
+		bool ilace, enum omap_color_mode color_mode, u8 rotation)
+{
+	int h_accu2_0, h_accu2_1;
+	int v_accu2_0, v_accu2_1;
+	int chroma_hinc, chroma_vinc;
+	int idx;
+
+	struct accu {
+		s8 h0_m, h0_n;
+		s8 h1_m, h1_n;
+		s8 v0_m, v0_n;
+		s8 v1_m, v1_n;
+	};
+
+	const struct accu *accu_table;
+	const struct accu *accu_val;
+
+	static const struct accu accu_nv12[4] = {
+		{  0, 1,  0, 1 , -1, 2, 0, 1 },
+		{  1, 2, -3, 4 ,  0, 1, 0, 1 },
+		{ -1, 1,  0, 1 , -1, 2, 0, 1 },
+		{ -1, 2, -1, 2 , -1, 1, 0, 1 },
+	};
+
+	static const struct accu accu_nv12_ilace[4] = {
+		{  0, 1,  0, 1 , -3, 4, -1, 4 },
+		{ -1, 4, -3, 4 ,  0, 1,  0, 1 },
+		{ -1, 1,  0, 1 , -1, 4, -3, 4 },
+		{ -3, 4, -3, 4 , -1, 1,  0, 1 },
+	};
+
+	static const struct accu accu_yuv[4] = {
+		{  0, 1, 0, 1,  0, 1, 0, 1 },
+		{  0, 1, 0, 1,  0, 1, 0, 1 },
+		{ -1, 1, 0, 1,  0, 1, 0, 1 },
+		{  0, 1, 0, 1, -1, 1, 0, 1 },
+	};
+
+	switch (rotation) {
+	case OMAP_DSS_ROT_0:
+		idx = 0;
+		break;
+	case OMAP_DSS_ROT_90:
+		idx = 1;
+		break;
+	case OMAP_DSS_ROT_180:
+		idx = 2;
+		break;
+	case OMAP_DSS_ROT_270:
+		idx = 3;
+		break;
+	default:
+		BUG();
+	}
+
+	switch (color_mode) {
+	case OMAP_DSS_COLOR_NV12:
+		if (ilace)
+			accu_table = accu_nv12_ilace;
+		else
+			accu_table = accu_nv12;
+		break;
+	case OMAP_DSS_COLOR_YUV2:
+	case OMAP_DSS_COLOR_UYVY:
+		accu_table = accu_yuv;
+		break;
+	default:
+		BUG();
+	}
+
+	accu_val = &accu_table[idx];
+
+	chroma_hinc = 1024 * orig_width / out_width;
+	chroma_vinc = 1024 * orig_height / out_height;
+
+	h_accu2_0 = (accu_val->h0_m * chroma_hinc / accu_val->h0_n) % 1024;
+	h_accu2_1 = (accu_val->h1_m * chroma_hinc / accu_val->h1_n) % 1024;
+	v_accu2_0 = (accu_val->v0_m * chroma_vinc / accu_val->v0_n) % 1024;
+	v_accu2_1 = (accu_val->v1_m * chroma_vinc / accu_val->v1_n) % 1024;
+
+	dispc_ovl_set_vid_accu2_0(plane, h_accu2_0, v_accu2_0);
+	dispc_ovl_set_vid_accu2_1(plane, h_accu2_1, v_accu2_1);
+}
+
 static void dispc_ovl_set_scaling_common(enum omap_plane plane,
 		u16 orig_width, u16 orig_height,
 		u16 out_width, u16 out_height,
@@ -1249,6 +1335,9 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 	int scale_x = out_width != orig_width;
 	int scale_y = out_height != orig_height;
 
+	dispc_ovl_set_accu_uv(plane, orig_width, orig_height, out_width,
+			out_height, ilace, color_mode, rotation);
+
 	if (!dss_has_feature(FEAT_HANDLE_UV_SEPARATE))
 		return;
 	if ((color_mode != OMAP_DSS_COLOR_YUV2 &&
@@ -1297,9 +1386,6 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), scale_x ? 1 : 0, 5, 5);
 	/* set V scaling */
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), scale_y ? 1 : 0, 6, 6);
-
-	dispc_ovl_set_vid_accu2_0(plane, 0x80, 0);
-	dispc_ovl_set_vid_accu2_1(plane, 0x80, 0);
 }
 
 static void dispc_ovl_set_scaling(enum omap_plane plane,
-- 
1.7.1

