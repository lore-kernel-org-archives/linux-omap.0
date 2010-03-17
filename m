From: ville.syrjala@nokia.com
Subject: [PATCH v4 2/8] DSS2: OMAPFB: Check var even if there isn't memory
Date: Thu, 18 Mar 2010 00:46:17 +0200
Message-ID: <1268865983-16270-3-git-send-email-ville.syrjala@nokia.com>
References: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28627 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226Ab0CQWqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 18:46:46 -0400
In-Reply-To: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Imre Deak <imre.deak@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

If video memory hasn't been allocate have check_fb_var() still check
most of the settings, just skip the ones involving the size of the
memory region. Also skip the memory address calculations in
omapfb_setup_overlay() if there's no memory.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/o=
map2/omapfb/omapfb-main.c
index ea619a9..7351e96 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -667,9 +667,6 @@ int check_fb_var(struct fb_info *fbi, struct fb_var=
_screeninfo *var)
=20
 	DBG("check_fb_var %d\n", ofbi->id);
=20
-	if (ofbi->region.size =3D=3D 0)
-		return 0;
-
 	r =3D fb_mode_to_dss_mode(var, &mode);
 	if (r) {
 		DBG("cannot convert var to omap dss mode\n");
@@ -689,7 +686,8 @@ int check_fb_var(struct fb_info *fbi, struct fb_var=
_screeninfo *var)
 	if (check_fb_res_bounds(var))
 		return -EINVAL;
=20
-	if (check_fb_size(ofbi, var))
+	/* When no memory is allocated ignore the size check */
+	if (ofbi->region.size !=3D 0 && check_fb_size(ofbi, var))
 		return -EINVAL;
=20
 	if (var->xres + var->xoffset > var->xres_virtual)
@@ -893,8 +891,9 @@ static int omapfb_setup_overlay(struct fb_info *fbi=
, struct omap_overlay *ovl,
 		yres =3D var->yres;
 	}
=20
-	omapfb_calc_addr(ofbi, var, fix, rotation,
-			 &data_start_p, &data_start_v);
+	if (ofbi->region.size)
+		omapfb_calc_addr(ofbi, var, fix, rotation,
+				 &data_start_p, &data_start_v);
=20
 	r =3D fb_mode_to_dss_mode(var, &mode);
 	if (r) {
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
