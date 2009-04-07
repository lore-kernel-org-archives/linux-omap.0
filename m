From: Gregoire Gentil <gregoire@gentil.com>
Subject: YUV rotation support for DSS2 - 2.6.29 [WAS Re: Hello Tomi
	Valkeinen, I have some questions about dss2 driver.]
Date: Mon, 06 Apr 2009 21:30:02 -0700
Message-ID: <1239078602.16520.59.camel@localhost>
References: <90b950fc0903102157q21dec037m65edee4afe104d6a@mail.gmail.com>
	 <1236757641.12797.16.camel@tubuntu>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-HDkXRcW/DUVbJ/ASIQbW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:19395 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbZDGEaI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 00:30:08 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2579803wff.4
        for <linux-omap@vger.kernel.org>; Mon, 06 Apr 2009 21:30:06 -0700 (PDT)
In-Reply-To: <1236757641.12797.16.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, beagleboard@googlegroups.com, plasm@roo.me.uk


--=-HDkXRcW/DUVbJ/ASIQbW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Tomi,

Tim has patched your latest DSS2 2.6.29 git (master branch) to add
support for YUV rotation. It has been successfully tested on the coming
Touch Book, as well as the Beagleboard Rev B6 with the exception of the
bug mentioned below. You may want to review this patch and perhaps
integrate once we have fixed the problem below.

A couple of questions and comments:

﻿1. dss.c has no way of knowing whether VRFB is being used or not --
this is a problem because you need to decide whether to call
calc_rotation_offset_vrfb(...) or calc_rotation_offset(...). Any
suggestions on how the rotation mode should be passed between dss.c and
omapfb-main.c?

2. If I try to rotate both plane 0 and plane 1 to either 90 degrees or
270 (doesn't matter which is which), as soon as you try to play a video
you get VID1_FIFO_UNDERFLOW error messages, so it seems that the
hardware seems to be struggling a little when you have two sets of
90/270 degree rotations. If one of the planes is 0/180 and the other
is 90/270, then everything is fine. Would changing the FIFO settings
somehow improve this or do you have any ideas about what else might make
it work better?


Thanks in advance,

Grégoire Gentil


--=-HDkXRcW/DUVbJ/ASIQbW
Content-Disposition: attachment; filename=vrfb-yuv-rotation.patch
Content-Type: text/x-patch; name=vrfb-yuv-rotation.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/arch/arm/plat-omap/vrfb.c b/arch/arm/plat-omap/vrfb.c
index 7e0f8fc..77aa9a7 100644
--- a/arch/arm/plat-omap/vrfb.c
+++ b/arch/arm/plat-omap/vrfb.c
@@ -61,8 +61,10 @@ void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
 			width, height, bytespp);
 
 	if (bytespp == 4)
+	{
 		pixel_size_exp = 2;
-	else if (bytespp == 2)
+		width >>= 1;
+	} else if (bytespp == 2)
 		pixel_size_exp = 1;
 	else
 		BUG();
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 2480a03..1f022ce 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1089,7 +1089,8 @@ static void _dispc_set_scaling(enum omap_plane plane,
 }
 
 static void _dispc_set_rotation_attrs(enum omap_plane plane, u8 rotation,
-		bool mirroring, enum omap_color_mode color_mode)
+		bool mirroring, enum omap_color_mode color_mode, u16 width,
+		u16 height)
 {
 	if (color_mode == OMAP_DSS_COLOR_YUV2 ||
 			color_mode == OMAP_DSS_COLOR_UYVY) {
@@ -1107,7 +1108,7 @@ static void _dispc_set_rotation_attrs(enum omap_plane plane, u8 rotation,
 			case 0: vidrot = 0; break;
 			case 1: vidrot = 1; break;
 			case 2: vidrot = 2; break;
-			case 3: vidrot = 1; break;
+			case 3: vidrot = 3; break;
 			}
 		}
 
@@ -1121,6 +1122,13 @@ static void _dispc_set_rotation_attrs(enum omap_plane plane, u8 rotation,
 		REG_FLD_MOD(dispc_reg_att[plane], 0, 13, 12);
 		REG_FLD_MOD(dispc_reg_att[plane], 0, 18, 18);
 	}
+
+	/* Turn on DMA optimization. For this to work, both height
+	   and width need to be even... */
+	if(width % 2 == 0 && height % 2 == 0 && (rotation == 1 || rotation == 3))
+		REG_FLD_MOD(dispc_reg_att[plane], 1, 20, 20);
+	else
+		REG_FLD_MOD(dispc_reg_att[plane], 0, 20, 20);
 }
 
 static s32 pixinc(int pixels, u8 ps)
@@ -1283,6 +1291,76 @@ static void calc_rotation_offset(u8 rotation, bool mirror,
 	}
 }
 
