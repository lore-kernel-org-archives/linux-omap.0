From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 2/2] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Date: Thu, 15 Mar 2012 17:18:52 +0530
Message-ID: <1331812132-9814-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43184 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761677Ab2COLs6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Mar 2012 07:48:58 -0400
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
 drivers/video/omap2/dss/dispc.c |   67 +++++++++++++++++++++++++++++++=
++++++--
 1 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/=
dispc.c
index 5a1963e..ebfa613 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1622,6 +1622,58 @@ static void calc_dma_rotation_offset(u8 rotation=
, bool mirror,
 	}
 }
=20
+static int check_horiz_timing(enum omap_channel channel, u16 pos_x,
+		u16 width, u16 height, u16 out_width, u16 out_height)
+{
+	int DS =3D DIV_ROUND_UP(height, out_height);
+	struct omap_dss_device *dssdev =3D dispc_mgr_get_device(channel);
+	struct omap_video_timings t =3D dssdev->panel.timings;
+	int pcd =3D REG_GET(DISPC_DIVISORo(channel), 7, 0);
+	unsigned long nonactive, val, blank;
+	static const u8 limits[3] =3D { 8, 10, 20 };
+	int i;
+
+	nonactive =3D t.x_res + t.hfp + t.hsw + t.hbp - out_width;
+
+	/*
+	 * Atleast DS-2 lines must have already been fetched
+	 * before the display active video period starts.
+	 */
+	val =3D (nonactive - pos_x) * pcd;
+	DSSDBG("(nonactive - pos_x) * pcd =3D %lu,"
+		" max(0, DS - 2) * width =3D %d\n",
+		val, max(0, DS - 2) * width);
+	if (val < max(0, DS - 2) * width)
+		return -EINVAL;
+
+	/*
+	 * Only one line can be fetched during the overlay active
+	 * period, the rest have to be fetched during the inactive
+	 * period.
+	 */
+	val =3D nonactive * pcd;
+	DSSDBG("nonactive * pcd  =3D %lu, max(0, DS - 1) * width =3D %d\n",
+		val, max(0, DS - 1) * width);
+	if (val < max(0, DS - 1) * width)
+		return -EINVAL;
+
+	/*
+	 * Atleast Ceil(DS) lines should have been loaded during
+	 * PPL (screen width) + blanking period.
+	 */
+	i =3D 0;
+	if (out_height < height)
+		i++;
+	if (out_width < width)
+		i++;
+	blank =3D (t.hbp + t.hsw + t.hfp) * pcd;
+	DSSDBG("blanking period + ppl =3D %lu (limit =3D %u)\n", blank, limit=
s[i]);
+	if (blank <=3D limits[i])
+		return -EINVAL;
+
+	return 0;
+}
+
 static unsigned long calc_fclk_five_taps(enum omap_channel channel, u1=
6 width,
 		u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode)
@@ -1702,7 +1754,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane=
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
@@ -1778,6 +1830,9 @@ static int dispc_ovl_calc_scaling(enum omap_plane=
 plane,
 			fclk =3D calc_fclk_five_taps(channel, in_width, in_height,
 				out_width, out_height, color_mode);
=20
+			error =3D check_horiz_timing(channel, pos_x, in_width,
+				in_height, out_width, out_height);
+
 			if (in_width > maxsinglelinewidth)
 				if (in_height > out_height &&
 					in_height < out_height * 2)
@@ -1785,7 +1840,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane=
 plane,
 			if (!*five_taps)
 				fclk =3D calc_fclk(channel, in_width, in_height,
 					out_width, out_height);
-			error =3D (in_width > maxsinglelinewidth * 2 ||
+			error =3D (error || in_width > maxsinglelinewidth * 2 ||
 				(in_width > maxsinglelinewidth && *five_taps) ||
 				!fclk || fclk > dispc_fclk_rate());
 			if (error) {
@@ -1801,6 +1856,12 @@ static int dispc_ovl_calc_scaling(enum omap_plan=
e plane,
 		} while (decim_x <=3D *x_predecim && decim_y <=3D *y_predecim
 			&& error);
=20
+		if (check_horiz_timing(channel, pos_x, width, height,
+			out_width, out_height)){
+				DSSERR("horizontal timing too tight\n");
+				return -EINVAL;
+		}
+
 		if (in_width > (maxsinglelinewidth * 2)) {
 			DSSERR("Cannot setup scaling");
 			DSSERR("width exceeds maximum width possible");
@@ -1901,7 +1962,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct=
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
