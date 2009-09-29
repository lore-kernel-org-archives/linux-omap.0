From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [RFC][PATCH] omapfb: Condition mutex acquisition
Date: Tue, 29 Sep 2009 09:14:05 -0500
Message-ID: <A24693684029E5489D1D202277BE89444B781B6F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE89444B781B6Fdlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38985 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbZI2OQv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Sep 2009 10:16:51 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "imre.deak@nokia.com" <imre.deak@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_A24693684029E5489D1D202277BE89444B781B6Fdlee02entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: Sergio Aguirre <saaguirre@ti.com>

Acquiring mutex before framebuffer registration doesn't make sense,
As there's no danger of external access to the memory related fields.

NOTE: PLEASE REVIEW! I'M NOT AN EXPERT ON THIS.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/video/omap/omapfb_main.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_m=
ain.c
index 125e605..0d0c8c8 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -393,7 +393,7 @@ static void omapfb_sync(struct fb_info *fbi)
  * Set fb_info.fix fields and also updates fbdev.
  * When calling this fb_info.var must be set up already.
  */
-static void set_fb_fix(struct fb_info *fbi)
+static void set_fb_fix(struct fb_info *fbi, int from_init)
 {
 	struct fb_fix_screeninfo *fix =3D &fbi->fix;
 	struct fb_var_screeninfo *var =3D &fbi->var;
@@ -403,10 +403,16 @@ static void set_fb_fix(struct fb_info *fbi)
=20
 	rg =3D &plane->fbdev->mem_desc.region[plane->idx];
 	fbi->screen_base	=3D rg->vaddr;
-	mutex_lock(&fbi->mm_lock);
-	fix->smem_start		=3D rg->paddr;
-	fix->smem_len		=3D rg->size;
-	mutex_unlock(&fbi->mm_lock);
+
+	if (!from_init) {
+		mutex_lock(&fbi->mm_lock);
+		fix->smem_start		=3D rg->paddr;
+		fix->smem_len		=3D rg->size;
+		mutex_unlock(&fbi->mm_lock);
+	} else {
+		fix->smem_start		=3D rg->paddr;
+		fix->smem_len		=3D rg->size;
+	}
=20
 	fix->type =3D FB_TYPE_PACKED_PIXELS;
 	bpp =3D var->bits_per_pixel;
@@ -704,7 +710,7 @@ static int omapfb_set_par(struct fb_info *fbi)
 	int r =3D 0;
=20
 	omapfb_rqueue_lock(fbdev);
-	set_fb_fix(fbi);
+	set_fb_fix(fbi, 0);
 	r =3D ctrl_change_mode(fbi);
 	omapfb_rqueue_unlock(fbdev);
=20
@@ -904,7 +910,7 @@ static int omapfb_setup_mem(struct fb_info *fbi, struct=
 omapfb_mem_info *mi)
 		if (old_size !=3D size) {
 			if (size) {
 				memcpy(&fbi->var, new_var, sizeof(fbi->var));
-				set_fb_fix(fbi);
+				set_fb_fix(fbi, 0);
 			} else {
 				/*
 				 * Set these explicitly to indicate that the
@@ -1504,7 +1510,7 @@ static int fbinfo_init(struct omapfb_device *fbdev, s=
truct fb_info *info)
 	var->bits_per_pixel =3D fbdev->panel->bpp;
=20
 	set_fb_var(info, var);
-	set_fb_fix(info);
+	set_fb_fix(info, 1);
=20
 	r =3D fb_alloc_cmap(&info->cmap, 16, 0);
 	if (r !=3D 0)
--=20
1.6.0.4

--_002_A24693684029E5489D1D202277BE89444B781B6Fdlee02entticom_
Content-Type: text/x-patch;
	name="0001-omapfb-Condition-mutex-acquisition.patch"
Content-Description: 0001-omapfb-Condition-mutex-acquisition.patch
Content-Disposition: attachment;
	filename="0001-omapfb-Condition-mutex-acquisition.patch"; size=2493;
	creation-date="Tue, 29 Sep 2009 09:14:22 GMT";
	modification-date="Tue, 29 Sep 2009 09:14:22 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiYmEyZDg5ZWE0NWVjMDM1OWRlYzZmZTIxYzE3NTZhZDM0MDZlMzQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gQWd1aXJyZSA8c2FhZ3VpcnJlQHRpLmNvbT4KRGF0
ZTogVHVlLCAyOSBTZXAgMjAwOSAwNzo0NDoxOSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIG9tYXBm
YjogQ29uZGl0aW9uIG11dGV4IGFjcXVpc2l0aW9uCgpBY3F1aXJpbmcgbXV0ZXggYmVmb3JlIGZy
YW1lYnVmZmVyIHJlZ2lzdHJhdGlvbiBkb2Vzbid0IG1ha2Ugc2Vuc2UsCkFzIHRoZXJlJ3Mgbm8g
ZGFuZ2VyIG9mIGV4dGVybmFsIGFjY2VzcyB0byB0aGUgbWVtb3J5IHJlbGF0ZWQgZmllbGRzLgoK
Tk9URTogUExFQVNFIFJFVklFVyEgSSdNIE5PVCBBTiBFWFBFUlQgT04gVEhJUy4KClNpZ25lZC1v
ZmYtYnk6IFNlcmdpbyBBZ3VpcnJlIDxzYWFndWlycmVAdGkuY29tPgotLS0KIGRyaXZlcnMvdmlk
ZW8vb21hcC9vbWFwZmJfbWFpbi5jIHwgICAyMiArKysrKysrKysrKysrKy0tLS0tLS0tCiAxIGZp
bGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aWRlby9vbWFwL29tYXBmYl9tYWluLmMgYi9kcml2ZXJzL3ZpZGVvL29tYXAv
b21hcGZiX21haW4uYwppbmRleCAxMjVlNjA1Li4wZDBjOGM4IDEwMDY0NAotLS0gYS9kcml2ZXJz
L3ZpZGVvL29tYXAvb21hcGZiX21haW4uYworKysgYi9kcml2ZXJzL3ZpZGVvL29tYXAvb21hcGZi
X21haW4uYwpAQCAtMzkzLDcgKzM5Myw3IEBAIHN0YXRpYyB2b2lkIG9tYXBmYl9zeW5jKHN0cnVj
dCBmYl9pbmZvICpmYmkpCiAgKiBTZXQgZmJfaW5mby5maXggZmllbGRzIGFuZCBhbHNvIHVwZGF0
ZXMgZmJkZXYuCiAgKiBXaGVuIGNhbGxpbmcgdGhpcyBmYl9pbmZvLnZhciBtdXN0IGJlIHNldCB1
cCBhbHJlYWR5LgogICovCi1zdGF0aWMgdm9pZCBzZXRfZmJfZml4KHN0cnVjdCBmYl9pbmZvICpm
YmkpCitzdGF0aWMgdm9pZCBzZXRfZmJfZml4KHN0cnVjdCBmYl9pbmZvICpmYmksIGludCBmcm9t
X2luaXQpCiB7CiAJc3RydWN0IGZiX2ZpeF9zY3JlZW5pbmZvICpmaXggPSAmZmJpLT5maXg7CiAJ
c3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIgPSAmZmJpLT52YXI7CkBAIC00MDMsMTAgKzQw
MywxNiBAQCBzdGF0aWMgdm9pZCBzZXRfZmJfZml4KHN0cnVjdCBmYl9pbmZvICpmYmkpCiAKIAly
ZyA9ICZwbGFuZS0+ZmJkZXYtPm1lbV9kZXNjLnJlZ2lvbltwbGFuZS0+aWR4XTsKIAlmYmktPnNj
cmVlbl9iYXNlCT0gcmctPnZhZGRyOwotCW11dGV4X2xvY2soJmZiaS0+bW1fbG9jayk7Ci0JZml4
LT5zbWVtX3N0YXJ0CQk9IHJnLT5wYWRkcjsKLQlmaXgtPnNtZW1fbGVuCQk9IHJnLT5zaXplOwot
CW11dGV4X3VubG9jaygmZmJpLT5tbV9sb2NrKTsKKworCWlmICghZnJvbV9pbml0KSB7CisJCW11
dGV4X2xvY2soJmZiaS0+bW1fbG9jayk7CisJCWZpeC0+c21lbV9zdGFydAkJPSByZy0+cGFkZHI7
CisJCWZpeC0+c21lbV9sZW4JCT0gcmctPnNpemU7CisJCW11dGV4X3VubG9jaygmZmJpLT5tbV9s
b2NrKTsKKwl9IGVsc2UgeworCQlmaXgtPnNtZW1fc3RhcnQJCT0gcmctPnBhZGRyOworCQlmaXgt
PnNtZW1fbGVuCQk9IHJnLT5zaXplOworCX0KIAogCWZpeC0+dHlwZSA9IEZCX1RZUEVfUEFDS0VE
X1BJWEVMUzsKIAlicHAgPSB2YXItPmJpdHNfcGVyX3BpeGVsOwpAQCAtNzA0LDcgKzcxMCw3IEBA
IHN0YXRpYyBpbnQgb21hcGZiX3NldF9wYXIoc3RydWN0IGZiX2luZm8gKmZiaSkKIAlpbnQgciA9
IDA7CiAKIAlvbWFwZmJfcnF1ZXVlX2xvY2soZmJkZXYpOwotCXNldF9mYl9maXgoZmJpKTsKKwlz
ZXRfZmJfZml4KGZiaSwgMCk7CiAJciA9IGN0cmxfY2hhbmdlX21vZGUoZmJpKTsKIAlvbWFwZmJf
cnF1ZXVlX3VubG9jayhmYmRldik7CiAKQEAgLTkwNCw3ICs5MTAsNyBAQCBzdGF0aWMgaW50IG9t
YXBmYl9zZXR1cF9tZW0oc3RydWN0IGZiX2luZm8gKmZiaSwgc3RydWN0IG9tYXBmYl9tZW1faW5m
byAqbWkpCiAJCWlmIChvbGRfc2l6ZSAhPSBzaXplKSB7CiAJCQlpZiAoc2l6ZSkgewogCQkJCW1l
bWNweSgmZmJpLT52YXIsIG5ld192YXIsIHNpemVvZihmYmktPnZhcikpOwotCQkJCXNldF9mYl9m
aXgoZmJpKTsKKwkJCQlzZXRfZmJfZml4KGZiaSwgMCk7CiAJCQl9IGVsc2UgewogCQkJCS8qCiAJ
CQkJICogU2V0IHRoZXNlIGV4cGxpY2l0bHkgdG8gaW5kaWNhdGUgdGhhdCB0aGUKQEAgLTE1MDQs
NyArMTUxMCw3IEBAIHN0YXRpYyBpbnQgZmJpbmZvX2luaXQoc3RydWN0IG9tYXBmYl9kZXZpY2Ug
KmZiZGV2LCBzdHJ1Y3QgZmJfaW5mbyAqaW5mbykKIAl2YXItPmJpdHNfcGVyX3BpeGVsID0gZmJk
ZXYtPnBhbmVsLT5icHA7CiAKIAlzZXRfZmJfdmFyKGluZm8sIHZhcik7Ci0Jc2V0X2ZiX2ZpeChp
bmZvKTsKKwlzZXRfZmJfZml4KGluZm8sIDEpOwogCiAJciA9IGZiX2FsbG9jX2NtYXAoJmluZm8t
PmNtYXAsIDE2LCAwKTsKIAlpZiAociAhPSAwKQotLSAKMS42LjAuNAoK

--_002_A24693684029E5489D1D202277BE89444B781B6Fdlee02entticom_--
