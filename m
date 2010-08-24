From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] OMAP: DSS2: make filter coefficient tables human readable
Date: Tue, 24 Aug 2010 16:18:43 +0300
Message-ID: <1282655923-32094-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50454 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885Ab0HXNSv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 09:18:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

Reorganize scaler FIR filter data as FIR value tables from raw
register values. This makes them easier to understand and simplifies
register programming code.

No functional changes.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/video/omap2/dss/dispc.c |  214 +++++++++++++++++----------------------
 1 files changed, 94 insertions(+), 120 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 5ecdc00..90eb110 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -139,6 +139,22 @@ struct omap_dispc_isr_data {
 	u32			mask;
 };
 
+struct dispc_h_coef {
+	s8 hc4;
+	s8 hc3;
+	u8 hc2;
+	s8 hc1;
+	s8 hc0;
+};
+
+struct dispc_v_coef {
+	s8 vc22;
+	s8 vc2;
+	u8 vc1;
+	s8 vc0;
+	s8 vc00;
+};
+
 #define REG_GET(idx, start, end) \
 	FLD_GET(dispc_read_reg(idx), start, end)
 
@@ -564,106 +580,77 @@ static void _dispc_set_scale_coef(enum omap_plane plane, int hscaleup,
 		int vscaleup, int five_taps)
 {
 	/* Coefficients for horizontal up-sampling */
-	static const u32 coef_hup[8] = {
-		0x00800000,
-		0x0D7CF800,
-		0x1E70F5FF,
-		0x335FF5FE,
-		0xF74949F7,
-		0xF55F33FB,
-		0xF5701EFE,
-		0xF87C0DFF,
+	static const struct dispc_h_coef coef_hup[8] = {
+		{  0,   0, 128,   0,  0 },
+		{ -1,  13, 124,  -8,  0 },
+		{ -2,  30, 112, -11, -1 },
+		{ -5,  51,  95, -11, -2 },
+		{  0,  -9,  73,  73, -9 },
+		{ -2, -11,  95,  51, -5 },
+		{ -1, -11, 112,  30, -2 },
+		{  0,  -8, 124,  13, -1 },
 	};
 
-	/* Coefficients for horizontal down-sampling */
-	static const u32 coef_hdown[8] = {
-		0x24382400,
-		0x28371FFE,
-		0x2C361BFB,
-		0x303516F9,
-		0x11343311,
-		0x1635300C,
-		0x1B362C08,
-		0x1F372804,
+	/* Coefficients for vertical up-sampling */
+	static const struct dispc_v_coef coef_vup_3tap[8] = {
+		{ 0,  0, 128,  0, 0 },
+		{ 0,  3, 123,  2, 0 },
+		{ 0, 12, 111,  5, 0 },
+		{ 0, 32,  89,  7, 0 },
+		{ 0,  0,  64, 64, 0 },
+		{ 0,  7,  89, 32, 0 },
+		{ 0,  5, 111, 12, 0 },
+		{ 0,  2, 123,  3, 0 },
 	};
 
-	/* Coefficients for horizontal and vertical up-sampling */
-	static const u32 coef_hvup[2][8] = {
-		{
-		0x00800000,
-		0x037B02FF,
-		0x0C6F05FE,
-		0x205907FB,
-		0x00404000,
-		0x075920FE,
-		0x056F0CFF,
-		0x027B0300,
-		},
-		{
-		0x00800000,
-		0x0D7CF8FF,
-		0x1E70F5FE,
-		0x335FF5FB,
-		0xF7404000,
-		0xF55F33FE,
-		0xF5701EFF,
-		0xF87C0D00,
-		},
+	static const struct dispc_v_coef coef_vup_5tap[8] = {
+		{  0,   0, 128,   0,  0 },
+		{ -1,  13, 124,  -8,  0 },
+		{ -2,  30, 112, -11, -1 },
+		{ -5,  51,  95, -11, -2 },
+		{  0,  -9,  73,  73, -9 },
+		{ -2, -11,  95,  51, -5 },
+		{ -1, -11, 112,  30, -2 },
+		{  0,  -8, 124,  13, -1 },
 	};
 
-	/* Coefficients for horizontal and vertical down-sampling */
-	static const u32 coef_hvdown[2][8] = {
-		{
-		0x24382400,
-		0x28391F04,
-		0x2D381B08,
-		0x3237170C,
-		0x123737F7,
-		0x173732F9,
-		0x1B382DFB,
-		0x1F3928FE,
-		},
-		{
-		0x24382400,
-		0x28371F04,
-		0x2C361B08,
-		0x3035160C,
-		0x113433F7,
-		0x163530F9,
-		0x1B362CFB,
-		0x1F3728FE,
-		},
+	/* Coefficients for horizontal down-sampling */
+	static const struct dispc_h_coef coef_hdown[8] = {
+		{   0, 36, 56, 36,  0 },
+		{   4, 40, 55, 31, -2 },
+		{   8, 44, 54, 27, -5 },
+		{  12, 48, 53, 22, -7 },
+		{  -9, 17, 52, 51, 17 },
+		{  -7, 22, 53, 48, 12 },
+		{  -5, 27, 54, 44,  8 },
+		{  -2, 31, 55, 40,  4 },
 	};
 
-	/* Coefficients for vertical up-sampling */
-	static const u32 coef_vup[8] = {
-		0x00000000,
-		0x0000FF00,
-		0x0000FEFF,
-		0x0000FBFE,
-		0x000000F7,
-		0x0000FEFB,
-		0x0000FFFE,
-		0x000000FF,
+	/* Coefficients for vertical down-sampling */
+	static const struct dispc_v_coef coef_vdown_3tap[8] = {
+		{ 0, 36, 56, 36, 0 },
+		{ 0, 40, 57, 31, 0 },
+		{ 0, 45, 56, 27, 0 },
+		{ 0, 50, 55, 23, 0 },
+		{ 0, 18, 55, 55, 0 },
+		{ 0, 23, 55, 50, 0 },
+		{ 0, 27, 56, 45, 0 },
+		{ 0, 31, 57, 40, 0 },
 	};
 
-
-	/* Coefficients for vertical down-sampling */
-	static const u32 coef_vdown[8] = {
-		0x00000000,
-		0x000004FE,
-		0x000008FB,
-		0x00000CF9,
-		0x0000F711,
-		0x0000F90C,
-		0x0000FB08,
-		0x0000FE04,
+	static const struct dispc_v_coef coef_vdown_5tap[8] = {
+		{   0, 36, 56, 36,  0 },
+		{   4, 40, 55, 31, -2 },
+		{   8, 44, 54, 27, -5 },
+		{  12, 48, 53, 22, -7 },
+		{  -9, 17, 52, 51, 17 },
+		{  -7, 22, 53, 48, 12 },
+		{  -5, 27, 54, 44,  8 },
+		{  -2, 31, 55, 40,  4 },
 	};
 
-	const u32 *h_coef;
-	const u32 *hv_coef;
-	const u32 *hv_coef_mod;
-	const u32 *v_coef;
+	const struct dispc_h_coef *h_coef;
+	const struct dispc_v_coef *v_coef;
 	int i;
 
 	if (hscaleup)
@@ -671,47 +658,34 @@ static void _dispc_set_scale_coef(enum omap_plane plane, int hscaleup,
 	else
 		h_coef = coef_hdown;
 
-	if (vscaleup) {
-		hv_coef = coef_hvup[five_taps];
-		v_coef = coef_vup;
-
-		if (hscaleup)
-			hv_coef_mod = NULL;
-		else
-			hv_coef_mod = coef_hvdown[five_taps];
-	} else {
-		hv_coef = coef_hvdown[five_taps];
-		v_coef = coef_vdown;
-
-		if (hscaleup)
-			hv_coef_mod = coef_hvup[five_taps];
-		else
-			hv_coef_mod = NULL;
-	}
+	if (vscaleup)
+		v_coef = five_taps ? coef_vup_5tap : coef_vup_3tap;
+	else
+		v_coef = five_taps ? coef_vdown_5tap : coef_vdown_3tap;
 
 	for (i = 0; i < 8; i++) {
 		u32 h, hv;
 
-		h = h_coef[i];
-
-		hv = hv_coef[i];
-
-		if (hv_coef_mod) {
-			hv &= 0xffffff00;
-			hv |= (hv_coef_mod[i] & 0xff);
-		}
+		h = FLD_VAL(h_coef[i].hc0, 7, 0)
+			| FLD_VAL(h_coef[i].hc1, 15, 8)
+			| FLD_VAL(h_coef[i].hc2, 23, 16)
+			| FLD_VAL(h_coef[i].hc3, 31, 24);
+		hv = FLD_VAL(h_coef[i].hc4, 7, 0)
+			| FLD_VAL(v_coef[i].vc0, 15, 8)
+			| FLD_VAL(v_coef[i].vc1, 23, 16)
+			| FLD_VAL(v_coef[i].vc2, 31, 24);
 
 		_dispc_write_firh_reg(plane, i, h);
 		_dispc_write_firhv_reg(plane, i, hv);
 	}
 
-	if (!five_taps)
-		return;
-
-	for (i = 0; i < 8; i++) {
-		u32 v;
-		v = v_coef[i];
-		_dispc_write_firv_reg(plane, i, v);
+	if (five_taps) {
+		for (i = 0; i < 8; i++) {
+			u32 v;
+			v = FLD_VAL(v_coef[i].vc00, 7, 0)
+				| FLD_VAL(v_coef[i].vc22, 15, 8);
+			_dispc_write_firv_reg(plane, i, v);
+		}
 	}
 }
 
-- 
1.6.3.3

