From: ville.syrjala@nokia.com
Subject: [PATCH v4 4/8] DSS2: OMAPFB: Add support for switching memory regions
Date: Thu, 18 Mar 2010 00:46:19 +0200
Message-ID: <1268865983-16270-5-git-send-email-ville.syrjala@nokia.com>
References: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63354 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243Ab0CQWqx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 18:46:53 -0400
In-Reply-To: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Imre Deak <imre.deak@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

Separate the memory region from the framebuffer device a little bit.
It's now possible to select the memory region used by the framebuffer
device using the new mem_idx parameter of omapfb_plane_info. If the
mem_idx is specified it will be interpreted as an index into the
memory regions array, if it's not specified the framebuffer's index is
used instead. So by default each framebuffer keeps using it's own
memory region which preserves backwards compatibility.

This allows cloning the same memory region to several overlays and yet
each overlay can be controlled independently since they can be
associated with separate framebuffer devices.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |  125 +++++++++++++++++++++=
++-----
 drivers/video/omap2/omapfb/omapfb-main.c  |   71 ++++++++++-------
 drivers/video/omap2/omapfb/omapfb-sysfs.c |   37 ++++++---
 drivers/video/omap2/omapfb/omapfb.h       |    9 ++-
 include/linux/omapfb.h                    |    5 +-
 5 files changed, 183 insertions(+), 64 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/=
omap2/omapfb/omapfb-ioctl.c
index 1ffa760..a160a3e 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -34,12 +34,37 @@
=20
 #include "omapfb.h"
