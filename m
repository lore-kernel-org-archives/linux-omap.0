From: ville.syrjala@nokia.com
Subject: [PATCH v4 5/8] DSS2: OMAPFB: Add locking for memory regions
Date: Thu, 18 Mar 2010 00:46:20 +0200
Message-ID: <1268865983-16270-6-git-send-email-ville.syrjala@nokia.com>
References: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28635 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226Ab0CQWqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 18:46:52 -0400
In-Reply-To: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Imre Deak <imre.deak@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

Add locking to the memory regions to make sure the memory region size
won't be changed while some other piece of code is performing some
checks or setup based on that information.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   44 +++++++++++++++-----
 drivers/video/omap2/omapfb/omapfb-main.c  |   62 +++++++++++++++++++++=
++++----
 drivers/video/omap2/omapfb/omapfb-sysfs.c |   37 ++++++++++++++++-
 drivers/video/omap2/omapfb/omapfb.h       |   18 ++++++++
 4 files changed, 140 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/=
omap2/omapfb/omapfb-ioctl.c
index a160a3e..f02b1b0 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -55,7 +55,7 @@ static struct omapfb2_mem_region *get_mem_region(stru=
ct omapfb_info *ofbi,
 	if (mem_idx >=3D fbdev->num_fbs)
 		return NULL;
=20
-	return &fbdev->regions[mem_idx];
+	return omapfb_get_mem_region(&fbdev->regions[mem_idx]);
 }
=20
 static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane=
_info *pi)
@@ -77,11 +77,11 @@ static int omapfb_setup_plane(struct fb_info *fbi, =
struct omapfb_plane_info *pi)
 	/* XXX uses only the first overlay */
 	ovl =3D ofbi->overlays[0];
=20
-	old_rg =3D ofbi->region;
+	old_rg =3D omapfb_get_mem_region(ofbi->region);
 	new_rg =3D get_mem_region(ofbi, pi->mem_idx);
 	if (!new_rg) {
 		r =3D -EINVAL;
-		goto out;
+		goto put_old;
 	}
=20
 	if (pi->enabled && !new_rg->size) {
@@ -90,7 +90,7 @@ static int omapfb_setup_plane(struct fb_info *fbi, st=
ruct omapfb_plane_info *pi)
 		 * until it's reallocated.
 		 */
 		r =3D -EINVAL;
-		goto out;
+		goto put_new;
 	}
=20
 	ovl->get_overlay_info(ovl, &old_info);
@@ -135,6 +135,9 @@ static int omapfb_setup_plane(struct fb_info *fbi, =
struct omapfb_plane_info *pi)
 	if (ovl->manager)
 		ovl->manager->apply(ovl->manager);
=20
+	omapfb_put_mem_region(new_rg);
+	omapfb_put_mem_region(old_rg);
+
 	return 0;
=20
  undo:
@@ -144,6 +147,10 @@ static int omapfb_setup_plane(struct fb_info *fbi,=
 struct omapfb_plane_info *pi)
 	}
=20
 	ovl->set_overlay_info(ovl, &old_info);
+ put_new:
+	omapfb_put_mem_region(new_rg);
+ put_old:
+	omapfb_put_mem_region(old_rg);
  out:
 	dev_err(fbdev->dev, "setup_plane failed\n");
=20
@@ -181,7 +188,7 @@ static int omapfb_setup_mem(struct fb_info *fbi, st=
ruct omapfb_mem_info *mi)
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	struct omapfb2_mem_region *rg;
-	int r, i;
+	int r =3D 0, i;
 	size_t size;
=20
 	if (mi->type > OMAPFB_MEMTYPE_MAX)
@@ -191,8 +198,18 @@ static int omapfb_setup_mem(struct fb_info *fbi, s=
truct omapfb_mem_info *mi)
=20
 	rg =3D ofbi->region;
=20
-	if (atomic_read(&rg->map_count))
-		return -EBUSY;
+	/* FIXME probably should be a rwsem ... */
+	mutex_lock(&rg->mtx);
+	while (rg->ref) {
+		mutex_unlock(&rg->mtx);
+		schedule();
+		mutex_lock(&rg->mtx);
+	}
+
+	if (atomic_read(&rg->map_count)) {
+		r =3D -EBUSY;
+		goto out;
+	}
=20
 	for (i =3D 0; i < fbdev->num_fbs; i++) {
 		struct omapfb_info *ofbi2 =3D FB2OFB(fbdev->fbs[i]);
@@ -204,7 +221,7 @@ static int omapfb_setup_mem(struct fb_info *fbi, st=
ruct omapfb_mem_info *mi)
 		for (j =3D 0; j < ofbi2->num_overlays; j++) {
 			if (ofbi2->overlays[j]->info.enabled) {
 				r =3D -EBUSY;
-				return r;
+				goto out;
 			}
 		}
 	}
