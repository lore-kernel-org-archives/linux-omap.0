From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH 1/4] [v3]OMAP:iommu renamed omap3-iommu to omap-iommu
Date: Tue, 20 Apr 2010 17:56:30 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B3BF950@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E4B3BF950dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35838 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab0DTW4h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 18:56:37 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "tony@atomide.com" <tony@atomide.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3BF950dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From ea10f0d6550d521ff575e0ea03d5ca4fc258b80e Mon Sep 17 00:00:00 2001
From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Tue, 20 Apr 2010 17:30:09 -0500
Subject: [PATCH 1/4] OMAP:iommu renamed omap3-iommu to omap-iommu

This patch includes changes to omap3-iommu.c file to make it generic
for all OMAPs. Renamed omap3-iommu.c to omap-iommu.c

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/Makefile      |    4 +-
 arch/arm/mach-omap2/omap-iommu.c  |  108 +++++++++++++++++++++++++++++++++=
++++
 arch/arm/mach-omap2/omap3-iommu.c |  105 ---------------------------------=
--
 3 files changed, 109 insertions(+), 108 deletions(-)
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
index 0000000..416a65d
--- /dev/null
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -0,0 +1,108 @@
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
--=20
1.7.0


--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3BF950dlee03entticom_
Content-Type: application/octet-stream;
	name="0001-OMAP-iommu-renamed-omap3-iommu-to-omap-iommu.patch"
Content-Description: 0001-OMAP-iommu-renamed-omap3-iommu-to-omap-iommu.patch
Content-Disposition: attachment;
	filename="0001-OMAP-iommu-renamed-omap3-iommu-to-omap-iommu.patch";
	size=6300; creation-date="Tue, 20 Apr 2010 17:40:25 GMT";
	modification-date="Tue, 20 Apr 2010 17:40:25 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlYTEwZjBkNjU1MGQ1MjFmZjU3NWUwZWEwM2Q1Y2E0ZmMyNThiODBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IFR1ZSwgMjAgQXByIDIwMTAgMTc6MzA6MDkgLTA1MDAKU3ViamVjdDogW1BBVENIIDEvNF0g
