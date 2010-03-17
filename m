From: ville.syrjala@nokia.com
Subject: [PATCH v4 8/8] DSS2: OMAPFB: Add some locking debug checks
Date: Thu, 18 Mar 2010 00:46:23 +0200
Message-ID: <1268865983-16270-9-git-send-email-ville.syrjala@nokia.com>
References: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28656 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756285Ab0CQWrE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 18:47:04 -0400
In-Reply-To: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Imre Deak <imre.deak@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

Trigger WARN_ON() messages from various places in the code in case the
memory region is not currently locked.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    2 ++
 drivers/video/omap2/omapfb/omapfb-main.c  |    6 ++++++
 drivers/video/omap2/omapfb/omapfb-sysfs.c |    2 ++
 drivers/video/omap2/omapfb/omapfb.h       |    3 +++
 4 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/=
omap2/omapfb/omapfb-ioctl.c
index a3681da..64e70e0 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -222,6 +222,7 @@ static int omapfb_setup_mem(struct fb_info *fbi, st=
ruct omapfb_mem_info *mi)
 	rg =3D ofbi->region;
=20
 	down_write_nested(&rg->lock, rg->id);
+	atomic_inc(&rg->lock_count);
=20
 	if (atomic_read(&rg->map_count)) {
 		r =3D -EBUSY;
@@ -252,6 +253,7 @@ static int omapfb_setup_mem(struct fb_info *fbi, st=
ruct omapfb_mem_info *mi)
 	}
=20
  out:
+	atomic_dec(&rg->lock_count);
 	up_write(&rg->lock);
=20
 	return r;
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/o=
map2/omapfb/omapfb-main.c
index 2bd5b42..ac7625d 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -667,6 +667,8 @@ int check_fb_var(struct fb_info *fbi, struct fb_var=
_screeninfo *var)
=20
 	DBG("check_fb_var %d\n", ofbi->id);
=20
+	WARN_ON(!atomic_read(&ofbi->region->lock_count));
+
 	r =3D fb_mode_to_dss_mode(var, &mode);
 	if (r) {
 		DBG("cannot convert var to omap dss mode\n");
@@ -872,6 +874,8 @@ int omapfb_setup_overlay(struct fb_info *fbi, struc=
t omap_overlay *ovl,
 	int rotation =3D var->rotate;
 	int i;
=20
+	WARN_ON(!atomic_read(&ofbi->region->lock_count));
+
 	for (i =3D 0; i < ofbi->num_overlays; i++) {
 		if (ovl !=3D ofbi->overlays[i])
 			continue;
@@ -965,6 +969,8 @@ int omapfb_apply_changes(struct fb_info *fbi, int i=
nit)
 		fill_fb(fbi);
 #endif
=20
+	WARN_ON(!atomic_read(&ofbi->region->lock_count));
+
 	for (i =3D 0; i < ofbi->num_overlays; i++) {
 		ovl =3D ofbi->overlays[i];
=20
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/=
omap2/omapfb/omapfb-sysfs.c
index 1b7cf57..cf2f478 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -446,6 +446,7 @@ static ssize_t store_size(struct device *dev, struc=
t device_attribute *attr,
 	rg =3D ofbi->region;
=20
 	down_write_nested(&rg->lock, rg->id);
+	atomic_inc(&rg->lock_count);
=20
 	if (atomic_read(&rg->map_count)) {
 		r =3D -EBUSY;
@@ -477,6 +478,7 @@ static ssize_t store_size(struct device *dev, struc=
t device_attribute *attr,
=20
 	r =3D count;
 out:
+	atomic_dec(&rg->lock_count);
 	up_write(&rg->lock);
=20
 	unlock_fb_info(fbi);
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/=
omapfb/omapfb.h
index 676b55d..1305fc9 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -56,6 +56,7 @@ struct omapfb2_mem_region {
 	bool		map;		/* kernel mapped by the driver */
 	atomic_t	map_count;
 	struct rw_semaphore lock;
+	atomic_t	lock_count;
 };
=20
 /* appended to fb_info */
@@ -166,11 +167,13 @@ static inline struct omapfb2_mem_region *
 omapfb_get_mem_region(struct omapfb2_mem_region *rg)
 {
 	down_read_nested(&rg->lock, rg->id);
+	atomic_inc(&rg->lock_count);
 	return rg;
 }
=20
 static inline void omapfb_put_mem_region(struct omapfb2_mem_region *rg=
)
 {
+	atomic_dec(&rg->lock_count);
 	up_read(&rg->lock);
 }
=20
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