@@ -213,11 +230,14 @@ static int omapfb_setup_mem(struct fb_info *fbi, =
struct omapfb_mem_info *mi)
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
@@ -225,12 +245,14 @@ static int omapfb_query_mem(struct fb_info *fbi, =
struct omapfb_mem_info *mi)
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	struct omapfb2_mem_region *rg;
=20
-	rg =3D ofbi->region;
+	rg =3D omapfb_get_mem_region(ofbi->region);
 	memset(mi, 0, sizeof(*mi));
=20
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
index ceb7d92..d330032 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1018,36 +1018,48 @@ err:
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
@@ -1063,8 +1075,12 @@ static int omapfb_pan_display(struct fb_var_scre=
eninfo *var,
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
@@ -1072,14 +1088,18 @@ static void mmap_user_open(struct vm_area_struc=
t *vma)
 {
 	struct omapfb2_mem_region *rg =3D vma->vm_private_data;
=20
+	omapfb_get_mem_region(rg);
 	atomic_inc(&rg->map_count);
+	omapfb_put_mem_region(rg);
 }
=20
 static void mmap_user_close(struct vm_area_struct *vma)
 {
 	struct omapfb2_mem_region *rg =3D vma->vm_private_data;
=20
+	omapfb_get_mem_region(rg);
 	atomic_dec(&rg->map_count);
+	omapfb_put_mem_region(rg);
 }
=20
 static struct vm_operations_struct mmap_user_ops =3D {
@@ -1095,6 +1115,7 @@ static int omapfb_mmap(struct fb_info *fbi, struc=
t vm_area_struct *vma)
 	unsigned long off;
 	unsigned long start;
 	u32 len;
+	int r =3D -EINVAL;
=20
 	if (vma->vm_end - vma->vm_start =3D=3D 0)
 		return 0;
@@ -1102,14 +1123,14 @@ static int omapfb_mmap(struct fb_info *fbi, str=
uct vm_area_struct *vma)
 		return -EINVAL;
 	off =3D vma->vm_pgoff << PAGE_SHIFT;
=20
-	rg =3D ofbi->region;
+	rg =3D omapfb_get_mem_region(ofbi->region);
=20
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
@@ -1121,11 +1142,23 @@ static int omapfb_mmap(struct fb_info *fbi, str=
uct vm_area_struct *vma)
 	vma->vm_ops =3D &mmap_user_ops;
 	vma->vm_private_data =3D rg;
 	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
-			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
-		return -EAGAIN;
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot)) {
+		r =3D -EAGAIN;
+		goto error;
+	}
+
 	/* vm_ops.open won't be called for mmap itself. */
 	atomic_inc(&rg->map_count);
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
@@ -1896,6 +1929,7 @@ static int omapfb_create_framebuffers(struct omap=
fb2_device *fbdev)
=20
 		ofbi->region =3D &fbdev->regions[i];
 		ofbi->region->id =3D i;
+		mutex_init(&ofbi->region->mtx);
=20
 		/* assign these early, so that fb alloc can use them */
 		ofbi->rotation_type =3D def_vrfb ? OMAP_DSS_ROT_VRFB :
