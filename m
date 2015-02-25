From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: restore "name" sysfs entry.
Date: Wed, 25 Feb 2015 10:49:58 +0200
Message-ID: <54ED8CB6.4010308@ti.com>
References: <20150224203706.1eafa129@notabene.brown>	<54EC5520.1020105@ti.com> <20150225073131.7fbff605@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="2XSJr0s4mLbE1p7aXjBDCbMiGmnWcxjtD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58822 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbbBYIuJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 03:50:09 -0500
In-Reply-To: <20150225073131.7fbff605@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>

--2XSJr0s4mLbE1p7aXjBDCbMiGmnWcxjtD
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/02/15 22:31, NeilBrown wrote:
> On Tue, 24 Feb 2015 12:40:32 +0200 Tomi Valkeinen <tomi.valkeinen@ti.co=
m>
> wrote:
>=20
>> Hi,
>>
>> On 24/02/15 11:37, NeilBrown wrote:
>>>
>>>
>>> commit 303e4697e762dc92a40405f4e4b8aac02cd0d70b
>>>     OMAPDSS: rename display-sysfs 'name' entry
>>>
>>> broke the xorg X server on my device as it couldn't find the display
>>> any more.  It needs the 'name' file and now there isn't one.
>>>
>>> That commit claims that 'name' is not compatible with i2c or spi.
>>> i2c does register it own 'name' file, but spi does not, hence my
>>> problem - I have an spi display.
>>>
>>> So create a special case for i2c: add the name attribute for non-i2c
>>> devices.

How about this patch instead. It separates the underlying device's sysfs =
directory=20
from the "displayX" directory, and allows us to have name & display_name.=
 So it
should work for any device type.


=46rom 8e411fa684d42fca35628b41837c6d72e87aaff0 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 25 Feb 2015 10:23:58 +0200
Subject: [PATCH] OMAPDSS: fix regression with display sysfs files

omapdss's sysfs directories for displays used to have 'name' file,
giving the name for the display. This file was later renamed to
'display_name' to avoid conflicts with i2c sysfs 'name' file. Looks like
at least xserver-xorg-video-omap3 requires the 'name' file to be
present.

To fix the regression, this patch creates new kobjects for each display,
allowing us to create sysfs directories for the displays. This way we
have the whole directory for omapdss, and there will be no sysfs file
clashes with the underlying display device's sysfs files.

We can thus add the 'name' sysfs file back.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/display-sysfs.c | 179 ++++++++++++++------=
------
 include/video/omapdss.h                       |   1 +
 2 files changed, 96 insertions(+), 84 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/display-sysfs.c b/drivers/vide=
o/fbdev/omap2/dss/display-sysfs.c
index 5a2095a98ed8..12186557a9d4 100644
--- a/drivers/video/fbdev/omap2/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/dss/display-sysfs.c
@@ -28,44 +28,22 @@
 #include <video/omapdss.h>
 #include "dss.h"
=20
-static struct omap_dss_device *to_dss_device_sysfs(struct device *dev)
+static ssize_t display_name_show(struct omap_dss_device *dssdev, char *b=
uf)
 {
-	struct omap_dss_device *dssdev =3D NULL;
-
-	for_each_dss_dev(dssdev) {
-		if (dssdev->dev =3D=3D dev) {
-			omap_dss_put_device(dssdev);
-			return dssdev;
-		}
-	}
-
-	return NULL;
-}
-
-static ssize_t display_name_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
-
 	return snprintf(buf, PAGE_SIZE, "%s\n",
 			dssdev->name ?
 			dssdev->name : "");
 }
=20
-static ssize_t display_enabled_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t display_enabled_show(struct omap_dss_device *dssdev, char=
 *buf)
 {
-	struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
-
 	return snprintf(buf, PAGE_SIZE, "%d\n",
 			omapdss_device_is_enabled(dssdev));
 }