T01BUDppb21tdSByZW5hbWVkIG9tYXAzLWlvbW11IHRvIG9tYXAtaW9tbXUKClRoaXMgcGF0Y2gg
aW5jbHVkZXMgY2hhbmdlcyB0byBvbWFwMy1pb21tdS5jIGZpbGUgdG8gbWFrZSBpdCBnZW5lcmlj
CmZvciBhbGwgT01BUHMuIFJlbmFtZWQgb21hcDMtaW9tbXUuYyB0byBvbWFwLWlvbW11LmMKClNp
Z25lZC1vZmYtYnk6IEhhcmkgS2FuaWdlcmkgPGgta2FuaWdlcmkyQHRpLmNvbT4KLS0tCiBhcmNo
L2FybS9tYWNoLW9tYXAyL01ha2VmaWxlICAgICAgfCAgICA0ICstCiBhcmNoL2FybS9tYWNoLW9t
YXAyL29tYXAtaW9tbXUuYyAgfCAgMTA4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIGFyY2gvYXJtL21hY2gtb21hcDIvb21hcDMtaW9tbXUuYyB8ICAxMDUgLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTA5IGluc2VydGlv
bnMoKyksIDEwOCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9tYWNo
LW9tYXAyL29tYXAtaW9tbXUuYwogZGVsZXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtb21h
cDIvb21hcDMtaW9tbXUuYwoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZp
bGUgYi9hcmNoL2FybS9tYWNoLW9tYXAyL01ha2VmaWxlCmluZGV4IDMyZDhlN2MuLmVkNzA2ZmQg
MTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUKKysrIGIvYXJjaC9hcm0v
bWFjaC1vbWFwMi9NYWtlZmlsZQpAQCAtODMsOSArODMsNyBAQCBvYmotJChDT05GSUdfT01BUDNf
RU1VKQkJCSs9IGVtdS5vCiBvYmotJChDT05GSUdfT01BUF9NQk9YX0ZXSykJCSs9IG1haWxib3hf
bWFjaC5vCiBtYWlsYm94X21hY2gtb2JqcwkJCTo9IG1haWxib3gubwogCi1pb21tdS15CQkJCQkr
PSBpb21tdTIubwotaW9tbXUtJChDT05GSUdfQVJDSF9PTUFQMykJCSs9IG9tYXAzLWlvbW11Lm8K
LQoraW9tbXUteQkJCQkJKz0gaW9tbXUyLm8gb21hcC1pb21tdS5vCiBvYmotJChDT05GSUdfT01B
UF9JT01NVSkJCSs9ICQoaW9tbXUteSkKIAogaTJjLW9tYXAtJChDT05GSUdfSTJDX09NQVApCQk6
PSBpMmMubwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwLWlvbW11LmMgYi9h
cmNoL2FybS9tYWNoLW9tYXAyL29tYXAtaW9tbXUuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwLi40MTZhNjVkCi0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9vbWFwLWlvbW11LmMKQEAgLTAsMCArMSwxMDggQEAKKy8qCisgKiBvbWFwIGlvbW11OiBvbWFw
IGRldmljZSByZWdpc3RyYXRpb24KKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMDgtMjAwOSBOb2tp
YSBDb3Jwb3JhdGlvbgorICoKKyAqIFdyaXR0ZW4gYnkgSGlyb3NoaSBET1lVIDxIaXJvc2hpLkRP
WVVAbm9raWEuY29tPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3Ug
Y2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRlciB0aGUgdGVybXMg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcworICogcHVibGlz
aGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisgKi8KKworI2luY2x1ZGUgPGxp
bnV4L3BsYXRmb3JtX2RldmljZS5oPgorCisjaW5jbHVkZSA8cGxhdC9pb21tdS5oPgorCitzdHJ1
Y3QgaW9tbXVfZGV2aWNlIHsKKwlyZXNvdXJjZV9zaXplX3QgYmFzZTsKKwlpbnQgaXJxOworCXN0
cnVjdCBpb21tdV9wbGF0Zm9ybV9kYXRhIHBkYXRhOworCXN0cnVjdCByZXNvdXJjZSByZXNbMl07
Cit9OworCisjaWZkZWYgQ09ORklHX0FSQ0hfT01BUDMKK3N0YXRpYyBzdHJ1Y3QgaW9tbXVfZGV2
aWNlIGRldmljZXNbXSA9IHsKKwl7CisJCS5iYXNlID0gMHg0ODBiZDQwMCwKKwkJLmlycSA9IDI0
LAorCQkucGRhdGEgPSB7CisJCQkubmFtZSA9ICJpc3AiLAorCQkJLm5yX3RsYl9lbnRyaWVzID0g
OCwKKwkJCS5jbGtfbmFtZSA9ICJjYW1faWNrIiwKKwkJfSwKKwl9LAorI2lmIGRlZmluZWQoQ09O
RklHX01QVV9CUklER0VfSU9NTVUpCisJeworCQkuYmFzZSA9IDB4NWQwMDAwMDAsCisJCS5pcnEg
PSAyOCwKKwkJLnBkYXRhID0geworCQkJLm5hbWUgPSAiaXZhMiIsCisJCQkubnJfdGxiX2VudHJp
ZXMgPSAzMiwKKwkJCS5jbGtfbmFtZSA9ICJpdmEyX2NrIiwKKwkJfSwKKwl9LAorI2VuZGlmCit9
OworI2VuZGlmCisKKyNkZWZpbmUgTlJfSU9NTVVfREVWSUNFUyBBUlJBWV9TSVpFKGRldmljZXMp
CisKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpvbWFwX2lvbW11X3BkZXZbTlJfSU9N
TVVfREVWSUNFU107CisKK3N0YXRpYyBpbnQgX19pbml0IG9tYXBfaW9tbXVfaW5pdCh2b2lkKQor
eworCWludCBpLCBlcnI7CisJc3RydWN0IHJlc291cmNlIHJlc1tdID0geworCQl7IC5mbGFncyA9
IElPUkVTT1VSQ0VfTUVNIH0sCisJCXsgLmZsYWdzID0gSU9SRVNPVVJDRV9JUlEgfSwKKwl9Owor
CisJZm9yIChpID0gMDsgaSA8IE5SX0lPTU1VX0RFVklDRVM7IGkrKykgeworCQlzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2OworCQljb25zdCBzdHJ1Y3QgaW9tbXVfZGV2aWNlICpkID0gJmRl
dmljZXNbaV07CisKKwkJcGRldiA9IHBsYXRmb3JtX2RldmljZV9hbGxvYygib21hcC1pb21tdSIs
IGkpOworCQlpZiAoIXBkZXYpIHsKKwkJCWVyciA9IC1FTk9NRU07CisJCQlnb3RvIGVycl9vdXQ7
CisJCX0KKworCQlyZXNbMF0uc3RhcnQgPSBkLT5iYXNlOworCQlyZXNbMF0uZW5kID0gZC0+YmFz
ZSArIE1NVV9SRUdfU0laRSAtIDE7CisJCXJlc1sxXS5zdGFydCA9IHJlc1sxXS5lbmQgPSBkLT5p
cnE7CisKKwkJZXJyID0gcGxhdGZvcm1fZGV2aWNlX2FkZF9yZXNvdXJjZXMocGRldiwgcmVzLAor
CQkJCQkJICAgIEFSUkFZX1NJWkUocmVzKSk7CisJCWlmIChlcnIpCisJCQlnb3RvIGVycl9vdXQ7
CisJCWVyciA9IHBsYXRmb3JtX2RldmljZV9hZGRfZGF0YShwZGV2LCAmZC0+cGRhdGEsCisJCQkJ
CSAgICAgICBzaXplb2YoZC0+cGRhdGEpKTsKKwkJaWYgKGVycikKKwkJCWdvdG8gZXJyX291dDsK
KwkJZXJyID0gcGxhdGZvcm1fZGV2aWNlX2FkZChwZGV2KTsKKwkJaWYgKGVycikKKwkJCWdvdG8g
ZXJyX291dDsKKwkJb21hcF9pb21tdV9wZGV2W2ldID0gcGRldjsKKwl9CisJcmV0dXJuIDA7CisK
K2Vycl9vdXQ6CisJd2hpbGUgKGktLSkKKwkJcGxhdGZvcm1fZGV2aWNlX3B1dChvbWFwX2lvbW11
X3BkZXZbaV0pOworCXJldHVybiBlcnI7Cit9Cittb2R1bGVfaW5pdChvbWFwX2lvbW11X2luaXQp
OworCitzdGF0aWMgdm9pZCBfX2V4aXQgb21hcF9pb21tdV9leGl0KHZvaWQpCit7CisJaW50IGk7
CisKKwlmb3IgKGkgPSAwOyBpIDwgTlJfSU9NTVVfREVWSUNFUzsgaSsrKQorCQlwbGF0Zm9ybV9k
ZXZpY2VfdW5yZWdpc3RlcihvbWFwX2lvbW11X3BkZXZbaV0pOworfQorbW9kdWxlX2V4aXQob21h
cF9pb21tdV9leGl0KTsKKworTU9EVUxFX0FVVEhPUigiSGlyb3NoaSBET1lVIik7CitNT0RVTEVf
REVTQ1JJUFRJT04oIm9tYXAgaW9tbXU6IG9tYXAgZGV2aWNlIHJlZ2lzdHJhdGlvbiIpOworTU9E
VUxFX0xJQ0VOU0UoIkdQTCB2MiIpOwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9v
bWFwMy1pb21tdS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwMy1pb21tdS5jCmRlbGV0ZWQg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCBmYmJjYjVjLi4wMDAwMDAwCi0tLSBhL2FyY2gvYXJtL21h
Y2gtb21hcDIvb21hcDMtaW9tbXUuYworKysgL2Rldi9udWxsCkBAIC0xLDEwNSArMCwwIEBACi0v
KgotICogb21hcCBpb21tdTogb21hcDMgZGV2aWNlIHJlZ2lzdHJhdGlvbgotICoKLSAqIENvcHly
aWdodCAoQykgMjAwOC0yMDA5IE5va2lhIENvcnBvcmF0aW9uCi0gKgotICogV3JpdHRlbiBieSBI
aXJvc2hpIERPWVUgPEhpcm9zaGkuRE9ZVUBub2tpYS5jb20+Ci0gKgotICogVGhpcyBwcm9ncmFt
IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkK
LSAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
dmVyc2lvbiAyIGFzCi0gKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlv
bi4KLSAqLwotCi0jaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+Ci0KLSNpbmNsdWRl
IDxwbGF0L2lvbW11Lmg+Ci0KLXN0cnVjdCBpb21tdV9kZXZpY2UgewotCXJlc291cmNlX3NpemVf
dCBiYXNlOwotCWludCBpcnE7Ci0Jc3RydWN0IGlvbW11X3BsYXRmb3JtX2RhdGEgcGRhdGE7Ci0J
c3RydWN0IHJlc291cmNlIHJlc1syXTsKLX07Ci0KLXN0YXRpYyBzdHJ1Y3QgaW9tbXVfZGV2aWNl
IGRldmljZXNbXSA9IHsKLQl7Ci0JCS5iYXNlID0gMHg0ODBiZDQwMCwKLQkJLmlycSA9IDI0LAot
CQkucGRhdGEgPSB7Ci0JCQkubmFtZSA9ICJpc3AiLAotCQkJLm5yX3RsYl9lbnRyaWVzID0gOCwK
LQkJCS5jbGtfbmFtZSA9ICJjYW1faWNrIiwKLQkJfSwKLQl9LAotI2lmIGRlZmluZWQoQ09ORklH
X01QVV9CUklER0VfSU9NTVUpCi0JewotCQkuYmFzZSA9IDB4NWQwMDAwMDAsCi0JCS5pcnEgPSAy
OCwKLQkJLnBkYXRhID0gewotCQkJLm5hbWUgPSAiaXZhMiIsCi0JCQkubnJfdGxiX2VudHJpZXMg
PSAzMiwKLQkJCS5jbGtfbmFtZSA9ICJpdmEyX2NrIiwKLQkJfSwKLQl9LAotI2VuZGlmCi19Owot
I2RlZmluZSBOUl9JT01NVV9ERVZJQ0VTIEFSUkFZX1NJWkUoZGV2aWNlcykKLQotc3RhdGljIHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKm9tYXAzX2lvbW11X3BkZXZbTlJfSU9NTVVfREVWSUNFU107
Ci0KLXN0YXRpYyBpbnQgX19pbml0IG9tYXAzX2lvbW11X2luaXQodm9pZCkKLXsKLQlpbnQgaSwg
ZXJyOwotCXN0cnVjdCByZXNvdXJjZSByZXNbXSA9IHsKLQkJeyAuZmxhZ3MgPSBJT1JFU09VUkNF
X01FTSB9LAotCQl7IC5mbGFncyA9IElPUkVTT1VSQ0VfSVJRIH0sCi0JfTsKLQotCWZvciAoaSA9
IDA7IGkgPCBOUl9JT01NVV9ERVZJQ0VTOyBpKyspIHsKLQkJc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldjsKLQkJY29uc3Qgc3RydWN0IGlvbW11X2RldmljZSAqZCA9ICZkZXZpY2VzW2ldOwot
Ci0JCXBkZXYgPSBwbGF0Zm9ybV9kZXZpY2VfYWxsb2MoIm9tYXAtaW9tbXUiLCBpKTsKLQkJaWYg
KCFwZGV2KSB7Ci0JCQllcnIgPSAtRU5PTUVNOwotCQkJZ290byBlcnJfb3V0OwotCQl9Ci0KLQkJ
cmVzWzBdLnN0YXJ0ID0gZC0+YmFzZTsKLQkJcmVzWzBdLmVuZCA9IGQtPmJhc2UgKyBNTVVfUkVH
X1NJWkUgLSAxOwotCQlyZXNbMV0uc3RhcnQgPSByZXNbMV0uZW5kID0gZC0+aXJxOwotCi0JCWVy
ciA9IHBsYXRmb3JtX2RldmljZV9hZGRfcmVzb3VyY2VzKHBkZXYsIHJlcywKLQkJCQkJCSAgICBB
UlJBWV9TSVpFKHJlcykpOwotCQlpZiAoZXJyKQotCQkJZ290byBlcnJfb3V0OwotCQllcnIgPSBw
bGF0Zm9ybV9kZXZpY2VfYWRkX2RhdGEocGRldiwgJmQtPnBkYXRhLAotCQkJCQkgICAgICAgc2l6
ZW9mKGQtPnBkYXRhKSk7Ci0JCWlmIChlcnIpCi0JCQlnb3RvIGVycl9vdXQ7Ci0JCWVyciA9IHBs
YXRmb3JtX2RldmljZV9hZGQocGRldik7Ci0JCWlmIChlcnIpCi0JCQlnb3RvIGVycl9vdXQ7Ci0J
CW9tYXAzX2lvbW11X3BkZXZbaV0gPSBwZGV2OwotCX0KLQlyZXR1cm4gMDsKLQotZXJyX291dDoK
LQl3aGlsZSAoaS0tKQotCQlwbGF0Zm9ybV9kZXZpY2VfcHV0KG9tYXAzX2lvbW11X3BkZXZbaV0p
OwotCXJldHVybiBlcnI7Ci19Ci1tb2R1bGVfaW5pdChvbWFwM19pb21tdV9pbml0KTsKLQotc3Rh
dGljIHZvaWQgX19leGl0IG9tYXAzX2lvbW11X2V4aXQodm9pZCkKLXsKLQlpbnQgaTsKLQotCWZv
ciAoaSA9IDA7IGkgPCBOUl9JT01NVV9ERVZJQ0VTOyBpKyspCi0JCXBsYXRmb3JtX2RldmljZV91
bnJlZ2lzdGVyKG9tYXAzX2lvbW11X3BkZXZbaV0pOwotfQotbW9kdWxlX2V4aXQob21hcDNfaW9t
bXVfZXhpdCk7Ci0KLU1PRFVMRV9BVVRIT1IoIkhpcm9zaGkgRE9ZVSIpOwotTU9EVUxFX0RFU0NS
SVBUSU9OKCJvbWFwIGlvbW11OiBvbWFwMyBkZXZpY2UgcmVnaXN0cmF0aW9uIik7Ci1NT0RVTEVf
TElDRU5TRSgiR1BMIHYyIik7Ci0tIAoxLjcuMAoK

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3BF950dlee03entticom_--
