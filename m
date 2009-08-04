From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH v1 2/3] ARM:OMAP4 iommu:add omap4 support in iommu
Date: Tue, 4 Aug 2009 17:31:38 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E3ABDBABF@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E3ABDBABFdlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51297 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbZHDWbx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Aug 2009 18:31:53 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E3ABDBABFdlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch adds omap4 support in iommu
module. This creates OMAP4 platform specific file
for iommu and defines the Ducati MMU fault interrupt.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/omap4-iommu.c      |  110 ++++++++++++++++++++++++++++=
++++
 arch/arm/plat-omap/include/mach/irqs.h |    2 +-
 2 files changed, 111 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap4-iommu.c

diff --git a/arch/arm/mach-omap2/omap4-iommu.c b/arch/arm/mach-omap2/omap4-=
iommu.c
new file mode 100644
index 0000000..7c7f396
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4-iommu.c
@@ -0,0 +1,110 @@
+/*
+ * omap iommu: omap4 device registration
+ *
+ * Copyright (C) 2008-2009 Nokia Corporation
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


--_002_8F7AF80515AF0D4D93307E594F3CB40E3ABDBABFdlee03entticom_
Content-Type: application/octet-stream;
	name="0002-ARM-OMAP4-iommu-add-omap4-support-in-iommu.patch"
Content-Description: 0002-ARM-OMAP4-iommu-add-omap4-support-in-iommu.patch
Content-Disposition: attachment;
	filename="0002-ARM-OMAP4-iommu-add-omap4-support-in-iommu.patch"; size=3926;
	creation-date="Tue, 04 Aug 2009 17:19:41 GMT";
	modification-date="Tue, 04 Aug 2009 17:19:41 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzOTkzNzdlZDhmY2YxMTlmYjdlZmVkY2IxMWI4NTE5ZWNjNWY5OWE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IFR1ZSwgNCBBdWcgMjAwOSAxNzoxODoxMSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFSTTpP
TUFQNCBpb21tdTphZGQgb21hcDQgc3VwcG9ydCBpbiBpb21tdQoKVGhpcyBwYXRjaCBhZGRzIG9t
YXA0IHN1cHBvcnQgaW4gaW9tbXUKbW9kdWxlLiBUaGlzIGNyZWF0ZXMgT01BUDQgcGxhdGZvcm0g
c3BlY2lmaWMgZmlsZQpmb3IgaW9tbXUgYW5kIGRlZmluZXMgdGhlIER1Y2F0aSBNTVUgZmF1bHQg
aW50ZXJydXB0LgoKU2lnbmVkLW9mZi1ieTogSGFyaSBLYW5pZ2VyaSA8aC1rYW5pZ2VyaTJAdGku
Y29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvb21hcDQtaW9tbXUuYyAgICAgIHwgIDExMCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1
ZGUvbWFjaC9pcnFzLmggfCAgICAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDExMSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtb21h
cDIvb21hcDQtaW9tbXUuYwoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcDQt
aW9tbXUuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcDQtaW9tbXUuYwpuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwLi43YzdmMzk2Ci0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9h
cm0vbWFjaC1vbWFwMi9vbWFwNC1pb21tdS5jCkBAIC0wLDAgKzEsMTEwIEBACisvKgorICogb21h
cCBpb21tdTogb21hcDQgZGV2aWNlIHJlZ2lzdHJhdGlvbgorICoKKyAqIENvcHlyaWdodCAoQykg
MjAwOC0yMDA5IE5va2lhIENvcnBvcmF0aW9uCisgKgorICogV3JpdHRlbiBieSBIYXJpIEthbmln
ZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CisgKgorICogQWRkZWQgc3VwcG9ydCBmb3IgT01BUDQu
IFRoaXMgaXMgYmFzZWQgb24gb3JpZ2luYWwgZmlsZQorICogb21hcDMtaW9tbXUuYworICoKKyAq
IFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBh
bmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3
YXJlIEZvdW5kYXRpb24uCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5o
PgorCisjaW5jbHVkZSA8bWFjaC9pb21tdS5oPgorI2luY2x1ZGUgPG1hY2gvaXJxcy5oPgorCisj
ZGVmaW5lIE9NQVA0X01NVTFfQkFTRQkweDU1MDgyMDAwCisjZGVmaW5lIE9NQVA0X01NVTJfQkFT
RQkweDRBMDY2MDAwCisKKyNkZWZpbmUgT01BUDRfTU1VMV9JUlEJSU5UXzQ0WFhfRFVDQVRJX01N
VV9JUlEKKyNkZWZpbmUgT01BUDRfTU1VMl9JUlEJSU5UXzQ0WFhfRFNQX01NVQorCisKKworc3Rh
dGljIHVuc2lnbmVkIGxvbmcgaW9tbXVfYmFzZVtdIF9faW5pdGRhdGEgPSB7CisJT01BUDRfTU1V
MV9CQVNFLAorCU9NQVA0X01NVTJfQkFTRSwKK307CisKK3N0YXRpYyBpbnQgaW9tbXVfaXJxW10g
X19pbml0ZGF0YSA9IHsKKwlPTUFQNF9NTVUxX0lSUSwKKwlPTUFQNF9NTVUyX0lSUSwKK307CisK
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgaW9tbXVfcGxhdGZvcm1fZGF0YSBvbWFwNF9pb21tdV9wZGF0
YVtdIF9faW5pdGNvbnN0ID0geworCXsKKwkJLm5hbWUgPSAiZHVjYXRpIiwKKwkJLm5yX3RsYl9l
bnRyaWVzID0gMzIsCisJfSwKKyNpZiBkZWZpbmVkKENPTkZJR19NUFVfVEVTTEFfSU9NTVUpCisJ
eworCQkubmFtZSA9ICJ0ZXNsYSIsCisJCS5ucl90bGJfZW50cmllcyA9IDMyLAorCX0sCisjZW5k
aWYKK307CisjZGVmaW5lIE5SX0lPTU1VX0RFVklDRVMgQVJSQVlfU0laRShvbWFwNF9pb21tdV9w
ZGF0YSkKKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKm9tYXA0X2lvbW11X3BkZXZb
TlJfSU9NTVVfREVWSUNFU107CisKK3N0YXRpYyBpbnQgX19pbml0IG9tYXA0X2lvbW11X2luaXQo
dm9pZCkKK3sKKwlpbnQgaSwgZXJyOworCisJZm9yIChpID0gMDsgaSA8IE5SX0lPTU1VX0RFVklD
RVM7IGkrKykgeworCQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2OworCQlzdHJ1Y3QgcmVz
b3VyY2UgcmVzWzJdOworCisJCXBkZXYgPSBwbGF0Zm9ybV9kZXZpY2VfYWxsb2MoIm9tYXAtaW9t
bXUiLCBpKTsKKwkJaWYgKCFwZGV2KSB7CisJCQllcnIgPSAtRU5PTUVNOworCQkJZ290byBlcnJf
b3V0OworCQl9CisKKwkJbWVtc2V0KHJlcywgMCwgIHNpemVvZihyZXMpKTsKKwkJcmVzWzBdLnN0
YXJ0ID0gaW9tbXVfYmFzZVtpXTsKKwkJcmVzWzBdLmVuZCA9IGlvbW11X2Jhc2VbaV0gKyBNTVVf
UkVHX1NJWkUgLSAxOworCQlyZXNbMF0uZmxhZ3MgPSBJT1JFU09VUkNFX01FTTsKKwkJcmVzWzFd
LnN0YXJ0ID0gcmVzWzFdLmVuZCA9IGlvbW11X2lycVtpXTsKKwkJcmVzWzFdLmZsYWdzID0gSU9S
RVNPVVJDRV9JUlE7CisKKwkJZXJyID0gcGxhdGZvcm1fZGV2aWNlX2FkZF9yZXNvdXJjZXMocGRl
diwgcmVzLAorCQkJCQkJICAgIEFSUkFZX1NJWkUocmVzKSk7CisJCWlmIChlcnIpCisJCQlnb3Rv
IGVycl9vdXQ7CisJCWVyciA9IHBsYXRmb3JtX2RldmljZV9hZGRfZGF0YShwZGV2LCAmb21hcDRf
aW9tbXVfcGRhdGFbaV0sCisJCQkJCSAgICAgICBzaXplb2Yob21hcDRfaW9tbXVfcGRhdGFbMF0p
KTsKKwkJaWYgKGVycikKKwkJCWdvdG8gZXJyX291dDsKKwkJZXJyID0gcGxhdGZvcm1fZGV2aWNl
X2FkZChwZGV2KTsKKwkJaWYgKGVycikKKwkJCWdvdG8gZXJyX291dDsKKwkJb21hcDRfaW9tbXVf
cGRldltpXSA9IHBkZXY7CisJfQorCXJldHVybiAwOworCitlcnJfb3V0OgorCXdoaWxlIChpLS0p
CisJCXBsYXRmb3JtX2RldmljZV9wdXQob21hcDRfaW9tbXVfcGRldltpXSk7CisJcmV0dXJuIGVy
cjsKK30KK21vZHVsZV9pbml0KG9tYXA0X2lvbW11X2luaXQpOworCitzdGF0aWMgdm9pZCBfX2V4
aXQgb21hcDRfaW9tbXVfZXhpdCh2b2lkKQoreworCWludCBpOworCisJZm9yIChpID0gMDsgaSA8
IE5SX0lPTU1VX0RFVklDRVM7IGkrKykKKwkJcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIob21h
cDRfaW9tbXVfcGRldltpXSk7Cit9Cittb2R1bGVfZXhpdChvbWFwNF9pb21tdV9leGl0KTsKKwor
TU9EVUxFX0FVVEhPUigiSGlyb3NoaSBET1lVLCBIYXJpIEthbmlnZXJpIik7CitNT0RVTEVfREVT
Q1JJUFRJT04oIm9tYXAgaW9tbXU6IG9tYXA0IGRldmljZSByZWdpc3RyYXRpb24iKTsKK01PRFVM
RV9MSUNFTlNFKCJHUEwgdjIiKTsKKwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1vbWFwL2lu
Y2x1ZGUvbWFjaC9pcnFzLmggYi9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9tYWNoL2lycXMu
aAppbmRleCBmYjdjYjc3Li4zNGI2ZDA5IDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LW9tYXAv
aW5jbHVkZS9tYWNoL2lycXMuaAorKysgYi9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9tYWNo
L2lycXMuaApAQCAtNTExLDcgKzUxMSw3IEBACiAjZGVmaW5lIElOVF80NFhYX1RMTF9JUlEJKDc4
ICsgSVJRX0dJQ19TVEFSVCkKICNkZWZpbmUgSU5UXzQ0WFhfUEFSVEhBU0hfSVJRCSg3OSArIElS
UV9HSUNfU1RBUlQpCiAjZGVmaW5lIElOVF80NFhYX01NQzNfSVJRCSg5NCArIElSUV9HSUNfU1RB
UlQpCi0KKyNkZWZpbmUgSU5UXzQ0WFhfRFVDQVRJX01NVV9JUlEJKDEwMCArIElSUV9HSUNfU1RB
UlQpCiAKIC8qIE1heC4gMTI4IGxldmVsIDIgSVJRcyAoT01BUDE2MTApLCAxOTIgR1BJT3MgKE9N
QVA3MzAvODUwKSBhbmQKICAqIDE2IE1QVUlPIGxpbmVzICovCi0tIAoxLjUuNC4zCgo=

--_002_8F7AF80515AF0D4D93307E594F3CB40E3ABDBABFdlee03entticom_--
