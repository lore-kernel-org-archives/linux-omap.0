From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V3 2/3] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Date: Mon, 2 Apr 2012 20:43:17 +0530
Message-ID: <1333379598-11544-3-git-send-email-cmahapatra@ti.com>
References: <1333379598-11544-1-git-send-email-cmahapatra@ti.com>
 <1333379598-11544-2-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42309 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001Ab2DBPNy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Apr 2012 11:13:54 -0400
In-Reply-To: <1333379598-11544-2-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

In OMAP3 DISPC video overlays suffer from some undocumented horizontal =
position
and timing related limitations leading to SYNCLOST errors. Whenever the=
 image
window is moved towards the right of the screen SYNCLOST errors become
frequent. Checks have been implemented to see that DISPC driver rejects
configuration exceeding above limitations.

This code was successfully tested on OMAP3. This code is written based =
on code
written by Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com> in Linux O=
MAP kernel. Ville
Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com> had added checks for video =
overlay horizontal
timing and DISPC horizontal blanking length limitations.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   72 +++++++++++++++++++++++++++++++=
++++++--
 1 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/=
dispc.c
index 4ab5433..17ffa71 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1664,6 +1664,63 @@ static void calc_dma_rotation_offset(u8 rotation=
, bool mirror,
 	}
 }
=20
+/*
+ * This function is used to avoid synclosts in OMAP3, because of some
+ * undocumented horizontal position and timing related limitations.
+ */
+static int check_horiz_timing_omap3(enum omap_channel channel, u16 pos=
_x,
+		u16 width, u16 height, u16 out_width, u16 out_height)
+{
+	int DS =3D DIV_ROUND_UP(height, out_height);
+	struct omap_dss_device *dssdev =3D dispc_mgr_get_device(channel);
+	struct omap_video_timings t =3D dssdev->panel.timings;
+	unsigned long nonactive, lclk, pclk;
+	static const u8 limits[3] =3D { 8, 10, 20 };
+	u64 val, blank;
+	int i;
+
+	nonactive =3D t.x_res + t.hfp + t.hsw + t.hbp - out_width;
+	pclk =3D dispc_mgr_pclk_rate(channel);
+	if (dispc_mgr_is_lcd(channel))
+		lclk =3D dispc_mgr_lclk_rate(channel);
+	else
+		lclk =3D dispc_fclk_rate();
+
+	i =3D 0;
+	if (out_height < height)
+		i++;
+	if (out_width < width)
+		i++;
+	blank =3D div_u64((u64)(t.hbp + t.hsw + t.hfp) * lclk, pclk);
+	DSSDBG("blanking period + ppl =3D %llu (limit =3D %u)\n", blank, limi=
ts[i]);
+	if (blank <=3D limits[i])
+		return -EINVAL;
+
+	/*
+	 * Pixel data should be prepared before visible display point starts.
+	 * So, atleast DS-2 lines must have already been fetched by DISPC
+	 * during nonactive - pos_x period.
+	 */
+	val =3D div_u64((u64)(nonactive - pos_x) * lclk, pclk);
+	DSSDBG("(nonactive - pos_x) * pcd =3D %llu max(0, DS - 2) * width =3D=
 %d\n",
+		val, max(0, DS - 2) * width);
+	if (val < max(0, DS - 2) * width)
+		return -EINVAL;
+
+	/*
+	 * All lines need to be refilled during the nonactive period of which
+	 * only one line can be loaded during the active period. So, atleast
+	 * DS - 1 lines should be loaded during nonactive period.
+	 */
+	val =3D  div_u64((u64)nonactive * lclk, pclk);
+	DSSDBG("nonactive * pcd  =3D %llu, max(0, DS - 1) * width =3D %d\n",
+		val, max(0, DS - 1) * width);
+	if (val < max(0, DS - 1) * width)
+		return -EINVAL;
+
+	return 0;
+}
+
 static unsigned long calc_fclk_five_taps(enum omap_channel channel, u1=
6 width,
 		u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode)
@@ -1748,7 +1805,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane=
 plane,
 		enum omap_channel channel, u16 width, u16 height,
 		u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
-		int *x_predecim, int *y_predecim)
+		int *x_predecim, int *y_predecim, u16 pos_x)
 {
 	struct omap_overlay *ovl =3D omap_dss_get_overlay(plane);
 	const int maxdownscale =3D dss_feat_get_param_max(FEAT_PARAM_DOWNSCAL=
E);
@@ -1824,6 +1881,9 @@ static int dispc_ovl_calc_scaling(enum omap_plane=
 plane,
 			fclk =3D calc_fclk_five_taps(channel, in_width, in_height,
 				out_width, out_height, color_mode);
=20
+			error =3D check_horiz_timing_omap3(channel, pos_x,
+				in_width, in_height, out_width, out_height);
+
 			if (in_width > maxsinglelinewidth)
 				if (in_height > out_height &&
 					in_height < out_height * 2)
@@ -1831,7 +1891,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane=
 plane,
 			if (!*five_taps)
 				fclk =3D calc_fclk(channel, in_width, in_height,
 					out_width, out_height);
-			error =3D (in_width > maxsinglelinewidth * 2 ||
+			error =3D (error || in_width > maxsinglelinewidth * 2 ||
 				(in_width > maxsinglelinewidth && *five_taps) ||
 				!fclk || fclk > dispc_fclk_rate());
 			if (error) {
@@ -1847,6 +1907,12 @@ static int dispc_ovl_calc_scaling(enum omap_plan=
e plane,
 		} while (decim_x <=3D *x_predecim && decim_y <=3D *y_predecim
 			&& error);
=20
+		if (check_horiz_timing_omap3(channel, pos_x, width, height,
+			out_width, out_height)){
+				DSSERR("horizontal timing too tight\n");
+				return -EINVAL;
+		}
+
 		if (in_width > (maxsinglelinewidth * 2)) {
 			DSSERR("Cannot setup scaling");
 			DSSERR("width exceeds maximum width possible");
@@ -1951,7 +2017,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct=
 omap_overlay_info *oi,
=20
 	r =3D dispc_ovl_calc_scaling(plane, channel, in_width, in_height,
 			out_width, out_height, oi->color_mode, &five_taps,
-			&x_predecim, &y_predecim);
+			&x_predecim, &y_predecim, oi->pos_x);
 	if (r)
 		return r;
=20
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