=20
-static ssize_t display_enabled_store(struct device *dev,
-		struct device_attribute *attr,
+static ssize_t display_enabled_store(struct omap_dss_device *dssdev,
 		const char *buf, size_t size)
 {
-	struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
 	int r;
 	bool enable;
=20
@@ -90,19 +68,16 @@ static ssize_t display_enabled_store(struct device *d=
ev,
 	return size;
 }
=20
-static ssize_t display_tear_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t display_tear_show(struct omap_dss_device *dssdev, char *b=
uf)
 {
-	struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
 	return snprintf(buf, PAGE_SIZE, "%d\n",
 			dssdev->driver->get_te ?
 			dssdev->driver->get_te(dssdev) : 0);
 }
=20
-static ssize_t display_tear_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size)
+static ssize_t display_tear_store(struct omap_dss_device *dssdev,
+	const char *buf, size_t size)
 {
-	struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
 	int r;
 	bool te;
=20
@@ -120,10 +95,8 @@ static ssize_t display_tear_store(struct device *dev,=

 	return size;
 }
=20
-static ssize_t display_timings_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t display_timings_show(struct omap_dss_device *dssdev, char=
 *buf)
 {
-	struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
 	struct omap_video_timings t;
=20
 	if (!dssdev->driver->get_timings)
@@ -137,10 +110,9 @@ static ssize_t display_timings_show(struct device *d=
ev,
 			t.y_res, t.vfp, t.vbp, t.vsw);
 }
=20
-static ssize_t display_timings_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size)
+static ssize_t display_timings_store(struct omap_dss_device *dssdev,
+	const char *buf, size_t size)
 {
-	struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
 	struct omap_video_timings t =3D dssdev->panel.timings;
 	int r, found;
=20
@@ -176,10 +148,8 @@ static ssize_t display_timings_store(struct device *=
dev,
 	return size;
 }
=20
-static ssize_t display_rotate_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t display_rotate_show(struct omap_dss_device *dssdev, char =
*buf)
 {
-	struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
 	int rotate;
 	if (!dssdev->driver->get_rotate)
 		return -ENOENT;
@@ -187,10 +157,9 @@ static ssize_t display_rotate_show(struct device *de=
v,
 	return snprintf(buf, PAGE_SIZE, "%u\n", rotate);
 }
=20
-static ssize_t display_rotate_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size)
+static ssize_t display_rotate_store(struct omap_dss_device *dssdev,
+	const char *buf, size_t size)
 {
-	struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
 	int rot, r;
=20
 	if (!dssdev->driver->set_rotate || !dssdev->driver->get_rotate)
@@ -207,10 +176,8 @@ static ssize_t display_rotate_store(struct device *d=
ev,
 	return size;
 }
=20
-static ssize_t display_mirror_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t display_mirror_show(struct omap_dss_device *dssdev, char =
*buf)
 {
-	struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
 	int mirror;
 	if (!dssdev->driver->get_mirror)
 		return -ENOENT;
@@ -218,10 +185,9 @@ static ssize_t display_mirror_show(struct device *de=
v,
 	return snprintf(buf, PAGE_SIZE, "%u\n", mirror);
 }
=20
-static ssize_t display_mirror_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size)
+static ssize_t display_mirror_store(struct omap_dss_device *dssdev,
+	const char *buf, size_t size)
 {
-	struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
 	int r;
 	bool mirror;
=20
@@ -239,10 +205,8 @@ static ssize_t display_mirror_store(struct device *d=
ev,
 	return size;
 }
=20
-static ssize_t display_wss_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t display_wss_show(struct omap_dss_device *dssdev, char *bu=
f)
 {
-	struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
 	unsigned int wss;
=20
 	if (!dssdev->driver->get_wss)
@@ -253,10 +217,9 @@ static ssize_t display_wss_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "0x%05x\n", wss);
 }
=20
-static ssize_t display_wss_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size)
+static ssize_t display_wss_store(struct omap_dss_device *dssdev,
+	const char *buf, size_t size)
 {
-	struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
 	u32 wss;
 	int r;
=20
@@ -277,50 +240,94 @@ static ssize_t display_wss_store(struct device *dev=
,
 	return size;
 }
=20
-static DEVICE_ATTR(display_name, S_IRUGO, display_name_show, NULL);
-static DEVICE_ATTR(enabled, S_IRUGO|S_IWUSR,
+struct display_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct omap_dss_device *, char *);
+	ssize_t	(*store)(struct omap_dss_device *, const char *, size_t);
+};
+
+#define DISPLAY_ATTR(_name, _mode, _show, _store) \
+	struct display_attribute display_attr_##_name =3D \
+	__ATTR(_name, _mode, _show, _store)
+
+static DISPLAY_ATTR(name, S_IRUGO, display_name_show, NULL);
+static DISPLAY_ATTR(display_name, S_IRUGO, display_name_show, NULL);
+static DISPLAY_ATTR(enabled, S_IRUGO|S_IWUSR,
 		display_enabled_show, display_enabled_store);
-static DEVICE_ATTR(tear_elim, S_IRUGO|S_IWUSR,
+static DISPLAY_ATTR(tear_elim, S_IRUGO|S_IWUSR,
 		display_tear_show, display_tear_store);
-static DEVICE_ATTR(timings, S_IRUGO|S_IWUSR,
+static DISPLAY_ATTR(timings, S_IRUGO|S_IWUSR,
 		display_timings_show, display_timings_store);
-static DEVICE_ATTR(rotate, S_IRUGO|S_IWUSR,
+static DISPLAY_ATTR(rotate, S_IRUGO|S_IWUSR,
 		display_rotate_show, display_rotate_store);
-static DEVICE_ATTR(mirror, S_IRUGO|S_IWUSR,
+static DISPLAY_ATTR(mirror, S_IRUGO|S_IWUSR,
 		display_mirror_show, display_mirror_store);
-static DEVICE_ATTR(wss, S_IRUGO|S_IWUSR,
+static DISPLAY_ATTR(wss, S_IRUGO|S_IWUSR,
 		display_wss_show, display_wss_store);
=20
-static const struct attribute *display_sysfs_attrs[] =3D {
-	&dev_attr_display_name.attr,
-	&dev_attr_enabled.attr,
-	&dev_attr_tear_elim.attr,
-	&dev_attr_timings.attr,
-	&dev_attr_rotate.attr,
-	&dev_attr_mirror.attr,
-	&dev_attr_wss.attr,
+static struct attribute *display_sysfs_attrs[] =3D {
+	&display_attr_name.attr,
+	&display_attr_display_name.attr,
+	&display_attr_enabled.attr,
+	&display_attr_tear_elim.attr,
+	&display_attr_timings.attr,
+	&display_attr_rotate.attr,
+	&display_attr_mirror.attr,
+	&display_attr_wss.attr,
 	NULL
 };
=20
+static ssize_t display_attr_show(struct kobject *kobj, struct attribute =
*attr,
+		char *buf)
+{
+	struct omap_dss_device *dssdev;
+	struct display_attribute *display_attr;
+
+	dssdev =3D container_of(kobj, struct omap_dss_device, kobj);
+	display_attr =3D container_of(attr, struct display_attribute, attr);
+
+	if (!display_attr->show)
+		return -ENOENT;
+
+	return display_attr->show(dssdev, buf);
+}
+
+static ssize_t display_attr_store(struct kobject *kobj, struct attribute=
 *attr,
+		const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev;
+	struct display_attribute *display_attr;
+
+	dssdev =3D container_of(kobj, struct omap_dss_device, kobj);
+	display_attr =3D container_of(attr, struct display_attribute, attr);
+
+	if (!display_attr->store)
+		return -ENOENT;
+
+	return display_attr->store(dssdev, buf, size);
+}
+
+static const struct sysfs_ops display_sysfs_ops =3D {
+	.show =3D display_attr_show,
+	.store =3D display_attr_store,
+};
+
+static struct kobj_type display_ktype =3D {
+	.sysfs_ops =3D &display_sysfs_ops,
+	.default_attrs =3D display_sysfs_attrs,
+};
+
 int display_init_sysfs(struct platform_device *pdev)
 {
 	struct omap_dss_device *dssdev =3D NULL;
 	int r;
=20
 	for_each_dss_dev(dssdev) {
-		struct kobject *kobj =3D &dssdev->dev->kobj;
-
-		r =3D sysfs_create_files(kobj, display_sysfs_attrs);
+		r =3D kobject_init_and_add(&dssdev->kobj, &display_ktype,
+			&pdev->dev.kobj, dssdev->alias);
 		if (r) {
 			DSSERR("failed to create sysfs files\n");
-			goto err;
-		}
-
-		r =3D sysfs_create_link(&pdev->dev.kobj, kobj, dssdev->alias);
-		if (r) {
-			sysfs_remove_files(kobj, display_sysfs_attrs);
-
-			DSSERR("failed to create sysfs display link\n");
+			omap_dss_put_device(dssdev);
 			goto err;
 		}
 	}
@@ -338,8 +345,12 @@ void display_uninit_sysfs(struct platform_device *pd=
ev)
 	struct omap_dss_device *dssdev =3D NULL;
=20
 	for_each_dss_dev(dssdev) {
-		sysfs_remove_link(&pdev->dev.kobj, dssdev->alias);
-		sysfs_remove_files(&dssdev->dev->kobj,
-				display_sysfs_attrs);
+		if (kobject_name(&dssdev->kobj) =3D=3D NULL)
+			continue;
+
+		kobject_del(&dssdev->kobj);
+		kobject_put(&dssdev->kobj);
+
+		memset(&dssdev->kobj, 0, sizeof(dssdev->kobj));
 	}
 }
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 60de61fea8e3..c8ed15daad02 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -689,6 +689,7 @@ struct omapdss_dsi_ops {
 };
=20
 struct omap_dss_device {
+	struct kobject kobj;
 	struct device *dev;
=20
 	struct module *owner;
--=20
2.3.0




--2XSJr0s4mLbE1p7aXjBDCbMiGmnWcxjtD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7Yy2AAoJEPo9qoy8lh71uukQAJy5zzR80dNa96XVK/QR6rY8
Z3DRe+JBQDJ/FTLT1qKOJgjFjpZIi5HlkrP3u/C5GMLsLJ0G2+tqtJ6oogCUzld+
PpDxZ4GRTljwTEgZvRm08vTMTp41w3j+gWR4IxVyTShPvMgAUbM8Uqj/DUxNHwFT
ZUd4en0V2EGTIYOhzcwK+Ni/KMW7ZKwoq1CKkPQPUD39AydCXwEx2JaXGvlbre1S
C4gYdQfgXEJT34ikLt26J5HtSmDWyEOxqFfeXLn3MdiyFkvV7gV1Z2+ENYlppi4T
xnYv1nmcF4xlCMnIQ4Gt+qHtUhbcxN98ep1oUM5TkYebimC2YgwFosDReGpNnPhl
uM4lU30ICG0plrw7W9righUVaxutDHG5fKa6wrej35t3guSbqLnIPM4ZmRNQ0VYJ
3gUyRRCgT64tHlGAaWpVyQ+8rQEkjZC/rEemkuI6iwWFcLuP2XqVRWNXcgT6Ovfh
VB6zMdAr8EM873+yeeKwoWUuxqlSQy92Wszu1IeI2ptQE5WpgI7cBzCh+azhboFS
YJ7Urh4uPMX8502bZckxln8C6AkNdL3or7g4VVv2AAdLz/XctUUX0UhsiT8caLgi
f3dAjlwBI2RKai4ztlQ5yxCV7Cb11lTUmQfqa312O77jVsTH2D4Fmrz/TkR5UguX
m/rUC3FItyvzi1RUD2rM
=ZU2g
-----END PGP SIGNATURE-----

--2XSJr0s4mLbE1p7aXjBDCbMiGmnWcxjtD--
