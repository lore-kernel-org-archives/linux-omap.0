From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V2 1/2] OMAPDSS: DISPC: Update Fir Coefficients
Date: Mon, 19 Dec 2011 14:03:44 +0530
Message-ID: <1324283624-6421-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51784 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab1LSIdu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 03:33:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The FIR coefficients present in kernel are being updated to new coefficients
consisting of 24 coefficient tables, with 12 each for 3 tap and 5 tap scenario,
which are chosen on the basis of DISPC up/downsampling filters M value. M is
the inverse of low pass cut off frequency of the sampling filter. For vertical
scaling 3 tap or 5 tap tables are used based on the clock rate and width of
the line buffer whereas in OMAP2 3 tap is always used. For horizontal scaling
however 5 tap tables are always used.

New coefficients and the corresponding logic have been tested on OMAP2, OMAP3
and OMAP4. Horizontal and vertical scaling worked fine except for some 3 tap
vs 5 tap issue during vertical upscaling and clock failing issues which is
acknowledged in the next patch. Vertical upscaling was found to perform better
under 5 taps. The 24 coefficient tables have been moved to another file
dispc_coefs.c for proper maintainance.

This code is written based on code written by Lajos Molnar <lajos@ti.com> in
Android Kernel for scaling. Lajos Molnar <lajos@ti.com> had fine tuned the FIR
coefficient selection process and reduced outliness and blockiness around
images when upscaling more than 2 times.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/Makefile      |    2 +-
 drivers/video/omap2/dss/dispc.c       |  135 ++------------
 drivers/video/omap2/dss/dispc.h       |   11 +
 drivers/video/omap2/dss/dispc_coefs.c |  326 +++++++++++++++++++++++++++++++++
 4 files changed, 356 insertions(+), 118 deletions(-)
 create mode 100644 drivers/video/omap2/dss/dispc_coefs.c

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index bd34ac5..f10d56f 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_OMAP2_DSS) += omapdss.o
-omapdss-y := core.o dss.o dss_features.o dispc.o display.o manager.o overlay.o
+omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o manager.o overlay.o
 omapdss-$(CONFIG_OMAP2_DSS_DPI) += dpi.o
 omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
 omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 6892cfd..b981983 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -63,22 +63,6 @@ struct omap_dispc_isr_data {
 	u32			mask;
 };
 
-struct dispc_h_coef {
-	s8 hc4;
-	s8 hc3;
-	u8 hc2;
-	s8 hc1;
-	s8 hc0;
-};
-
-struct dispc_v_coef {
-	s8 vc22;
-	s8 vc2;
-	u8 vc1;
-	s8 vc0;
-	s8 vc00;
-};
-
 enum omap_burst_size {
 	BURST_SIZE_X2 = 0,
 	BURST_SIZE_X4 = 1,
@@ -532,105 +516,27 @@ static void dispc_ovl_write_firv2_reg(enum omap_plane plane, int reg, u32 value)
 	dispc_write_reg(DISPC_OVL_FIR_COEF_V2(plane, reg), value);
 }
 
