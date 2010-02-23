From: ville.syrjala@nokia.com
Subject: [PATCH 3/3] DSS2: OMAPFB: Add support for switching memory regions
Date: Wed, 24 Feb 2010 00:36:27 +0200
Message-ID: <1266964587-14381-3-git-send-email-ville.syrjala@nokia.com>
References: <1266964587-14381-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32416 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab0BWWhF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 17:37:05 -0500
In-Reply-To: <1266964587-14381-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

Separate the memory region from the framebuffer device a little bit.
It's now possible to select the memory region used by the framebuffer
device using the new source_idx parameter of omapfb_plane_info. If the
source_idx is specified it will be interpreted as an index into the
memory regions array, if it's not specified the framebuffer's index is
used instead. So by default each framebuffer keeps using it's own
memory region which preserves backwards compatibility.

This allows cloning the same memory region to several overlays and yet
each overlay can be controlled independently since they can be
associated with separate framebuffer devices.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |  156 +++++++++++++++++++--=
---
 drivers/video/omap2/omapfb/omapfb-main.c  |  185 +++++++++++++++++++--=
--------
 drivers/video/omap2/omapfb/omapfb-sysfs.c |   47 +++++--
 drivers/video/omap2/omapfb/omapfb.h       |   47 +++++++-
 include/linux/omapfb.h                    |    5 +-
 5 files changed, 326 insertions(+), 114 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/=
omap2/omapfb/omapfb-ioctl.c
index 4c4bafd..14f8d6b 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -34,12 +34,37 @@
=20
 #include "omapfb.h"
=20
+static u8 get_source_idx(struct omapfb_info *ofbi)
+{
+	if (ofbi->id =3D=3D ofbi->region->id)
+		return 0;
+
+	return OMAPFB_SOURCE_IDX_ENABLED | ofbi->region->id;
+}
+
+static struct omapfb2_mem_region *get_mem_region(struct omapfb_info *o=
fbi,
+						 u8 source_idx)
+{
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
+
+	if (source_idx & OMAPFB_SOURCE_IDX_ENABLED)
+		source_idx &=3D OMAPFB_SOURCE_IDX_MASK;
+	else
+		source_idx =3D ofbi->id;
+
+	if (source_idx > fbdev->num_fbs)
+		return NULL;
+
+	return omapfb_get_mem_region(&fbdev->regions[source_idx]);
+}
+
 static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane=
