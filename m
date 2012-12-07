From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/5] OMAPFB: simplify locking
Date: Fri, 7 Dec 2012 13:55:06 +0200
Message-ID: <1354881309-17625-2-git-send-email-tomi.valkeinen@ti.com>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43029 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932346Ab2LGLz3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Dec 2012 06:55:29 -0500
In-Reply-To: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>

Kernel lock verification code has lately detected possible circular
locking in omapfb. The exact problem is unclear, but omapfb's current
locking seems to be overly complex.

This patch simplifies the locking in the following ways:

- Remove explicit omapfb mem region locking. I couldn't figure out the
  need for this, as long as we take care to take omapfb lock.

- Get omapfb lock always, even if the operation is possibly only relate=
d
  to one fb_info. Better safe than sorry, and normally there's only one
  user for the fb so this shouldn't matter.

- Make sure fb_info lock is taken first, then omapfb lock.

With this patch the warnings about possible circular locking does not
happen anymore.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   65 +++------------------=
-
 drivers/video/omap2/omapfb/omapfb-main.c  |   40 ++++----------
 drivers/video/omap2/omapfb/omapfb-sysfs.c |   84 +++++++++++++++++++--=
--------
 drivers/video/omap2/omapfb/omapfb.h       |   19 -------
 4 files changed, 73 insertions(+), 135 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/=
omap2/omapfb/omapfb-ioctl.c
index 94de47e..ae7aac7 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -85,16 +85,6 @@ static int omapfb_setup_plane(struct fb_info *fbi, s=
truct omapfb_plane_info *pi)
 		goto out;
 	}
=20
-	/* Take the locks in a specific order to keep lockdep happy */
-	if (old_rg->id < new_rg->id) {
-		omapfb_get_mem_region(old_rg);
-		omapfb_get_mem_region(new_rg);
-	} else if (new_rg->id < old_rg->id) {
-		omapfb_get_mem_region(new_rg);
-		omapfb_get_mem_region(old_rg);
-	} else
-		omapfb_get_mem_region(old_rg);
-
 	if (pi->enabled && !new_rg->size) {
 		/*
 		 * This plane's memory was freed, can't enable it
@@ -146,16 +136,6 @@ static int omapfb_setup_plane(struct fb_info *fbi,=
 struct omapfb_plane_info *pi)
 			goto undo;
 	}
=20
-	/* Release the locks in a specific order to keep lockdep happy */
-	if (old_rg->id > new_rg->id) {
-		omapfb_put_mem_region(old_rg);
-		omapfb_put_mem_region(new_rg);
-	} else if (new_rg->id > old_rg->id) {
-		omapfb_put_mem_region(new_rg);
-		omapfb_put_mem_region(old_rg);
-	} else
-		omapfb_put_mem_region(old_rg);
-
 	return 0;
=20
  undo:
@@ -166,15 +146,6 @@ static int omapfb_setup_plane(struct fb_info *fbi,=
 struct omapfb_plane_info *pi)
=20
 	ovl->set_overlay_info(ovl, &old_info);
  put_mem:
-	/* Release the locks in a specific order to keep lockdep happy */
-	if (old_rg->id > new_rg->id) {
-		omapfb_put_mem_region(old_rg);
-		omapfb_put_mem_region(new_rg);
-	} else if (new_rg->id > old_rg->id) {
-		omapfb_put_mem_region(new_rg);
-		omapfb_put_mem_region(old_rg);
-	} else
-		omapfb_put_mem_region(old_rg);
  out:
 	dev_err(fbdev->dev, "setup_plane failed\n");
=20
@@ -222,9 +193,6 @@ static int omapfb_setup_mem(struct fb_info *fbi, st=
ruct omapfb_mem_info *mi)
=20
 	rg =3D ofbi->region;
=20
-	down_write_nested(&rg->lock, rg->id);
-	atomic_inc(&rg->lock_count);
-
 	if (rg->size =3D=3D size && rg->type =3D=3D mi->type)
 		goto out;
=20
@@ -257,9 +225,6 @@ static int omapfb_setup_mem(struct fb_info *fbi, st=
ruct omapfb_mem_info *mi)
 	}
