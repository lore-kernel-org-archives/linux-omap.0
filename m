From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH] ARM: OMAP add TLB preservation support to IOMMU
Date: Fri, 16 Apr 2010 11:18:59 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B216AFA@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E4B216AFAdlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55935 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758545Ab0DPQTH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 12:19:07 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B216AFAdlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From bcdd232666a163d2661d704f9c21d055bacfd178 Mon Sep 17 00:00:00 2001
From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Mon, 8 Mar 2010 18:00:36 -0600
Subject: [PATCH] ARM: OMAP add TLB preservation support to IOMMU

This patch adds TLB preservation support to IOMMU module

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/iommu2.c |    7 +++++--
 arch/arm/plat-omap/iommu.c   |   16 +++++++++-------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 6f4b7cc..2735bd7 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -146,6 +146,8 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32=
 *ra)
 	printk("\n");
=20
 	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
+	/* Disable MMU to stop continuous generation of MMU faults */
+	omap2_iommu_disable(obj);
 	return stat;
 }
=20
@@ -183,7 +185,7 @@ static struct cr_regs *omap2_alloc_cr(struct iommu *obj=
, struct iotlb_entry *e)
 	if (!cr)
 		return ERR_PTR(-ENOMEM);
=20
-	cr->cam =3D (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz;
+	cr->cam =3D (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz | e->valid;
 	cr->ram =3D e->pa | e->endian | e->elsz | e->mixed;
=20
 	return cr;
@@ -211,7 +213,8 @@ static ssize_t omap2_dump_cr(struct iommu *obj, struct =
cr_regs *cr, char *buf)
 	char *p =3D buf;
=20
 	/* FIXME: Need more detail analysis of cam/ram */
-	p +=3D sprintf(p, "%08x %08x\n", cr->cam, cr->ram);
+	p +=3D sprintf(p, "%08x %08x %01x\n", cr->cam, cr->ram,
+					(cr->cam & MMU_CAM_P) ? 1 : 0);
=20
 	return p - buf;
 }
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 5186728..64d676e 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -171,15 +171,12 @@ static void iotlb_lock_get(struct iommu *obj, struct =
iotlb_lock *l)
 	l->base =3D MMU_LOCK_BASE(val);
 	l->vict =3D MMU_LOCK_VICT(val);
=20
-	BUG_ON(l->base !=3D 0); /* Currently no preservation is used */
 }
=20
 static void iotlb_lock_set(struct iommu *obj, struct iotlb_lock *l)
 {
 	u32 val;
=20
-	BUG_ON(l->base !=3D 0); /* Currently no preservation is used */
-
 	val =3D (l->base << MMU_LOCK_BASE_SHIFT);
 	val |=3D (l->vict << MMU_LOCK_VICT_SHIFT);
=20
@@ -241,7 +238,7 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_en=
try *e)
 			break;
 	}
=20
-	if (i =3D=3D obj->nr_tlb_entries) {
+	if (i =3D=3D obj->nr_tlb_entries || (l.base =3D=3D obj->nr_tlb_entries)) =
{
 		dev_dbg(obj->dev, "%s: full: no entry\n", __func__);
 		err =3D -EBUSY;
 		goto out;
@@ -252,13 +249,18 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_=
entry *e)
 		clk_disable(obj->clk);
 		return PTR_ERR(cr);
 	}
-
 	iotlb_load_cr(obj, cr);
 	kfree(cr);
=20
+	/* Increment base number if preservation is set */
+	if (e->prsvd)
+		l.base++;
 	/* increment victim for next tlb load */
-	if (++l.vict =3D=3D obj->nr_tlb_entries)
-		l.vict =3D 0;
+	if (++l.vict =3D=3D obj->nr_tlb_entries) {
+		l.vict =3D l.base;
+		goto out;
+	}
+
 	iotlb_lock_set(obj, &l);
 out:
 	clk_disable(obj->clk);
--=20
1.7.0


Thank you,
Best regards,
Hari


--_002_8F7AF80515AF0D4D93307E594F3CB40E4B216AFAdlee03entticom_
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP-add-TLB-preservation-support-to-IOMMU.patch"
Content-Description: 0001-ARM-OMAP-add-TLB-preservation-support-to-IOMMU.patch
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-add-TLB-preservation-support-to-IOMMU.patch";
	size=3017; creation-date="Fri, 16 Apr 2010 11:27:34 GMT";
	modification-date="Fri, 16 Apr 2010 11:27:34 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiY2RkMjMyNjY2YTE2M2QyNjYxZDcwNGY5YzIxZDA1NWJhY2ZkMTc4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IE1vbiwgOCBNYXIgMjAxMCAxODowMDozNiAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIEFSTTog
