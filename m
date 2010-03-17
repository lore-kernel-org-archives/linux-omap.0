From: ville.syrjala@nokia.com
Subject: [PATCH v4 6/8] DSS2: OMAPFB: Convert the memory region locking to rwsem
Date: Thu, 18 Mar 2010 00:46:21 +0200
Message-ID: <1268865983-16270-7-git-send-email-ville.syrjala@nokia.com>
References: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63360 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756274Ab0CQWq6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 18:46:58 -0400
In-Reply-To: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Imre Deak <imre.deak@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

R/W semaphore is a goof fit for the memory region locking pattern.
So use it.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   10 ++--------
 drivers/video/omap2/omapfb/omapfb-main.c  |    2 +-
 drivers/video/omap2/omapfb/omapfb-sysfs.c |   10 ++--------
 drivers/video/omap2/omapfb/omapfb.h       |   13 +++++--------
 4 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/=
omap2/omapfb/omapfb-ioctl.c
index f02b1b0..4d5e5af 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -198,13 +198,7 @@ static int omapfb_setup_mem(struct fb_info *fbi, s=
truct omapfb_mem_info *mi)
=20
 	rg =3D ofbi->region;
=20
-	/* FIXME probably should be a rwsem ... */
-	mutex_lock(&rg->mtx);
-	while (rg->ref) {
-		mutex_unlock(&rg->mtx);
-		schedule();
-		mutex_lock(&rg->mtx);
-	}
+	down_write(&rg->lock);
=20
 	if (atomic_read(&rg->map_count)) {
 		r =3D -EBUSY;
@@ -235,7 +229,7 @@ static int omapfb_setup_mem(struct fb_info *fbi, st=
ruct omapfb_mem_info *mi)
 	}
=20
  out:
-	mutex_unlock(&rg->mtx);
+	up_write(&rg->lock);
=20
 	return r;
 }
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/o=
map2/omapfb/omapfb-main.c
index d330032..2bd5b42 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1929,7 +1929,7 @@ static int omapfb_create_framebuffers(struct omap=
fb2_device *fbdev)
=20
 		ofbi->region =3D &fbdev->regions[i];
 		ofbi->region->id =3D i;
-		mutex_init(&ofbi->region->mtx);
+		init_rwsem(&ofbi->region->lock);
=20
 		/* assign these early, so that fb alloc can use them */
 		ofbi->rotation_type =3D def_vrfb ? OMAP_DSS_ROT_VRFB :
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/=
omap2/omapfb/omapfb-sysfs.c
index 6aee279..aa22f7b 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -445,13 +445,7 @@ static ssize_t store_size(struct device *dev, stru=
ct device_attribute *attr,
=20
 	rg =3D ofbi->region;
=20
-	/* FIXME probably should be a rwsem ... */
-	mutex_lock(&rg->mtx);
-	while (rg->ref) {
-		mutex_unlock(&rg->mtx);
-		schedule();
-		mutex_lock(&rg->mtx);
-	}
+	down_write(&rg->lock);
=20
 	if (atomic_read(&rg->map_count)) {
 		r =3D -EBUSY;
@@ -483,7 +477,7 @@ static ssize_t store_size(struct device *dev, struc=
t device_attribute *attr,
=20
 	r =3D count;
 out:
-	mutex_unlock(&rg->mtx);
+	up_write(&rg->lock);
=20
 	unlock_fb_info(fbi);
=20
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/=
omapfb/omapfb.h
index db3aef5..195a760 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -27,6 +27,8 @@
 #define DEBUG
 #endif
=20
+#include <linux/rwsem.h>
+
 #include <plat/display.h>
=20
 #ifdef DEBUG
@@ -52,9 +54,8 @@ struct omapfb2_mem_region {
 	u8		type;		/* OMAPFB_PLANE_MEM_* */
 	bool		alloc;		/* allocated by the driver */
 	bool		map;		/* kernel mapped by the driver */
-	struct mutex    mtx;
-	unsigned int    ref;
 	atomic_t	map_count;
+	struct rw_semaphore lock;
 };
=20
 /* appended to fb_info */
@@ -164,17 +165,13 @@ static inline int omapfb_overlay_enable(struct om=
ap_overlay *ovl,
 static inline struct omapfb2_mem_region *
 omapfb_get_mem_region(struct omapfb2_mem_region *rg)
 {
-	mutex_lock(&rg->mtx);
-	rg->ref++;
-	mutex_unlock(&rg->mtx);
+	down_read(&rg->lock);
 	return rg;
 }
=20
 static inline void omapfb_put_mem_region(struct omapfb2_mem_region *rg=
)
 {
-	mutex_lock(&rg->mtx);
-	rg->ref--;
-	mutex_unlock(&rg->mtx);
+	up_read(&rg->lock);
 }
=20
 #endif
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
