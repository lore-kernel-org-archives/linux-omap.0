From: ville.syrjala@nokia.com
Subject: [PATCH v4 1/8] DSS2: OMAPFB: Refactor overlay address calculations
Date: Thu, 18 Mar 2010 00:46:16 +0200
Message-ID: <1268865983-16270-2-git-send-email-ville.syrjala@nokia.com>
References: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28620 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185Ab0CQWqn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 18:46:43 -0400
In-Reply-To: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Imre Deak <imre.deak@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

Split the overlay address calculations into their own function.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   63 ++++++++++++++++++----=
--------
 1 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/o=
map2/omapfb/omapfb-main.c
index 4a76917..ea619a9 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -821,6 +821,40 @@ static unsigned calc_rotation_offset_vrfb(const st=
ruct fb_var_screeninfo *var,
 	return offset;
 }
=20
+static void omapfb_calc_addr(const struct omapfb_info *ofbi,
+			     const struct fb_var_screeninfo *var,
+			     const struct fb_fix_screeninfo *fix,
+			     int rotation, u32 *paddr, void __iomem **vaddr)
+{
+	u32 data_start_p;
+	void __iomem *data_start_v;
+	int offset;
+
+	if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB) {
+		data_start_p =3D omapfb_get_region_rot_paddr(ofbi, rotation);
+		data_start_v =3D NULL;
+	} else {
+		data_start_p =3D omapfb_get_region_paddr(ofbi);
+		data_start_v =3D omapfb_get_region_vaddr(ofbi);
+	}
+
+	if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB)
+		offset =3D calc_rotation_offset_vrfb(var, fix, rotation);
+	else
+		offset =3D calc_rotation_offset_dma(var, fix, rotation);
+
+	data_start_p +=3D offset;
+	data_start_v +=3D offset;
+
+	if (offset)
+		DBG("offset %d, %d =3D %d\n",
+		    var->xoffset, var->yoffset, offset);
+
+	DBG("paddr %x, vaddr %p\n", data_start_p, data_start_v);
+
+	*paddr =3D data_start_p;
+	*vaddr =3D data_start_v;
+}
=20
 /* setup overlay according to the fb */
 static int omapfb_setup_overlay(struct fb_info *fbi, struct omap_overl=
ay *ovl,
@@ -831,9 +865,8 @@ static int omapfb_setup_overlay(struct fb_info *fbi=
, struct omap_overlay *ovl,
 	struct fb_var_screeninfo *var =3D &fbi->var;
 	struct fb_fix_screeninfo *fix =3D &fbi->fix;
 	enum omap_color_mode mode =3D 0;
-	int offset;
-	u32 data_start_p;
-	void __iomem *data_start_v;
+	u32 data_start_p =3D 0;
+	void __iomem *data_start_v =3D NULL;
 	struct omap_overlay_info info;
 	int xres, yres;
 	int screen_width;
@@ -860,28 +893,8 @@ static int omapfb_setup_overlay(struct fb_info *fb=
i, struct omap_overlay *ovl,
 		yres =3D var->yres;
 	}
=20
-
-	if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB) {
-		data_start_p =3D omapfb_get_region_rot_paddr(ofbi, rotation);
-		data_start_v =3D NULL;
-	} else {
-		data_start_p =3D omapfb_get_region_paddr(ofbi);
-		data_start_v =3D omapfb_get_region_vaddr(ofbi);
-	}
-
-	if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB)
-		offset =3D calc_rotation_offset_vrfb(var, fix, rotation);
-	else
-		offset =3D calc_rotation_offset_dma(var, fix, rotation);
-
-	data_start_p +=3D offset;
-	data_start_v +=3D offset;
-
-	if (offset)
-		DBG("offset %d, %d =3D %d\n",
-				var->xoffset, var->yoffset, offset);
-
-	DBG("paddr %x, vaddr %p\n", data_start_p, data_start_v);
+	omapfb_calc_addr(ofbi, var, fix, rotation,
+			 &data_start_p, &data_start_v);
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
