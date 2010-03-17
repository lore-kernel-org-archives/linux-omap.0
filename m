From: ville.syrjala@nokia.com
Subject: [PATCH v4 7/8] DSS2: OMAPFB: Make lockdep happy
Date: Thu, 18 Mar 2010 00:46:22 +0200
Message-ID: <1268865983-16270-8-git-send-email-ville.syrjala@nokia.com>
References: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63357 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226Ab0CQWqz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 18:46:55 -0400
In-Reply-To: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Imre Deak <imre.deak@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

When more than one memory region needs to be lockd at the same time use
the memory region id to fix the order in which the locks are taken. Als=
o
one needs to use the _nested() versions of the locking primitives. The
memory region id can serve as the lock class there as well.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   45 +++++++++++++++++++++=
+-------
 drivers/video/omap2/omapfb/omapfb-sysfs.c |    2 +-
 drivers/video/omap2/omapfb/omapfb.h       |    2 +-
 3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/=
omap2/omapfb/omapfb-ioctl.c
index 4d5e5af..a3681da 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -55,7 +55,7 @@ static struct omapfb2_mem_region *get_mem_region(stru=
ct omapfb_info *ofbi,
 	if (mem_idx >=3D fbdev->num_fbs)
 		return NULL;
=20
-	return omapfb_get_mem_region(&fbdev->regions[mem_idx]);
+	return &fbdev->regions[mem_idx];
 }
=20
 static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane=
_info *pi)
@@ -77,20 +77,30 @@ static int omapfb_setup_plane(struct fb_info *fbi, =
struct omapfb_plane_info *pi)
 	/* XXX uses only the first overlay */
 	ovl =3D ofbi->overlays[0];
=20
-	old_rg =3D omapfb_get_mem_region(ofbi->region);
+	old_rg =3D ofbi->region;
 	new_rg =3D get_mem_region(ofbi, pi->mem_idx);
 	if (!new_rg) {
 		r =3D -EINVAL;
-		goto put_old;
+		goto out;
 	}
=20
+	/* Take the locks in a specific order to keep lockdep happy */
+	if (old_rg->id < new_rg->id) {
+		omapfb_get_mem_region(old_rg);
+		omapfb_get_mem_region(new_rg);
+	} else if (new_rg->id < old_rg->id) {
+		omapfb_get_mem_region(new_rg);
+		omapfb_get_mem_region(old_rg);
+	} else
+		omapfb_get_mem_region(old_rg);
+
 	if (pi->enabled && !new_rg->size) {
 		/*
 		 * This plane's memory was freed, can't enable it
 		 * until it's reallocated.
 		 */
 		r =3D -EINVAL;
-		goto put_new;
+		goto put_mem;
 	}
=20
 	ovl->get_overlay_info(ovl, &old_info);
@@ -135,8 +145,15 @@ static int omapfb_setup_plane(struct fb_info *fbi,=
 struct omapfb_plane_info *pi)
 	if (ovl->manager)
 		ovl->manager->apply(ovl->manager);
=20
-	omapfb_put_mem_region(new_rg);
-	omapfb_put_mem_region(old_rg);
+	/* Release the locks in a specific order to keep lockdep happy */
+	if (old_rg->id > new_rg->id) {
+		omapfb_put_mem_region(old_rg);
+		omapfb_put_mem_region(new_rg);
+	} else if (new_rg->id > old_rg->id) {
+		omapfb_put_mem_region(new_rg);
+		omapfb_put_mem_region(old_rg);
+	} else
+		omapfb_put_mem_region(old_rg);
=20
 	return 0;
=20
@@ -147,10 +164,16 @@ static int omapfb_setup_plane(struct fb_info *fbi=
, struct omapfb_plane_info *pi)
 	}
=20
 	ovl->set_overlay_info(ovl, &old_info);
- put_new:
-	omapfb_put_mem_region(new_rg);
- put_old:
-	omapfb_put_mem_region(old_rg);
+ put_mem:
+	/* Release the locks in a specific order to keep lockdep happy */
+	if (old_rg->id > new_rg->id) {
+		omapfb_put_mem_region(old_rg);
+		omapfb_put_mem_region(new_rg);
+	} else if (new_rg->id > old_rg->id) {
+		omapfb_put_mem_region(new_rg);
+		omapfb_put_mem_region(old_rg);
+	} else
+		omapfb_put_mem_region(old_rg);
  out:
 	dev_err(fbdev->dev, "setup_plane failed\n");
=20
@@ -198,7 +221,7 @@ static int omapfb_setup_mem(struct fb_info *fbi, st=
ruct omapfb_mem_info *mi)
=20
 	rg =3D ofbi->region;
=20
-	down_write(&rg->lock);
+	down_write_nested(&rg->lock, rg->id);
=20
 	if (atomic_read(&rg->map_count)) {
 		r =3D -EBUSY;
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/=
omap2/omapfb/omapfb-sysfs.c
index aa22f7b..1b7cf57 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -445,7 +445,7 @@ static ssize_t store_size(struct device *dev, struc=
t device_attribute *attr,
=20
 	rg =3D ofbi->region;
=20
-	down_write(&rg->lock);
+	down_write_nested(&rg->lock, rg->id);
=20
 	if (atomic_read(&rg->map_count)) {
 		r =3D -EBUSY;
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/=
omapfb/omapfb.h
index 195a760..676b55d 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -165,7 +165,7 @@ static inline int omapfb_overlay_enable(struct omap=
_overlay *ovl,
 static inline struct omapfb2_mem_region *
 omapfb_get_mem_region(struct omapfb2_mem_region *rg)
 {
-	down_read(&rg->lock);
+	down_read_nested(&rg->lock, rg->id);
 	return rg;
 }
=20
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
