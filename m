From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH v1 1/3] ARM:OMAP4 iommu:changes in iommu for OMAP4
Date: Tue, 4 Aug 2009 17:30:23 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E3ABDBABD@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E3ABDBABDdlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38064 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbZHDWap (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 18:30:45 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E3ABDBABDdlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch has the changes to iommu module to make
iommu functional on OMAP4 simulator. The changes
included using stubbed clock interface and commenting
out reading the MMU soft reset register.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/iommu2.c |    8 +++++---
 arch/arm/plat-omap/iommu.c   |   12 +++++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 015f22a..30b7158 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -80,12 +80,14 @@ static int omap2_iommu_enable(struct iommu *obj)
 		if (l & MMU_SYS_RESETDONE)
 			break;
 	} while (time_after(jiffies, timeout));
-
-	if (!(l & MMU_SYS_RESETDONE)) {
+	/* FIXME: Hack till the reading the MMU status register
+	 * is resolved in Simulator. Simulator doesn't update
+	 * the STATUS register.
+	 */
+	if (!cpu_is_omap44xx() && !(l & MMU_SYS_RESETDONE)) {
 		dev_err(obj->dev, "can't take mmu out of reset\n");
 		return -ENODEV;
 	}
-
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


--_002_8F7AF80515AF0D4D93307E594F3CB40E3ABDBABDdlee03entticom_
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP4-iommu-changes-in-iommu-for-OMAP4.patch"
Content-Description: 0001-ARM-OMAP4-iommu-changes-in-iommu-for-OMAP4.patch
Content-Disposition: attachment;
	filename="0001-ARM-OMAP4-iommu-changes-in-iommu-for-OMAP4.patch"; size=2063;
	creation-date="Tue, 04 Aug 2009 17:19:41 GMT";
	modification-date="Tue, 04 Aug 2009 17:19:41 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiMGU5ZGQ0OWVkNGQ1NzI5ZmZjNjJiOTg0M2NjNDMzOGQ0MTM1MzFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IFR1ZSwgNCBBdWcgMjAwOSAxNzoxNzowMCAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFSTTpP
TUFQNCBpb21tdTpjaGFuZ2VzIGluIGlvbW11IGZvciBPTUFQNAoKVGhpcyBwYXRjaCBoYXMgdGhl
IGNoYW5nZXMgdG8gaW9tbXUgbW9kdWxlIHRvIG1ha2UKaW9tbXUgZnVuY3Rpb25hbCBvbiBPTUFQ
NCBzaW11bGF0b3IuIFRoZSBjaGFuZ2VzCmluY2x1ZGVkIHVzaW5nIHN0dWJiZWQgY2xvY2sgaW50
ZXJmYWNlIGFuZCBjb21tZW50aW5nCm91dCByZWFkaW5nIHRoZSBNTVUgc29mdCByZXNldCByZWdp
c3Rlci4KClNpZ25lZC1vZmYtYnk6IEhhcmkgS2FuaWdlcmkgPGgta2FuaWdlcmkyQHRpLmNvbT4K
LS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL2lvbW11Mi5jIHwgICAgOCArKysrKy0tLQogYXJjaC9h
cm0vcGxhdC1vbWFwL2lvbW11LmMgICB8ICAgMTIgKysrKysrKysrLS0tCiAyIGZpbGVzIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vbWFjaC1vbWFwMi9pb21tdTIuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvaW9tbXUyLmMKaW5k
ZXggMDE1ZjIyYS4uMzBiNzE1OCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9pb21t
dTIuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2lvbW11Mi5jCkBAIC04MCwxMiArODAsMTQg
QEAgc3RhdGljIGludCBvbWFwMl9pb21tdV9lbmFibGUoc3RydWN0IGlvbW11ICpvYmopCiAJCWlm
IChsICYgTU1VX1NZU19SRVNFVERPTkUpCiAJCQlicmVhazsKIAl9IHdoaWxlICh0aW1lX2FmdGVy
KGppZmZpZXMsIHRpbWVvdXQpKTsKLQotCWlmICghKGwgJiBNTVVfU1lTX1JFU0VURE9ORSkpIHsK
KwkvKiBGSVhNRTogSGFjayB0aWxsIHRoZSByZWFkaW5nIHRoZSBNTVUgc3RhdHVzIHJlZ2lzdGVy
CisJICogaXMgcmVzb2x2ZWQgaW4gU2ltdWxhdG9yLiBTaW11bGF0b3IgZG9lc24ndCB1cGRhdGUK
KwkgKiB0aGUgU1RBVFVTIHJlZ2lzdGVyLgorCSAqLworCWlmICghY3B1X2lzX29tYXA0NHh4KCkg
JiYgIShsICYgTU1VX1NZU19SRVNFVERPTkUpKSB7CiAJCWRldl9lcnIob2JqLT5kZXYsICJjYW4n
dCB0YWtlIG1tdSBvdXQgb2YgcmVzZXRcbiIpOwogCQlyZXR1cm4gLUVOT0RFVjsKIAl9Ci0KIAls
ID0gaW9tbXVfcmVhZF9yZWcob2JqLCBNTVVfUkVWSVNJT04pOwogCWRldl9pbmZvKG9iai0+ZGV2
LCAiJXM6IHZlcnNpb24gJWQuJWRcbiIsIG9iai0+bmFtZSwKIAkJIChsID4+IDQpICYgMHhmLCBs
ICYgMHhmKTsKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9pb21tdS5jIGIvYXJjaC9h
cm0vcGxhdC1vbWFwL2lvbW11LmMKaW5kZXggNGNmNDQ5Zi4uYjYyYTA4NyAxMDA2NDQKLS0tIGEv
YXJjaC9hcm0vcGxhdC1vbWFwL2lvbW11LmMKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2lvbW11
LmMKQEAgLTg2MSw5ICs4NjEsMTUgQEAgc3RhdGljIGludCBfX2RldmluaXQgb21hcF9pb21tdV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCWlmICghb2JqKQogCQlyZXR1cm4g
LUVOT01FTTsKIAotCW9iai0+Y2xrID0gY2xrX2dldCgmcGRldi0+ZGV2LCBwZGF0YS0+Y2xrX25h
bWUpOwotCWlmIChJU19FUlIob2JqLT5jbGspKQotCQlnb3RvIGVycl9jbGs7CisJLyoKKwkgKiBG
SVgtTUU6IFJlcGxhY2Ugd2l0aCBjb3JyZWN0IGNsayBub2RlIHdoZW4gY2xrCisJICogZnJhbWV3
b3JrIGlzIGF2YWlsYWJsZQorCSAqLworCWlmICghY3B1X2lzX29tYXA0NHh4KCkpCXsKKwkJb2Jq
LT5jbGsgPSBjbGtfZ2V0KCZwZGV2LT5kZXYsIHBkYXRhLT5jbGtfbmFtZSk7CisJCWlmIChJU19F
UlIob2JqLT5jbGspKQorCQkJZ290byBlcnJfY2xrOworCX0KIAogCW9iai0+bnJfdGxiX2VudHJp
ZXMgPSBwZGF0YS0+bnJfdGxiX2VudHJpZXM7CiAJb2JqLT5uYW1lID0gcGRhdGEtPm5hbWU7Ci0t
IAoxLjUuNC4zCgo=

--_002_8F7AF80515AF0D4D93307E594F3CB40E3ABDBABDdlee03entticom_--
