From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [RFC][PATCH 2/3] ARM:OMAP4 iommu:add omap4 support in iommu
Date: Fri, 24 Jul 2009 12:22:32 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD44@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E3A8CAD44dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53888 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832AbZGXRWt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jul 2009 13:22:49 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Pasam, Vijay" <vpasam@ti.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E3A8CAD44dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch adds omap4 support in iommu
module. This creates OMAP4 platform specific file
for iommu and defines the Ducati MMU fault interrupt.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/omap4-iommu.c      |  112 ++++++++++++++++++++++++++++=
++++
 arch/arm/plat-omap/include/mach/irqs.h |    2 +-
 2 files changed, 113 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap4-iommu.c

diff --git a/arch/arm/mach-omap2/omap4-iommu.c b/arch/arm/mach-omap2/omap4-=
iommu.c
new file mode 100644
index 0000000..5a782df
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4-iommu.c
@@ -0,0 +1,112 @@
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
+#include <mach/iommu.h>
+#include <mach/irqs.h>
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
+		.clk_name =3D "ducati_ick",
+	},
+#if defined(CONFIG_MPU_TESLA_IOMMU)
+	{
+		.name =3D "tesla",
+		.nr_tlb_entries =3D 32,
+		.clk_name =3D "tesla_ick",
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
diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/in=
clude/mach/irqs.h
index fb7cb77..34b6d09 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -511,7 +511,7 @@
 #define INT_44XX_TLL_IRQ	(78 + IRQ_GIC_START)
 #define INT_44XX_PARTHASH_IRQ	(79 + IRQ_GIC_START)
 #define INT_44XX_MMC3_IRQ	(94 + IRQ_GIC_START)
-
+#define INT_44XX_DUCATI_MMU_IRQ	(100 + IRQ_GIC_START)
=20
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730/850) and
  * 16 MPUIO lines */
--=20
1.5.4.3


Thank you,
Best regards,
Hari


--_002_8F7AF80515AF0D4D93307E594F3CB40E3A8CAD44dlee03entticom_
Content-Type: application/octet-stream;
	name="0002-ARM-OMAP4-iommu-add-omap4-support-in-iommu.patch"
Content-Description: 0002-ARM-OMAP4-iommu-add-omap4-support-in-iommu.patch
Content-Disposition: attachment;
	filename="0002-ARM-OMAP4-iommu-add-omap4-support-in-iommu.patch"; size=3984;
	creation-date="Fri, 24 Jul 2009 10:58:47 GMT";
	modification-date="Fri, 24 Jul 2009 10:58:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmZmNmZWY3NDY0MDBjYTJlZjRlMWM1NTE4ZWI1MDIyY2QxMDAzZTRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IEZyaSwgMTcgSnVsIDIwMDkgMTk6MDE6NTcgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBUk06