+static void calc_rotation_offset_vrfb(u8 rotation, bool mirror,
+		u16 screen_width,
+		u16 width, u16 height,
+		enum omap_color_mode color_mode, bool fieldmode,
+		unsigned *offset0, unsigned *offset1,
+		s32 *row_inc, s32 *pix_inc)
+{
+	u8 ps;
+	u16 fbw, fbh;
+
+	DSSDBG("calc_rot(%d): scrw %d, %dx%d, cm %d\n", rotation, screen_width,
+			width, height, color_mode);
+
+	/* width & height are overlay sizes, convert to fb sizes */
+	if (rotation == 0 || rotation == 2) {
+		fbw = width;
+		fbh = height;
+	} else {
+		fbw = height;
+		fbh = width;
+	}
+
+	switch (color_mode) {
+	case OMAP_DSS_COLOR_RGB16:
+	case OMAP_DSS_COLOR_ARGB16:
+		ps = 2;
+		break;
+
+	case OMAP_DSS_COLOR_RGB24P:
+		ps = 3;
+		break;
+
+	case OMAP_DSS_COLOR_RGB24U:
+	case OMAP_DSS_COLOR_ARGB32:
+	case OMAP_DSS_COLOR_RGBA32:
+	case OMAP_DSS_COLOR_RGBX32:
+		ps = 4;
+		break;
+
+	case OMAP_DSS_COLOR_YUV2:
+	case OMAP_DSS_COLOR_UYVY:
+		ps = 4;
+		fbw >>= 1;
+		break;
+	default:
+		BUG();
+		return;
+	}
+
+	*pix_inc = 1;
+	switch(rotation + mirror * 4) {
+		case 0:
+		case 1:
+		case 2:
+		case 3:
+			*offset0 = *offset1 = 0;
+			break;
+		default:
+			BUG();
+	}
+
+        if(!mirror) {
+		if(rotation == 0 || rotation == 2)
+			*row_inc = 1 + (screen_width - fbw) * ps;
+		else
+			*row_inc = 1 + (screen_width - fbh) * ps;
+	} else
+		BUG();
+}
+
 static int _dispc_setup_plane(enum omap_plane plane,
 		enum omap_channel channel_out,
 		u32 paddr, u16 screen_width,
@@ -1361,7 +1439,7 @@ static int _dispc_setup_plane(enum omap_plane plane,
 	if (ilace && height >= out_height)
 		fieldmode = 1;
 
-	calc_rotation_offset(rotation, mirror,
+	calc_rotation_offset_vrfb(rotation, mirror,
 			screen_width, width, height, color_mode,
 			fieldmode,
 			&offset0, &offset1, &row_inc, &pix_inc);
@@ -1393,18 +1471,25 @@ static int _dispc_setup_plane(enum omap_plane plane,
 			out_width, out_height);
 
 	_dispc_set_plane_pos(plane, pos_x, pos_y);
-
 	_dispc_set_pic_size(plane, width, height);
 
 	if (plane != OMAP_DSS_GFX) {
-		_dispc_set_scaling(plane, width, height,
-				   out_width, out_height,
-				   ilace);
-		_dispc_set_vid_size(plane, out_width, out_height);
+		if(rotation == 0 || rotation == 2)
+		{
+			_dispc_set_scaling(plane, width, height,
+					   out_width, out_height,
+					   ilace);
+			_dispc_set_vid_size(plane, out_width, out_height);
+		} else {
+			_dispc_set_scaling(plane, width, height,
+					   out_height, out_width,
+					   ilace);
+			_dispc_set_vid_size(plane, out_height, out_width);
+		}
 		_dispc_set_vid_color_conv(plane, cconv);
 	}
 
-	_dispc_set_rotation_attrs(plane, rotation, mirror, color_mode);
+	_dispc_set_rotation_attrs(plane, rotation, mirror, color_mode, width, height);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index afe40a9..02d308a 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -420,10 +420,14 @@ void set_fb_fix(struct fb_info *fbi)
 	fix->ypanstep = 1;
 
 	if (rg->size) {
-		if (ofbi->rotation_type == OMAPFB_ROT_VRFB)
+		if (ofbi->rotation_type == OMAPFB_ROT_VRFB && ofbi->id == 0)
 			omap_vrfb_setup(&rg->vrfb, rg->paddr,
 					var->xres_virtual, var->yres_virtual,
 					var->bits_per_pixel >> 3);
+		else if (ofbi->rotation_type == OMAPFB_ROT_VRFB && ofbi->id != 0)
+			omap_vrfb_setup(&rg->vrfb, rg->paddr,
+					var->xres_virtual, var->yres_virtual,
+					var->bits_per_pixel >> 2);
 	}
 }
 
@@ -487,6 +491,8 @@ int check_fb_var(struct fb_info *fbi, struct fb_var_screeninfo *var)
 	yres_max = 2048;
 
 	bytespp = var->bits_per_pixel >> 3;
+	if(mode == OMAP_DSS_COLOR_YUV2 || mode == OMAP_DSS_COLOR_UYVY)
+		bytespp <<= 1;
 
 	/* XXX: some applications seem to set virtual res to 0. */
 	if (var->xres_virtual == 0)
@@ -696,13 +702,8 @@ static int omapfb_setup_overlay(struct fb_info *fbi, struct omap_overlay *ovl,
 
 	ovl->get_overlay_info(ovl, &info);
 
-	if (ofbi->rotation_type == OMAPFB_ROT_VRFB) {
-		rot = 0;
-		mirror = 0;
-	} else {
-		rot = ofbi->rotation;
-		mirror = ofbi->mirror;
-	}
+	rot = ofbi->rotation;
+	mirror = ofbi->mirror;
 
 	info.paddr = data_start_p;
 	info.vaddr = data_start_v;

--=-HDkXRcW/DUVbJ/ASIQbW--

