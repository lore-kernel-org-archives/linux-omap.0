From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH 4/4][v3] OMAP:iommu- add TLB preservation support
Date: Tue, 20 Apr 2010 17:57:10 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B3BF953@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E4B3BF953dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35341 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576Ab0DTW5T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 18:57:19 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "tony@atomide.com" <tony@atomide.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3BF953dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From b76cbee7bb442f61dd2f29ed64ccf98efd871791 Mon Sep 17 00:00:00 2001
From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Tue, 20 Apr 2010 12:11:16 -0500
Subject: [PATCH 4/4] OMAP:iommu- add TLB preservation support

This patch adds TLB preservation support to IOMMU module

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/iommu2.c |    4 +++-
 arch/arm/plat-omap/iommu.c   |   12 ++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index f01f985..5ce76e4 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -146,6 +146,7 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32=
 *ra)
 	printk("\n");
=20
 	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
+	omap2_iommu_disable(obj);
 	return stat;
 }
=20
@@ -211,7 +212,8 @@ static ssize_t omap2_dump_cr(struct iommu *obj, struct =
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
index 463d638..a1d4ccf 100644
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
@@ -241,6 +238,11 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_e=
ntry *e)
 			break;
 	}
=20
+	if (l.base =3D=3D obj->nr_tlb_entries) {
+		dev_dbg(obj->dev, "%s: preserve entries full\n", __func__);
+		err =3D -EBUSY;
+		goto out;
+	}
 	if (i =3D=3D obj->nr_tlb_entries) {
 		dev_dbg(obj->dev, "%s: full: no entry\n", __func__);
 		err =3D -EBUSY;
@@ -256,9 +258,11 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_e=
ntry *e)
 	iotlb_load_cr(obj, cr);
 	kfree(cr);
=20
+	if (e->prsvd)
+		l.base++;
 	/* increment victim for next tlb load */
 	if (++l.vict =3D=3D obj->nr_tlb_entries)
-		l.vict =3D 0;
+		l.vict =3D l.base;
 	iotlb_lock_set(obj, &l);
 out:
 	clk_disable(obj->clk);
--=20
1.7.0


Thank you,
Best regards,
Hari


--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3BF953dlee03entticom_
Content-Type: application/octet-stream;
	name="0004-OMAP-iommu-add-TLB-preservation-support.patch"
Content-Description: 0004-OMAP-iommu-add-TLB-preservation-support.patch
Content-Disposition: attachment;
	filename="0004-OMAP-iommu-add-TLB-preservation-support.patch"; size=2485;
	creation-date="Tue, 20 Apr 2010 17:40:25 GMT";
	modification-date="Tue, 20 Apr 2010 17:40:25 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiNzZjYmVlN2JiNDQyZjYxZGQyZjI5ZWQ2NGNjZjk4ZWZkODcxNzkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IFR1ZSwgMjAgQXByIDIwMTAgMTI6MTE6MTYgLTA1MDAKU3ViamVjdDogW1BBVENIIDQvNF0g
