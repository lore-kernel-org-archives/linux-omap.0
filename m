From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [RFC][PATCH 1/3] ARM:OMAP4 iommu:changes in iommu for OMAP4
Date: Fri, 24 Jul 2009 12:22:09 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD43@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E3A8CAD43dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37129 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbZGXRWY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jul 2009 13:22:24 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Pasam, Vijay" <vpasam@ti.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E3A8CAD43dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch has the changes to iommu module to make
iommu functional on OMAP4 simulator. The changes
included using stubbed clock interface and commenting
out reading the MMU soft reset register.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/iommu2.c |    8 ++++++--
 arch/arm/plat-omap/iommu.c   |   12 +++++++++---
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 015f22a..01cb15d 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -80,12 +80,16 @@ static int omap2_iommu_enable(struct iommu *obj)
 		if (l & MMU_SYS_RESETDONE)
 			break;
 	} while (time_after(jiffies, timeout));
-
+/* FIXME: Hack till the reading the MMU status register
+ * is resolved in Simulator. Simulator doesn't update
+ * the STATUS register.
+ */
+#ifndef CONFIG_ARCH_OMAP4
 	if (!(l & MMU_SYS_RESETDONE)) {
 		dev_err(obj->dev, "can't take mmu out of reset\n");
 		return -ENODEV;
 	}
-
+#endif
 	l =3D iommu_read_reg(obj, MMU_REVISION);
 	dev_info(obj->dev, "%s: version %d.%d\n", obj->name,
 		 (l >> 4) & 0xf, l & 0xf);
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 4cf449f..b62a087 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -861,9 +861,15 @@ static int __devinit omap_iommu_probe(struct platform_=
device *pdev)
 	if (!obj)
 		return -ENOMEM;
=20
-	obj->clk =3D clk_get(&pdev->dev, pdata->clk_name);
-	if (IS_ERR(obj->clk))
-		goto err_clk;
+	/*
+	 * FIX-ME: Replace with correct clk node when clk
+	 * framework is available
+	 */
+	if (!cpu_is_omap44xx())	{
+		obj->clk =3D clk_get(&pdev->dev, pdata->clk_name);
+		if (IS_ERR(obj->clk))
+			goto err_clk;
+	}
=20
 	obj->nr_tlb_entries =3D pdata->nr_tlb_entries;
 	obj->name =3D pdata->name;
--=20
1.5.4.3


Thank you,
Best regards,
Hari


--_002_8F7AF80515AF0D4D93307E594F3CB40E3A8CAD43dlee03entticom_
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP4-iommu-changes-in-iommu-for-OMAP4.patch"
Content-Description: 0001-ARM-OMAP4-iommu-changes-in-iommu-for-OMAP4.patch
Content-Disposition: attachment;
	filename="0001-ARM-OMAP4-iommu-changes-in-iommu-for-OMAP4.patch"; size=2039;
	creation-date="Fri, 24 Jul 2009 10:58:47 GMT";
	modification-date="Fri, 24 Jul 2009 10:58:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2MDk2ODI4NWM2MDQyNTJmMDM3MWE0NGIyNDhkOWRhZjc0M2RmZTExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IFR1ZSwgMTQgSnVsIDIwMDkgMTc6MDc6MDcgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBUk06