_info *pi)
 {
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	struct omap_overlay *ovl;
-	struct omap_overlay_info info;
+	struct omap_overlay_info old_info;
+	struct omapfb2_mem_region *old_rg, *new_rg;
 	int r =3D 0;
=20
 	DBG("omapfb_setup_plane\n");
@@ -52,57 +77,110 @@ static int omapfb_setup_plane(struct fb_info *fbi,=
 struct omapfb_plane_info *pi)
 	/* XXX uses only the first overlay */
 	ovl =3D ofbi->overlays[0];
=20
-	if (pi->enabled && !ofbi->region.size) {
+	old_rg =3D omapfb_get_mem_region(ofbi->region);
+	new_rg =3D get_mem_region(ofbi, pi->source_idx);
+	if (!new_rg) {
+		r =3D -EINVAL;
+		goto out;
+	}
+
+	if (pi->enabled && !new_rg->size) {
 		/*
 		 * This plane's memory was freed, can't enable it
 		 * until it's reallocated.
 		 */
 		r =3D -EINVAL;
-		goto out;
+		goto put_regions;
 	}
=20
-	ovl->get_overlay_info(ovl, &info);
+	ovl->get_overlay_info(ovl, &old_info);
=20
-	info.pos_x =3D pi->pos_x;
-	info.pos_y =3D pi->pos_y;
-	info.out_width =3D pi->out_width;
-	info.out_height =3D pi->out_height;
-	info.enabled =3D pi->enabled;
+	if (old_rg !=3D new_rg) {
+		ofbi->region =3D new_rg;
+		set_fb_fix(fbi);
+	}
=20
-	r =3D ovl->set_overlay_info(ovl, &info);
-	if (r)
-		goto out;
+	if (pi->enabled) {
+		struct omap_overlay_info info;
=20
-	if (ovl->manager) {
-		r =3D ovl->manager->apply(ovl->manager);
+		r =3D omapfb_setup_overlay(fbi, ovl, pi->pos_x, pi->pos_y,
+			pi->out_width, pi->out_height);
 		if (r)
-			goto out;
+			goto undo;
+
+		ovl->get_overlay_info(ovl, &info);
+
+		if (!info.enabled) {
+			info.enabled =3D pi->enabled;
+			r =3D ovl->set_overlay_info(ovl, &info);
+			if (r)
+				goto undo;
+			atomic_inc(&new_rg->use_count);
+		} else {
+			atomic_inc(&new_rg->use_count);
+			atomic_dec(&old_rg->use_count);
+		}
+	} else {
+		struct omap_overlay_info info;
+		bool enabled;
+
+		ovl->get_overlay_info(ovl, &info);
+
+		enabled =3D info.enabled;
+
+		info.enabled =3D pi->enabled;
+		info.pos_x =3D pi->pos_x;
+		info.pos_y =3D pi->pos_y;
+		info.out_width =3D pi->out_width;
+		info.out_height =3D pi->out_height;
+
+		r =3D ovl->set_overlay_info(ovl, &info);
+		if (r)
+			goto undo;
+
+		if (enabled)
+			atomic_dec(&old_rg->use_count);
 	}
=20
-out:
-	if (r)
-		dev_err(fbdev->dev, "setup_plane failed\n");
+	if (ovl->manager)
+		ovl->manager->apply(ovl->manager);
+
+	omapfb_put_mem_region(new_rg);
+	omapfb_put_mem_region(old_rg);
+
+	return 0;
+
+ undo:
+	if (old_rg !=3D new_rg) {
+		ofbi->region =3D old_rg;
+		set_fb_fix(fbi);
+	}
+
+	ovl->set_overlay_info(ovl, &old_info);
+ put_regions:
+	omapfb_put_mem_region(new_rg);
+	omapfb_put_mem_region(old_rg);
+ out:
+	dev_err(fbdev->dev, "setup_plane failed\n");
+
 	return r;
 }
=20
 static int omapfb_query_plane(struct fb_info *fbi, struct omapfb_plane=
_info *pi)
 {
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omap_overlay *ovl =3D ofbi->overlays[0];
+	struct omap_overlay_info *ovli =3D &ovl->info;
=20
 	if (ofbi->num_overlays !=3D 1) {
 		memset(pi, 0, sizeof(*pi));
 	} else {
-		struct omap_overlay_info *ovli;
-		struct omap_overlay *ovl;
-
-		ovl =3D ofbi->overlays[0];
-		ovli =3D &ovl->info;
-
 		pi->pos_x =3D ovli->pos_x;
 		pi->pos_y =3D ovli->pos_y;
 		pi->enabled =3D ovli->enabled;
 		pi->channel_out =3D 0; /* xxx */
 		pi->mirror =3D 0;
+		pi->source_idx =3D get_source_idx(ofbi);
 		pi->out_width =3D ovli->out_width;
 		pi->out_height =3D ovli->out_height;
 	}
@@ -115,7 +193,7 @@ static int omapfb_setup_mem(struct fb_info *fbi, st=
ruct omapfb_mem_info *mi)
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	struct omapfb2_mem_region *rg;
-	int r, i;
+	int r =3D 0;
 	size_t size;
=20
 	if (mi->type > OMAPFB_MEMTYPE_MAX)
@@ -123,22 +201,33 @@ static int omapfb_setup_mem(struct fb_info *fbi, =
struct omapfb_mem_info *mi)
=20
 	size =3D PAGE_ALIGN(mi->size);
=20
-	rg =3D &ofbi->region;
+	rg =3D ofbi->region;
=20
-	for (i =3D 0; i < ofbi->num_overlays; i++) {
-		if (ofbi->overlays[i]->info.enabled)
-			return -EBUSY;
+	/* FIXME probably should be a rwsem ... */
+	mutex_lock(&rg->mtx);
+	while (rg->ref) {
+		mutex_unlock(&rg->mtx);
+		schedule();
+		mutex_lock(&rg->mtx);
+	}
+
+	if (atomic_read(&rg->map_count) || atomic_read(&rg->use_count)) {
+		r =3D -EBUSY;
+		goto out;
 	}
=20
 	if (rg->size !=3D size || rg->type !=3D mi->type) {
 		r =3D omapfb_realloc_fbmem(fbi, size, mi->type);
 		if (r) {
 			dev_err(fbdev->dev, "realloc fbmem failed\n");
-			return r;
+			goto out;
 		}
 	}
=20
-	return 0;
+ out:
+	mutex_unlock(&rg->mtx);
+
+	return r;
 }
=20
 static int omapfb_query_mem(struct fb_info *fbi, struct omapfb_mem_inf=
o *mi)
@@ -146,12 +235,15 @@ static int omapfb_query_mem(struct fb_info *fbi, =
struct omapfb_mem_info *mi)
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	struct omapfb2_mem_region *rg;
=20
-	rg =3D &ofbi->region;
 	memset(mi, 0, sizeof(*mi));
=20
+	rg =3D omapfb_get_mem_region(ofbi->region);
+
 	mi->size =3D rg->size;
 	mi->type =3D rg->type;
=20
+	omapfb_put_mem_region(rg);
+
 	return 0;
 }
=20
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/o=
map2/omapfb/omapfb-main.c
index d1f02ae..954cab2 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -154,7 +154,7 @@ static void fill_fb(struct fb_info *fbi)
=20
 static unsigned omapfb_get_vrfb_offset(const struct omapfb_info *ofbi,=
 int rot)
 {
-	const struct vrfb *vrfb =3D &ofbi->region.vrfb;
+	const struct vrfb *vrfb =3D &ofbi->region->vrfb;
 	unsigned offset;
=20
 	switch (rot) {
@@ -182,27 +182,27 @@ static unsigned omapfb_get_vrfb_offset(const stru=
ct omapfb_info *ofbi, int rot)
 static u32 omapfb_get_region_rot_paddr(const struct omapfb_info *ofbi,=
 int rot)
 {
 	if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB) {
-		return ofbi->region.vrfb.paddr[rot]
+		return ofbi->region->vrfb.paddr[rot]
 			+ omapfb_get_vrfb_offset(ofbi, rot);
 	} else {
-		return ofbi->region.paddr;
+		return ofbi->region->paddr;
 	}
 }
=20
 static u32 omapfb_get_region_paddr(const struct omapfb_info *ofbi)
 {
 	if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB)
-		return ofbi->region.vrfb.paddr[0];
+		return ofbi->region->vrfb.paddr[0];
 	else
-		return ofbi->region.paddr;
+		return ofbi->region->paddr;
 }
=20
 static void __iomem *omapfb_get_region_vaddr(const struct omapfb_info =
*ofbi)
 {
 	if (ofbi->rotation_type =3D=3D OMAP_DSS_ROT_VRFB)
-		return ofbi->region.vrfb.vaddr[0];
+		return ofbi->region->vrfb.vaddr[0];
 	else
-		return ofbi->region.vaddr;
+		return ofbi->region->vaddr;
 }
=20
 static struct omapfb_colormode omapfb_colormodes[] =3D {
@@ -447,7 +447,7 @@ static int check_vrfb_fb_size(unsigned long region_=
size,
 static int check_fb_size(const struct omapfb_info *ofbi,
 		struct fb_var_screeninfo *var)
 {
-	unsigned long max_frame_size =3D ofbi->region.size;
+	unsigned long max_frame_size =3D ofbi->region->size;
 	int bytespp =3D var->bits_per_pixel >> 3;
 	unsigned long line_size =3D var->xres_virtual * bytespp;
=20
@@ -494,7 +494,7 @@ static int check_fb_size(const struct omapfb_info *=
ofbi,
 static int setup_vrfb_rotation(struct fb_info *fbi)
 {
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
-	struct omapfb2_mem_region *rg =3D &ofbi->region;
+	struct omapfb2_mem_region *rg =3D ofbi->region;
 	struct vrfb *vrfb =3D &rg->vrfb;
 	struct fb_var_screeninfo *var =3D &fbi->var;
 	struct fb_fix_screeninfo *fix =3D &fbi->fix;
@@ -555,9 +555,9 @@ static int setup_vrfb_rotation(struct fb_info *fbi)
 		return r;
=20
 	/* used by open/write in fbmem.c */
-	fbi->screen_base =3D ofbi->region.vrfb.vaddr[0];
+	fbi->screen_base =3D ofbi->region->vrfb.vaddr[0];
=20
-	fix->smem_start =3D ofbi->region.vrfb.paddr[0];
+	fix->smem_start =3D ofbi->region->vrfb.paddr[0];
=20
 	switch (var->nonstd) {
 	case OMAPFB_COLOR_YUV422:
@@ -596,7 +596,7 @@ void set_fb_fix(struct fb_info *fbi)
 	struct fb_fix_screeninfo *fix =3D &fbi->fix;
 	struct fb_var_screeninfo *var =3D &fbi->var;
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
-	struct omapfb2_mem_region *rg =3D &ofbi->region;
+	struct omapfb2_mem_region *rg =3D ofbi->region;
=20
 	DBG("set_fb_fix\n");
=20
@@ -665,9 +665,6 @@ int check_fb_var(struct fb_info *fbi, struct fb_var=
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
@@ -687,7 +684,8 @@ int check_fb_var(struct fb_info *fbi, struct fb_var=
_screeninfo *var)
 	if (check_fb_res_bounds(var))
 		return -EINVAL;
=20
-	if (check_fb_size(ofbi, var))
+	/* When no memory is allocated ignore the size check */
+	if (ofbi->region->size !=3D 0 && check_fb_size(ofbi, var))
 		return -EINVAL;
=20
 	if (var->xres + var->xoffset > var->xres_virtual)
@@ -819,9 +817,43 @@ static unsigned calc_rotation_offset_vrfb(const st=
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
-static int omapfb_setup_overlay(struct fb_info *fbi, struct omap_overl=
ay *ovl,
+int omapfb_setup_overlay(struct fb_info *fbi, struct omap_overlay *ovl=
,
 		u16 posx, u16 posy, u16 outw, u16 outh)
 {
 	int r =3D 0;
@@ -829,9 +861,8 @@ static int omapfb_setup_overlay(struct fb_info *fbi=
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
@@ -858,28 +889,9 @@ static int omapfb_setup_overlay(struct fb_info *fb=
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
+	if (ofbi->region->size)
+		omapfb_calc_addr(ofbi, var, fix, rotation,
+				 &data_start_p, &data_start_v);
=20
 	r =3D fb_mode_to_dss_mode(var, &mode);
 	if (r) {
@@ -956,9 +968,9 @@ int omapfb_apply_changes(struct fb_info *fbi, int i=
nit)
=20
 		DBG("apply_changes, fb %d, ovl %d\n", ofbi->id, ovl->id);
=20
-		if (ofbi->region.size =3D=3D 0) {
+		if (ofbi->region->size =3D=3D 0) {
 			/* the fb is not available. disable the overlay */
-			omapfb_overlay_enable(ovl, 0);
+			r =3D omapfb_overlay_enable(ofbi, ovl, false);
 			if (!init && ovl->manager)
 				ovl->manager->apply(ovl->manager);
 			continue;
@@ -1004,36 +1016,48 @@ err:
  * DO NOT MODIFY PAR */
 static int omapfb_check_var(struct fb_var_screeninfo *var, struct fb_i=
nfo *fbi)
 {
+	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	int r;
=20
 	DBG("check_var(%d)\n", FB2OFB(fbi)->id);
=20
+	omapfb_get_mem_region(ofbi->region);
+
 	r =3D check_fb_var(fbi, var);
=20
+	omapfb_put_mem_region(ofbi->region);
+
 	return r;
 }
=20
 /* set the video mode according to info->var */
 static int omapfb_set_par(struct fb_info *fbi)
 {
+	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	int r;
=20
 	DBG("set_par(%d)\n", FB2OFB(fbi)->id);
=20
+	omapfb_get_mem_region(ofbi->region);
+
 	set_fb_fix(fbi);
=20
 	r =3D setup_vrfb_rotation(fbi);
 	if (r)
-		return r;
+		goto out;
=20
 	r =3D omapfb_apply_changes(fbi, 0);
=20
+ out:
+	omapfb_put_mem_region(ofbi->region);
+
 	return r;
 }
=20
 static int omapfb_pan_display(struct fb_var_screeninfo *var,
 		struct fb_info *fbi)
 {
+	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	struct fb_var_screeninfo new_var;
 	int r;
=20
@@ -1049,23 +1073,31 @@ static int omapfb_pan_display(struct fb_var_scr=
eeninfo *var,
=20
 	fbi->var =3D new_var;
=20
+	omapfb_get_mem_region(ofbi->region);
+
 	r =3D omapfb_apply_changes(fbi, 0);
=20
+	omapfb_put_mem_region(ofbi->region);
+
 	return r;
 }
=20
 static void mmap_user_open(struct vm_area_struct *vma)
 {
-	struct omapfb_info *ofbi =3D (struct omapfb_info *)vma->vm_private_da=
ta;
+	struct omapfb2_mem_region *rg =3D vma->vm_private_data;
=20
-	atomic_inc(&ofbi->map_count);
+	omapfb_get_mem_region(rg);
+	atomic_inc(&rg->map_count);
+	omapfb_put_mem_region(rg);
 }
=20
 static void mmap_user_close(struct vm_area_struct *vma)
 {
-	struct omapfb_info *ofbi =3D (struct omapfb_info *)vma->vm_private_da=
ta;
+	struct omapfb2_mem_region *rg =3D vma->vm_private_data;
=20
-	atomic_dec(&ofbi->map_count);
+	omapfb_get_mem_region(rg);
+	atomic_dec(&rg->map_count);
+	omapfb_put_mem_region(rg);
 }
=20
 static struct vm_operations_struct mmap_user_ops =3D {
@@ -1077,9 +1109,11 @@ static int omapfb_mmap(struct fb_info *fbi, stru=
ct vm_area_struct *vma)
 {
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	struct fb_fix_screeninfo *fix =3D &fbi->fix;
+	struct omapfb2_mem_region *rg;
 	unsigned long off;
 	unsigned long start;
 	u32 len;
+	int r =3D -EINVAL;
=20
 	if (vma->vm_end - vma->vm_start =3D=3D 0)
 		return 0;
@@ -1087,12 +1121,14 @@ static int omapfb_mmap(struct fb_info *fbi, str=
uct vm_area_struct *vma)
 		return -EINVAL;
 	off =3D vma->vm_pgoff << PAGE_SHIFT;
=20
+	rg =3D omapfb_get_mem_region(ofbi->region);
+
 	start =3D omapfb_get_region_paddr(ofbi);
 	len =3D fix->smem_len;
 	if (off >=3D len)
-		return -EINVAL;
+		goto error;
 	if ((vma->vm_end - vma->vm_start + off) > len)
-		return -EINVAL;
+		goto error;
=20
 	off +=3D start;
=20
@@ -1102,13 +1138,24 @@ static int omapfb_mmap(struct fb_info *fbi, str=
uct vm_area_struct *vma)
 	vma->vm_flags |=3D VM_IO | VM_RESERVED;
 	vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);
 	vma->vm_ops =3D &mmap_user_ops;
-	vma->vm_private_data =3D ofbi;
+	vma->vm_private_data =3D rg;
 	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
-			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
-		return -EAGAIN;
+			vma->vm_end - vma->vm_start, vma->vm_page_prot)) {
+		r =3D -EAGAIN;
+		goto error;
+	}
+
 	/* vm_ops.open won't be called for mmap itself. */
-	atomic_inc(&ofbi->map_count);
+	atomic_inc(&rg->map_count);
+
+	omapfb_put_mem_region(rg);
+
 	return 0;
+
+ error:
+	omapfb_put_mem_region(ofbi->region);
+
+	return r;
 }
=20
 /* Store a single color palette entry into a pseudo palette or the har=
dware
@@ -1297,7 +1344,10 @@ static void omapfb_free_fbmem(struct fb_info *fb=
i)
 	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	struct omapfb2_mem_region *rg;
=20
-	rg =3D &ofbi->region;
+	rg =3D ofbi->region;
+
+	WARN_ON(atomic_read(&rg->map_count));
+	WARN_ON(atomic_read(&rg->use_count));
=20
 	if (rg->paddr)
 		if (omap_vram_free(rg->paddr, rg->size))
@@ -1352,8 +1402,15 @@ static int omapfb_alloc_fbmem(struct fb_info *fb=
i, unsigned long size,
 	void __iomem *vaddr;
 	int r;
=20
-	rg =3D &ofbi->region;
-	memset(rg, 0, sizeof(*rg));
+	rg =3D ofbi->region;
+
+	rg->paddr =3D 0;
+	rg->vaddr =3D NULL;
+	memset(&rg->vrfb, 0, sizeof rg->vrfb);
+	rg->size =3D 0;
+	rg->type =3D 0;
+	rg->alloc =3D false;
+	rg->map =3D false;
=20
 	size =3D PAGE_ALIGN(size);
=20
@@ -1605,7 +1662,7 @@ static int omapfb_allocate_all_fbs(struct omapfb2=
_device *fbdev)
 	for (i =3D 0; i < fbdev->num_fbs; i++) {
 		struct omapfb_info *ofbi =3D FB2OFB(fbdev->fbs[i]);
 		struct omapfb2_mem_region *rg;
-		rg =3D &ofbi->region;
+		rg =3D ofbi->region;
=20
 		DBG("region%d phys %08x virt %p size=3D%lu\n",
 				i,
@@ -1622,7 +1679,7 @@ int omapfb_realloc_fbmem(struct fb_info *fbi, uns=
igned long size, int type)
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	struct omap_dss_device *display =3D fb2display(fbi);
-	struct omapfb2_mem_region *rg =3D &ofbi->region;
+	struct omapfb2_mem_region *rg =3D ofbi->region;
 	unsigned long old_size =3D rg->size;
 	unsigned long old_paddr =3D rg->paddr;
 	int old_type =3D rg->type;
@@ -1705,7 +1762,7 @@ static int omapfb_fb_init(struct omapfb2_device *=
fbdev, struct fb_info *fbi)
 	fbi->flags =3D FBINFO_FLAG_DEFAULT;
 	fbi->pseudo_palette =3D fbdev->pseudo_palette;
=20
-	if (ofbi->region.size =3D=3D 0) {
+	if (ofbi->region->size =3D=3D 0) {
 		clear_fb_info(fbi);
 		return 0;
 	}
@@ -1867,6 +1924,10 @@ static int omapfb_create_framebuffers(struct oma=
pfb2_device *fbdev)
 		ofbi->fbdev =3D fbdev;
 		ofbi->id =3D i;
=20
+		ofbi->region =3D &fbdev->regions[i];
+		ofbi->region->id =3D i;
+		mutex_init(&ofbi->region->mtx);
+
 		/* assign these early, so that fb alloc can use them */
 		ofbi->rotation_type =3D def_vrfb ? OMAP_DSS_ROT_VRFB :
 			OMAP_DSS_ROT_DMA;
@@ -1938,7 +1999,7 @@ static int omapfb_create_framebuffers(struct omap=
fb2_device *fbdev)
 		if (ofbi->num_overlays > 0) {
 			struct omap_overlay *ovl =3D ofbi->overlays[0];
=20
-			r =3D omapfb_overlay_enable(ovl, 1);
+			r =3D omapfb_overlay_enable(ofbi, ovl, true);
=20
 			if (r) {
 				dev_err(fbdev->dev,
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/=
omap2/omapfb/omapfb-sysfs.c
index 62bb88f..ea02c02 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -49,6 +49,7 @@ static ssize_t store_rotate_type(struct device *dev,
 {
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_mem_region *rg;
 	enum omap_dss_rotation_type rot_type;
 	int r;
=20
@@ -63,9 +64,11 @@ static ssize_t store_rotate_type(struct device *dev,
 	if (rot_type =3D=3D ofbi->rotation_type)
 		goto out;
=20
-	if (ofbi->region.size) {
+	rg =3D omapfb_get_mem_region(ofbi->region);
+
+	if (rg->size) {
 		r =3D -EBUSY;
-		goto out;
+		goto put_region;
 	}
=20
 	ofbi->rotation_type =3D rot_type;
@@ -74,7 +77,10 @@ static ssize_t store_rotate_type(struct device *dev,
 	 * Since the VRAM for this FB is not allocated at the moment we don't
 	 * need to do any further parameter checking at this point.
 	 */
+put_region:
+	omapfb_put_mem_region(rg);
 out:
+
 	unlock_fb_info(fbi);
=20
 	return r ? r : count;
@@ -242,6 +248,7 @@ static ssize_t store_overlays(struct device *dev, s=
truct device_attribute *attr,
 	/* detach unused overlays */
 	for (i =3D 0; i < ofbi->num_overlays; ++i) {
 		int t, found;
+		struct omapfb2_mem_region *rg;
=20
 		ovl =3D ofbi->overlays[i];
=20
@@ -259,7 +266,9 @@ static ssize_t store_overlays(struct device *dev, s=
truct device_attribute *attr,
=20
 		DBG("detaching %d\n", ofbi->overlays[i]->id);
=20
-		omapfb_overlay_enable(ovl, 0);
+		rg =3D omapfb_get_mem_region(ofbi->region);
+		r =3D omapfb_overlay_enable(ofbi, ovl, false);
+		omapfb_put_mem_region(ofbi->region);
=20
 		if (ovl->manager)
 			ovl->manager->apply(ovl->manager);
@@ -402,7 +411,7 @@ static ssize_t show_size(struct device *dev,
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
=20
-	return snprintf(buf, PAGE_SIZE, "%lu\n", ofbi->region.size);
+	return snprintf(buf, PAGE_SIZE, "%lu\n", ofbi->region->size);
 }
=20
 static ssize_t store_size(struct device *dev, struct device_attribute =
*attr,
@@ -410,23 +419,31 @@ static ssize_t store_size(struct device *dev, str=
uct device_attribute *attr,
 {
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_mem_region *rg;
 	unsigned long size;
 	int r;
-	int i;
=20
 	size =3D PAGE_ALIGN(simple_strtoul(buf, NULL, 0));
=20
 	lock_fb_info(fbi);
=20
-	for (i =3D 0; i < ofbi->num_overlays; i++) {
-		if (ofbi->overlays[i]->info.enabled) {
-			r =3D -EBUSY;
-			goto out;
-		}
+	rg =3D ofbi->region;
+
+	/* FIXME probably should be a rwsem ... */
+	mutex_lock(&rg->mtx);
+	while (rg->ref) {
+		mutex_unlock(&rg->mtx);
+		schedule();
+		mutex_lock(&rg->mtx);
+	}
+
+	if (atomic_read(&rg->map_count) || atomic_read(&rg->use_count)) {
+		r =3D -EBUSY;
+		goto out;
 	}
=20
-	if (size !=3D ofbi->region.size) {
-		r =3D omapfb_realloc_fbmem(fbi, size, ofbi->region.type);
+	if (size !=3D ofbi->region->size) {
+		r =3D omapfb_realloc_fbmem(fbi, size, ofbi->region->type);
 		if (r) {
 			dev_err(dev, "realloc fbmem failed\n");
 			goto out;
@@ -435,6 +452,8 @@ static ssize_t store_size(struct device *dev, struc=
t device_attribute *attr,
=20
 	r =3D count;
 out:
+	mutex_unlock(&rg->mtx);
+
 	unlock_fb_info(fbi);
=20
 	return r;
@@ -446,7 +465,7 @@ static ssize_t show_phys(struct device *dev,
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
=20
-	return snprintf(buf, PAGE_SIZE, "%0x\n", ofbi->region.paddr);
+	return snprintf(buf, PAGE_SIZE, "%0x\n", ofbi->region->paddr);
 }
=20
 static ssize_t show_virt(struct device *dev,
@@ -455,7 +474,7 @@ static ssize_t show_virt(struct device *dev,
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
=20
-	return snprintf(buf, PAGE_SIZE, "%p\n", ofbi->region.vaddr);
+	return snprintf(buf, PAGE_SIZE, "%p\n", ofbi->region->vaddr);
 }
=20
 static struct device_attribute omapfb_attrs[] =3D {
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/=
omapfb/omapfb.h
index f7c9c73..62afb42 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -44,6 +44,7 @@ extern unsigned int omapfb_debug;
 #define OMAPFB_MAX_OVL_PER_FB 3
=20
 struct omapfb2_mem_region {
+	int             id;
 	u32		paddr;
 	void __iomem	*vaddr;
 	struct vrfb	vrfb;
@@ -51,13 +52,16 @@ struct omapfb2_mem_region {
 	u8		type;		/* OMAPFB_PLANE_MEM_* */
 	bool		alloc;		/* allocated by the driver */
 	bool		map;		/* kernel mapped by the driver */
+	struct mutex    mtx;
+	unsigned int    ref;
+	atomic_t	map_count;
+	atomic_t	use_count;
 };
=20
 /* appended to fb_info */
 struct omapfb_info {
 	int id;
-	struct omapfb2_mem_region region;
-	atomic_t map_count;
+	struct omapfb2_mem_region *region;
 	int num_overlays;
 	struct omap_overlay *overlays[OMAPFB_MAX_OVL_PER_FB];
 	struct omapfb2_device *fbdev;
@@ -76,6 +80,7 @@ struct omapfb2_device {
=20
 	unsigned num_fbs;
 	struct fb_info *fbs[10];
+	struct omapfb2_mem_region regions[10];
=20
 	unsigned num_displays;
 	struct omap_dss_device *displays[10];
@@ -108,6 +113,9 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int =
cmd, unsigned long arg);
 int dss_mode_to_fb_mode(enum omap_color_mode dssmode,
 			struct fb_var_screeninfo *var);
=20
+int omapfb_setup_overlay(struct fb_info *fbi, struct omap_overlay *ovl=
,
+		u16 posx, u16 posy, u16 outw, u16 outh);
+
 /* find the display connected to this fb, if any */
 static inline struct omap_dss_device *fb2display(struct fb_info *fbi)
 {
@@ -133,14 +141,43 @@ static inline void omapfb_unlock(struct omapfb2_d=
evice *fbdev)
 	mutex_unlock(&fbdev->mtx);
 }
=20
-static inline int omapfb_overlay_enable(struct omap_overlay *ovl,
-		int enable)
+static inline int omapfb_overlay_enable(struct omapfb_info *ofbi,
+					struct omap_overlay *ovl,
+					int enable)
 {
 	struct omap_overlay_info info;
+	int r;
=20
 	ovl->get_overlay_info(ovl, &info);
+	if (info.enabled =3D=3D enable)
+		return 0;
 	info.enabled =3D enable;
-	return ovl->set_overlay_info(ovl, &info);
+	r =3D ovl->set_overlay_info(ovl, &info);
+	if (r)
+		return r;
+
+	if (enable)
+		atomic_inc(&ofbi->region->use_count);
+	else
+		atomic_dec(&ofbi->region->use_count);
+
+	return 0;
+}
+
+static inline struct omapfb2_mem_region *
+omapfb_get_mem_region(struct omapfb2_mem_region *rg)
+{
+	mutex_lock(&rg->mtx);
+	rg->ref++;
+	mutex_unlock(&rg->mtx);
+	return rg;
+}
+
+static inline void omapfb_put_mem_region(struct omapfb2_mem_region *rg=
)
+{
+	mutex_lock(&rg->mtx);
+	rg->ref--;
+	mutex_unlock(&rg->mtx);
 }
=20
 #endif
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index f46c40a..6bb0d50 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -84,6 +84,9 @@
 #define OMAPFB_MEMTYPE_SRAM		1
 #define OMAPFB_MEMTYPE_MAX		1
=20
+#define OMAPFB_SOURCE_IDX_ENABLED	0x8
+#define OMAPFB_SOURCE_IDX_MASK		0x7
+
 enum omapfb_color_format {
 	OMAPFB_COLOR_RGB565 =3D 0,
 	OMAPFB_COLOR_YUV422,
@@ -135,7 +138,7 @@ struct omapfb_plane_info {
 	__u8  enabled;
 	__u8  channel_out;
 	__u8  mirror;
-	__u8  reserved1;
+	__u8  source_idx;
 	__u32 out_width;
 	__u32 out_height;
 	__u32 reserved2[12];
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