=20
  out:
-	atomic_dec(&rg->lock_count);
-	up_write(&rg->lock);
-
 	return r;
 }
=20
@@ -268,14 +233,12 @@ static int omapfb_query_mem(struct fb_info *fbi, =
struct omapfb_mem_info *mi)
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
 	struct omapfb2_mem_region *rg;
=20
-	rg =3D omapfb_get_mem_region(ofbi->region);
+	rg =3D ofbi->region;
 	memset(mi, 0, sizeof(*mi));
=20
 	mi->size =3D rg->size;
 	mi->type =3D rg->type;
=20
-	omapfb_put_mem_region(rg);
-
 	return 0;
 }
=20
@@ -314,14 +277,10 @@ int omapfb_set_update_mode(struct fb_info *fbi,
 	if (mode !=3D OMAPFB_AUTO_UPDATE && mode !=3D OMAPFB_MANUAL_UPDATE)
 		return -EINVAL;
=20
-	omapfb_lock(fbdev);
-
 	d =3D get_display_data(fbdev, display);
=20
-	if (d->update_mode =3D=3D mode) {
-		omapfb_unlock(fbdev);
+	if (d->update_mode =3D=3D mode)
 		return 0;
-	}
=20
 	r =3D 0;
=20
@@ -337,8 +296,6 @@ int omapfb_set_update_mode(struct fb_info *fbi,
 			r =3D -EINVAL;
 	}
=20
-	omapfb_unlock(fbdev);
-
 	return r;
 }
=20
@@ -353,14 +310,10 @@ int omapfb_get_update_mode(struct fb_info *fbi,
 	if (!display)
 		return -EINVAL;
=20
-	omapfb_lock(fbdev);
-
 	d =3D get_display_data(fbdev, display);
=20
 	*mode =3D d->update_mode;
=20
-	omapfb_unlock(fbdev);
-
 	return 0;
 }