T01BUCBhZGQgVExCIHByZXNlcnZhdGlvbiBzdXBwb3J0IHRvIElPTU1VCgpUaGlzIHBhdGNoIGFk
ZHMgVExCIHByZXNlcnZhdGlvbiBzdXBwb3J0IHRvIElPTU1VIG1vZHVsZQoKU2lnbmVkLW9mZi1i
eTogSGFyaSBLYW5pZ2VyaSA8aC1rYW5pZ2VyaTJAdGkuY29tPgotLS0KIGFyY2gvYXJtL21hY2gt
b21hcDIvaW9tbXUyLmMgfCAgICA3ICsrKysrLS0KIGFyY2gvYXJtL3BsYXQtb21hcC9pb21tdS5j
ICAgfCAgIDE2ICsrKysrKysrKy0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2lv
bW11Mi5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9pb21tdTIuYwppbmRleCA2ZjRiN2NjLi4yNzM1
YmQ3IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2lvbW11Mi5jCisrKyBiL2FyY2gv
YXJtL21hY2gtb21hcDIvaW9tbXUyLmMKQEAgLTE0Niw2ICsxNDYsOCBAQCBzdGF0aWMgdTMyIG9t
YXAyX2lvbW11X2ZhdWx0X2lzcihzdHJ1Y3QgaW9tbXUgKm9iaiwgdTMyICpyYSkKIAlwcmludGso
IlxuIik7CiAKIAlpb21tdV93cml0ZV9yZWcob2JqLCBzdGF0LCBNTVVfSVJRU1RBVFVTKTsKKwkv
KiBEaXNhYmxlIE1NVSB0byBzdG9wIGNvbnRpbnVvdXMgZ2VuZXJhdGlvbiBvZiBNTVUgZmF1bHRz
ICovCisJb21hcDJfaW9tbXVfZGlzYWJsZShvYmopOwogCXJldHVybiBzdGF0OwogfQogCkBAIC0x
ODMsNyArMTg1LDcgQEAgc3RhdGljIHN0cnVjdCBjcl9yZWdzICpvbWFwMl9hbGxvY19jcihzdHJ1
Y3QgaW9tbXUgKm9iaiwgc3RydWN0IGlvdGxiX2VudHJ5ICplKQogCWlmICghY3IpCiAJCXJldHVy
biBFUlJfUFRSKC1FTk9NRU0pOwogCi0JY3ItPmNhbSA9IChlLT5kYSAmIE1NVV9DQU1fVkFUQUdf
TUFTSykgfCBlLT5wcnN2ZCB8IGUtPnBnc3o7CisJY3ItPmNhbSA9IChlLT5kYSAmIE1NVV9DQU1f
VkFUQUdfTUFTSykgfCBlLT5wcnN2ZCB8IGUtPnBnc3ogfCBlLT52YWxpZDsKIAljci0+cmFtID0g
ZS0+cGEgfCBlLT5lbmRpYW4gfCBlLT5lbHN6IHwgZS0+bWl4ZWQ7CiAKIAlyZXR1cm4gY3I7CkBA
IC0yMTEsNyArMjEzLDggQEAgc3RhdGljIHNzaXplX3Qgb21hcDJfZHVtcF9jcihzdHJ1Y3QgaW9t
bXUgKm9iaiwgc3RydWN0IGNyX3JlZ3MgKmNyLCBjaGFyICpidWYpCiAJY2hhciAqcCA9IGJ1ZjsK
IAogCS8qIEZJWE1FOiBOZWVkIG1vcmUgZGV0YWlsIGFuYWx5c2lzIG9mIGNhbS9yYW0gKi8KLQlw
ICs9IHNwcmludGYocCwgIiUwOHggJTA4eFxuIiwgY3ItPmNhbSwgY3ItPnJhbSk7CisJcCArPSBz
cHJpbnRmKHAsICIlMDh4ICUwOHggJTAxeFxuIiwgY3ItPmNhbSwgY3ItPnJhbSwKKwkJCQkJKGNy
LT5jYW0gJiBNTVVfQ0FNX1ApID8gMSA6IDApOwogCiAJcmV0dXJuIHAgLSBidWY7CiB9CmRpZmYg
LS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvaW9tbXUuYyBiL2FyY2gvYXJtL3BsYXQtb21hcC9p
b21tdS5jCmluZGV4IDUxODY3MjguLjY0ZDY3NmUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3BsYXQt
b21hcC9pb21tdS5jCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9pb21tdS5jCkBAIC0xNzEsMTUg
KzE3MSwxMiBAQCBzdGF0aWMgdm9pZCBpb3RsYl9sb2NrX2dldChzdHJ1Y3QgaW9tbXUgKm9iaiwg
c3RydWN0IGlvdGxiX2xvY2sgKmwpCiAJbC0+YmFzZSA9IE1NVV9MT0NLX0JBU0UodmFsKTsKIAls
LT52aWN0ID0gTU1VX0xPQ0tfVklDVCh2YWwpOwogCi0JQlVHX09OKGwtPmJhc2UgIT0gMCk7IC8q
IEN1cnJlbnRseSBubyBwcmVzZXJ2YXRpb24gaXMgdXNlZCAqLwogfQogCiBzdGF0aWMgdm9pZCBp
b3RsYl9sb2NrX3NldChzdHJ1Y3QgaW9tbXUgKm9iaiwgc3RydWN0IGlvdGxiX2xvY2sgKmwpCiB7
CiAJdTMyIHZhbDsKIAotCUJVR19PTihsLT5iYXNlICE9IDApOyAvKiBDdXJyZW50bHkgbm8gcHJl
c2VydmF0aW9uIGlzIHVzZWQgKi8KLQogCXZhbCA9IChsLT5iYXNlIDw8IE1NVV9MT0NLX0JBU0Vf
U0hJRlQpOwogCXZhbCB8PSAobC0+dmljdCA8PCBNTVVfTE9DS19WSUNUX1NISUZUKTsKIApAQCAt
MjQxLDcgKzIzOCw3IEBAIGludCBsb2FkX2lvdGxiX2VudHJ5KHN0cnVjdCBpb21tdSAqb2JqLCBz
dHJ1Y3QgaW90bGJfZW50cnkgKmUpCiAJCQlicmVhazsKIAl9CiAKLQlpZiAoaSA9PSBvYmotPm5y
X3RsYl9lbnRyaWVzKSB7CisJaWYgKGkgPT0gb2JqLT5ucl90bGJfZW50cmllcyB8fCAobC5iYXNl
ID09IG9iai0+bnJfdGxiX2VudHJpZXMpKSB7CiAJCWRldl9kYmcob2JqLT5kZXYsICIlczogZnVs
bDogbm8gZW50cnlcbiIsIF9fZnVuY19fKTsKIAkJZXJyID0gLUVCVVNZOwogCQlnb3RvIG91dDsK
QEAgLTI1MiwxMyArMjQ5LDE4IEBAIGludCBsb2FkX2lvdGxiX2VudHJ5KHN0cnVjdCBpb21tdSAq
b2JqLCBzdHJ1Y3QgaW90bGJfZW50cnkgKmUpCiAJCWNsa19kaXNhYmxlKG9iai0+Y2xrKTsKIAkJ
cmV0dXJuIFBUUl9FUlIoY3IpOwogCX0KLQogCWlvdGxiX2xvYWRfY3Iob2JqLCBjcik7CiAJa2Zy
ZWUoY3IpOwogCisJLyogSW5jcmVtZW50IGJhc2UgbnVtYmVyIGlmIHByZXNlcnZhdGlvbiBpcyBz
ZXQgKi8KKwlpZiAoZS0+cHJzdmQpCisJCWwuYmFzZSsrOwogCS8qIGluY3JlbWVudCB2aWN0aW0g
Zm9yIG5leHQgdGxiIGxvYWQgKi8KLQlpZiAoKytsLnZpY3QgPT0gb2JqLT5ucl90bGJfZW50cmll
cykKLQkJbC52aWN0ID0gMDsKKwlpZiAoKytsLnZpY3QgPT0gb2JqLT5ucl90bGJfZW50cmllcykg
eworCQlsLnZpY3QgPSBsLmJhc2U7CisJCWdvdG8gb3V0OworCX0KKwogCWlvdGxiX2xvY2tfc2V0
KG9iaiwgJmwpOwogb3V0OgogCWNsa19kaXNhYmxlKG9iai0+Y2xrKTsKLS0gCjEuNy4wCgo=

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B216AFAdlee03entticom_--
