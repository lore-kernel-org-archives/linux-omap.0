From: ville.syrjala@nokia.com
Subject: [PATCH 2/3] DSS2: OMAPFB: Constify some function parameters
Date: Wed, 24 Feb 2010 00:36:26 +0200
Message-ID: <1266964587-14381-2-git-send-email-ville.syrjala@nokia.com>
References: <1266964587-14381-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32415 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089Ab0BWWhC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 17:37:02 -0500
In-Reply-To: <1266964587-14381-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>


Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/o=
map2/omapfb/omapfb-main.c
index d17caef..d1f02ae 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -152,9 +152,9 @@ static void fill_fb(struct fb_info *fbi)
 }
 #endif
=20
-static unsigned omapfb_get_vrfb_offset(struct omapfb_info *ofbi, int r=
ot)
+static unsigned omapfb_get_vrfb_offset(const struct omapfb_info *ofbi,=
 int rot)
 {
-	struct vrfb *vrfb =3D &ofbi->region.vrfb;
+	const struct vrfb *vrfb =3D &ofbi->region.vrfb;
 	unsigned offset;
=20
 	switch (rot) {
@@ -179,7 +179,7 @@ static unsigned omapfb_get_vrfb_offset(struct omapf=
b_info *ofbi, int rot)
 	return offset;
 }
=20
-static u32 omapfb_get_region_rot_paddr(struct omapfb_info *ofbi, int r=
ot)
+static u32 omapfb_get_region_rot_paddr(const struct omapfb_info *ofbi,=
 int rot)
 {
 	if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB) {
 		return ofbi->region.vrfb.paddr[rot]
@@ -189,7 +189,7 @@ static u32 omapfb_get_region_rot_paddr(struct omapf=
b_info *ofbi, int rot)
 	}
 }
=20
-static u32 omapfb_get_region_paddr(struct omapfb_info *ofbi)
+static u32 omapfb_get_region_paddr(const struct omapfb_info *ofbi)
 {
 	if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB)
 		return ofbi->region.vrfb.paddr[0];
@@ -197,7 +197,7 @@ static u32 omapfb_get_region_paddr(struct omapfb_in=
fo *ofbi)
 		return ofbi->region.paddr;
 }
=20
-static void __iomem *omapfb_get_region_vaddr(struct omapfb_info *ofbi)
+static void __iomem *omapfb_get_region_vaddr(const struct omapfb_info =
*ofbi)
 {
 	if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB)
 		return ofbi->region.vrfb.vaddr[0];
@@ -778,8 +778,8 @@ static int omapfb_release(struct fb_info *fbi, int =
user)
 	return 0;
 }
=20
-static unsigned calc_rotation_offset_dma(struct fb_var_screeninfo *var=
,
-		struct fb_fix_screeninfo *fix, int rotation)
+static unsigned calc_rotation_offset_dma(const struct fb_var_screeninf=
o *var,
+		const struct fb_fix_screeninfo *fix, int rotation)
 {
 	unsigned offset;
=20
@@ -789,8 +789,8 @@ static unsigned calc_rotation_offset_dma(struct fb_=
var_screeninfo *var,
 	return offset;
 }
=20
-static unsigned calc_rotation_offset_vrfb(struct fb_var_screeninfo *va=
r,
-		struct fb_fix_screeninfo *fix, int rotation)
+static unsigned calc_rotation_offset_vrfb(const struct fb_var_screenin=
fo *var,
+		const struct fb_fix_screeninfo *fix, int rotation)
 {
 	unsigned offset;
=20
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