@@ -1926,7 +1960,13 @@ static int omapfb_create_framebuffers(struct oma=
pfb2_device *fbdev)
=20
 	/* setup fb_infos */
 	for (i =3D 0; i < fbdev->num_fbs; i++) {
-		r =3D omapfb_fb_init(fbdev, fbdev->fbs[i]);
+		struct fb_info *fbi =3D fbdev->fbs[i];
+		struct omapfb_info *ofbi =3D FB2OFB(fbi);
+
+		omapfb_get_mem_region(ofbi->region);
+		r =3D omapfb_fb_init(fbdev, fbi);
+		omapfb_put_mem_region(ofbi->region);
+
 		if (r) {
 			dev_err(fbdev->dev, "failed to setup fb_info\n");
 			return r;
@@ -1947,7 +1987,13 @@ static int omapfb_create_framebuffers(struct oma=
pfb2_device *fbdev)
 	DBG("framebuffers registered\n");
=20
 	for (i =3D 0; i < fbdev->num_fbs; i++) {
-		r =3D omapfb_apply_changes(fbdev->fbs[i], 1);
+		struct fb_info *fbi =3D fbdev->fbs[i];
+		struct omapfb_info *ofbi =3D FB2OFB(fbi);
+
+		omapfb_get_mem_region(ofbi->region);
+		r =3D omapfb_apply_changes(fbi, 1);
+		omapfb_put_mem_region(ofbi->region);
+
 		if (r) {
 			dev_err(fbdev->dev, "failed to change mode\n");
 			return r;
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/=
omap2/omapfb/omapfb-sysfs.c
index 6fbe39a..6aee279 100644
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
-	if (ofbi->region->size) {
+	rg =3D omapfb_get_mem_region(ofbi->region);
+
+	if (rg->size) {
 		r =3D -EBUSY;
-		goto out;
+		goto put_region;
 	}
=20
 	ofbi->rotation_type =3D rot_type;
@@ -74,6 +77,8 @@ static ssize_t store_rotate_type(struct device *dev,
 	 * Since the VRAM for this FB is not allocated at the moment we don't
 	 * need to do any further parameter checking at this point.
 	 */
+put_region:
+	omapfb_put_mem_region(rg);
 out:
 	unlock_fb_info(fbi);
=20
@@ -109,6 +114,8 @@ static ssize_t store_mirror(struct device *dev,
=20
 	ofbi->mirror =3D mirror;
=20
+	omapfb_get_mem_region(ofbi->region);
+
 	memcpy(&new_var, &fbi->var, sizeof(new_var));
 	r =3D check_fb_var(fbi, &new_var);
 	if (r)
@@ -123,6 +130,8 @@ static ssize_t store_mirror(struct device *dev,
=20
 	r =3D count;
 out:
+	omapfb_put_mem_region(ofbi->region);
+
 	unlock_fb_info(fbi);
=20
 	return r;
@@ -259,11 +268,15 @@ static ssize_t store_overlays(struct device *dev,=
 struct device_attribute *attr,
=20
 		DBG("detaching %d\n", ofbi->overlays[i]->id);
=20
+		omapfb_get_mem_region(ofbi->region);
+
 		omapfb_overlay_enable(ovl, 0);
=20
 		if (ovl->manager)
 			ovl->manager->apply(ovl->manager);
=20
+		omapfb_put_mem_region(ofbi->region);
+
 		for (t =3D i + 1; t < ofbi->num_overlays; t++) {
 			ofbi->rotation[t-1] =3D ofbi->rotation[t];
 			ofbi->overlays[t-1] =3D ofbi->overlays[t];
@@ -296,7 +309,12 @@ static ssize_t store_overlays(struct device *dev, =
struct device_attribute *attr,
 	}
=20
 	if (added) {
+		omapfb_get_mem_region(ofbi->region);
+
 		r =3D omapfb_apply_changes(fbi, 0);
+
+		omapfb_put_mem_region(ofbi->region);
+
 		if (r)
 			goto out;
 	}
@@ -382,7 +400,12 @@ static ssize_t store_overlays_rotate(struct device=
 *dev,
 		for (i =3D 0; i < num_ovls; ++i)
 			ofbi->rotation[i] =3D rotation[i];
=20
+		omapfb_get_mem_region(ofbi->region);
+
 		r =3D omapfb_apply_changes(fbi, 0);
+
+		omapfb_put_mem_region(ofbi->region);
+
 		if (r)
 			goto out;
=20
@@ -422,6 +445,14 @@ static ssize_t store_size(struct device *dev, stru=
ct device_attribute *attr,
=20
 	rg =3D ofbi->region;
=20
+	/* FIXME probably should be a rwsem ... */
+	mutex_lock(&rg->mtx);
+	while (rg->ref) {
+		mutex_unlock(&rg->mtx);
+		schedule();
+		mutex_lock(&rg->mtx);
+	}
+
 	if (atomic_read(&rg->map_count)) {
 		r =3D -EBUSY;
 		goto out;
@@ -452,6 +483,8 @@ static ssize_t store_size(struct device *dev, struc=
t device_attribute *attr,
=20
 	r =3D count;
 out:
+	mutex_unlock(&rg->mtx);
+
 	unlock_fb_info(fbi);
=20
 	return r;
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/=
omapfb/omapfb.h
index 02f1ba9..db3aef5 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -52,6 +52,8 @@ struct omapfb2_mem_region {
 	u8		type;		/* OMAPFB_PLANE_MEM_* */
 	bool		alloc;		/* allocated by the driver */
 	bool		map;		/* kernel mapped by the driver */
+	struct mutex    mtx;
+	unsigned int    ref;
 	atomic_t	map_count;
 };
=20
@@ -159,4 +161,20 @@ static inline int omapfb_overlay_enable(struct oma=
p_overlay *ovl,
 	return ovl->set_overlay_info(ovl, &info);
 }
=20
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
+}
+
 #endif
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
