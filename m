From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH] ARM:iommu support for OMAP4
Date: Fri, 16 Apr 2010 11:17:09 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B216AE2@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E4B216AE2dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55842 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758256Ab0DPQRO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 12:17:14 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B216AE2dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 708914e1a82a608d423b050cb31b4deb46eb8411 Mon Sep 17 00:00:00 2001
From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Mon, 8 Mar 2010 17:55:21 -0600
Subject: [PATCH] ARM:iommu support for OMAP4

This patch provides the iommu support for OMAP4 co-processors.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/Makefile      |    2 +-
 arch/arm/mach-omap2/omap4-iommu.c |  110 +++++++++++++++++++++++++++++++++=
++++
 arch/arm/plat-omap/iommu.c        |   10 ++-
 3 files changed, 117 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap4-iommu.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d3e54da..1395125 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -77,7 +77,7 @@ mailbox_mach-objs			:=3D mailbox.o
=20
 iommu-y					+=3D iommu2.o
 iommu-$(CONFIG_ARCH_OMAP3)		+=3D omap3-iommu.o
-
+iommu-$(CONFIG_ARCH_OMAP4)              +=3D omap4-iommu.o
 obj-$(CONFIG_OMAP_IOMMU)		+=3D $(iommu-y)
=20
 i2c-omap-$(CONFIG_I2C_OMAP)		:=3D i2c.o
diff --git a/arch/arm/mach-omap2/omap4-iommu.c b/arch/arm/mach-omap2/omap4-=
iommu.c
new file mode 100644
index 0000000..6225616
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4-iommu.c
@@ -0,0 +1,110 @@
+/*
+ * omap iommu: omap4 device registration
+ *
+ * Copyright (C) 2009-2010 Nokia Corporation
+ *
+ * Written by Hari Kanigeri <h-kanigeri2@ti.com>
+ *
+ * Added support for OMAP4. This is based on original file
+ * omap3-iommu.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+
+#include <plat/iommu.h>
+#include <plat/irqs.h>
+
+#define OMAP4_MMU1_BASE	0x55082000
+#define OMAP4_MMU2_BASE	0x4A066000
+
+#define OMAP4_MMU1_IRQ	INT_44XX_DUCATI_MMU_IRQ
+#define OMAP4_MMU2_IRQ	INT_44XX_DSP_MMU
+
+
+
+static unsigned long iommu_base[] __initdata =3D {
+	OMAP4_MMU1_BASE,
+	OMAP4_MMU2_BASE,
+};
+
+static int iommu_irq[] __initdata =3D {
+	OMAP4_MMU1_IRQ,
+	OMAP4_MMU2_IRQ,
+};
+
+static const struct iommu_platform_data omap4_iommu_pdata[] __initconst =
=3D {
+	{
+		.name =3D "ducati",
+		.nr_tlb_entries =3D 32,
+	},
+#if defined(CONFIG_MPU_TESLA_IOMMU)
+	{
+		.name =3D "tesla",
+		.nr_tlb_entries =3D 32,
+	},
+#endif
+};
+#define NR_IOMMU_DEVICES ARRAY_SIZE(omap4_iommu_pdata)
+
+static struct platform_device *omap4_iommu_pdev[NR_IOMMU_DEVICES];
+
+static int __init omap4_iommu_init(void)
+{
+	int i, err;
+
+	for (i =3D 0; i < NR_IOMMU_DEVICES; i++) {
+		struct platform_device *pdev;
+		struct resource res[2];
+
+		pdev =3D platform_device_alloc("omap-iommu", i);
+		if (!pdev) {
+			err =3D -ENOMEM;
+			goto err_out;
+		}
+
+		memset(res, 0,  sizeof(res));
+		res[0].start =3D iommu_base[i];
+		res[0].end =3D iommu_base[i] + MMU_REG_SIZE - 1;
+		res[0].flags =3D IORESOURCE_MEM;
+		res[1].start =3D res[1].end =3D iommu_irq[i];
+		res[1].flags =3D IORESOURCE_IRQ;
+
+		err =3D platform_device_add_resources(pdev, res,
+						    ARRAY_SIZE(res));
+		if (err)
+			goto err_out;
+		err =3D platform_device_add_data(pdev, &omap4_iommu_pdata[i],
+					       sizeof(omap4_iommu_pdata[0]));
+		if (err)
+			goto err_out;
+		err =3D platform_device_add(pdev);
+		if (err)
+			goto err_out;
+		omap4_iommu_pdev[i] =3D pdev;
+	}
+	return 0;
+
+err_out:
+	while (i--)
+		platform_device_put(omap4_iommu_pdev[i]);
+	return err;
+}
+module_init(omap4_iommu_init);
+
+static void __exit omap4_iommu_exit(void)
+{
+	int i;
+
+	for (i =3D 0; i < NR_IOMMU_DEVICES; i++)
+		platform_device_unregister(omap4_iommu_pdev[i]);
+}
+module_exit(omap4_iommu_exit);
+
+MODULE_AUTHOR("Hiroshi DOYU, Hari Kanigeri");
+MODULE_DESCRIPTION("omap iommu: omap4 device registration");
+MODULE_LICENSE("GPL v2");
+
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 905ed83..5186728 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -862,10 +862,12 @@ static int __devinit omap_iommu_probe(struct platform=
_device *pdev)
 	if (!obj)
 		return -ENOMEM;
=20
-	obj->clk =3D clk_get(&pdev->dev, pdata->clk_name);
-	if (IS_ERR(obj->clk))
-		goto err_clk;
-
+	/* FIX ME: OMAP4 PM framework not ready */
+	if (!cpu_is_omap44xx()) {
+		obj->clk =3D clk_get(&pdev->dev, pdata->clk_name);
+		if (IS_ERR(obj->clk))
+			goto err_clk;
+	}
 	obj->nr_tlb_entries =3D pdata->nr_tlb_entries;
 	obj->name =3D pdata->name;
 	obj->dev =3D &pdev->dev;