T01BUDppb21tdS0gYWRkIFRMQiBwcmVzZXJ2YXRpb24gc3VwcG9ydAoKVGhpcyBwYXRjaCBhZGRz
IFRMQiBwcmVzZXJ2YXRpb24gc3VwcG9ydCB0byBJT01NVSBtb2R1bGUKClNpZ25lZC1vZmYtYnk6
IEhhcmkgS2FuaWdlcmkgPGgta2FuaWdlcmkyQHRpLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9t
YXAyL2lvbW11Mi5jIHwgICAgNCArKystCiBhcmNoL2FybS9wbGF0LW9tYXAvaW9tbXUuYyAgIHwg
ICAxMiArKysrKysrKy0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2lvbW11Mi5jIGIv
YXJjaC9hcm0vbWFjaC1vbWFwMi9pb21tdTIuYwppbmRleCBmMDFmOTg1Li41Y2U3NmU0IDEwMDY0
NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2lvbW11Mi5jCisrKyBiL2FyY2gvYXJtL21hY2gt
b21hcDIvaW9tbXUyLmMKQEAgLTE0Niw2ICsxNDYsNyBAQCBzdGF0aWMgdTMyIG9tYXAyX2lvbW11
X2ZhdWx0X2lzcihzdHJ1Y3QgaW9tbXUgKm9iaiwgdTMyICpyYSkKIAlwcmludGsoIlxuIik7CiAK
IAlpb21tdV93cml0ZV9yZWcob2JqLCBzdGF0LCBNTVVfSVJRU1RBVFVTKTsKKwlvbWFwMl9pb21t
dV9kaXNhYmxlKG9iaik7CiAJcmV0dXJuIHN0YXQ7CiB9CiAKQEAgLTIxMSw3ICsyMTIsOCBAQCBz
dGF0aWMgc3NpemVfdCBvbWFwMl9kdW1wX2NyKHN0cnVjdCBpb21tdSAqb2JqLCBzdHJ1Y3QgY3Jf
cmVncyAqY3IsIGNoYXIgKmJ1ZikKIAljaGFyICpwID0gYnVmOwogCiAJLyogRklYTUU6IE5lZWQg
bW9yZSBkZXRhaWwgYW5hbHlzaXMgb2YgY2FtL3JhbSAqLwotCXAgKz0gc3ByaW50ZihwLCAiJTA4
eCAlMDh4XG4iLCBjci0+Y2FtLCBjci0+cmFtKTsKKwlwICs9IHNwcmludGYocCwgIiUwOHggJTA4
eCAlMDF4XG4iLCBjci0+Y2FtLCBjci0+cmFtLAorCQkJCQkoY3ItPmNhbSAmIE1NVV9DQU1fUCkg
PyAxIDogMCk7CiAKIAlyZXR1cm4gcCAtIGJ1ZjsKIH0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3Bs
YXQtb21hcC9pb21tdS5jIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2lvbW11LmMKaW5kZXggNDYzZDYz
OC4uYTFkNGNjZiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2lvbW11LmMKKysrIGIv
YXJjaC9hcm0vcGxhdC1vbWFwL2lvbW11LmMKQEAgLTE3MSwxNSArMTcxLDEyIEBAIHN0YXRpYyB2
b2lkIGlvdGxiX2xvY2tfZ2V0KHN0cnVjdCBpb21tdSAqb2JqLCBzdHJ1Y3QgaW90bGJfbG9jayAq
bCkKIAlsLT5iYXNlID0gTU1VX0xPQ0tfQkFTRSh2YWwpOwogCWwtPnZpY3QgPSBNTVVfTE9DS19W
SUNUKHZhbCk7CiAKLQlCVUdfT04obC0+YmFzZSAhPSAwKTsgLyogQ3VycmVudGx5IG5vIHByZXNl
cnZhdGlvbiBpcyB1c2VkICovCiB9CiAKIHN0YXRpYyB2b2lkIGlvdGxiX2xvY2tfc2V0KHN0cnVj
dCBpb21tdSAqb2JqLCBzdHJ1Y3QgaW90bGJfbG9jayAqbCkKIHsKIAl1MzIgdmFsOwogCi0JQlVH
X09OKGwtPmJhc2UgIT0gMCk7IC8qIEN1cnJlbnRseSBubyBwcmVzZXJ2YXRpb24gaXMgdXNlZCAq
LwotCiAJdmFsID0gKGwtPmJhc2UgPDwgTU1VX0xPQ0tfQkFTRV9TSElGVCk7CiAJdmFsIHw9IChs
LT52aWN0IDw8IE1NVV9MT0NLX1ZJQ1RfU0hJRlQpOwogCkBAIC0yNDEsNiArMjM4LDExIEBAIGlu
dCBsb2FkX2lvdGxiX2VudHJ5KHN0cnVjdCBpb21tdSAqb2JqLCBzdHJ1Y3QgaW90bGJfZW50cnkg
KmUpCiAJCQlicmVhazsKIAl9CiAKKwlpZiAobC5iYXNlID09IG9iai0+bnJfdGxiX2VudHJpZXMp
IHsKKwkJZGV2X2RiZyhvYmotPmRldiwgIiVzOiBwcmVzZXJ2ZSBlbnRyaWVzIGZ1bGxcbiIsIF9f
ZnVuY19fKTsKKwkJZXJyID0gLUVCVVNZOworCQlnb3RvIG91dDsKKwl9CiAJaWYgKGkgPT0gb2Jq
LT5ucl90bGJfZW50cmllcykgewogCQlkZXZfZGJnKG9iai0+ZGV2LCAiJXM6IGZ1bGw6IG5vIGVu
dHJ5XG4iLCBfX2Z1bmNfXyk7CiAJCWVyciA9IC1FQlVTWTsKQEAgLTI1Niw5ICsyNTgsMTEgQEAg
aW50IGxvYWRfaW90bGJfZW50cnkoc3RydWN0IGlvbW11ICpvYmosIHN0cnVjdCBpb3RsYl9lbnRy
eSAqZSkKIAlpb3RsYl9sb2FkX2NyKG9iaiwgY3IpOwogCWtmcmVlKGNyKTsKIAorCWlmIChlLT5w
cnN2ZCkKKwkJbC5iYXNlKys7CiAJLyogaW5jcmVtZW50IHZpY3RpbSBmb3IgbmV4dCB0bGIgbG9h
ZCAqLwogCWlmICgrK2wudmljdCA9PSBvYmotPm5yX3RsYl9lbnRyaWVzKQotCQlsLnZpY3QgPSAw
OworCQlsLnZpY3QgPSBsLmJhc2U7CiAJaW90bGJfbG9ja19zZXQob2JqLCAmbCk7CiBvdXQ6CiAJ
Y2xrX2Rpc2FibGUob2JqLT5jbGspOwotLSAKMS43LjAKCg==

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3BF953dlee03entticom_--