T01BUDQgaW9tbXU6Y2hhbmdlcyBpbiBpb21tdSBmb3IgT01BUDQKClRoaXMgcGF0Y2ggaGFzIHRo
ZSBjaGFuZ2VzIHRvIGlvbW11IG1vZHVsZSB0byBtYWtlCmlvbW11IGZ1bmN0aW9uYWwgb24gT01B
UDQgc2ltdWxhdG9yLiBUaGUgY2hhbmdlcwppbmNsdWRlZCB1c2luZyBzdHViYmVkIGNsb2NrIGlu
dGVyZmFjZSBhbmQgY29tbWVudGluZwpvdXQgcmVhZGluZyB0aGUgTU1VIHNvZnQgcmVzZXQgcmVn
aXN0ZXIuCgpTaWduZWQtb2ZmLWJ5OiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+
Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9pb21tdTIuYyB8ICAgIDggKysrKysrLS0KIGFyY2gv
YXJtL3BsYXQtb21hcC9pb21tdS5jICAgfCAgIDEyICsrKysrKysrKy0tLQogMiBmaWxlcyBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL21hY2gtb21hcDIvaW9tbXUyLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2lvbW11Mi5jCmlu
ZGV4IDAxNWYyMmEuLjAxY2IxNWQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvaW9t
bXUyLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9pb21tdTIuYwpAQCAtODAsMTIgKzgwLDE2
IEBAIHN0YXRpYyBpbnQgb21hcDJfaW9tbXVfZW5hYmxlKHN0cnVjdCBpb21tdSAqb2JqKQogCQlp
ZiAobCAmIE1NVV9TWVNfUkVTRVRET05FKQogCQkJYnJlYWs7CiAJfSB3aGlsZSAodGltZV9hZnRl
cihqaWZmaWVzLCB0aW1lb3V0KSk7Ci0KKy8qIEZJWE1FOiBIYWNrIHRpbGwgdGhlIHJlYWRpbmcg
dGhlIE1NVSBzdGF0dXMgcmVnaXN0ZXIKKyAqIGlzIHJlc29sdmVkIGluIFNpbXVsYXRvci4gU2lt
dWxhdG9yIGRvZXNuJ3QgdXBkYXRlCisgKiB0aGUgU1RBVFVTIHJlZ2lzdGVyLgorICovCisjaWZu
ZGVmIENPTkZJR19BUkNIX09NQVA0CiAJaWYgKCEobCAmIE1NVV9TWVNfUkVTRVRET05FKSkgewog
CQlkZXZfZXJyKG9iai0+ZGV2LCAiY2FuJ3QgdGFrZSBtbXUgb3V0IG9mIHJlc2V0XG4iKTsKIAkJ
cmV0dXJuIC1FTk9ERVY7CiAJfQotCisjZW5kaWYKIAlsID0gaW9tbXVfcmVhZF9yZWcob2JqLCBN
TVVfUkVWSVNJT04pOwogCWRldl9pbmZvKG9iai0+ZGV2LCAiJXM6IHZlcnNpb24gJWQuJWRcbiIs
IG9iai0+bmFtZSwKIAkJIChsID4+IDQpICYgMHhmLCBsICYgMHhmKTsKZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL3BsYXQtb21hcC9pb21tdS5jIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2lvbW11LmMKaW5k
ZXggNGNmNDQ5Zi4uYjYyYTA4NyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2lvbW11
LmMKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2lvbW11LmMKQEAgLTg2MSw5ICs4NjEsMTUgQEAg
c3RhdGljIGludCBfX2RldmluaXQgb21hcF9pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQogCWlmICghb2JqKQogCQlyZXR1cm4gLUVOT01FTTsKIAotCW9iai0+Y2xrID0g
Y2xrX2dldCgmcGRldi0+ZGV2LCBwZGF0YS0+Y2xrX25hbWUpOwotCWlmIChJU19FUlIob2JqLT5j
bGspKQotCQlnb3RvIGVycl9jbGs7CisJLyoKKwkgKiBGSVgtTUU6IFJlcGxhY2Ugd2l0aCBjb3Jy
ZWN0IGNsayBub2RlIHdoZW4gY2xrCisJICogZnJhbWV3b3JrIGlzIGF2YWlsYWJsZQorCSAqLwor
CWlmICghY3B1X2lzX29tYXA0NHh4KCkpCXsKKwkJb2JqLT5jbGsgPSBjbGtfZ2V0KCZwZGV2LT5k
ZXYsIHBkYXRhLT5jbGtfbmFtZSk7CisJCWlmIChJU19FUlIob2JqLT5jbGspKQorCQkJZ290byBl
cnJfY2xrOworCX0KIAogCW9iai0+bnJfdGxiX2VudHJpZXMgPSBwZGF0YS0+bnJfdGxiX2VudHJp
ZXM7CiAJb2JqLT5uYW1lID0gcGRhdGEtPm5hbWU7Ci0tIAoxLjUuNC4zCgo=

--_002_8F7AF80515AF0D4D93307E594F3CB40E3A8CAD43dlee03entticom_--