-static void dispc_ovl_set_scale_coef(enum omap_plane plane, int hscaleup,
-				  int vscaleup, int five_taps,
-				  enum omap_color_component color_comp)
-{
-	/* Coefficients for horizontal up-sampling */
-	static const struct dispc_h_coef coef_hup[8] = {
-		{  0,   0, 128,   0,  0 },
-		{ -1,  13, 124,  -8,  0 },
-		{ -2,  30, 112, -11, -1 },
-		{ -5,  51,  95, -11, -2 },
-		{  0,  -9,  73,  73, -9 },
-		{ -2, -11,  95,  51, -5 },
-		{ -1, -11, 112,  30, -2 },
-		{  0,  -8, 124,  13, -1 },
-	};
-
-	/* Coefficients for vertical up-sampling */
-	static const struct dispc_v_coef coef_vup_3tap[8] = {
-		{ 0,  0, 128,  0, 0 },
-		{ 0,  3, 123,  2, 0 },
-		{ 0, 12, 111,  5, 0 },
-		{ 0, 32,  89,  7, 0 },
-		{ 0,  0,  64, 64, 0 },
-		{ 0,  7,  89, 32, 0 },
-		{ 0,  5, 111, 12, 0 },
-		{ 0,  2, 123,  3, 0 },
-	};
-
-	static const struct dispc_v_coef coef_vup_5tap[8] = {
-		{  0,   0, 128,   0,  0 },
-		{ -1,  13, 124,  -8,  0 },
-		{ -2,  30, 112, -11, -1 },
-		{ -5,  51,  95, -11, -2 },
-		{  0,  -9,  73,  73, -9 },
-		{ -2, -11,  95,  51, -5 },
-		{ -1, -11, 112,  30, -2 },
-		{  0,  -8, 124,  13, -1 },
-	};
-
-	/* Coefficients for horizontal down-sampling */
-	static const struct dispc_h_coef coef_hdown[8] = {
-		{   0, 36, 56, 36,  0 },
-		{   4, 40, 55, 31, -2 },
-		{   8, 44, 54, 27, -5 },
-		{  12, 48, 53, 22, -7 },
-		{  -9, 17, 52, 51, 17 },
-		{  -7, 22, 53, 48, 12 },
-		{  -5, 27, 54, 44,  8 },
-		{  -2, 31, 55, 40,  4 },
-	};
-
-	/* Coefficients for vertical down-sampling */
-	static const struct dispc_v_coef coef_vdown_3tap[8] = {
-		{ 0, 36, 56, 36, 0 },
-		{ 0, 40, 57, 31, 0 },
-		{ 0, 45, 56, 27, 0 },
-		{ 0, 50, 55, 23, 0 },
-		{ 0, 18, 55, 55, 0 },
-		{ 0, 23, 55, 50, 0 },
-		{ 0, 27, 56, 45, 0 },
-		{ 0, 31, 57, 40, 0 },
-	};
-
-	static const struct dispc_v_coef coef_vdown_5tap[8] = {
-		{   0, 36, 56, 36,  0 },
-		{   4, 40, 55, 31, -2 },
-		{   8, 44, 54, 27, -5 },
-		{  12, 48, 53, 22, -7 },
-		{  -9, 17, 52, 51, 17 },
-		{  -7, 22, 53, 48, 12 },
-		{  -5, 27, 54, 44,  8 },
-		{  -2, 31, 55, 40,  4 },
-	};
-
-	const struct dispc_h_coef *h_coef;
-	const struct dispc_v_coef *v_coef;
+static void dispc_ovl_set_scale_coef(enum omap_plane plane, int fir_hinc,
+				int fir_vinc, int five_taps,
+				enum omap_color_component color_comp)
+{
+	const struct dispc_coef *h_coef, *v_coef;
 	int i;
 
-	if (hscaleup)
-		h_coef = coef_hup;
-	else
-		h_coef = coef_hdown;
-
-	if (vscaleup)
-		v_coef = five_taps ? coef_vup_5tap : coef_vup_3tap;
-	else
-		v_coef = five_taps ? coef_vdown_5tap : coef_vdown_3tap;
+	h_coef = dispc_ovl_get_scale_coef(fir_hinc, true);
+	v_coef = dispc_ovl_get_scale_coef(fir_vinc, five_taps);
 
 	for (i = 0; i < 8; i++) {
 		u32 h, hv;
 
-		h = FLD_VAL(h_coef[i].hc0, 7, 0)
-			| FLD_VAL(h_coef[i].hc1, 15, 8)
-			| FLD_VAL(h_coef[i].hc2, 23, 16)
-			| FLD_VAL(h_coef[i].hc3, 31, 24);
-		hv = FLD_VAL(h_coef[i].hc4, 7, 0)
-			| FLD_VAL(v_coef[i].vc0, 15, 8)
-			| FLD_VAL(v_coef[i].vc1, 23, 16)
-			| FLD_VAL(v_coef[i].vc2, 31, 24);
+		h = FLD_VAL(h_coef[i].hc0_vc00, 7, 0)
+			| FLD_VAL(h_coef[i].hc1_vc0, 15, 8)
+			| FLD_VAL(h_coef[i].hc2_vc1, 23, 16)
+			| FLD_VAL(h_coef[i].hc3_vc2, 31, 24);
+		hv = FLD_VAL(h_coef[i].hc4_vc22, 7, 0)
+			| FLD_VAL(v_coef[i].hc1_vc0, 15, 8)
+			| FLD_VAL(v_coef[i].hc2_vc1, 23, 16)
+			| FLD_VAL(v_coef[i].hc3_vc2, 31, 24);
 
 		if (color_comp == DISPC_COLOR_COMPONENT_RGB_Y) {
 			dispc_ovl_write_firh_reg(plane, i, h);
@@ -645,8 +551,8 @@ static void dispc_ovl_set_scale_coef(enum omap_plane plane, int hscaleup,
 	if (five_taps) {
 		for (i = 0; i < 8; i++) {
 			u32 v;
-			v = FLD_VAL(v_coef[i].vc00, 7, 0)
-				| FLD_VAL(v_coef[i].vc22, 15, 8);
+			v = FLD_VAL(v_coef[i].hc0_vc00, 7, 0)
+				| FLD_VAL(v_coef[i].hc4_vc22, 15, 8);
 			if (color_comp == DISPC_COLOR_COMPONENT_RGB_Y)
 				dispc_ovl_write_firv_reg(plane, i, v);
 			else
@@ -1168,17 +1074,12 @@ static void dispc_ovl_set_scale_param(enum omap_plane plane,
 		enum omap_color_component color_comp)
 {
 	int fir_hinc, fir_vinc;
-	int hscaleup, vscaleup;
-
-	hscaleup = orig_width <= out_width;
-	vscaleup = orig_height <= out_height;
-
-	dispc_ovl_set_scale_coef(plane, hscaleup, vscaleup, five_taps,
-			color_comp);
 
 	fir_hinc = 1024 * orig_width / out_width;
 	fir_vinc = 1024 * orig_height / out_height;
 
+	dispc_ovl_set_scale_coef(plane, fir_hinc, fir_vinc, five_taps,
+				color_comp);
 	dispc_ovl_set_fir(plane, fir_hinc, fir_vinc, color_comp);
 }
 
diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index c06efc3..5836bd1 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -97,6 +97,17 @@
 #define DISPC_OVL_PRELOAD(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_PRELOAD_OFFSET(n))
 
+/* DISPC up/downsampling FIR filter coefficient structure */
+struct dispc_coef {
+	s8 hc4_vc22;
+	s8 hc3_vc2;
+	u8 hc2_vc1;
+	s8 hc1_vc0;
+	s8 hc0_vc00;
+};
+
+const struct dispc_coef *dispc_ovl_get_scale_coef(int inc, int five_taps);
+
 /* DISPC manager/channel specific registers */
 static inline u16 DISPC_DEFAULT_COLOR(enum omap_channel channel)
 {
diff --git a/drivers/video/omap2/dss/dispc_coefs.c b/drivers/video/omap2/dss/dispc_coefs.c
new file mode 100644
index 0000000..069bccb
--- /dev/null
+++ b/drivers/video/omap2/dss/dispc_coefs.c
@@ -0,0 +1,326 @@
+/*
+ * linux/drivers/video/omap2/dss/dispc_coefs.c
+ *
+ * Copyright (C) 2011 Texas Instruments
+ * Author: Chandrabhanu Mahapatra <cmahapatra@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/kernel.h>
+#include <video/omapdss.h>
+#include "dispc.h"
+
+#define ARRAY_LEN(array) (sizeof(array) / sizeof(array[0]))
+
+static const struct dispc_coef coef3_M8[8] = {
+	{ 0,  0, 128,  0, 0 },
+	{ 0, -4, 123,  9, 0 },
+	{ 0, -4, 108, 87, 0 },
+	{ 0, -2,  87, 43, 0 },
+	{ 0, 64,  64,  0, 0 },
+	{ 0, 43,  87, -2, 0 },
+	{ 0, 24, 108, -4, 0 },
+	{ 0,  9, 123, -4, 0 },
+};
+
+static const struct dispc_coef coef3_M9[8] = {
+	{ 0,  6, 116,  6, 0 },
+	{ 0,  0, 112, 16, 0 },
+	{ 0, -2, 100, 30, 0 },
+	{ 0, -2,  83, 47, 0 },
+	{ 0, 64,  64,  0, 0 },
+	{ 0, 47,  83, -2, 0 },
+	{ 0, 30, 100, -2, 0 },
+	{ 0, 16, 112,  0, 0 },
+};
+
+static const struct dispc_coef coef3_M10[8] = {
+	{ 0, 10, 108, 10, 0 },
+	{ 0,  3, 104, 21, 0 },
+	{ 0,  0,  94, 34, 0 },
+	{ 0, -1,  80, 49, 0 },
+	{ 0, 64,  64,  0, 0 },
+	{ 0, 49,  80, -1, 0 },
+	{ 0, 34,  94,  0, 0 },
+	{ 0, 21, 104,  3, 0 },
+};
+
+static const struct dispc_coef coef3_M11[8] = {
+	{ 0, 14, 100, 14, 0 },
+	{ 0,  6,  98, 24, 0 },
+	{ 0,  2,  90, 36, 0 },
+	{ 0,  0,  78, 50, 0 },
+	{ 0, 64,  64,  0, 0 },
+	{ 0, 50,  78,  0, 0 },
+	{ 0, 36,  90,  2, 0 },
+	{ 0, 24,  98,  6, 0 },
+};
+
+static const struct dispc_coef coef3_M12[8] = {
+	{ 0, 16,  96, 16, 0 },
+	{ 0,  9,  93, 26, 0 },
+	{ 0,  4,  86, 38, 0 },
+	{ 0,  1,  76, 51, 0 },
+	{ 0, 64,  64,  0, 0 },
+	{ 0, 51,  76,  1, 0 },
+	{ 0, 38,  86,  4, 0 },
+	{ 0, 26,  93,  9, 0 },
+};
+
+static const struct dispc_coef coef3_M13[8] = {
+	{ 0, 18,  92, 18, 0 },
+	{ 0, 10,  90, 28, 0 },
+	{ 0,  5,  83, 40, 0 },
+	{ 0,  1,  75, 52, 0 },
+	{ 0, 64,  64,  0, 0 },
+	{ 0, 52,  75,  1, 0 },
+	{ 0, 40,  83,  5, 0 },
+	{ 0, 28,  90, 10, 0 },
+};
+
+static const struct dispc_coef coef3_M14[8] = {
+	{ 0, 20, 88, 20, 0 },
+	{ 0, 12, 86, 30, 0 },
+	{ 0,  6, 81, 41, 0 },
+	{ 0,  2, 74, 52, 0 },
+	{ 0, 64, 64,  0, 0 },
+	{ 0, 52, 74,  2, 0 },
+	{ 0, 41, 81,  6, 0 },
+	{ 0, 30, 86, 12, 0 },
+};
+
+static const struct dispc_coef coef3_M16[8] = {
+	{ 0, 22, 84, 22, 0 },
+	{ 0, 14, 82, 32, 0 },
+	{ 0,  8, 78, 42, 0 },
+	{ 0,  3, 72, 53, 0 },
+	{ 0, 64, 64,  0, 0 },
+	{ 0, 53, 72,  3, 0 },
+	{ 0, 42, 78,  8, 0 },
+	{ 0, 32, 82, 14, 0 },
+};
+
+static const struct dispc_coef coef3_M19[8] = {
+	{ 0, 24, 80, 24, 0 },
+	{ 0, 16, 79, 33, 0 },
+	{ 0,  9, 76, 43, 0 },
+	{ 0,  4, 70, 54, 0 },
+	{ 0, 64, 64,  0, 0 },
+	{ 0, 54, 70,  4, 0 },
+	{ 0, 43, 76,  9, 0 },
+	{ 0, 33, 79, 16, 0 },
+};
+
+static const struct dispc_coef coef3_M22[8] = {
+	{ 0, 25, 78, 25, 0 },
+	{ 0, 17, 77, 34, 0 },
+	{ 0, 10, 74, 44, 0 },
+	{ 0,  5, 69, 54, 0 },
+	{ 0, 64, 64,  0, 0 },
+	{ 0, 54, 69,  5, 0 },
+	{ 0, 44, 74, 10, 0 },
+	{ 0, 34, 77, 17, 0 },
+};
+
+static const struct dispc_coef coef3_M26[8] = {
+	{ 0, 26, 76, 26, 0 },
+	{ 0, 19, 74, 35, 0 },
+	{ 0, 11, 72, 45, 0 },
+	{ 0,  5, 69, 54, 0 },
+	{ 0, 64, 64,  0, 0 },
+	{ 0, 54, 69,  5, 0 },
+	{ 0, 45, 72, 11, 0 },
+	{ 0, 35, 74, 19, 0 },
+};
+
+static const struct dispc_coef coef3_M32[8] = {
+	{ 0, 27, 74, 27, 0 },
+	{ 0, 19, 73, 36, 0 },
+	{ 0, 12, 71, 45, 0 },
+	{ 0,  6, 68, 54, 0 },
+	{ 0, 64, 64,  0, 0 },
+	{ 0, 54, 68,  6, 0 },
+	{ 0, 45, 71, 12, 0 },
+	{ 0, 36, 73, 19, 0 },
+};
+
+static const struct dispc_coef coef5_M8[8] = {
+	{   0,   0, 128,   0,   0 },
+	{  -2,  14, 125, -10,   1 },
+	{  -6,  33, 114, -15,   2 },
+	{ -10,  55,  98, -16,   1 },
+	{   0, -14,  78,  78, -14 },
+	{   1, -16,  98,  55, -10 },
+	{   2, -15, 114,  33,  -6 },
+	{   1, -10, 125,  14,  -2 },
+};
+
+static const struct dispc_coef coef5_M9[8] = {
+	{  -3,  10, 114,  10,  -3 },
+	{  -6,  24, 110,   0,  -1 },
+	{  -8,  40, 103,  -7,   0 },
+	{ -11,  58,  91, -11,   1 },
+	{   0, -12,  76,  76, -12 },
+	{   1, -11,  91,  58, -11 },
+	{   0,  -7, 103,  40,  -8 },
+	{  -1,   0, 111,  24,  -6 },
+};
+
+static const struct dispc_coef coef5_M10[8] = {
+	{  -4,  18, 100,  18,  -4 },
+	{  -6,  30,  99,   8,  -3 },
+	{  -8,  44,  93,   0,  -1 },
+	{  -9,  58,  84,  -5,   0 },
+	{   0,  -8,  72,  72,  -8 },
+	{   0,  -5,  84,  58,  -9 },
+	{  -1,   0,  93,  44,  -8 },
+	{  -3,   8,  99,  30,  -6 },
+};
+
+static const struct dispc_coef coef5_M11[8] = {
+	{  -5,  23,  92,  23,  -5 },
+	{  -6,  34,  90,  13,  -3 },
+	{  -6,  45,  85,   6,  -2 },
+	{  -6,  57,  78,   0,  -1 },
+	{   0,  -4,  68,  68,  -4 },
+	{  -1,   0,  78,  57,  -6 },
+	{  -2,   6,  85,  45,  -6 },
+	{  -3,  13,  90,  34,  -6 },
+};
+
+static const struct dispc_coef coef5_M12[8] = {
+	{  -4,  26,  84,  26,  -4 },
+	{  -5,  36,  82,  18,  -3 },
+	{  -4,  46,  78,  10,  -2 },
+	{  -3,  55,  72,   5,  -1 },
+	{   0,   0,  64,  64,   0 },
+	{  -1,   5,  72,  55,  -3 },
+	{  -2,  10,  78,  46,  -4 },
+	{  -3,  18,  82,  36,  -5 },
+};
+
+static const struct dispc_coef coef5_M13[8] = {
+	{  -3,  28,  78,  28,  -3 },
+	{  -3,  37,  76,  21,  -3 },
+	{  -2,  45,  73,  14,  -2 },
+	{   0,  53,  68,   8,  -1 },
+	{   0,   3,  61,  61,   3 },
+	{  -1,   8,  68,  53,   0 },
+	{  -2,  14,  73,  45,  -2 },
+	{  -3,  21,  76,  37,  -3 },
+};
+
+static const struct dispc_coef coef5_M14[8] = {
+	{  -2,  30,  72,  30,  -2 },
+	{  -1,  37,  71,  23,  -2 },
+	{   0,  45,  69,  16,  -2 },
+	{   3,  52,  64,  10,  -1 },
+	{   0,   6,  58,  58,   6 },
+	{  -1,  10,  64,  52,   3 },
+	{  -2,  16,  69,  45,   0 },
+	{  -2,  23,  71,  37,  -1 },
+};
+
+static const struct dispc_coef coef5_M16[8] = {
+	{   0,  31,  66,  31,   0 },
+	{   1,  38,  65,  25,  -1 },
+	{   3,  44,  62,  20,  -1 },
+	{   6,  49,  59,  14,   0 },
+	{   0,  10,  54,  54,  10 },
+	{   0,  14,  59,  49,   6 },
+	{  -1,  20,  62,  44,   3 },
+	{  -1,  25,  65,  38,   1 },
+};
+
+static const struct dispc_coef coef5_M19[8] = {
+	{   3,  32,  58,  32,   3 },
+	{   4,  38,  58,  27,   1 },
+	{   7,  42,  55,  23,   1 },
+	{  10,  46,  54,  18,   0 },
+	{   0,  14,  50,  50,  14 },
+	{   0,  18,  54,  46,  10 },
+	{   1,  23,  55,  42,   7 },
+	{   1,  27,  58,  38,   4 },
+};
+
+static const struct dispc_coef coef5_M22[8] = {
+	{   4,  33,  54,  33,   4 },
+	{   6,  37,  54,  28,   3 },
+	{   9,  41,  53,  24,   1 },
+	{  12,  45,  51,  20,   0 },
+	{   0,  16,  48,  48,  16 },
+	{   0,  20,  51,  45,  12 },
+	{   1,  24,  53,  41,   9 },
+	{   3,  28,  54,  37,   6 },
+};
+
+static const struct dispc_coef coef5_M26[8] = {
+	{   6,  33,  50,  33,   6 },
+	{   8,  36,  51,  29,   4 },
+	{  11,  40,  50,  25,   2 },
+	{  14,  43,  48,  22,   1 },
+	{   0,  18,  46,  46,  18 },
+	{   1,  22,  48,  43,  14 },
+	{   2,  25,  50,  40,  11 },
+	{   4,  29,  51,  36,   8 },
+};
+
+static const struct dispc_coef coef5_M32[8] = {
+	{   7,  33,  48,  33,   7 },
+	{  10,  36,  48,  29,   5 },
+	{  13,  39,  47,  26,   3 },
+	{  16,  42,  46,  23,   1 },
+	{   0,  19,  45,  45,  19 },
+	{   1,  23,  46,  42,  16 },
+	{   3,  26,  47,  39,  13 },
+	{   5,  29,  48,  36,  10 },
+};
+
+const struct dispc_coef *dispc_ovl_get_scale_coef(int inc, int five_taps)
+{
+	int i;
+	static const struct {
+		int Mmin;
+		int Mmax;
+		const struct dispc_coef *coef_3;
+		const struct dispc_coef *coef_5;
+	} coefs[] = {
+		{ 27, 32, coef3_M32, coef5_M32 },
+		{ 23, 26, coef3_M26, coef5_M26 },
+		{ 20, 22, coef3_M22, coef5_M22 },
+		{ 17, 19, coef3_M19, coef5_M19 },
+		{ 15, 16, coef3_M16, coef5_M16 },
+		{ 14, 14, coef3_M14, coef5_M14 },
+		{ 13, 13, coef3_M13, coef5_M13 },
+		{ 12, 12, coef3_M12, coef5_M12 },
+		{ 11, 11, coef3_M11, coef5_M11 },
+		{ 10, 10, coef3_M10, coef5_M10 },
+		{  9,  9,  coef3_M9,  coef5_M9 },
+		{  4,  8,  coef3_M8,  coef5_M8 },
+		/*
+		 * When upscaling more than two times, blockiness and outlines
+		 * around the image are observed when M8 tables are used. M11,
+		 * M16 and M19 tables are used to prevent this.
+		 */
+		{  3,  3, coef3_M11, coef5_M11 },
+		{  2,  2, coef3_M16, coef5_M16 },
+		{  0,  1, coef3_M19, coef5_M19 },
+	};
+
+	inc /= 128;
+	for (i = 0; i < ARRAY_LEN(coefs); ++i)
+		if (inc >= coefs[i].Mmin && inc <= coefs[i].Mmax)
+			return five_taps ? coefs[i].coef_5 : coefs[i].coef_3;
+	return NULL;
+}
-- 
1.7.1