=20
+static u8 get_mem_idx(struct omapfb_info *ofbi)
+{
+	if (ofbi->id =3D=3D ofbi->region->id)
+		return 0;
+
+	return OMAPFB_MEM_IDX_ENABLED | ofbi->region->id;
+}
+
+static struct omapfb2_mem_region *get_mem_region(struct omapfb_info *o=
fbi,
+						 u8 mem_idx)
+{
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
+
+	if (mem_idx & OMAPFB_MEM_IDX_ENABLED)
+		mem_idx &=3D OMAPFB_MEM_IDX_MASK;
+	else
+		mem_idx =3D ofbi->id;
+
+	if (mem_idx >=3D fbdev->num_fbs)
+		return NULL;
+
+	return &fbdev->regions[mem_idx];
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
@@ -52,7 +77,14 @@ static int omapfb_setup_plane(struct fb_info *fbi, s=
truct omapfb_plane_info *pi)
 	/* XXX uses only the first overlay */
 	ovl =3D ofbi->overlays[0];
=20
-	if (pi->enabled && !ofbi->region.size) {
+	old_rg =3D ofbi->region;
+	new_rg =3D get_mem_region(ofbi, pi->mem_idx);
+	if (!new_rg) {
+		r =3D -EINVAL;
+		goto out;
+	}
+
+	if (pi->enabled && !new_rg->size) {
 		/*
 		 * This plane's memory was freed, can't enable it
 		 * until it's reallocated.
@@ -61,27 +93,60 @@ static int omapfb_setup_plane(struct fb_info *fbi, =
struct omapfb_plane_info *pi)
 		goto out;
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
+
+		r =3D omapfb_setup_overlay(fbi, ovl, pi->pos_x, pi->pos_y,
+			pi->out_width, pi->out_height);
+		if (r)
+			goto undo;
=20
-	if (ovl->manager) {
-		r =3D ovl->manager->apply(ovl->manager);
+		ovl->get_overlay_info(ovl, &info);
+
+		if (!info.enabled) {
+			info.enabled =3D pi->enabled;
+			r =3D ovl->set_overlay_info(ovl, &info);
+			if (r)
+				goto undo;
+		}
+	} else {
+		struct omap_overlay_info info;
+
+		ovl->get_overlay_info(ovl, &info);
+
+		info.enabled =3D pi->enabled;
+		info.pos_x =3D pi->pos_x;
+		info.pos_y =3D pi->pos_y;
+		info.out_width =3D pi->out_width;
+		info.out_height =3D pi->out_height;
+
+		r =3D ovl->set_overlay_info(ovl, &info);
 		if (r)
-			goto out;
+			goto undo;
 	}
=20
-out:
-	if (r)
-		dev_err(fbdev->dev, "setup_plane failed\n");
+	if (ovl->manager)
+		ovl->manager->apply(ovl->manager);
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
+ out:
+	dev_err(fbdev->dev, "setup_plane failed\n");
+
 	return r;
 }
=20
@@ -92,8 +157,8 @@ static int omapfb_query_plane(struct fb_info *fbi, s=
truct omapfb_plane_info *pi)
 	if (ofbi->num_overlays !=3D 1) {
 		memset(pi, 0, sizeof(*pi));
 	} else {
-		struct omap_overlay_info *ovli;
 		struct omap_overlay *ovl;
+		struct omap_overlay_info *ovli;
=20
 		ovl =3D ofbi->overlays[0];
 		ovli =3D &ovl->info;
@@ -103,6 +168,7 @@ static int omapfb_query_plane(struct fb_info *fbi, =
struct omapfb_plane_info *pi)
 		pi->enabled =3D ovli->enabled;
 		pi->channel_out =3D 0; /* xxx */
 		pi->mirror =3D 0;
+		pi->mem_idx =3D get_mem_idx(ofbi);
 		pi->out_width =3D ovli->out_width;
 		pi->out_height =3D ovli->out_height;
 	}
@@ -123,11 +189,24 @@ static int omapfb_setup_mem(struct fb_info *fbi, =
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
+	if (atomic_read(&rg->map_count))
+		return -EBUSY;
+
+	for (i =3D 0; i < fbdev->num_fbs; i++) {
+		struct omapfb_info *ofbi2 =3D FB2OFB(fbdev->fbs[i]);
+		int j;
+
+		if (ofbi2->region !=3D rg)
+			continue;
+
+		for (j =3D 0; j < ofbi2->num_overlays; j++) {
+			if (ofbi2->overlays[j]->info.enabled) {
+				r =3D -EBUSY;
+				return r;
+			}
+		}
 	}
=20
 	if (rg->size !=3D size || rg->type !=3D mi->type) {
@@ -146,7 +225,7 @@ static int omapfb_query_mem(struct fb_info *fbi, st=
ruct omapfb_mem_info *mi)
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	struct omapfb2_mem_region *rg;
=20
-	rg =3D &ofbi->region;
+	rg =3D ofbi->region;
 	memset(mi, 0, sizeof(*mi));
=20
 	mi->size =3D rg->size;
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/o=
map2/omapfb/omapfb-main.c
index 7351e96..ceb7d92 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -156,7 +156,7 @@ static void fill_fb(struct fb_info *fbi)
=20
 static unsigned omapfb_get_vrfb_offset(const struct omapfb_info *ofbi,=
 int rot)
 {
-	const struct vrfb *vrfb =3D &ofbi->region.vrfb;
+	const struct vrfb *vrfb =3D &ofbi->region->vrfb;
 	unsigned offset;
=20
 	switch (rot) {
@@ -184,27 +184,27 @@ static unsigned omapfb_get_vrfb_offset(const stru=
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
@@ -449,7 +449,7 @@ static int check_vrfb_fb_size(unsigned long region_=
size,
 static int check_fb_size(const struct omapfb_info *ofbi,
 		struct fb_var_screeninfo *var)
 {
-	unsigned long max_frame_size =3D ofbi->region.size;
+	unsigned long max_frame_size =3D ofbi->region->size;
 	int bytespp =3D var->bits_per_pixel >> 3;
 	unsigned long line_size =3D var->xres_virtual * bytespp;
=20
@@ -496,7 +496,7 @@ static int check_fb_size(const struct omapfb_info *=
ofbi,
 static int setup_vrfb_rotation(struct fb_info *fbi)
 {
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
-	struct omapfb2_mem_region *rg =3D &ofbi->region;
+	struct omapfb2_mem_region *rg =3D ofbi->region;
 	struct vrfb *vrfb =3D &rg->vrfb;
 	struct fb_var_screeninfo *var =3D &fbi->var;
 	struct fb_fix_screeninfo *fix =3D &fbi->fix;
@@ -557,9 +557,9 @@ static int setup_vrfb_rotation(struct fb_info *fbi)
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
@@ -598,7 +598,7 @@ void set_fb_fix(struct fb_info *fbi)
 	struct fb_fix_screeninfo *fix =3D &fbi->fix;
 	struct fb_var_screeninfo *var =3D &fbi->var;
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
-	struct omapfb2_mem_region *rg =3D &ofbi->region;
+	struct omapfb2_mem_region *rg =3D ofbi->region;
=20
 	DBG("set_fb_fix\n");
=20
@@ -687,7 +687,7 @@ int check_fb_var(struct fb_info *fbi, struct fb_var=
_screeninfo *var)
 		return -EINVAL;
=20
 	/* When no memory is allocated ignore the size check */
-	if (ofbi->region.size !=3D 0 && check_fb_size(ofbi, var))
+	if (ofbi->region->size !=3D 0 && check_fb_size(ofbi, var))
 		return -EINVAL;
=20
 	if (var->xres + var->xoffset > var->xres_virtual)
@@ -855,7 +855,7 @@ static void omapfb_calc_addr(const struct omapfb_in=
fo *ofbi,
 }
=20
 /* setup overlay according to the fb */
-static int omapfb_setup_overlay(struct fb_info *fbi, struct omap_overl=
ay *ovl,
+int omapfb_setup_overlay(struct fb_info *fbi, struct omap_overlay *ovl=
,
 		u16 posx, u16 posy, u16 outw, u16 outh)
 {
 	int r =3D 0;
@@ -891,7 +891,7 @@ static int omapfb_setup_overlay(struct fb_info *fbi=
, struct omap_overlay *ovl,
 		yres =3D var->yres;
 	}
=20
-	if (ofbi->region.size)
+	if (ofbi->region->size)
 		omapfb_calc_addr(ofbi, var, fix, rotation,
 				 &data_start_p, &data_start_v);
=20
@@ -970,7 +970,7 @@ int omapfb_apply_changes(struct fb_info *fbi, int i=
nit)
=20
 		DBG("apply_changes, fb %d, ovl %d\n", ofbi->id, ovl->id);
=20
-		if (ofbi->region.size =3D=3D 0) {
+		if (ofbi->region->size =3D=3D 0) {
 			/* the fb is not available. disable the overlay */
 			omapfb_overlay_enable(ovl, 0);
 			if (!init && ovl->manager)
@@ -1070,16 +1070,16 @@ static int omapfb_pan_display(struct fb_var_scr=
eeninfo *var,
=20
 static void mmap_user_open(struct vm_area_struct *vma)
 {
-	struct omapfb_info *ofbi =3D (struct omapfb_info *)vma->vm_private_da=
ta;
+	struct omapfb2_mem_region *rg =3D vma->vm_private_data;
=20
-	atomic_inc(&ofbi->map_count);
+	atomic_inc(&rg->map_count);
 }
=20
 static void mmap_user_close(struct vm_area_struct *vma)
 {
-	struct omapfb_info *ofbi =3D (struct omapfb_info *)vma->vm_private_da=
ta;
+	struct omapfb2_mem_region *rg =3D vma->vm_private_data;
=20
-	atomic_dec(&ofbi->map_count);
+	atomic_dec(&rg->map_count);
 }
=20
 static struct vm_operations_struct mmap_user_ops =3D {
@@ -1091,6 +1091,7 @@ static int omapfb_mmap(struct fb_info *fbi, struc=
t vm_area_struct *vma)
 {
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	struct fb_fix_screeninfo *fix =3D &fbi->fix;
+	struct omapfb2_mem_region *rg;
 	unsigned long off;
 	unsigned long start;
 	u32 len;
@@ -1101,6 +1102,8 @@ static int omapfb_mmap(struct fb_info *fbi, struc=
t vm_area_struct *vma)
 		return -EINVAL;
 	off =3D vma->vm_pgoff << PAGE_SHIFT;
=20
+	rg =3D ofbi->region;
+
 	start =3D omapfb_get_region_paddr(ofbi);
 	len =3D fix->smem_len;
 	if (off >=3D len)
@@ -1116,12 +1119,12 @@ static int omapfb_mmap(struct fb_info *fbi, str=
uct vm_area_struct *vma)
 	vma->vm_flags |=3D VM_IO | VM_RESERVED;
 	vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);
 	vma->vm_ops =3D &mmap_user_ops;
-	vma->vm_private_data =3D ofbi;
+	vma->vm_private_data =3D rg;
 	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
 			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
 	/* vm_ops.open won't be called for mmap itself. */
-	atomic_inc(&ofbi->map_count);
+	atomic_inc(&rg->map_count);
 	return 0;
 }
=20
@@ -1311,7 +1314,9 @@ static void omapfb_free_fbmem(struct fb_info *fbi=
)
 	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	struct omapfb2_mem_region *rg;
=20
-	rg =3D &ofbi->region;
+	rg =3D ofbi->region;
+
+	WARN_ON(atomic_read(&rg->map_count));
=20
 	if (rg->paddr)
 		if (omap_vram_free(rg->paddr, rg->size))
@@ -1366,8 +1371,15 @@ static int omapfb_alloc_fbmem(struct fb_info *fb=
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
@@ -1620,7 +1632,7 @@ static int omapfb_allocate_all_fbs(struct omapfb2=
_device *fbdev)
 	for (i =3D 0; i < fbdev->num_fbs; i++) {
 		struct omapfb_info *ofbi =3D FB2OFB(fbdev->fbs[i]);
 		struct omapfb2_mem_region *rg;
-		rg =3D &ofbi->region;
+		rg =3D ofbi->region;
=20
 		DBG("region%d phys %08x virt %p size=3D%lu\n",
 				i,
@@ -1637,7 +1649,7 @@ int omapfb_realloc_fbmem(struct fb_info *fbi, uns=
igned long size, int type)
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	struct omap_dss_device *display =3D fb2display(fbi);
-	struct omapfb2_mem_region *rg =3D &ofbi->region;
+	struct omapfb2_mem_region *rg =3D ofbi->region;
 	unsigned long old_size =3D rg->size;
 	unsigned long old_paddr =3D rg->paddr;
 	int old_type =3D rg->type;
@@ -1720,7 +1732,7 @@ static int omapfb_fb_init(struct omapfb2_device *=
fbdev, struct fb_info *fbi)
 	fbi->flags =3D FBINFO_FLAG_DEFAULT;
 	fbi->pseudo_palette =3D fbdev->pseudo_palette;
=20
-	if (ofbi->region.size =3D=3D 0) {
+	if (ofbi->region->size =3D=3D 0) {
 		clear_fb_info(fbi);
 		return 0;
 	}
@@ -1882,6 +1894,9 @@ static int omapfb_create_framebuffers(struct omap=
fb2_device *fbdev)
 		ofbi->fbdev =3D fbdev;
 		ofbi->id =3D i;
=20
+		ofbi->region =3D &fbdev->regions[i];
+		ofbi->region->id =3D i;
+
 		/* assign these early, so that fb alloc can use them */
 		ofbi->rotation_type =3D def_vrfb ? OMAP_DSS_ROT_VRFB :
 			OMAP_DSS_ROT_DMA;
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/=
omap2/omapfb/omapfb-sysfs.c
index 62bb88f..6fbe39a 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -63,7 +63,7 @@ static ssize_t store_rotate_type(struct device *dev,
 	if (rot_type =3D=3D ofbi->rotation_type)
 		goto out;
=20
-	if (ofbi->region.size) {
+	if (ofbi->region->size) {
 		r =3D -EBUSY;
 		goto out;
 	}
@@ -402,7 +402,7 @@ static ssize_t show_size(struct device *dev,
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
=20
-	return snprintf(buf, PAGE_SIZE, "%lu\n", ofbi->region.size);
+	return snprintf(buf, PAGE_SIZE, "%lu\n", ofbi->region->size);
 }
=20
 static ssize_t store_size(struct device *dev, struct device_attribute =
*attr,
@@ -410,6 +410,8 @@ static ssize_t store_size(struct device *dev, struc=
t device_attribute *attr,
 {
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
+	struct omapfb2_mem_region *rg;
 	unsigned long size;
 	int r;
 	int i;
@@ -418,15 +420,30 @@ static ssize_t store_size(struct device *dev, str=
uct device_attribute *attr,
=20
 	lock_fb_info(fbi);
=20
-	for (i =3D 0; i < ofbi->num_overlays; i++) {
-		if (ofbi->overlays[i]->info.enabled) {
-			r =3D -EBUSY;
-			goto out;
+	rg =3D ofbi->region;
+
+	if (atomic_read(&rg->map_count)) {
+		r =3D -EBUSY;
+		goto out;
+	}
+
+	for (i =3D 0; i < fbdev->num_fbs; i++) {
+		struct omapfb_info *ofbi2 =3D FB2OFB(fbdev->fbs[i]);
+		int j;
+
+		if (ofbi2->region !=3D rg)
+			continue;
+
+		for (j =3D 0; j < ofbi2->num_overlays; j++) {
+			if (ofbi2->overlays[j]->info.enabled) {
+				r =3D -EBUSY;
+				goto out;
+			}
 		}
 	}
=20
-	if (size !=3D ofbi->region.size) {
-		r =3D omapfb_realloc_fbmem(fbi, size, ofbi->region.type);
+	if (size !=3D ofbi->region->size) {
+		r =3D omapfb_realloc_fbmem(fbi, size, ofbi->region->type);
 		if (r) {
 			dev_err(dev, "realloc fbmem failed\n");
 			goto out;
@@ -446,7 +463,7 @@ static ssize_t show_phys(struct device *dev,
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
=20
-	return snprintf(buf, PAGE_SIZE, "%0x\n", ofbi->region.paddr);
+	return snprintf(buf, PAGE_SIZE, "%0x\n", ofbi->region->paddr);
 }
=20
 static ssize_t show_virt(struct device *dev,
@@ -455,7 +472,7 @@ static ssize_t show_virt(struct device *dev,
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
index c9866be..02f1ba9 100644
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
@@ -51,13 +52,13 @@ struct omapfb2_mem_region {
 	u8		type;		/* OMAPFB_PLANE_MEM_* */
 	bool		alloc;		/* allocated by the driver */
 	bool		map;		/* kernel mapped by the driver */
+	atomic_t	map_count;
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
@@ -76,6 +77,7 @@ struct omapfb2_device {
=20
 	unsigned num_fbs;
 	struct fb_info *fbs[10];
+	struct omapfb2_mem_region regions[10];
=20
 	unsigned num_displays;
 	struct omap_dss_device *displays[10];
@@ -117,6 +119,9 @@ int omapfb_update_window(struct fb_info *fbi,
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
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index 9bdd914..0ecf731 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -85,6 +85,9 @@
 #define OMAPFB_MEMTYPE_SRAM		1
 #define OMAPFB_MEMTYPE_MAX		1
=20
+#define OMAPFB_MEM_IDX_ENABLED	0x80
+#define OMAPFB_MEM_IDX_MASK	0x7f
+
 enum omapfb_color_format {
 	OMAPFB_COLOR_RGB565 =3D 0,
 	OMAPFB_COLOR_YUV422,
@@ -136,7 +139,7 @@ struct omapfb_plane_info {
 	__u8  enabled;
 	__u8  channel_out;
 	__u8  mirror;
-	__u8  reserved1;
+	__u8  mem_idx;
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
