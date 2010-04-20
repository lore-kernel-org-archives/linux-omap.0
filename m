From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH 1/3][v2] OMAP:iommu support for OMAP4
Date: Tue, 20 Apr 2010 16:31:03 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B3445E5@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E4B3445E5dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59900 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432Ab0DTVbM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 17:31:12 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "tony@atomide.com" <tony@atomide.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3445E5dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 9a6f91b0c108fd010afdb6bddcae92579c87fcbd Mon Sep 17 00:00:00 2001
From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Tue, 20 Apr 2010 12:03:03 -0500
Subject: [PATCH 1/3] OMAP:iommu support for OMAP4

This patch provides the iommu support for OMAP4 co-processors.
This includes changes to omap3-iommu.c file to make it generic
for all OMAPs. Renamed omap3-iommu.c to omap-iommu.c

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/Makefile               |    4 +-
 arch/arm/mach-omap2/omap-iommu.c           |  134 ++++++++++++++++++++++++=
++++
 arch/arm/mach-omap2/omap3-iommu.c          |  105 ----------------------
 arch/arm/plat-omap/include/plat/omap44xx.h |    3 +
 4 files changed, 138 insertions(+), 108 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap-iommu.c
 delete mode 100644 arch/arm/mach-omap2/omap3-iommu.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 32d8e7c..ed706fd 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -83,9 +83,7 @@ obj-$(CONFIG_OMAP3_EMU)			+=3D emu.o
 obj-$(CONFIG_OMAP_MBOX_FWK)		+=3D mailbox_mach.o
 mailbox_mach-objs			:=3D mailbox.o
=20
-iommu-y					+=3D iommu2.o
-iommu-$(CONFIG_ARCH_OMAP3)		+=3D omap3-iommu.o
-
+iommu-y					+=3D iommu2.o omap-iommu.o
 obj-$(CONFIG_OMAP_IOMMU)		+=3D $(iommu-y)
