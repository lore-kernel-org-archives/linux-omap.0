From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V3 1/3] OMAPDSS: DISPC: Enable predecimation
Date: Mon, 2 Apr 2012 20:43:16 +0530
Message-ID: <1333379598-11544-2-git-send-email-cmahapatra@ti.com>
References: <1333379598-11544-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59885 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854Ab2DBPNt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Apr 2012 11:13:49 -0400
In-Reply-To: <1333379598-11544-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

In OMAP3 and OMAP4, the DISPC Scaler can downscale an image up to 4 times, and
up to 2 times in OMAP2. However, with predecimation, the image can be reduced
to 16 times by fetching only the necessary pixels in memory. Then this
predecimated image can be downscaled further by the DISPC scaler.

The pipeline is configured to use a burst of size 8 * 128 bits which consists
of 8 mini bursts of 16 bytes each. So, horizontal predecimation more than 16
can lead to complete discarding of such mini bursts. L3 interconnect may
handover the bus to some other initiator and inturn delay the fetching of
pixels leading to underflows. So, maximum predecimation limit is fixed at 16.

Based on the downscaling required, a prior calculation of predecimation values
for width and height of an image is done. Since, Predecimation reduces quality
of an image higher priorty is given to DISPC Scaler for downscaling.

This code was successfully tested on OMAP2, OMAP3 and OMAP4. Horizontal and
vertical predecimation worked fine except for some synclost errors due to
undocumented errata in OMAP3 which are fixed later and skewed images were seen
on OMAP2 and OMAP3 during horizontal predecimation which will be addressed in
the future patches.

