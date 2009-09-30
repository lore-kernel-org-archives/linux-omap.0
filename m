From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH v2] omapfb: Condition mutex acquisition
Date: Wed, 30 Sep 2009 07:34:55 -0500
Message-ID: <A24693684029E5489D1D202277BE89444C92BC78@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE89444C92BC78dlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55276 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbZI3MfL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Sep 2009 08:35:11 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, Imre Deak <imre.deak@nokia.com>, ext Tony Lindgren <tony@atomide.com>

--_002_A24693684029E5489D1D202277BE89444C92BC78dlee02entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: Sergio Aguirre <saaguirre@ti.com>

This fixes a bug introduced by this commit ID:

  commit 537a1bf059fa312355696fa6db80726e655e7f17
  Author: Krzysztof Helt <krzysztof.h1@wp.pl>
  Date:   Tue Jun 30 11:41:29 2009 -0700

    fbdev: add mutex for fb_mmap locking

In which a mutex was added when changing smem_start and smem_len fields,
so the mutex inside the fb_mmap() call is actually used.

The problem was that set_fb_fix, which modifies the above 2 fields,
was called before and after registering the framebuffer,
which when used before registration, lead to a failed attempt to
use an uninitialized mutex.

Solution: Don't use mutex before framebuffer registration.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Acked-by: Imre Deak <imre.deak@nokia.com>
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


--_002_A24693684029E5489D1D202277BE89444C92BC78dlee02entticom_
Content-Type: application/octet-stream;
	name="0001-omapfb-Condition-mutex-acquisition.patch"
Content-Description: 0001-omapfb-Condition-mutex-acquisition.patch
Content-Disposition: attachment;
	filename="0001-omapfb-Condition-mutex-acquisition.patch"; size=3037;
	creation-date="Wed, 30 Sep 2009 07:32:35 GMT";
	modification-date="Wed, 30 Sep 2009 07:32:35 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjZDAyZjIyMDc4MWI5ZWIwMjIxMTU3YTM2YjQ3MzFkZmIyZGE5MGFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gQWd1aXJyZSA8c2FhZ3VpcnJlQHRpLmNvbT4KRGF0