--=20
1.7.0


Thank you,
Best regards,
Hari


--_002_8F7AF80515AF0D4D93307E594F3CB40E4B216AE2dlee03entticom_
Content-Type: application/octet-stream;
	name="0001-ARM-iommu-support-for-OMAP4.patch"
Content-Description: 0001-ARM-iommu-support-for-OMAP4.patch
Content-Disposition: attachment;
	filename="0001-ARM-iommu-support-for-OMAP4.patch"; size=4435;
	creation-date="Fri, 16 Apr 2010 11:27:15 GMT";
	modification-date="Fri, 16 Apr 2010 11:27:15 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3MDg5MTRlMWE4MmE2MDhkNDIzYjA1MGNiMzFiNGRlYjQ2ZWI4NDExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IE1vbiwgOCBNYXIgMjAxMCAxNzo1NToyMSAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIEFSTTpp
b21tdSBzdXBwb3J0IGZvciBPTUFQNAoKVGhpcyBwYXRjaCBwcm92aWRlcyB0aGUgaW9tbXUgc3Vw
cG9ydCBmb3IgT01BUDQgY28tcHJvY2Vzc29ycy4KClNpZ25lZC1vZmYtYnk6IEhhcmkgS2FuaWdl
cmkgPGgta2FuaWdlcmkyQHRpLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL01ha2VmaWxl
ICAgICAgfCAgICAyICstCiBhcmNoL2FybS9tYWNoLW9tYXAyL29tYXA0LWlvbW11LmMgfCAgMTEw
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGFyY2gvYXJtL3BsYXQtb21h
cC9pb21tdS5jICAgICAgICB8ICAgMTAgKystCiAzIGZpbGVzIGNoYW5nZWQsIDExNyBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gt
b21hcDIvb21hcDQtaW9tbXUuYwoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvTWFr
ZWZpbGUgYi9hcmNoL2FybS9tYWNoLW9tYXAyL01ha2VmaWxlCmluZGV4IGQzZTU0ZGEuLjEzOTUx
MjUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUKKysrIGIvYXJjaC9h
cm0vbWFjaC1vbWFwMi9NYWtlZmlsZQpAQCAtNzcsNyArNzcsNyBAQCBtYWlsYm94X21hY2gtb2Jq
cwkJCTo9IG1haWxib3gubwogCiBpb21tdS15CQkJCQkrPSBpb21tdTIubwogaW9tbXUtJChDT05G
SUdfQVJDSF9PTUFQMykJCSs9IG9tYXAzLWlvbW11Lm8KLQoraW9tbXUtJChDT05GSUdfQVJDSF9P
TUFQNCkgICAgICAgICAgICAgICs9IG9tYXA0LWlvbW11Lm8KIG9iai0kKENPTkZJR19PTUFQX0lP
TU1VKQkJKz0gJChpb21tdS15KQogCiBpMmMtb21hcC0kKENPTkZJR19JMkNfT01BUCkJCTo9IGky
Yy5vCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXA0LWlvbW11LmMgYi9hcmNo
L2FybS9tYWNoLW9tYXAyL29tYXA0LWlvbW11LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXgg
MDAwMDAwMC4uNjIyNTYxNgotLS0gL2Rldi9udWxsCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIv
b21hcDQtaW9tbXUuYwpAQCAtMCwwICsxLDExMCBAQAorLyoKKyAqIG9tYXAgaW9tbXU6IG9tYXA0
IGRldmljZSByZWdpc3RyYXRpb24KKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMDktMjAxMCBOb2tp
YSBDb3Jwb3JhdGlvbgorICoKKyAqIFdyaXR0ZW4gYnkgSGFyaSBLYW5pZ2VyaSA8aC1rYW5pZ2Vy
aTJAdGkuY29tPgorICoKKyAqIEFkZGVkIHN1cHBvcnQgZm9yIE9NQVA0LiBUaGlzIGlzIGJhc2Vk
IG9uIG9yaWdpbmFsIGZpbGUKKyAqIG9tYXAzLWlvbW11LmMKKyAqCisgKiBUaGlzIHByb2dyYW0g
aXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQor
ICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2
ZXJzaW9uIDIgYXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9u
LgorICovCisKKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKworI2luY2x1ZGUg
PHBsYXQvaW9tbXUuaD4KKyNpbmNsdWRlIDxwbGF0L2lycXMuaD4KKworI2RlZmluZSBPTUFQNF9N
TVUxX0JBU0UJMHg1NTA4MjAwMAorI2RlZmluZSBPTUFQNF9NTVUyX0JBU0UJMHg0QTA2NjAwMAor
CisjZGVmaW5lIE9NQVA0X01NVTFfSVJRCUlOVF80NFhYX0RVQ0FUSV9NTVVfSVJRCisjZGVmaW5l
IE9NQVA0X01NVTJfSVJRCUlOVF80NFhYX0RTUF9NTVUKKworCisKK3N0YXRpYyB1bnNpZ25lZCBs
b25nIGlvbW11X2Jhc2VbXSBfX2luaXRkYXRhID0geworCU9NQVA0X01NVTFfQkFTRSwKKwlPTUFQ
NF9NTVUyX0JBU0UsCit9OworCitzdGF0aWMgaW50IGlvbW11X2lycVtdIF9faW5pdGRhdGEgPSB7
CisJT01BUDRfTU1VMV9JUlEsCisJT01BUDRfTU1VMl9JUlEsCit9OworCitzdGF0aWMgY29uc3Qg
c3RydWN0IGlvbW11X3BsYXRmb3JtX2RhdGEgb21hcDRfaW9tbXVfcGRhdGFbXSBfX2luaXRjb25z
dCA9IHsKKwl7CisJCS5uYW1lID0gImR1Y2F0aSIsCisJCS5ucl90bGJfZW50cmllcyA9IDMyLAor
CX0sCisjaWYgZGVmaW5lZChDT05GSUdfTVBVX1RFU0xBX0lPTU1VKQorCXsKKwkJLm5hbWUgPSAi
dGVzbGEiLAorCQkubnJfdGxiX2VudHJpZXMgPSAzMiwKKwl9LAorI2VuZGlmCit9OworI2RlZmlu
ZSBOUl9JT01NVV9ERVZJQ0VTIEFSUkFZX1NJWkUob21hcDRfaW9tbXVfcGRhdGEpCisKK3N0YXRp
YyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpvbWFwNF9pb21tdV9wZGV2W05SX0lPTU1VX0RFVklD
RVNdOworCitzdGF0aWMgaW50IF9faW5pdCBvbWFwNF9pb21tdV9pbml0KHZvaWQpCit7CisJaW50
IGksIGVycjsKKworCWZvciAoaSA9IDA7IGkgPCBOUl9JT01NVV9ERVZJQ0VTOyBpKyspIHsKKwkJ
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsKKwkJc3RydWN0IHJlc291cmNlIHJlc1syXTsK
KworCQlwZGV2ID0gcGxhdGZvcm1fZGV2aWNlX2FsbG9jKCJvbWFwLWlvbW11IiwgaSk7CisJCWlm
ICghcGRldikgeworCQkJZXJyID0gLUVOT01FTTsKKwkJCWdvdG8gZXJyX291dDsKKwkJfQorCisJ
CW1lbXNldChyZXMsIDAsICBzaXplb2YocmVzKSk7CisJCXJlc1swXS5zdGFydCA9IGlvbW11X2Jh
c2VbaV07CisJCXJlc1swXS5lbmQgPSBpb21tdV9iYXNlW2ldICsgTU1VX1JFR19TSVpFIC0gMTsK
KwkJcmVzWzBdLmZsYWdzID0gSU9SRVNPVVJDRV9NRU07CisJCXJlc1sxXS5zdGFydCA9IHJlc1sx
XS5lbmQgPSBpb21tdV9pcnFbaV07CisJCXJlc1sxXS5mbGFncyA9IElPUkVTT1VSQ0VfSVJROwor
CisJCWVyciA9IHBsYXRmb3JtX2RldmljZV9hZGRfcmVzb3VyY2VzKHBkZXYsIHJlcywKKwkJCQkJ
CSAgICBBUlJBWV9TSVpFKHJlcykpOworCQlpZiAoZXJyKQorCQkJZ290byBlcnJfb3V0OworCQll
cnIgPSBwbGF0Zm9ybV9kZXZpY2VfYWRkX2RhdGEocGRldiwgJm9tYXA0X2lvbW11X3BkYXRhW2ld
LAorCQkJCQkgICAgICAgc2l6ZW9mKG9tYXA0X2lvbW11X3BkYXRhWzBdKSk7CisJCWlmIChlcnIp
CisJCQlnb3RvIGVycl9vdXQ7CisJCWVyciA9IHBsYXRmb3JtX2RldmljZV9hZGQocGRldik7CisJ
CWlmIChlcnIpCisJCQlnb3RvIGVycl9vdXQ7CisJCW9tYXA0X2lvbW11X3BkZXZbaV0gPSBwZGV2
OworCX0KKwlyZXR1cm4gMDsKKworZXJyX291dDoKKwl3aGlsZSAoaS0tKQorCQlwbGF0Zm9ybV9k
ZXZpY2VfcHV0KG9tYXA0X2lvbW11X3BkZXZbaV0pOworCXJldHVybiBlcnI7Cit9Cittb2R1bGVf
aW5pdChvbWFwNF9pb21tdV9pbml0KTsKKworc3RhdGljIHZvaWQgX19leGl0IG9tYXA0X2lvbW11
X2V4aXQodm9pZCkKK3sKKwlpbnQgaTsKKworCWZvciAoaSA9IDA7IGkgPCBOUl9JT01NVV9ERVZJ
Q0VTOyBpKyspCisJCXBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKG9tYXA0X2lvbW11X3BkZXZb
aV0pOworfQorbW9kdWxlX2V4aXQob21hcDRfaW9tbXVfZXhpdCk7CisKK01PRFVMRV9BVVRIT1Io
Ikhpcm9zaGkgRE9ZVSwgSGFyaSBLYW5pZ2VyaSIpOworTU9EVUxFX0RFU0NSSVBUSU9OKCJvbWFw
IGlvbW11OiBvbWFwNCBkZXZpY2UgcmVnaXN0cmF0aW9uIik7CitNT0RVTEVfTElDRU5TRSgiR1BM
IHYyIik7CisKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9pb21tdS5jIGIvYXJjaC9h
cm0vcGxhdC1vbWFwL2lvbW11LmMKaW5kZXggOTA1ZWQ4My4uNTE4NjcyOCAxMDA2NDQKLS0tIGEv
YXJjaC9hcm0vcGxhdC1vbWFwL2lvbW11LmMKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2lvbW11
LmMKQEAgLTg2MiwxMCArODYyLDEyIEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IG9tYXBfaW9tbXVf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlpZiAoIW9iaikKIAkJcmV0dXJu
IC1FTk9NRU07CiAKLQlvYmotPmNsayA9IGNsa19nZXQoJnBkZXYtPmRldiwgcGRhdGEtPmNsa19u
YW1lKTsKLQlpZiAoSVNfRVJSKG9iai0+Y2xrKSkKLQkJZ290byBlcnJfY2xrOwotCisJLyogRklY
IE1FOiBPTUFQNCBQTSBmcmFtZXdvcmsgbm90IHJlYWR5ICovCisJaWYgKCFjcHVfaXNfb21hcDQ0
eHgoKSkgeworCQlvYmotPmNsayA9IGNsa19nZXQoJnBkZXYtPmRldiwgcGRhdGEtPmNsa19uYW1l
KTsKKwkJaWYgKElTX0VSUihvYmotPmNsaykpCisJCQlnb3RvIGVycl9jbGs7CisJfQogCW9iai0+
bnJfdGxiX2VudHJpZXMgPSBwZGF0YS0+bnJfdGxiX2VudHJpZXM7CiAJb2JqLT5uYW1lID0gcGRh
dGEtPm5hbWU7CiAJb2JqLT5kZXYgPSAmcGRldi0+ZGV2OwotLSAKMS43LjAKCg==

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B216AE2dlee03entticom_--