This code is based on code written by Lajos Molnar <lajos@ti.com> who had added
predecimation support for NV12/YUV/rotated/SDMA buffers.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  266 +++++++++++++++++++++++++++------------
 1 files changed, 185 insertions(+), 81 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ee30937..4ab5433 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1431,7 +1431,7 @@ static void calc_vrfb_rotation_offset(u8 rotation, bool mirror,
 		enum omap_color_mode color_mode, bool fieldmode,
 		unsigned int field_offset,
 		unsigned *offset0, unsigned *offset1,
-		s32 *row_inc, s32 *pix_inc)
+		s32 *row_inc, s32 *pix_inc, int x_predecim, int y_predecim)
 {
 	u8 ps;
 
@@ -1477,10 +1477,10 @@ static void calc_vrfb_rotation_offset(u8 rotation, bool mirror,
 		else
 			*offset0 = 0;
 
-		*row_inc = pixinc(1 + (screen_width - width) +
-				(fieldmode ? screen_width : 0),
-				ps);
-		*pix_inc = pixinc(1, ps);
+		*row_inc = pixinc(1 +
+			(y_predecim * screen_width - x_predecim * width) +
+			(fieldmode ? screen_width : 0), ps);
+		*pix_inc = pixinc(x_predecim, ps);
 		break;
 
 	case OMAP_DSS_ROT_0 + 4:
@@ -1498,10 +1498,10 @@ static void calc_vrfb_rotation_offset(u8 rotation, bool mirror,
 			*offset0 = field_offset * screen_width * ps;
 		else
 			*offset0 = 0;
-		*row_inc = pixinc(1 - (screen_width + width) -
-				(fieldmode ? screen_width : 0),
-				ps);
-		*pix_inc = pixinc(1, ps);
+		*row_inc = pixinc(1 -
+			(y_predecim * screen_width + x_predecim * width) -
+			(fieldmode ? screen_width : 0), ps);
+		*pix_inc = pixinc(x_predecim, ps);
 		break;
 
 	default:
@@ -1515,7 +1515,7 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
 		enum omap_color_mode color_mode, bool fieldmode,
 		unsigned int field_offset,
 		unsigned *offset0, unsigned *offset1,
-		s32 *row_inc, s32 *pix_inc)
+		s32 *row_inc, s32 *pix_inc, int x_predecim, int y_predecim)
 {
 	u8 ps;
 	u16 fbw, fbh;
@@ -1557,10 +1557,14 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
 			*offset0 = *offset1 + field_offset * screen_width * ps;
 		else
 			*offset0 = *offset1;
-		*row_inc = pixinc(1 + (screen_width - fbw) +
-				(fieldmode ? screen_width : 0),
-				ps);
-		*pix_inc = pixinc(1, ps);
+		*row_inc = pixinc(1 +
+			(y_predecim * screen_width - fbw * x_predecim) +
+			(fieldmode ? screen_width : 0),	ps);
+		if (color_mode == OMAP_DSS_COLOR_YUV2 ||
+			color_mode == OMAP_DSS_COLOR_UYVY)
+			*pix_inc = pixinc(x_predecim, 2 * ps);
+		else
+			*pix_inc = pixinc(x_predecim, ps);
 		break;
 	case OMAP_DSS_ROT_90:
 		*offset1 = screen_width * (fbh - 1) * ps;
@@ -1568,9 +1572,9 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
 			*offset0 = *offset1 + field_offset * ps;
 		else
 			*offset0 = *offset1;
-		*row_inc = pixinc(screen_width * (fbh - 1) + 1 +
-				(fieldmode ? 1 : 0), ps);
-		*pix_inc = pixinc(-screen_width, ps);
+		*row_inc = pixinc(screen_width * (fbh * x_predecim - 1) +
+				y_predecim + (fieldmode ? 1 : 0), ps);
+		*pix_inc = pixinc(-x_predecim * screen_width, ps);
 		break;
 	case OMAP_DSS_ROT_180:
 		*offset1 = (screen_width * (fbh - 1) + fbw - 1) * ps;
@@ -1579,10 +1583,13 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
 		else
 			*offset0 = *offset1;
 		*row_inc = pixinc(-1 -
-				(screen_width - fbw) -
-				(fieldmode ? screen_width : 0),
-				ps);
-		*pix_inc = pixinc(-1, ps);
+			(y_predecim * screen_width - fbw * x_predecim) -
+			(fieldmode ? screen_width : 0),	ps);
+		if (color_mode == OMAP_DSS_COLOR_YUV2 ||
+			color_mode == OMAP_DSS_COLOR_UYVY)
+			*pix_inc = pixinc(-x_predecim, 2 * ps);
+		else
+			*pix_inc = pixinc(-x_predecim, ps);
 		break;
 	case OMAP_DSS_ROT_270:
 		*offset1 = (fbw - 1) * ps;
@@ -1590,9 +1597,9 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
 			*offset0 = *offset1 - field_offset * ps;
 		else
 			*offset0 = *offset1;
-		*row_inc = pixinc(-screen_width * (fbh - 1) - 1 -
-				(fieldmode ? 1 : 0), ps);
-		*pix_inc = pixinc(screen_width, ps);
+		*row_inc = pixinc(-screen_width * (fbh * x_predecim - 1) -
+				y_predecim - (fieldmode ? 1 : 0), ps);
+		*pix_inc = pixinc(x_predecim * screen_width, ps);
 		break;
 
 	/* mirroring */
@@ -1602,10 +1609,14 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
 			*offset0 = *offset1 + field_offset * screen_width * ps;
 		else
 			*offset0 = *offset1;
-		*row_inc = pixinc(screen_width * 2 - 1 +
+		*row_inc = pixinc(y_predecim * screen_width * 2 - 1 +
 				(fieldmode ? screen_width : 0),
 				ps);
-		*pix_inc = pixinc(-1, ps);
+		if (color_mode == OMAP_DSS_COLOR_YUV2 ||
+			color_mode == OMAP_DSS_COLOR_UYVY)
+			*pix_inc = pixinc(-x_predecim, 2 * ps);
+		else
+			*pix_inc = pixinc(-x_predecim, ps);
 		break;
 
 	case OMAP_DSS_ROT_90 + 4:
@@ -1614,10 +1625,10 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
 			*offset0 = *offset1 + field_offset * ps;
 		else
 			*offset0 = *offset1;
-		*row_inc = pixinc(-screen_width * (fbh - 1) + 1 +
-				(fieldmode ? 1 : 0),
+		*row_inc = pixinc(-screen_width * (fbh * x_predecim - 1) +
+				y_predecim + (fieldmode ? 1 : 0),
 				ps);
-		*pix_inc = pixinc(screen_width, ps);
+		*pix_inc = pixinc(x_predecim * screen_width, ps);
 		break;
 
 	case OMAP_DSS_ROT_180 + 4:
@@ -1626,10 +1637,14 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
 			*offset0 = *offset1 - field_offset * screen_width * ps;
 		else
 			*offset0 = *offset1;
-		*row_inc = pixinc(1 - screen_width * 2 -
+		*row_inc = pixinc(1 - y_predecim * screen_width * 2 -
 				(fieldmode ? screen_width : 0),
 				ps);
-		*pix_inc = pixinc(1, ps);
+		if (color_mode == OMAP_DSS_COLOR_YUV2 ||
+			color_mode == OMAP_DSS_COLOR_UYVY)
+			*pix_inc = pixinc(x_predecim, 2 * ps);
+		else
+			*pix_inc = pixinc(x_predecim, ps);
 		break;
 
 	case OMAP_DSS_ROT_270 + 4:
@@ -1638,10 +1653,10 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
 			*offset0 = *offset1 - field_offset * ps;
 		else
 			*offset0 = *offset1;
-		*row_inc = pixinc(screen_width * (fbh - 1) - 1 -
-				(fieldmode ? 1 : 0),
+		*row_inc = pixinc(screen_width * (fbh * x_predecim - 1) -
+				y_predecim - (fieldmode ? 1 : 0),
 				ps);
-		*pix_inc = pixinc(-screen_width, ps);
+		*pix_inc = pixinc(-x_predecim * screen_width, ps);
 		break;
 
 	default:
@@ -1732,13 +1747,17 @@ static unsigned long calc_fclk(enum omap_channel channel, u16 width,
 static int dispc_ovl_calc_scaling(enum omap_plane plane,
 		enum omap_channel channel, u16 width, u16 height,
 		u16 out_width, u16 out_height,
-		enum omap_color_mode color_mode, bool *five_taps)
+		enum omap_color_mode color_mode, bool *five_taps,
+		int *x_predecim, int *y_predecim)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
 	const int maxsinglelinewidth =
 				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
+	const int max_decim_limit = 16;
 	unsigned long fclk = 0;
+	int decim_x, decim_y, error, min_factor;
+	u16 in_width, in_height, in_width_max = 0;
 
 	if (width == out_width && height == out_height)
 		return 0;
@@ -1746,45 +1765,121 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) == 0)
 		return -EINVAL;
 
-	if (out_width < width / maxdownscale ||
-			out_width > width * 8)
+	*x_predecim = max_decim_limit;
+	*y_predecim = max_decim_limit;
+
+	if (color_mode == OMAP_DSS_COLOR_CLUT1 ||
+	    color_mode == OMAP_DSS_COLOR_CLUT2 ||
+	    color_mode == OMAP_DSS_COLOR_CLUT4 ||
+	    color_mode == OMAP_DSS_COLOR_CLUT8) {
+		*x_predecim = 1;
+		*y_predecim = 1;
+		*five_taps = false;
+		return 0;
+	}
+
+	decim_x = DIV_ROUND_UP(DIV_ROUND_UP(width, out_width), maxdownscale);
+	decim_y = DIV_ROUND_UP(DIV_ROUND_UP(height, out_height), maxdownscale);
+
+	min_factor = min(decim_x, decim_y);
+
+	if (decim_x > *x_predecim || out_width > width * 8)
 		return -EINVAL;
 
-	if (out_height < height / maxdownscale ||
-			out_height > height * 8)
+	if (decim_y > *y_predecim || out_height > height * 8)
 		return -EINVAL;
 
 	if (cpu_is_omap24xx()) {
-		if (width > maxsinglelinewidth)
-			DSSERR("Cannot scale max input width exceeded");
 		*five_taps = false;
-		fclk = calc_fclk(channel, width, height, out_width,
-								out_height);
+
+		do {
+			in_height = DIV_ROUND_UP(height, decim_y);
+			in_width = DIV_ROUND_UP(width, decim_x);
+			fclk = calc_fclk(channel, in_width, in_height,
+					out_width, out_height);
+			error = (in_width > maxsinglelinewidth || !fclk ||
+				fclk > dispc_fclk_rate());
+			if (error) {
+				if (decim_x == decim_y) {
+					decim_x = min_factor;
+					decim_y++;
+				} else {
+					swap(decim_x, decim_y);
+					if (decim_x < decim_y)
+						decim_x++;
+				}
+			}
+		} while (decim_x <= *x_predecim && decim_y <= *y_predecim &&
+				error);
+
+		if (in_width > maxsinglelinewidth) {
+			DSSERR("Cannot scale max input width exceeded");
+			return -EINVAL;
+		}
 	} else if (cpu_is_omap34xx()) {
-		if (width > (maxsinglelinewidth * 2)) {
+
+		do {
+			in_height = DIV_ROUND_UP(height, decim_y);
+			in_width = DIV_ROUND_UP(width, decim_x);
+			fclk = calc_fclk_five_taps(channel, in_width, in_height,
+				out_width, out_height, color_mode);
+
+			if (in_width > maxsinglelinewidth)
+				if (in_height > out_height &&
+					in_height < out_height * 2)
+					*five_taps = false;
+			if (!*five_taps)
+				fclk = calc_fclk(channel, in_width, in_height,
+					out_width, out_height);
+			error = (in_width > maxsinglelinewidth * 2 ||
+				(in_width > maxsinglelinewidth && *five_taps) ||
+				!fclk || fclk > dispc_fclk_rate());
+			if (error) {
+				if (decim_x == decim_y) {
+					decim_x = min_factor;
+					decim_y++;
+				} else {
+					swap(decim_x, decim_y);
+					if (decim_x < decim_y)
+						decim_x++;
+				}
+			}
+		} while (decim_x <= *x_predecim && decim_y <= *y_predecim
+			&& error);
+
+		if (in_width > (maxsinglelinewidth * 2)) {
 			DSSERR("Cannot setup scaling");
 			DSSERR("width exceeds maximum width possible");
 			return -EINVAL;
 		}
-		fclk = calc_fclk_five_taps(channel, width, height, out_width,
-						out_height, color_mode);
-		if (width > maxsinglelinewidth) {
-			if (height > out_height && height < out_height * 2)
-				*five_taps = false;
-			else {
-				DSSERR("cannot setup scaling with five taps");
-				return -EINVAL;
-			}
+
+		if (in_width > maxsinglelinewidth && *five_taps) {
+			DSSERR("cannot setup scaling with five taps");
+			return -EINVAL;
 		}
-		if (!*five_taps)
-			fclk = calc_fclk(channel, width, height, out_width,
-					out_height);
 	} else {
-		if (width > maxsinglelinewidth) {
+		int decim_x_min = decim_x;
+		in_height = DIV_ROUND_UP(height, decim_y);
+		in_width_max = dispc_fclk_rate() /
+				DIV_ROUND_UP(dispc_mgr_pclk_rate(channel),
+						out_width);
+		decim_x = DIV_ROUND_UP(width, in_width_max);
+
+		decim_x = decim_x > decim_x_min ? decim_x : decim_x_min;
+		if (decim_x > *x_predecim)
+			return -EINVAL;
+
+		do {
+			in_width = DIV_ROUND_UP(width, decim_x);
+		} while (decim_x <= *x_predecim &&
+				in_width > maxsinglelinewidth && decim_x++);
+
+		if (in_width > maxsinglelinewidth) {
 			DSSERR("Cannot scale width exceeds max line width");
 			return -EINVAL;
 		}
-		fclk = calc_fclk(channel, width, height, out_width,
+
+		fclk = calc_fclk(channel, in_width, in_height, out_width,
 				out_height);
 	}
 
@@ -1799,6 +1894,8 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 		return -EINVAL;
 	}
 
+	*x_predecim = decim_x;
+	*y_predecim = decim_y;
 	return 0;
 }
 
@@ -1814,8 +1911,11 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	s32 pix_inc;
 	u16 frame_height = oi->height;
 	unsigned int field_offset = 0;
-	u16 outw, outh;
+	u16 in_height = oi->height;
+	u16 in_width = oi->width;
+	u16 out_width, out_height;
 	enum omap_channel channel;
+	int x_predecim = 1, y_predecim = 1;
 
 	channel = dispc_ovl_get_channel_out(plane);
 
@@ -1829,32 +1929,35 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	if (oi->paddr == 0)
 		return -EINVAL;
 
-	outw = oi->out_width == 0 ? oi->width : oi->out_width;
-	outh = oi->out_height == 0 ? oi->height : oi->out_height;
+	out_width = oi->out_width == 0 ? oi->width : oi->out_width;
+	out_height = oi->out_height == 0 ? oi->height : oi->out_height;
 
-	if (ilace && oi->height == outh)
+	if (ilace && oi->height == out_height)
 		fieldmode = 1;
 
 	if (ilace) {
 		if (fieldmode)
-			oi->height /= 2;
+			in_height /= 2;
 		oi->pos_y /= 2;
-		outh /= 2;
+		out_height /= 2;
 
 		DSSDBG("adjusting for ilace: height %d, pos_y %d, "
 				"out_height %d\n",
-				oi->height, oi->pos_y, outh);
+				in_height, oi->pos_y, out_height);
 	}
 
 	if (!dss_feat_color_mode_supported(plane, oi->color_mode))
 		return -EINVAL;
 
-	r = dispc_ovl_calc_scaling(plane, channel, oi->width, oi->height,
-			outw, outh, oi->color_mode,
-			&five_taps);
+	r = dispc_ovl_calc_scaling(plane, channel, in_width, in_height,
+			out_width, out_height, oi->color_mode, &five_taps,
+			&x_predecim, &y_predecim);
 	if (r)
 		return r;
 
+	in_width = DIV_ROUND_UP(in_width, x_predecim);
+	in_height = DIV_ROUND_UP(in_height, y_predecim);
+
 	if (oi->color_mode == OMAP_DSS_COLOR_YUV2 ||
 			oi->color_mode == OMAP_DSS_COLOR_UYVY ||
 			oi->color_mode == OMAP_DSS_COLOR_NV12)
@@ -1868,10 +1971,10 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 		 * so the integer part must be added to the base address of the
 		 * bottom field.
 		 */
-		if (!oi->height || oi->height == outh)
+		if (!in_height || in_height == out_height)
 			field_offset = 0;
 		else
-			field_offset = oi->height / outh / 2;
+			field_offset = in_height / out_height / 2;
 	}
 
 	/* Fields are independent but interleaved in memory. */
@@ -1880,14 +1983,16 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 
 	if (oi->rotation_type == OMAP_DSS_ROT_DMA)
 		calc_dma_rotation_offset(oi->rotation, oi->mirror,
-				oi->screen_width, oi->width, frame_height,
+				oi->screen_width, in_width, frame_height,
 				oi->color_mode, fieldmode, field_offset,
-				&offset0, &offset1, &row_inc, &pix_inc);
+				&offset0, &offset1, &row_inc, &pix_inc,
+				x_predecim, y_predecim);
 	else
 		calc_vrfb_rotation_offset(oi->rotation, oi->mirror,
-				oi->screen_width, oi->width, frame_height,
+				oi->screen_width, in_width, frame_height,
 				oi->color_mode, fieldmode, field_offset,
-				&offset0, &offset1, &row_inc, &pix_inc);
+				&offset0, &offset1, &row_inc, &pix_inc,
+				x_predecim, y_predecim);
 
 	DSSDBG("offset0 %u, offset1 %u, row_inc %d, pix_inc %d\n",
 			offset0, offset1, row_inc, pix_inc);
@@ -1906,19 +2011,18 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	dispc_ovl_set_row_inc(plane, row_inc);
 	dispc_ovl_set_pix_inc(plane, pix_inc);
 
-	DSSDBG("%d,%d %dx%d -> %dx%d\n", oi->pos_x, oi->pos_y, oi->width,
-			oi->height, outw, outh);
+	DSSDBG("%d,%d %dx%d -> %dx%d\n", oi->pos_x, oi->pos_y, in_width,
+			in_height, out_width, out_height);
 
 	dispc_ovl_set_pos(plane, oi->pos_x, oi->pos_y);
 
-	dispc_ovl_set_pic_size(plane, oi->width, oi->height);
+	dispc_ovl_set_pic_size(plane, in_width, in_height);
 
 	if (ovl->caps & OMAP_DSS_OVL_CAP_SCALE) {
-		dispc_ovl_set_scaling(plane, oi->width, oi->height,
-				   outw, outh,
-				   ilace, five_taps, fieldmode,
+		dispc_ovl_set_scaling(plane, in_width, in_height, out_width,
+				   out_height, ilace, five_taps, fieldmode,
 				   oi->color_mode, oi->rotation);
-		dispc_ovl_set_vid_size(plane, outw, outh);
+		dispc_ovl_set_vid_size(plane, out_width, out_height);
 		dispc_ovl_set_vid_color_conv(plane, cconv);
 	}
 
-- 
1.7.1

