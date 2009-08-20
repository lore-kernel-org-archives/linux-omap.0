From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [RFC][PATCH] omapfb: Reorder Register_framebuffer call
Date: Thu, 20 Aug 2009 15:12:56 -0500
Message-ID: <A24693684029E5489D1D202277BE89444BA0DB52@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE89444BA0DB52dlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34376 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbZHTUJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 16:09:03 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: Imre Deak <imre.deak@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_A24693684029E5489D1D202277BE89444BA0DB52dlee02entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: Sergio Aguirre <saaguirre@ti.com>

This fixes the issue in which mm_lock mutex was attempted to be
used without initializing previously.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/video/omap/omapfb_main.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_m=
ain.c
index 125e605..60f9482 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -1503,12 +1503,21 @@ static int fbinfo_init(struct omapfb_device *fbdev,=
 struct fb_info *info)
 	var->rotate	  =3D def_rotate;
 	var->bits_per_pixel =3D fbdev->panel->bpp;
=20
+	r =3D register_framebuffer(info);
+	if (r !=3D 0) {
+		dev_err(fbdev->dev,
+			"registering framebuffer failed\n");
+		return r;
+	}
+
 	set_fb_var(info, var);
 	set_fb_fix(info);
=20
 	r =3D fb_alloc_cmap(&info->cmap, 16, 0);
-	if (r !=3D 0)
+	if (r !=3D 0) {
 		dev_err(fbdev->dev, "unable to allocate color map memory\n");
+		unregister_framebuffer(info);
+	}
=20
 	return r;
 }
@@ -1773,15 +1782,8 @@ static int omapfb_do_probe(struct platform_device *p=
dev,
 	init_state++;
=20
 	vram =3D 0;
-	for (i =3D 0; i < fbdev->mem_desc.region_cnt; i++) {
-		r =3D register_framebuffer(fbdev->fb_info[i]);
-		if (r !=3D 0) {
-			dev_err(fbdev->dev,
-				"registering framebuffer %d failed\n", i);
-			goto cleanup;
-		}
+	for (i =3D 0; i < fbdev->mem_desc.region_cnt; i++)
 		vram +=3D fbdev->mem_desc.region[i].size;
-	}
=20
 	fbdev->state =3D OMAPFB_ACTIVE;
=20
--=20
1.6.3.2


--_002_A24693684029E5489D1D202277BE89444BA0DB52dlee02entticom_
Content-Type: application/octet-stream;
	name="0001-omapfb-Reorder-Register_framebuffer-call.patch"
Content-Description: 0001-omapfb-Reorder-Register_framebuffer-call.patch
Content-Disposition: attachment;
	filename="0001-omapfb-Reorder-Register_framebuffer-call.patch"; size=1681;
	creation-date="Thu, 20 Aug 2009 15:08:11 GMT";
	modification-date="Thu, 20 Aug 2009 15:08:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiZjY4MTM0YzBkMTNjOWRmNjE4ZDllZjRkM2U5ZDA2NTU4NWYzZDE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gQWd1aXJyZSA8c2FhZ3VpcnJlQHRpLmNvbT4KRGF0
ZTogVGh1LCAyMCBBdWcgMjAwOSAxNDo1ODoyMiAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIG9tYXBm
YjogUmVvcmRlciBSZWdpc3Rlcl9mcmFtZWJ1ZmZlciBjYWxsCgpUaGlzIGZpeGVzIHRoZSBpc3N1
ZSBpbiB3aGljaCBtbV9sb2NrIG11dGV4IHdhcyBhdHRlbXB0ZWQgdG8gYmUKdXNlZCB3aXRob3V0
IGluaXRpYWxpemluZyBwcmV2aW91c2x5LgoKU2lnbmVkLW9mZi1ieTogU2VyZ2lvIEFndWlycmUg
PHNhYWd1aXJyZUB0aS5jb20+Ci0tLQogZHJpdmVycy92aWRlby9vbWFwL29tYXBmYl9tYWluLmMg
fCAgIDIwICsrKysrKysrKysrLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9vbWFwL29t
YXBmYl9tYWluLmMgYi9kcml2ZXJzL3ZpZGVvL29tYXAvb21hcGZiX21haW4uYwppbmRleCAxMjVl
NjA1Li42MGY5NDgyIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL29tYXAvb21hcGZiX21haW4u
YworKysgYi9kcml2ZXJzL3ZpZGVvL29tYXAvb21hcGZiX21haW4uYwpAQCAtMTUwMywxMiArMTUw
MywyMSBAQCBzdGF0aWMgaW50IGZiaW5mb19pbml0KHN0cnVjdCBvbWFwZmJfZGV2aWNlICpmYmRl
diwgc3RydWN0IGZiX2luZm8gKmluZm8pCiAJdmFyLT5yb3RhdGUJICA9IGRlZl9yb3RhdGU7CiAJ
dmFyLT5iaXRzX3Blcl9waXhlbCA9IGZiZGV2LT5wYW5lbC0+YnBwOwogCisJciA9IHJlZ2lzdGVy
X2ZyYW1lYnVmZmVyKGluZm8pOworCWlmIChyICE9IDApIHsKKwkJZGV2X2VycihmYmRldi0+ZGV2
LAorCQkJInJlZ2lzdGVyaW5nIGZyYW1lYnVmZmVyIGZhaWxlZFxuIik7CisJCXJldHVybiByOwor
CX0KKwogCXNldF9mYl92YXIoaW5mbywgdmFyKTsKIAlzZXRfZmJfZml4KGluZm8pOwogCiAJciA9
IGZiX2FsbG9jX2NtYXAoJmluZm8tPmNtYXAsIDE2LCAwKTsKLQlpZiAociAhPSAwKQorCWlmIChy
ICE9IDApIHsKIAkJZGV2X2VycihmYmRldi0+ZGV2LCAidW5hYmxlIHRvIGFsbG9jYXRlIGNvbG9y
IG1hcCBtZW1vcnlcbiIpOworCQl1bnJlZ2lzdGVyX2ZyYW1lYnVmZmVyKGluZm8pOworCX0KIAog
CXJldHVybiByOwogfQpAQCAtMTc3MywxNSArMTc4Miw4IEBAIHN0YXRpYyBpbnQgb21hcGZiX2Rv
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsCiAJaW5pdF9zdGF0ZSsrOwogCiAJ
dnJhbSA9IDA7Ci0JZm9yIChpID0gMDsgaSA8IGZiZGV2LT5tZW1fZGVzYy5yZWdpb25fY250OyBp
KyspIHsKLQkJciA9IHJlZ2lzdGVyX2ZyYW1lYnVmZmVyKGZiZGV2LT5mYl9pbmZvW2ldKTsKLQkJ
aWYgKHIgIT0gMCkgewotCQkJZGV2X2VycihmYmRldi0+ZGV2LAotCQkJCSJyZWdpc3RlcmluZyBm
cmFtZWJ1ZmZlciAlZCBmYWlsZWRcbiIsIGkpOwotCQkJZ290byBjbGVhbnVwOwotCQl9CisJZm9y
IChpID0gMDsgaSA8IGZiZGV2LT5tZW1fZGVzYy5yZWdpb25fY250OyBpKyspCiAJCXZyYW0gKz0g
ZmJkZXYtPm1lbV9kZXNjLnJlZ2lvbltpXS5zaXplOwotCX0KIAogCWZiZGV2LT5zdGF0ZSA9IE9N
QVBGQl9BQ1RJVkU7CiAKLS0gCjEuNi4zLjIKCg==

--_002_A24693684029E5489D1D202277BE89444BA0DB52dlee02entticom_--