T01BUDQgaW9tbXU6YWRkIG9tYXA0IHN1cHBvcnQgaW4gaW9tbXUKClRoaXMgcGF0Y2ggYWRkcyBv
bWFwNCBzdXBwb3J0IGluIGlvbW11Cm1vZHVsZS4gVGhpcyBjcmVhdGVzIE9NQVA0IHBsYXRmb3Jt
IHNwZWNpZmljIGZpbGUKZm9yIGlvbW11IGFuZCBkZWZpbmVzIHRoZSBEdWNhdGkgTU1VIGZhdWx0
IGludGVycnVwdC4KClNpZ25lZC1vZmYtYnk6IEhhcmkgS2FuaWdlcmkgPGgta2FuaWdlcmkyQHRp
LmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL29tYXA0LWlvbW11LmMgICAgICB8ICAxMTIg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGFyY2gvYXJtL3BsYXQtb21hcC9pbmNs
dWRlL21hY2gvaXJxcy5oIHwgICAgMiArLQogMiBmaWxlcyBjaGFuZ2VkLCAxMTMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9tYWNoLW9t
YXAyL29tYXA0LWlvbW11LmMKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXA0
LWlvbW11LmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXA0LWlvbW11LmMKbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uNWE3ODJkZgotLS0gL2Rldi9udWxsCisrKyBiL2FyY2gv
YXJtL21hY2gtb21hcDIvb21hcDQtaW9tbXUuYwpAQCAtMCwwICsxLDExMiBAQAorLyoKKyAqIG9t
YXAgaW9tbXU6IG9tYXA0IGRldmljZSByZWdpc3RyYXRpb24KKyAqCisgKiBDb3B5cmlnaHQgKEMp
IDIwMDktMjAxMCBOb2tpYSBDb3Jwb3JhdGlvbgorICoKKyAqIFdyaXR0ZW4gYnkgSGFyaSBLYW5p
Z2VyaSA8aC1rYW5pZ2VyaTJAdGkuY29tPgorICoKKyAqIEFkZGVkIHN1cHBvcnQgZm9yIE9NQVA0
LiBUaGlzIGlzIGJhc2VkIG9uIG9yaWdpbmFsIGZpbGUKKyAqIG9tYXAzLWlvbW11LmMKKyAqCisg
KiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQg
YW5kL29yIG1vZGlmeQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0
d2FyZSBGb3VuZGF0aW9uLgorICovCisKKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2Uu
aD4KKworI2luY2x1ZGUgPG1hY2gvaW9tbXUuaD4KKyNpbmNsdWRlIDxtYWNoL2lycXMuaD4KKwor
I2RlZmluZSBPTUFQNF9NTVUxX0JBU0UJMHg1NTA4MjAwMAorI2RlZmluZSBPTUFQNF9NTVUyX0JB
U0UJMHg0QTA2NjAwMAorCisjZGVmaW5lIE9NQVA0X01NVTFfSVJRCUlOVF80NFhYX0RVQ0FUSV9N
TVVfSVJRCisjZGVmaW5lIE9NQVA0X01NVTJfSVJRCUlOVF80NFhYX0RTUF9NTVUKKworCisKK3N0
YXRpYyB1bnNpZ25lZCBsb25nIGlvbW11X2Jhc2VbXSBfX2luaXRkYXRhID0geworCU9NQVA0X01N
VTFfQkFTRSwKKwlPTUFQNF9NTVUyX0JBU0UsCit9OworCitzdGF0aWMgaW50IGlvbW11X2lycVtd
IF9faW5pdGRhdGEgPSB7CisJT01BUDRfTU1VMV9JUlEsCisJT01BUDRfTU1VMl9JUlEsCit9Owor
CitzdGF0aWMgY29uc3Qgc3RydWN0IGlvbW11X3BsYXRmb3JtX2RhdGEgb21hcDRfaW9tbXVfcGRh
dGFbXSBfX2luaXRjb25zdCA9IHsKKwl7CisJCS5uYW1lID0gImR1Y2F0aSIsCisJCS5ucl90bGJf
ZW50cmllcyA9IDMyLAorCQkuY2xrX25hbWUgPSAiZHVjYXRpX2ljayIsCisJfSwKKyNpZiBkZWZp
bmVkKENPTkZJR19NUFVfVEVTTEFfSU9NTVUpCisJeworCQkubmFtZSA9ICJ0ZXNsYSIsCisJCS5u
cl90bGJfZW50cmllcyA9IDMyLAorCQkuY2xrX25hbWUgPSAidGVzbGFfaWNrIiwKKwl9LAorI2Vu
ZGlmCit9OworI2RlZmluZSBOUl9JT01NVV9ERVZJQ0VTIEFSUkFZX1NJWkUob21hcDRfaW9tbXVf
cGRhdGEpCisKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpvbWFwNF9pb21tdV9wZGV2
W05SX0lPTU1VX0RFVklDRVNdOworCitzdGF0aWMgaW50IF9faW5pdCBvbWFwNF9pb21tdV9pbml0
KHZvaWQpCit7CisJaW50IGksIGVycjsKKworCWZvciAoaSA9IDA7IGkgPCBOUl9JT01NVV9ERVZJ
Q0VTOyBpKyspIHsKKwkJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsKKwkJc3RydWN0IHJl
c291cmNlIHJlc1syXTsKKworCQlwZGV2ID0gcGxhdGZvcm1fZGV2aWNlX2FsbG9jKCJvbWFwLWlv
bW11IiwgaSk7CisJCWlmICghcGRldikgeworCQkJZXJyID0gLUVOT01FTTsKKwkJCWdvdG8gZXJy
X291dDsKKwkJfQorCisJCW1lbXNldChyZXMsIDAsICBzaXplb2YocmVzKSk7CisJCXJlc1swXS5z
dGFydCA9IGlvbW11X2Jhc2VbaV07CisJCXJlc1swXS5lbmQgPSBpb21tdV9iYXNlW2ldICsgTU1V
X1JFR19TSVpFIC0gMTsKKwkJcmVzWzBdLmZsYWdzID0gSU9SRVNPVVJDRV9NRU07CisJCXJlc1sx
XS5zdGFydCA9IHJlc1sxXS5lbmQgPSBpb21tdV9pcnFbaV07CisJCXJlc1sxXS5mbGFncyA9IElP
UkVTT1VSQ0VfSVJROworCisJCWVyciA9IHBsYXRmb3JtX2RldmljZV9hZGRfcmVzb3VyY2VzKHBk
ZXYsIHJlcywKKwkJCQkJCSAgICBBUlJBWV9TSVpFKHJlcykpOworCQlpZiAoZXJyKQorCQkJZ290
byBlcnJfb3V0OworCQllcnIgPSBwbGF0Zm9ybV9kZXZpY2VfYWRkX2RhdGEocGRldiwgJm9tYXA0
X2lvbW11X3BkYXRhW2ldLAorCQkJCQkgICAgICAgc2l6ZW9mKG9tYXA0X2lvbW11X3BkYXRhWzBd
KSk7CisJCWlmIChlcnIpCisJCQlnb3RvIGVycl9vdXQ7CisJCWVyciA9IHBsYXRmb3JtX2Rldmlj
ZV9hZGQocGRldik7CisJCWlmIChlcnIpCisJCQlnb3RvIGVycl9vdXQ7CisJCW9tYXA0X2lvbW11
X3BkZXZbaV0gPSBwZGV2OworCX0KKwlyZXR1cm4gMDsKKworZXJyX291dDoKKwl3aGlsZSAoaS0t
KQorCQlwbGF0Zm9ybV9kZXZpY2VfcHV0KG9tYXA0X2lvbW11X3BkZXZbaV0pOworCXJldHVybiBl
cnI7Cit9Cittb2R1bGVfaW5pdChvbWFwNF9pb21tdV9pbml0KTsKKworc3RhdGljIHZvaWQgX19l
eGl0IG9tYXA0X2lvbW11X2V4aXQodm9pZCkKK3sKKwlpbnQgaTsKKworCWZvciAoaSA9IDA7IGkg
PCBOUl9JT01NVV9ERVZJQ0VTOyBpKyspCisJCXBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKG9t
YXA0X2lvbW11X3BkZXZbaV0pOworfQorbW9kdWxlX2V4aXQob21hcDRfaW9tbXVfZXhpdCk7CisK
K01PRFVMRV9BVVRIT1IoIkhpcm9zaGkgRE9ZVSwgSGFyaSBLYW5pZ2VyaSIpOworTU9EVUxFX0RF
U0NSSVBUSU9OKCJvbWFwIGlvbW11OiBvbWFwNCBkZXZpY2UgcmVnaXN0cmF0aW9uIik7CitNT0RV
TEVfTElDRU5TRSgiR1BMIHYyIik7CisKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9p
bmNsdWRlL21hY2gvaXJxcy5oIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvbWFjaC9pcnFz
LmgKaW5kZXggZmI3Y2I3Ny4uMzRiNmQwOSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFw
L2luY2x1ZGUvbWFjaC9pcnFzLmgKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvbWFj
aC9pcnFzLmgKQEAgLTUxMSw3ICs1MTEsNyBAQAogI2RlZmluZSBJTlRfNDRYWF9UTExfSVJRCSg3
OCArIElSUV9HSUNfU1RBUlQpCiAjZGVmaW5lIElOVF80NFhYX1BBUlRIQVNIX0lSUQkoNzkgKyBJ
UlFfR0lDX1NUQVJUKQogI2RlZmluZSBJTlRfNDRYWF9NTUMzX0lSUQkoOTQgKyBJUlFfR0lDX1NU
QVJUKQotCisjZGVmaW5lIElOVF80NFhYX0RVQ0FUSV9NTVVfSVJRCSgxMDAgKyBJUlFfR0lDX1NU
QVJUKQogCiAvKiBNYXguIDEyOCBsZXZlbCAyIElSUXMgKE9NQVAxNjEwKSwgMTkyIEdQSU9zIChP
TUFQNzMwLzg1MCkgYW5kCiAgKiAxNiBNUFVJTyBsaW5lcyAqLwotLSAKMS41LjQuMwoK

--_002_8F7AF80515AF0D4D93307E594F3CB40E3A8CAD44dlee03entticom_--