=20
@@ -420,13 +373,10 @@ static int omapfb_set_color_key(struct fb_info *f=
bi,
 		struct omapfb_color_key *ck)
 {
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
-	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	int r;
 	int i;
 	struct omap_overlay_manager *mgr =3D NULL;
=20
-	omapfb_lock(fbdev);
-
 	for (i =3D 0; i < ofbi->num_overlays; i++) {
 		if (ofbi->overlays[i]->manager) {
 			mgr =3D ofbi->overlays[i]->manager;
@@ -441,8 +391,6 @@ static int omapfb_set_color_key(struct fb_info *fbi=
,
=20
 	r =3D _omapfb_set_color_key(mgr, ck);
 err:
-	omapfb_unlock(fbdev);
-
 	return r;
 }
=20
@@ -450,13 +398,10 @@ static int omapfb_get_color_key(struct fb_info *f=
bi,
 		struct omapfb_color_key *ck)
 {
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
-	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	struct omap_overlay_manager *mgr =3D NULL;
 	int r =3D 0;
 	int i;
=20
-	omapfb_lock(fbdev);
-
 	for (i =3D 0; i < ofbi->num_overlays; i++) {
 		if (ofbi->overlays[i]->manager) {
 			mgr =3D ofbi->overlays[i]->manager;
@@ -471,8 +416,6 @@ static int omapfb_get_color_key(struct fb_info *fbi=
,
=20
 	*ck =3D omapfb_color_keys[mgr->id];
 err:
-	omapfb_unlock(fbdev);
-
 	return r;
 }
=20
@@ -599,6 +542,8 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int =
cmd, unsigned long arg)
=20
 	int r =3D 0;
=20
+	omapfb_lock(fbdev);
+
 	switch (cmd) {
 	case OMAPFB_SYNC_GFX:
 		DBG("ioctl SYNC_GFX\n");
@@ -904,6 +849,8 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int =
cmd, unsigned long arg)
 		r =3D -EINVAL;
 	}
=20
+	omapfb_unlock(fbdev);
+
 	if (r < 0)
 		DBG("ioctl failed: %d\n", r);
=20
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/o=
map2/omapfb/omapfb-main.c
index 1a69d7c..28b2a21 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -672,8 +672,6 @@ int check_fb_var(struct fb_info *fbi, struct fb_var=
_screeninfo *var)
=20
 	DBG("check_fb_var %d\n", ofbi->id);
=20
-	WARN_ON(!atomic_read(&ofbi->region->lock_count));
-
 	r =3D fb_mode_to_dss_mode(var, &mode);
 	if (r) {
 		DBG("cannot convert var to omap dss mode\n");
@@ -855,8 +853,6 @@ int omapfb_setup_overlay(struct fb_info *fbi, struc=
t omap_overlay *ovl,
 	int rotation =3D var->rotate;
 	int i;
=20
-	WARN_ON(!atomic_read(&ofbi->region->lock_count));
-
 	for (i =3D 0; i < ofbi->num_overlays; i++) {
 		if (ovl !=3D ofbi->overlays[i])
 			continue;
@@ -948,8 +944,6 @@ int omapfb_apply_changes(struct fb_info *fbi, int i=
nit)
 		fill_fb(fbi);
 #endif
=20
-	WARN_ON(!atomic_read(&ofbi->region->lock_count));
-
 	for (i =3D 0; i < ofbi->num_overlays; i++) {
 		ovl =3D ofbi->overlays[i];
=20
@@ -1008,15 +1002,16 @@ err:
 static int omapfb_check_var(struct fb_var_screeninfo *var, struct fb_i=
nfo *fbi)
 {
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	int r;
=20
 	DBG("check_var(%d)\n", FB2OFB(fbi)->id);
=20
-	omapfb_get_mem_region(ofbi->region);
+	omapfb_lock(fbdev);
=20
 	r =3D check_fb_var(fbi, var);
=20
-	omapfb_put_mem_region(ofbi->region);
+	omapfb_unlock(fbdev);
=20
 	return r;
 }
@@ -1025,11 +1020,12 @@ static int omapfb_check_var(struct fb_var_scree=
ninfo *var, struct fb_info *fbi)
 static int omapfb_set_par(struct fb_info *fbi)
 {
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	int r;
=20
 	DBG("set_par(%d)\n", FB2OFB(fbi)->id);
=20
-	omapfb_get_mem_region(ofbi->region);
+	omapfb_lock(fbdev);
=20
 	set_fb_fix(fbi);
=20
@@ -1040,7 +1036,7 @@ static int omapfb_set_par(struct fb_info *fbi)
 	r =3D omapfb_apply_changes(fbi, 0);
=20
  out:
-	omapfb_put_mem_region(ofbi->region);
+	omapfb_unlock(fbdev);
=20
 	return r;
 }
@@ -1049,6 +1045,7 @@ static int omapfb_pan_display(struct fb_var_scree=
ninfo *var,
 		struct fb_info *fbi)
 {
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	struct fb_var_screeninfo new_var;
 	int r;
=20
@@ -1064,11 +1061,11 @@ static int omapfb_pan_display(struct fb_var_scr=
eeninfo *var,
=20
 	fbi->var =3D new_var;
=20
-	omapfb_get_mem_region(ofbi->region);
+	omapfb_lock(fbdev);
=20
 	r =3D omapfb_apply_changes(fbi, 0);
=20
-	omapfb_put_mem_region(ofbi->region);
+	omapfb_unlock(fbdev);
=20
 	return r;
 }
@@ -1077,18 +1074,14 @@ static void mmap_user_open(struct vm_area_struc=
t *vma)
 {
 	struct omapfb2_mem_region *rg =3D vma->vm_private_data;
=20
-	omapfb_get_mem_region(rg);
 	atomic_inc(&rg->map_count);
-	omapfb_put_mem_region(rg);
 }
=20
 static void mmap_user_close(struct vm_area_struct *vma)
 {
 	struct omapfb2_mem_region *rg =3D vma->vm_private_data;
=20
-	omapfb_get_mem_region(rg);
 	atomic_dec(&rg->map_count);
-	omapfb_put_mem_region(rg);
 }
=20
 static struct vm_operations_struct mmap_user_ops =3D {
@@ -1112,7 +1105,7 @@ static int omapfb_mmap(struct fb_info *fbi, struc=
t vm_area_struct *vma)
 		return -EINVAL;
 	off =3D vma->vm_pgoff << PAGE_SHIFT;
=20
-	rg =3D omapfb_get_mem_region(ofbi->region);
+	rg =3D ofbi->region;
=20
 	start =3D omapfb_get_region_paddr(ofbi);
 	len =3D fix->smem_len;
@@ -1140,13 +1133,9 @@ static int omapfb_mmap(struct fb_info *fbi, stru=
ct vm_area_struct *vma)
 	/* vm_ops.open won't be called for mmap itself. */
 	atomic_inc(&rg->map_count);
=20
-	omapfb_put_mem_region(rg);
-
 	return 0;
=20
  error:
-	omapfb_put_mem_region(ofbi->region);
-
 	return r;
 }
=20
@@ -1918,7 +1907,6 @@ static int omapfb_create_framebuffers(struct omap=
fb2_device *fbdev)
=20
 		ofbi->region =3D &fbdev->regions[i];
 		ofbi->region->id =3D i;
-		init_rwsem(&ofbi->region->lock);
=20
 		/* assign these early, so that fb alloc can use them */
 		ofbi->rotation_type =3D def_vrfb ? OMAP_DSS_ROT_VRFB :
@@ -1950,12 +1938,8 @@ static int omapfb_create_framebuffers(struct oma=
pfb2_device *fbdev)
 	/* setup fb_infos */
 	for (i =3D 0; i < fbdev->num_fbs; i++) {
 		struct fb_info *fbi =3D fbdev->fbs[i];
-		struct omapfb_info *ofbi =3D FB2OFB(fbi);
=20
-		omapfb_get_mem_region(ofbi->region);
 		r =3D omapfb_fb_init(fbdev, fbi);
-		omapfb_put_mem_region(ofbi->region);
-
 		if (r) {
 			dev_err(fbdev->dev, "failed to setup fb_info\n");
 			return r;
@@ -1987,12 +1971,8 @@ static int omapfb_create_framebuffers(struct oma=
pfb2_device *fbdev)
=20
 	for (i =3D 0; i < fbdev->num_fbs; i++) {
 		struct fb_info *fbi =3D fbdev->fbs[i];
-		struct omapfb_info *ofbi =3D FB2OFB(fbi);
=20
-		omapfb_get_mem_region(ofbi->region);
 		r =3D omapfb_apply_changes(fbi, 1);
-		omapfb_put_mem_region(ofbi->region);
-
 		if (r) {
 			dev_err(fbdev->dev, "failed to change mode\n");
 			return r;
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/=
omap2/omapfb/omapfb-sysfs.c
index 17aa174..6614462 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -49,6 +49,7 @@ static ssize_t store_rotate_type(struct device *dev,
 {
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	struct omapfb2_mem_region *rg;
 	int rot_type;
 	int r;
@@ -62,12 +63,13 @@ static ssize_t store_rotate_type(struct device *dev=
,
=20
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
+	omapfb_lock(fbdev);
=20
 	r =3D 0;
 	if (rot_type =3D=3D ofbi->rotation_type)
 		goto out;
=20
-	rg =3D omapfb_get_mem_region(ofbi->region);
+	rg =3D ofbi->region;
=20
 	if (rg->size) {
 		r =3D -EBUSY;
@@ -81,8 +83,8 @@ static ssize_t store_rotate_type(struct device *dev,
 	 * need to do any further parameter checking at this point.
 	 */
 put_region:
-	omapfb_put_mem_region(rg);
 out:
+	omapfb_unlock(fbdev);
 	unlock_fb_info(fbi);
=20
 	return r ? r : count;
@@ -104,6 +106,7 @@ static ssize_t store_mirror(struct device *dev,
 {
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	bool mirror;
 	int r;
 	struct fb_var_screeninfo new_var;
@@ -114,11 +117,10 @@ static ssize_t store_mirror(struct device *dev,
=20
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
+	omapfb_lock(fbdev);
=20
 	ofbi->mirror =3D mirror;
=20
-	omapfb_get_mem_region(ofbi->region);
-
 	memcpy(&new_var, &fbi->var, sizeof(new_var));
 	r =3D check_fb_var(fbi, &new_var);
 	if (r)
@@ -133,8 +135,7 @@ static ssize_t store_mirror(struct device *dev,
=20
 	r =3D count;
 out:
-	omapfb_put_mem_region(ofbi->region);
-
+	omapfb_unlock(fbdev);
 	unlock_fb_info(fbi);
=20
 	return r;
@@ -273,15 +274,11 @@ static ssize_t store_overlays(struct device *dev,=
 struct device_attribute *attr,
=20
 		DBG("detaching %d\n", ofbi->overlays[i]->id);
=20
-		omapfb_get_mem_region(ofbi->region);
-
 		omapfb_overlay_enable(ovl, 0);
=20
 		if (ovl->manager)
 			ovl->manager->apply(ovl->manager);
=20
-		omapfb_put_mem_region(ofbi->region);
-
 		for (t =3D i + 1; t < ofbi->num_overlays; t++) {
 			ofbi->rotation[t-1] =3D ofbi->rotation[t];
 			ofbi->overlays[t-1] =3D ofbi->overlays[t];
@@ -314,12 +311,8 @@ static ssize_t store_overlays(struct device *dev, =
struct device_attribute *attr,
 	}
=20
 	if (added) {
-		omapfb_get_mem_region(ofbi->region);
-
 		r =3D omapfb_apply_changes(fbi, 0);
=20
-		omapfb_put_mem_region(ofbi->region);
-
 		if (r)
 			goto out;
 	}
@@ -337,11 +330,13 @@ static ssize_t show_overlays_rotate(struct device=
 *dev,
 {
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	ssize_t l =3D 0;
 	int t;
=20
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
+	omapfb_lock(fbdev);
=20
 	for (t =3D 0; t < ofbi->num_overlays; t++) {
 		l +=3D snprintf(buf + l, PAGE_SIZE - l, "%s%d",
@@ -350,6 +345,7 @@ static ssize_t show_overlays_rotate(struct device *=
dev,
=20
 	l +=3D snprintf(buf + l, PAGE_SIZE - l, "\n");
=20
+	omapfb_unlock(fbdev);
 	unlock_fb_info(fbi);
=20
 	return l;
@@ -360,6 +356,7 @@ static ssize_t store_overlays_rotate(struct device =
*dev,
 {
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	int num_ovls =3D 0, r, i;
 	int len;
 	bool changed =3D false;
@@ -371,6 +368,7 @@ static ssize_t store_overlays_rotate(struct device =
*dev,
=20
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
+	omapfb_lock(fbdev);
=20
 	if (len > 0) {
 		char *p =3D (char *)buf;
@@ -407,12 +405,7 @@ static ssize_t store_overlays_rotate(struct device=
 *dev,
 		for (i =3D 0; i < num_ovls; ++i)
 			ofbi->rotation[i] =3D rotation[i];
=20
-		omapfb_get_mem_region(ofbi->region);
-
 		r =3D omapfb_apply_changes(fbi, 0);
-
-		omapfb_put_mem_region(ofbi->region);
-
 		if (r)
 			goto out;
=20
@@ -421,6 +414,7 @@ static ssize_t store_overlays_rotate(struct device =
*dev,
=20
 	r =3D count;
 out:
+	omapfb_unlock(fbdev);
 	unlock_fb_info(fbi);
=20
 	return r;
@@ -431,8 +425,19 @@ static ssize_t show_size(struct device *dev,
 {
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
+	int r;
+
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
+	omapfb_lock(fbdev);
+
+	r =3D snprintf(buf, PAGE_SIZE, "%lu\n", ofbi->region->size);
=20
-	return snprintf(buf, PAGE_SIZE, "%lu\n", ofbi->region->size);
+	omapfb_unlock(fbdev);
+	unlock_fb_info(fbi);
+
+	return r;
 }
=20
 static ssize_t store_size(struct device *dev, struct device_attribute =
*attr,
@@ -454,12 +459,10 @@ static ssize_t store_size(struct device *dev, str=
uct device_attribute *attr,
=20
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
+	omapfb_lock(fbdev);
=20
 	rg =3D ofbi->region;
=20
-	down_write_nested(&rg->lock, rg->id);
-	atomic_inc(&rg->lock_count);
-
 	if (atomic_read(&rg->map_count)) {
 		r =3D -EBUSY;
 		goto out;
@@ -492,9 +495,7 @@ static ssize_t store_size(struct device *dev, struc=
t device_attribute *attr,
=20
 	r =3D count;
 out:
-	atomic_dec(&rg->lock_count);
-	up_write(&rg->lock);
-
+	omapfb_unlock(fbdev);
 	unlock_fb_info(fbi);
=20
 	return r;
@@ -505,8 +506,19 @@ static ssize_t show_phys(struct device *dev,
 {
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
 	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
+	int r;
=20
-	return snprintf(buf, PAGE_SIZE, "%0x\n", ofbi->region->paddr);
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
+	omapfb_lock(fbdev);
+
+	r =3D snprintf(buf, PAGE_SIZE, "%0x\n", ofbi->region->paddr);
+
+	omapfb_unlock(fbdev);
+	unlock_fb_info(fbi);
+
+	return r;
 }
=20
 static ssize_t show_virt(struct device *dev,
@@ -522,11 +534,20 @@ static ssize_t show_upd_mode(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
+	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	enum omapfb_update_mode mode;
 	int r;
=20
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
+	omapfb_lock(fbdev);
+
 	r =3D omapfb_get_update_mode(fbi, &mode);
=20
+	omapfb_unlock(fbdev);
+	unlock_fb_info(fbi);
+
 	if (r)
 		return r;
=20
@@ -537,6 +558,8 @@ static ssize_t store_upd_mode(struct device *dev, s=
truct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct fb_info *fbi =3D dev_get_drvdata(dev);
+	struct omapfb_info *ofbi =3D FB2OFB(fbi);
+	struct omapfb2_device *fbdev =3D ofbi->fbdev;
 	unsigned mode;
 	int r;
=20
@@ -544,10 +567,17 @@ static ssize_t store_upd_mode(struct device *dev,=
 struct device_attribute *attr,
 	if (r)
 		return r;
=20
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
+	omapfb_lock(fbdev);
+
 	r =3D omapfb_set_update_mode(fbi, mode);
 	if (r)
 		return r;
=20
+	omapfb_unlock(fbdev);
+	unlock_fb_info(fbi);
+
 	return count;
 }
=20
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/=
omapfb/omapfb.h
index 5f72bf9..71cd8ba 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -62,8 +62,6 @@ struct omapfb2_mem_region {
 	bool		alloc;		/* allocated by the driver */
 	bool		map;		/* kernel mapped by the driver */
 	atomic_t	map_count;
-	struct rw_semaphore lock;
-	atomic_t	lock_count;
 };
=20
 /* appended to fb_info */
@@ -129,9 +127,6 @@ void omapfb_remove_sysfs(struct omapfb2_device *fbd=
ev);
=20
 int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long =
arg);
=20
-int omapfb_update_window(struct fb_info *fbi,
-		u32 x, u32 y, u32 w, u32 h);
-
 int dss_mode_to_fb_mode(enum omap_color_mode dssmode,
 			struct fb_var_screeninfo *var);
=20
@@ -194,18 +189,4 @@ static inline int omapfb_overlay_enable(struct oma=
p_overlay *ovl,
 		return ovl->disable(ovl);
 }
=20
-static inline struct omapfb2_mem_region *
-omapfb_get_mem_region(struct omapfb2_mem_region *rg)
-{
-	down_read_nested(&rg->lock, rg->id);
-	atomic_inc(&rg->lock_count);
-	return rg;
-}
-
-static inline void omapfb_put_mem_region(struct omapfb2_mem_region *rg=
)
-{
-	atomic_dec(&rg->lock_count);
-	up_read(&rg->lock);
-}
-
 #endif
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