ZTogVHVlLCAyOSBTZXAgMjAwOSAwNzo0NDoxOSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIG9tYXBm
YjogQ29uZGl0aW9uIG11dGV4IGFjcXVpc2l0aW9uCgpUaGlzIGZpeGVzIGEgYnVnIGludHJvZHVj
ZWQgYnkgdGhpcyBjb21taXQgSUQ6CgogIGNvbW1pdCA1MzdhMWJmMDU5ZmEzMTIzNTU2OTZmYTZk
YjgwNzI2ZTY1NWU3ZjE3CiAgQXV0aG9yOiBLcnp5c3p0b2YgSGVsdCA8a3J6eXN6dG9mLmgxQHdw
LnBsPgogIERhdGU6ICAgVHVlIEp1biAzMCAxMTo0MToyOSAyMDA5IC0wNzAwCgogICAgZmJkZXY6
IGFkZCBtdXRleCBmb3IgZmJfbW1hcCBsb2NraW5nCgpJbiB3aGljaCBhIG11dGV4IHdhcyBhZGRl
ZCB3aGVuIGNoYW5naW5nIHNtZW1fc3RhcnQgYW5kIHNtZW1fbGVuIGZpZWxkcywKc28gdGhlIG11
dGV4IGluc2lkZSB0aGUgZmJfbW1hcCgpIGNhbGwgaXMgYWN0dWFsbHkgdXNlZC4KClRoZSBwcm9i
bGVtIHdhcyB0aGF0IHNldF9mYl9maXgsIHdoaWNoIG1vZGlmaWVzIHRoZSBhYm92ZSAyIGZpZWxk
cywKd2FzIGNhbGxlZCBiZWZvcmUgYW5kIGFmdGVyIHJlZ2lzdGVyaW5nIHRoZSBmcmFtZWJ1ZmZl
ciwKd2hpY2ggd2hlbiB1c2VkIGJlZm9yZSByZWdpc3RyYXRpb24sIGxlYWQgdG8gYSBmYWlsZWQg
YXR0ZW1wdCB0bwp1c2UgYW4gdW5pbml0aWFsaXplZCBtdXRleC4KClNvbHV0aW9uOiBEb24ndCB1
c2UgbXV0ZXggYmVmb3JlIGZyYW1lYnVmZmVyIHJlZ2lzdHJhdGlvbi4KClNpZ25lZC1vZmYtYnk6
IFNlcmdpbyBBZ3VpcnJlIDxzYWFndWlycmVAdGkuY29tPgpBY2tlZC1ieTogVG9taSBWYWxrZWlu
ZW4gPHRvbWkudmFsa2VpbmVuQG5va2lhLmNvbT4KQWNrZWQtYnk6IEltcmUgRGVhayA8aW1yZS5k
ZWFrQG5va2lhLmNvbT4KLS0tCiBkcml2ZXJzL3ZpZGVvL29tYXAvb21hcGZiX21haW4uYyB8ICAg
MjIgKysrKysrKysrKysrKystLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vb21hcC9vbWFw
ZmJfbWFpbi5jIGIvZHJpdmVycy92aWRlby9vbWFwL29tYXBmYl9tYWluLmMKaW5kZXggMTI1ZTYw
NS4uMGQwYzhjOCAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9vbWFwL29tYXBmYl9tYWluLmMK
KysrIGIvZHJpdmVycy92aWRlby9vbWFwL29tYXBmYl9tYWluLmMKQEAgLTM5Myw3ICszOTMsNyBA
QCBzdGF0aWMgdm9pZCBvbWFwZmJfc3luYyhzdHJ1Y3QgZmJfaW5mbyAqZmJpKQogICogU2V0IGZi
X2luZm8uZml4IGZpZWxkcyBhbmQgYWxzbyB1cGRhdGVzIGZiZGV2LgogICogV2hlbiBjYWxsaW5n
IHRoaXMgZmJfaW5mby52YXIgbXVzdCBiZSBzZXQgdXAgYWxyZWFkeS4KICAqLwotc3RhdGljIHZv
aWQgc2V0X2ZiX2ZpeChzdHJ1Y3QgZmJfaW5mbyAqZmJpKQorc3RhdGljIHZvaWQgc2V0X2ZiX2Zp
eChzdHJ1Y3QgZmJfaW5mbyAqZmJpLCBpbnQgZnJvbV9pbml0KQogewogCXN0cnVjdCBmYl9maXhf
c2NyZWVuaW5mbyAqZml4ID0gJmZiaS0+Zml4OwogCXN0cnVjdCBmYl92YXJfc2NyZWVuaW5mbyAq
dmFyID0gJmZiaS0+dmFyOwpAQCAtNDAzLDEwICs0MDMsMTYgQEAgc3RhdGljIHZvaWQgc2V0X2Zi
X2ZpeChzdHJ1Y3QgZmJfaW5mbyAqZmJpKQogCiAJcmcgPSAmcGxhbmUtPmZiZGV2LT5tZW1fZGVz
Yy5yZWdpb25bcGxhbmUtPmlkeF07CiAJZmJpLT5zY3JlZW5fYmFzZQk9IHJnLT52YWRkcjsKLQlt
dXRleF9sb2NrKCZmYmktPm1tX2xvY2spOwotCWZpeC0+c21lbV9zdGFydAkJPSByZy0+cGFkZHI7
Ci0JZml4LT5zbWVtX2xlbgkJPSByZy0+c2l6ZTsKLQltdXRleF91bmxvY2soJmZiaS0+bW1fbG9j
ayk7CisKKwlpZiAoIWZyb21faW5pdCkgeworCQltdXRleF9sb2NrKCZmYmktPm1tX2xvY2spOwor
CQlmaXgtPnNtZW1fc3RhcnQJCT0gcmctPnBhZGRyOworCQlmaXgtPnNtZW1fbGVuCQk9IHJnLT5z
aXplOworCQltdXRleF91bmxvY2soJmZiaS0+bW1fbG9jayk7CisJfSBlbHNlIHsKKwkJZml4LT5z
bWVtX3N0YXJ0CQk9IHJnLT5wYWRkcjsKKwkJZml4LT5zbWVtX2xlbgkJPSByZy0+c2l6ZTsKKwl9
CiAKIAlmaXgtPnR5cGUgPSBGQl9UWVBFX1BBQ0tFRF9QSVhFTFM7CiAJYnBwID0gdmFyLT5iaXRz
X3Blcl9waXhlbDsKQEAgLTcwNCw3ICs3MTAsNyBAQCBzdGF0aWMgaW50IG9tYXBmYl9zZXRfcGFy
KHN0cnVjdCBmYl9pbmZvICpmYmkpCiAJaW50IHIgPSAwOwogCiAJb21hcGZiX3JxdWV1ZV9sb2Nr
KGZiZGV2KTsKLQlzZXRfZmJfZml4KGZiaSk7CisJc2V0X2ZiX2ZpeChmYmksIDApOwogCXIgPSBj
dHJsX2NoYW5nZV9tb2RlKGZiaSk7CiAJb21hcGZiX3JxdWV1ZV91bmxvY2soZmJkZXYpOwogCkBA
IC05MDQsNyArOTEwLDcgQEAgc3RhdGljIGludCBvbWFwZmJfc2V0dXBfbWVtKHN0cnVjdCBmYl9p
bmZvICpmYmksIHN0cnVjdCBvbWFwZmJfbWVtX2luZm8gKm1pKQogCQlpZiAob2xkX3NpemUgIT0g
c2l6ZSkgewogCQkJaWYgKHNpemUpIHsKIAkJCQltZW1jcHkoJmZiaS0+dmFyLCBuZXdfdmFyLCBz
aXplb2YoZmJpLT52YXIpKTsKLQkJCQlzZXRfZmJfZml4KGZiaSk7CisJCQkJc2V0X2ZiX2ZpeChm
YmksIDApOwogCQkJfSBlbHNlIHsKIAkJCQkvKgogCQkJCSAqIFNldCB0aGVzZSBleHBsaWNpdGx5
IHRvIGluZGljYXRlIHRoYXQgdGhlCkBAIC0xNTA0LDcgKzE1MTAsNyBAQCBzdGF0aWMgaW50IGZi
aW5mb19pbml0KHN0cnVjdCBvbWFwZmJfZGV2aWNlICpmYmRldiwgc3RydWN0IGZiX2luZm8gKmlu
Zm8pCiAJdmFyLT5iaXRzX3Blcl9waXhlbCA9IGZiZGV2LT5wYW5lbC0+YnBwOwogCiAJc2V0X2Zi
X3ZhcihpbmZvLCB2YXIpOwotCXNldF9mYl9maXgoaW5mbyk7CisJc2V0X2ZiX2ZpeChpbmZvLCAx
KTsKIAogCXIgPSBmYl9hbGxvY19jbWFwKCZpbmZvLT5jbWFwLCAxNiwgMCk7CiAJaWYgKHIgIT0g
MCkKLS0gCjEuNi4wLjQKCg==

--_002_A24693684029E5489D1D202277BE89444C92BC78dlee02entticom_--