=20
 i2c-omap-$(CONFIG_I2C_OMAP)		:=3D i2c.o
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-io=
mmu.c
new file mode 100644
index 0000000..f569371
--- /dev/null
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -0,0 +1,134 @@
+/*
+ * omap iommu: omap device registration
+ *
+ * Copyright (C) 2008-2009 Nokia Corporation
+ *
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
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
+struct iommu_device {
+	resource_size_t base;
+	int irq;
+	struct iommu_platform_data pdata;
+	struct resource res[2];
+};
+
+#ifdef CONFIG_ARCH_OMAP3
+static struct iommu_device devices[] =3D {
+	{
+		.base =3D 0x480bd400,
+		.irq =3D 24,
+		.pdata =3D {
+			.name =3D "isp",
+			.nr_tlb_entries =3D 8,
+			.clk_name =3D "cam_ick",
+		},
+	},
+#if defined(CONFIG_MPU_BRIDGE_IOMMU)
+	{
+		.base =3D 0x5d000000,
+		.irq =3D 28,
+		.pdata =3D {
+			.name =3D "iva2",
+			.nr_tlb_entries =3D 32,
+			.clk_name =3D "iva2_ck",
+		},
+	},
+#endif
+};
+#endif
+
+#ifdef CONFIG_ARCH_OMAP4
+static struct iommu_device devices[] =3D {
+	{
+		.base =3D OMAP4_MMU1_BASE,
+		.irq =3D INT_44XX_DUCATI_MMU_IRQ,
+		.pdata =3D {
+			.name =3D "ducati",
+			.nr_tlb_entries =3D 32,
+			.clk_name =3D "ducati_ick",
+		},
+	},
+#if defined(CONFIG_MPU_TESLA_IOMMU)
+	{
+		.base =3D OMAP4_MMU2_BASE,
+		.irq =3D INT_44XX_DSP_MMU,
+		.pdata =3D {
+			.name =3D "tesla",
+			.nr_tlb_entries =3D 32,
+			.clk_name =3D "tesla_ick",
+		},
+	},
+#endif
+};
+#endif
+
+#define NR_IOMMU_DEVICES ARRAY_SIZE(devices)
+
+static struct platform_device *omap_iommu_pdev[NR_IOMMU_DEVICES];
+
+static int __init omap_iommu_init(void)
+{
+	int i, err;
+	struct resource res[] =3D {
+		{ .flags =3D IORESOURCE_MEM },
+		{ .flags =3D IORESOURCE_IRQ },
+	};
+
+	for (i =3D 0; i < NR_IOMMU_DEVICES; i++) {
+		struct platform_device *pdev;
+		const struct iommu_device *d =3D &devices[i];
+
+		pdev =3D platform_device_alloc("omap-iommu", i);
+		if (!pdev) {
+			err =3D -ENOMEM;
+			goto err_out;
+		}
+
+		res[0].start =3D d->base;
+		res[0].end =3D d->base + MMU_REG_SIZE - 1;
+		res[1].start =3D res[1].end =3D d->irq;
+
+		err =3D platform_device_add_resources(pdev, res,
+						    ARRAY_SIZE(res));
+		if (err)
+			goto err_out;
+		err =3D platform_device_add_data(pdev, &d->pdata,
+					       sizeof(d->pdata));
+		if (err)
+			goto err_out;
+		err =3D platform_device_add(pdev);
+		if (err)
+			goto err_out;
+		omap_iommu_pdev[i] =3D pdev;
+	}
+	return 0;
+
+err_out:
+	while (i--)
+		platform_device_put(omap_iommu_pdev[i]);
+	return err;
+}
+module_init(omap_iommu_init);
+
+static void __exit omap_iommu_exit(void)
+{
+	int i;
+
+	for (i =3D 0; i < NR_IOMMU_DEVICES; i++)
+		platform_device_unregister(omap_iommu_pdev[i]);
+}
+module_exit(omap_iommu_exit);
+
+MODULE_AUTHOR("Hiroshi DOYU");
+MODULE_DESCRIPTION("omap iommu: omap device registration");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/mach-omap2/omap3-iommu.c b/arch/arm/mach-omap2/omap3-=
iommu.c
deleted file mode 100644
index fbbcb5c..0000000
--- a/arch/arm/mach-omap2/omap3-iommu.c
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- * omap iommu: omap3 device registration
- *
- * Copyright (C) 2008-2009 Nokia Corporation
- *
- * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/platform_device.h>
-
-#include <plat/iommu.h>
-
-struct iommu_device {
-	resource_size_t base;
-	int irq;
-	struct iommu_platform_data pdata;
-	struct resource res[2];
-};
-
-static struct iommu_device devices[] =3D {
-	{
-		.base =3D 0x480bd400,
-		.irq =3D 24,
-		.pdata =3D {
-			.name =3D "isp",
-			.nr_tlb_entries =3D 8,
-			.clk_name =3D "cam_ick",
-		},
-	},
-#if defined(CONFIG_MPU_BRIDGE_IOMMU)
-	{
-		.base =3D 0x5d000000,
-		.irq =3D 28,
-		.pdata =3D {
-			.name =3D "iva2",
-			.nr_tlb_entries =3D 32,
-			.clk_name =3D "iva2_ck",
-		},
-	},
-#endif
-};
-#define NR_IOMMU_DEVICES ARRAY_SIZE(devices)
-
-static struct platform_device *omap3_iommu_pdev[NR_IOMMU_DEVICES];
-
-static int __init omap3_iommu_init(void)
-{
-	int i, err;
-	struct resource res[] =3D {
-		{ .flags =3D IORESOURCE_MEM },
-		{ .flags =3D IORESOURCE_IRQ },
-	};
-
-	for (i =3D 0; i < NR_IOMMU_DEVICES; i++) {
-		struct platform_device *pdev;
-		const struct iommu_device *d =3D &devices[i];
-
-		pdev =3D platform_device_alloc("omap-iommu", i);
-		if (!pdev) {
-			err =3D -ENOMEM;
-			goto err_out;
-		}
-
-		res[0].start =3D d->base;
-		res[0].end =3D d->base + MMU_REG_SIZE - 1;
-		res[1].start =3D res[1].end =3D d->irq;
-
-		err =3D platform_device_add_resources(pdev, res,
-						    ARRAY_SIZE(res));
-		if (err)
-			goto err_out;
-		err =3D platform_device_add_data(pdev, &d->pdata,
-					       sizeof(d->pdata));
-		if (err)
-			goto err_out;
-		err =3D platform_device_add(pdev);
-		if (err)
-			goto err_out;
-		omap3_iommu_pdev[i] =3D pdev;
-	}
-	return 0;
-
-err_out:
-	while (i--)
-		platform_device_put(omap3_iommu_pdev[i]);
-	return err;
-}
-module_init(omap3_iommu_init);
-
-static void __exit omap3_iommu_exit(void)
-{
-	int i;
-
-	for (i =3D 0; i < NR_IOMMU_DEVICES; i++)
-		platform_device_unregister(omap3_iommu_pdev[i]);
-}
-module_exit(omap3_iommu_exit);
-
-MODULE_AUTHOR("Hiroshi DOYU");
-MODULE_DESCRIPTION("omap iommu: omap3 device registration");
-MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-oma=
p/include/plat/omap44xx.h
index 9cb1e9d..1b5b786 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -47,5 +47,8 @@
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
 #define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)
=20
+#define OMAP4_MMU1_BASE			0x55082000
+#define OMAP4_MMU2_BASE			0x4A066000
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
=20
--=20
1.7.0


Thank you,
Best regards,
Hari


--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3445E5dlee03entticom_
Content-Type: application/octet-stream;
	name="0001-OMAP-iommu-support-for-OMAP4.patch"
Content-Description: 0001-OMAP-iommu-support-for-OMAP4.patch
Content-Disposition: attachment;
	filename="0001-OMAP-iommu-support-for-OMAP4.patch"; size=7362;
	creation-date="Tue, 20 Apr 2010 16:19:05 GMT";
	modification-date="Tue, 20 Apr 2010 16:19:05 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5YTZmOTFiMGMxMDhmZDAxMGFmZGI2YmRkY2FlOTI1NzljODdmY2JkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IFR1ZSwgMjAgQXByIDIwMTAgMTI6MDM6MDMgLTA1MDAKU3ViamVjdDogW1BBVENIIDEvM10g
T01BUDppb21tdSBzdXBwb3J0IGZvciBPTUFQNAoKVGhpcyBwYXRjaCBwcm92aWRlcyB0aGUgaW9t
bXUgc3VwcG9ydCBmb3IgT01BUDQgY28tcHJvY2Vzc29ycy4KVGhpcyBpbmNsdWRlcyBjaGFuZ2Vz
IHRvIG9tYXAzLWlvbW11LmMgZmlsZSB0byBtYWtlIGl0IGdlbmVyaWMKZm9yIGFsbCBPTUFQcy4g
UmVuYW1lZCBvbWFwMy1pb21tdS5jIHRvIG9tYXAtaW9tbXUuYwoKU2lnbmVkLW9mZi1ieTogSGFy
aSBLYW5pZ2VyaSA8aC1rYW5pZ2VyaTJAdGkuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIv
TWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgIDQgKy0KIGFyY2gvYXJtL21hY2gtb21hcDIvb21h
cC1pb21tdS5jICAgICAgICAgICB8ICAxMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
YXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwMy1pb21tdS5jICAgICAgICAgIHwgIDEwNSAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiBhcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L29tYXA0NHh4
LmggfCAgICAzICsKIDQgZmlsZXMgY2hhbmdlZCwgMTM4IGluc2VydGlvbnMoKyksIDEwOCBkZWxl
dGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9tYWNoLW9tYXAyL29tYXAtaW9t
bXUuYwogZGVsZXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtb21hcDIvb21hcDMtaW9tbXUu
YwoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUgYi9hcmNoL2FybS9t
YWNoLW9tYXAyL01ha2VmaWxlCmluZGV4IDMyZDhlN2MuLmVkNzA2ZmQgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9NYWtl
ZmlsZQpAQCAtODMsOSArODMsNyBAQCBvYmotJChDT05GSUdfT01BUDNfRU1VKQkJCSs9IGVtdS5v
CiBvYmotJChDT05GSUdfT01BUF9NQk9YX0ZXSykJCSs9IG1haWxib3hfbWFjaC5vCiBtYWlsYm94
X21hY2gtb2JqcwkJCTo9IG1haWxib3gubwogCi1pb21tdS15CQkJCQkrPSBpb21tdTIubwotaW9t
bXUtJChDT05GSUdfQVJDSF9PTUFQMykJCSs9IG9tYXAzLWlvbW11Lm8KLQoraW9tbXUteQkJCQkJ
Kz0gaW9tbXUyLm8gb21hcC1pb21tdS5vCiBvYmotJChDT05GSUdfT01BUF9JT01NVSkJCSs9ICQo
aW9tbXUteSkKIAogaTJjLW9tYXAtJChDT05GSUdfSTJDX09NQVApCQk6PSBpMmMubwpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwLWlvbW11LmMgYi9hcmNoL2FybS9tYWNoLW9t
YXAyL29tYXAtaW9tbXUuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5mNTY5
MzcxCi0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwLWlvbW11LmMK
QEAgLTAsMCArMSwxMzQgQEAKKy8qCisgKiBvbWFwIGlvbW11OiBvbWFwIGRldmljZSByZWdpc3Ry
YXRpb24KKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMDgtMjAwOSBOb2tpYSBDb3Jwb3JhdGlvbgor
ICoKKyAqIFdyaXR0ZW4gYnkgSGlyb3NoaSBET1lVIDxIaXJvc2hpLkRPWVVAbm9raWEuY29tPgor
ICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0
ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVl
IFNvZnR3YXJlIEZvdW5kYXRpb24uCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2Rl
dmljZS5oPgorCisjaW5jbHVkZSA8cGxhdC9pb21tdS5oPgorI2luY2x1ZGUgPHBsYXQvaXJxcy5o
PgorCitzdHJ1Y3QgaW9tbXVfZGV2aWNlIHsKKwlyZXNvdXJjZV9zaXplX3QgYmFzZTsKKwlpbnQg
aXJxOworCXN0cnVjdCBpb21tdV9wbGF0Zm9ybV9kYXRhIHBkYXRhOworCXN0cnVjdCByZXNvdXJj
ZSByZXNbMl07Cit9OworCisjaWZkZWYgQ09ORklHX0FSQ0hfT01BUDMKK3N0YXRpYyBzdHJ1Y3Qg
aW9tbXVfZGV2aWNlIGRldmljZXNbXSA9IHsKKwl7CisJCS5iYXNlID0gMHg0ODBiZDQwMCwKKwkJ
LmlycSA9IDI0LAorCQkucGRhdGEgPSB7CisJCQkubmFtZSA9ICJpc3AiLAorCQkJLm5yX3RsYl9l
bnRyaWVzID0gOCwKKwkJCS5jbGtfbmFtZSA9ICJjYW1faWNrIiwKKwkJfSwKKwl9LAorI2lmIGRl
ZmluZWQoQ09ORklHX01QVV9CUklER0VfSU9NTVUpCisJeworCQkuYmFzZSA9IDB4NWQwMDAwMDAs
CisJCS5pcnEgPSAyOCwKKwkJLnBkYXRhID0geworCQkJLm5hbWUgPSAiaXZhMiIsCisJCQkubnJf
dGxiX2VudHJpZXMgPSAzMiwKKwkJCS5jbGtfbmFtZSA9ICJpdmEyX2NrIiwKKwkJfSwKKwl9LAor
I2VuZGlmCit9OworI2VuZGlmCisKKyNpZmRlZiBDT05GSUdfQVJDSF9PTUFQNAorc3RhdGljIHN0
cnVjdCBpb21tdV9kZXZpY2UgZGV2aWNlc1tdID0geworCXsKKwkJLmJhc2UgPSBPTUFQNF9NTVUx
X0JBU0UsCisJCS5pcnEgPSBJTlRfNDRYWF9EVUNBVElfTU1VX0lSUSwKKwkJLnBkYXRhID0gewor
CQkJLm5hbWUgPSAiZHVjYXRpIiwKKwkJCS5ucl90bGJfZW50cmllcyA9IDMyLAorCQkJLmNsa19u
YW1lID0gImR1Y2F0aV9pY2siLAorCQl9LAorCX0sCisjaWYgZGVmaW5lZChDT05GSUdfTVBVX1RF
U0xBX0lPTU1VKQorCXsKKwkJLmJhc2UgPSBPTUFQNF9NTVUyX0JBU0UsCisJCS5pcnEgPSBJTlRf
NDRYWF9EU1BfTU1VLAorCQkucGRhdGEgPSB7CisJCQkubmFtZSA9ICJ0ZXNsYSIsCisJCQkubnJf
dGxiX2VudHJpZXMgPSAzMiwKKwkJCS5jbGtfbmFtZSA9ICJ0ZXNsYV9pY2siLAorCQl9LAorCX0s
CisjZW5kaWYKK307CisjZW5kaWYKKworI2RlZmluZSBOUl9JT01NVV9ERVZJQ0VTIEFSUkFZX1NJ
WkUoZGV2aWNlcykKKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKm9tYXBfaW9tbXVf
cGRldltOUl9JT01NVV9ERVZJQ0VTXTsKKworc3RhdGljIGludCBfX2luaXQgb21hcF9pb21tdV9p
bml0KHZvaWQpCit7CisJaW50IGksIGVycjsKKwlzdHJ1Y3QgcmVzb3VyY2UgcmVzW10gPSB7CisJ
CXsgLmZsYWdzID0gSU9SRVNPVVJDRV9NRU0gfSwKKwkJeyAuZmxhZ3MgPSBJT1JFU09VUkNFX0lS
USB9LAorCX07CisKKwlmb3IgKGkgPSAwOyBpIDwgTlJfSU9NTVVfREVWSUNFUzsgaSsrKSB7CisJ
CXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7CisJCWNvbnN0IHN0cnVjdCBpb21tdV9kZXZp
Y2UgKmQgPSAmZGV2aWNlc1tpXTsKKworCQlwZGV2ID0gcGxhdGZvcm1fZGV2aWNlX2FsbG9jKCJv
bWFwLWlvbW11IiwgaSk7CisJCWlmICghcGRldikgeworCQkJZXJyID0gLUVOT01FTTsKKwkJCWdv
dG8gZXJyX291dDsKKwkJfQorCisJCXJlc1swXS5zdGFydCA9IGQtPmJhc2U7CisJCXJlc1swXS5l
bmQgPSBkLT5iYXNlICsgTU1VX1JFR19TSVpFIC0gMTsKKwkJcmVzWzFdLnN0YXJ0ID0gcmVzWzFd
LmVuZCA9IGQtPmlycTsKKworCQllcnIgPSBwbGF0Zm9ybV9kZXZpY2VfYWRkX3Jlc291cmNlcyhw
ZGV2LCByZXMsCisJCQkJCQkgICAgQVJSQVlfU0laRShyZXMpKTsKKwkJaWYgKGVycikKKwkJCWdv
dG8gZXJyX291dDsKKwkJZXJyID0gcGxhdGZvcm1fZGV2aWNlX2FkZF9kYXRhKHBkZXYsICZkLT5w
ZGF0YSwKKwkJCQkJICAgICAgIHNpemVvZihkLT5wZGF0YSkpOworCQlpZiAoZXJyKQorCQkJZ290
byBlcnJfb3V0OworCQllcnIgPSBwbGF0Zm9ybV9kZXZpY2VfYWRkKHBkZXYpOworCQlpZiAoZXJy
KQorCQkJZ290byBlcnJfb3V0OworCQlvbWFwX2lvbW11X3BkZXZbaV0gPSBwZGV2OworCX0KKwly
ZXR1cm4gMDsKKworZXJyX291dDoKKwl3aGlsZSAoaS0tKQorCQlwbGF0Zm9ybV9kZXZpY2VfcHV0
KG9tYXBfaW9tbXVfcGRldltpXSk7CisJcmV0dXJuIGVycjsKK30KK21vZHVsZV9pbml0KG9tYXBf
aW9tbXVfaW5pdCk7CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBvbWFwX2lvbW11X2V4aXQodm9pZCkK
K3sKKwlpbnQgaTsKKworCWZvciAoaSA9IDA7IGkgPCBOUl9JT01NVV9ERVZJQ0VTOyBpKyspCisJ
CXBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKG9tYXBfaW9tbXVfcGRldltpXSk7Cit9Cittb2R1
bGVfZXhpdChvbWFwX2lvbW11X2V4aXQpOworCitNT0RVTEVfQVVUSE9SKCJIaXJvc2hpIERPWVUi
KTsKK01PRFVMRV9ERVNDUklQVElPTigib21hcCBpb21tdTogb21hcCBkZXZpY2UgcmVnaXN0cmF0
aW9uIik7CitNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7CmRpZmYgLS1naXQgYS9hcmNoL2FybS9t
YWNoLW9tYXAyL29tYXAzLWlvbW11LmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXAzLWlvbW11
LmMKZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IGZiYmNiNWMuLjAwMDAwMDAKLS0tIGEv
YXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwMy1pb21tdS5jCisrKyAvZGV2L251bGwKQEAgLTEsMTA1
ICswLDAgQEAKLS8qCi0gKiBvbWFwIGlvbW11OiBvbWFwMyBkZXZpY2UgcmVnaXN0cmF0aW9uCi0g
KgotICogQ29weXJpZ2h0IChDKSAyMDA4LTIwMDkgTm9raWEgQ29ycG9yYXRpb24KLSAqCi0gKiBX
cml0dGVuIGJ5IEhpcm9zaGkgRE9ZVSA8SGlyb3NoaS5ET1lVQG5va2lhLmNvbT4KLSAqCi0gKiBU
aGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5k
L29yIG1vZGlmeQotICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKLSAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2Fy
ZSBGb3VuZGF0aW9uLgotICovCi0KLSNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4K
LQotI2luY2x1ZGUgPHBsYXQvaW9tbXUuaD4KLQotc3RydWN0IGlvbW11X2RldmljZSB7Ci0JcmVz
b3VyY2Vfc2l6ZV90IGJhc2U7Ci0JaW50IGlycTsKLQlzdHJ1Y3QgaW9tbXVfcGxhdGZvcm1fZGF0
YSBwZGF0YTsKLQlzdHJ1Y3QgcmVzb3VyY2UgcmVzWzJdOwotfTsKLQotc3RhdGljIHN0cnVjdCBp
b21tdV9kZXZpY2UgZGV2aWNlc1tdID0gewotCXsKLQkJLmJhc2UgPSAweDQ4MGJkNDAwLAotCQku
aXJxID0gMjQsCi0JCS5wZGF0YSA9IHsKLQkJCS5uYW1lID0gImlzcCIsCi0JCQkubnJfdGxiX2Vu
dHJpZXMgPSA4LAotCQkJLmNsa19uYW1lID0gImNhbV9pY2siLAotCQl9LAotCX0sCi0jaWYgZGVm
aW5lZChDT05GSUdfTVBVX0JSSURHRV9JT01NVSkKLQl7Ci0JCS5iYXNlID0gMHg1ZDAwMDAwMCwK
LQkJLmlycSA9IDI4LAotCQkucGRhdGEgPSB7Ci0JCQkubmFtZSA9ICJpdmEyIiwKLQkJCS5ucl90
bGJfZW50cmllcyA9IDMyLAotCQkJLmNsa19uYW1lID0gIml2YTJfY2siLAotCQl9LAotCX0sCi0j
ZW5kaWYKLX07Ci0jZGVmaW5lIE5SX0lPTU1VX0RFVklDRVMgQVJSQVlfU0laRShkZXZpY2VzKQot
Ci1zdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqb21hcDNfaW9tbXVfcGRldltOUl9JT01N
VV9ERVZJQ0VTXTsKLQotc3RhdGljIGludCBfX2luaXQgb21hcDNfaW9tbXVfaW5pdCh2b2lkKQot
ewotCWludCBpLCBlcnI7Ci0Jc3RydWN0IHJlc291cmNlIHJlc1tdID0gewotCQl7IC5mbGFncyA9
IElPUkVTT1VSQ0VfTUVNIH0sCi0JCXsgLmZsYWdzID0gSU9SRVNPVVJDRV9JUlEgfSwKLQl9Owot
Ci0JZm9yIChpID0gMDsgaSA8IE5SX0lPTU1VX0RFVklDRVM7IGkrKykgewotCQlzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2OwotCQljb25zdCBzdHJ1Y3QgaW9tbXVfZGV2aWNlICpkID0gJmRl
dmljZXNbaV07Ci0KLQkJcGRldiA9IHBsYXRmb3JtX2RldmljZV9hbGxvYygib21hcC1pb21tdSIs
IGkpOwotCQlpZiAoIXBkZXYpIHsKLQkJCWVyciA9IC1FTk9NRU07Ci0JCQlnb3RvIGVycl9vdXQ7
Ci0JCX0KLQotCQlyZXNbMF0uc3RhcnQgPSBkLT5iYXNlOwotCQlyZXNbMF0uZW5kID0gZC0+YmFz
ZSArIE1NVV9SRUdfU0laRSAtIDE7Ci0JCXJlc1sxXS5zdGFydCA9IHJlc1sxXS5lbmQgPSBkLT5p
cnE7Ci0KLQkJZXJyID0gcGxhdGZvcm1fZGV2aWNlX2FkZF9yZXNvdXJjZXMocGRldiwgcmVzLAot
CQkJCQkJICAgIEFSUkFZX1NJWkUocmVzKSk7Ci0JCWlmIChlcnIpCi0JCQlnb3RvIGVycl9vdXQ7
Ci0JCWVyciA9IHBsYXRmb3JtX2RldmljZV9hZGRfZGF0YShwZGV2LCAmZC0+cGRhdGEsCi0JCQkJ
CSAgICAgICBzaXplb2YoZC0+cGRhdGEpKTsKLQkJaWYgKGVycikKLQkJCWdvdG8gZXJyX291dDsK
LQkJZXJyID0gcGxhdGZvcm1fZGV2aWNlX2FkZChwZGV2KTsKLQkJaWYgKGVycikKLQkJCWdvdG8g
ZXJyX291dDsKLQkJb21hcDNfaW9tbXVfcGRldltpXSA9IHBkZXY7Ci0JfQotCXJldHVybiAwOwot
Ci1lcnJfb3V0OgotCXdoaWxlIChpLS0pCi0JCXBsYXRmb3JtX2RldmljZV9wdXQob21hcDNfaW9t
bXVfcGRldltpXSk7Ci0JcmV0dXJuIGVycjsKLX0KLW1vZHVsZV9pbml0KG9tYXAzX2lvbW11X2lu
aXQpOwotCi1zdGF0aWMgdm9pZCBfX2V4aXQgb21hcDNfaW9tbXVfZXhpdCh2b2lkKQotewotCWlu
dCBpOwotCi0JZm9yIChpID0gMDsgaSA8IE5SX0lPTU1VX0RFVklDRVM7IGkrKykKLQkJcGxhdGZv
cm1fZGV2aWNlX3VucmVnaXN0ZXIob21hcDNfaW9tbXVfcGRldltpXSk7Ci19Ci1tb2R1bGVfZXhp
dChvbWFwM19pb21tdV9leGl0KTsKLQotTU9EVUxFX0FVVEhPUigiSGlyb3NoaSBET1lVIik7Ci1N
T0RVTEVfREVTQ1JJUFRJT04oIm9tYXAgaW9tbXU6IG9tYXAzIGRldmljZSByZWdpc3RyYXRpb24i
KTsKLU1PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQt
b21hcC9pbmNsdWRlL3BsYXQvb21hcDQ0eHguaCBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRl
L3BsYXQvb21hcDQ0eHguaAppbmRleCA5Y2IxZTlkLi4xYjViNzg2IDEwMDY0NAotLS0gYS9hcmNo
L2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L29tYXA0NHh4LmgKKysrIGIvYXJjaC9hcm0vcGxh
dC1vbWFwL2luY2x1ZGUvcGxhdC9vbWFwNDR4eC5oCkBAIC00Nyw1ICs0Nyw4IEBACiAjZGVmaW5l
IE9NQVA0NFhYX01BSUxCT1hfQkFTRQkJKEw0XzQ0WFhfQkFTRSArIDB4RjQwMDApCiAjZGVmaW5l
IE9NQVA0NFhYX0hTVVNCX09UR19CQVNFCQkoTDRfNDRYWF9CQVNFICsgMHhBQjAwMCkKIAorI2Rl
ZmluZSBPTUFQNF9NTVUxX0JBU0UJCQkweDU1MDgyMDAwCisjZGVmaW5lIE9NQVA0X01NVTJfQkFT
RQkJCTB4NEEwNjYwMDAKKwogI2VuZGlmIC8qIF9fQVNNX0FSQ0hfT01BUDQ0WFhfSCAqLwogCi0t
IAoxLjcuMAoK

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3445E5dlee03entticom_--
