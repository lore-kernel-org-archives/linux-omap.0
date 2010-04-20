From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH 2/4][v3] OMAP:iommu support for OMAP4
Date: Tue, 20 Apr 2010 17:56:43 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B3BF951@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E4B3BF951dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35855 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab0DTW4u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 18:56:50 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "tony@atomide.com" <tony@atomide.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3BF951dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 9a2bcae7a2de6890884c23c45563eece1e6838de Mon Sep 17 00:00:00 2001
From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Tue, 20 Apr 2010 17:39:18 -0500
Subject: [PATCH 2/4] OMAP:iommu support for OMAP4

This patch provides the iommu support for OMAP4 co-processors.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/omap-iommu.c           |   26 ++++++++++++++++++++++++=
++
 arch/arm/plat-omap/include/plat/omap44xx.h |    3 +++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-io=
mmu.c
index 416a65d..f569371 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
=20
 #include <plat/iommu.h>
+#include <plat/irqs.h>
=20
 struct iommu_device {
 	resource_size_t base;
@@ -46,6 +47,31 @@ static struct iommu_device devices[] =3D {
 };
 #endif
=20
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
 #define NR_IOMMU_DEVICES ARRAY_SIZE(devices)
=20
 static struct platform_device *omap_iommu_pdev[NR_IOMMU_DEVICES];
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


--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3BF951dlee03entticom_
Content-Type: application/octet-stream;
	name="0002-OMAP-iommu-support-for-OMAP4.patch"
Content-Description: 0002-OMAP-iommu-support-for-OMAP4.patch
Content-Disposition: attachment;
	filename="0002-OMAP-iommu-support-for-OMAP4.patch"; size=1986;
	creation-date="Tue, 20 Apr 2010 17:40:25 GMT";
	modification-date="Tue, 20 Apr 2010 17:40:25 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5YTJiY2FlN2EyZGU2ODkwODg0YzIzYzQ1NTYzZWVjZTFlNjgzOGRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IFR1ZSwgMjAgQXByIDIwMTAgMTc6Mzk6MTggLTA1MDAKU3ViamVjdDogW1BBVENIIDIvNF0g
T01BUDppb21tdSBzdXBwb3J0IGZvciBPTUFQNAoKVGhpcyBwYXRjaCBwcm92aWRlcyB0aGUgaW9t
bXUgc3VwcG9ydCBmb3IgT01BUDQgY28tcHJvY2Vzc29ycy4KClNpZ25lZC1vZmYtYnk6IEhhcmkg
S2FuaWdlcmkgPGgta2FuaWdlcmkyQHRpLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL29t
YXAtaW9tbXUuYyAgICAgICAgICAgfCAgIDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrCiBh
cmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L29tYXA0NHh4LmggfCAgICAzICsrKwogMiBm
aWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcC1pb21tdS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9vbWFwLWlvbW11LmMKaW5kZXggNDE2YTY1ZC4uZjU2OTM3MSAxMDA2NDQKLS0tIGEvYXJjaC9h
cm0vbWFjaC1vbWFwMi9vbWFwLWlvbW11LmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFw
LWlvbW11LmMKQEAgLTEzLDYgKzEzLDcgQEAKICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZp
Y2UuaD4KIAogI2luY2x1ZGUgPHBsYXQvaW9tbXUuaD4KKyNpbmNsdWRlIDxwbGF0L2lycXMuaD4K
IAogc3RydWN0IGlvbW11X2RldmljZSB7CiAJcmVzb3VyY2Vfc2l6ZV90IGJhc2U7CkBAIC00Niw2
ICs0NywzMSBAQCBzdGF0aWMgc3RydWN0IGlvbW11X2RldmljZSBkZXZpY2VzW10gPSB7CiB9Owog
I2VuZGlmCiAKKyNpZmRlZiBDT05GSUdfQVJDSF9PTUFQNAorc3RhdGljIHN0cnVjdCBpb21tdV9k
ZXZpY2UgZGV2aWNlc1tdID0geworCXsKKwkJLmJhc2UgPSBPTUFQNF9NTVUxX0JBU0UsCisJCS5p
cnEgPSBJTlRfNDRYWF9EVUNBVElfTU1VX0lSUSwKKwkJLnBkYXRhID0geworCQkJLm5hbWUgPSAi
ZHVjYXRpIiwKKwkJCS5ucl90bGJfZW50cmllcyA9IDMyLAorCQkJLmNsa19uYW1lID0gImR1Y2F0
aV9pY2siLAorCQl9LAorCX0sCisjaWYgZGVmaW5lZChDT05GSUdfTVBVX1RFU0xBX0lPTU1VKQor
CXsKKwkJLmJhc2UgPSBPTUFQNF9NTVUyX0JBU0UsCisJCS5pcnEgPSBJTlRfNDRYWF9EU1BfTU1V
LAorCQkucGRhdGEgPSB7CisJCQkubmFtZSA9ICJ0ZXNsYSIsCisJCQkubnJfdGxiX2VudHJpZXMg
PSAzMiwKKwkJCS5jbGtfbmFtZSA9ICJ0ZXNsYV9pY2siLAorCQl9LAorCX0sCisjZW5kaWYKK307
CisjZW5kaWYKKwogI2RlZmluZSBOUl9JT01NVV9ERVZJQ0VTIEFSUkFZX1NJWkUoZGV2aWNlcykK
IAogc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKm9tYXBfaW9tbXVfcGRldltOUl9JT01N
VV9ERVZJQ0VTXTsKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQv
b21hcDQ0eHguaCBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvb21hcDQ0eHguaApp
bmRleCA5Y2IxZTlkLi4xYjViNzg2IDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LW9tYXAvaW5j
bHVkZS9wbGF0L29tYXA0NHh4LmgKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxh
dC9vbWFwNDR4eC5oCkBAIC00Nyw1ICs0Nyw4IEBACiAjZGVmaW5lIE9NQVA0NFhYX01BSUxCT1hf
QkFTRQkJKEw0XzQ0WFhfQkFTRSArIDB4RjQwMDApCiAjZGVmaW5lIE9NQVA0NFhYX0hTVVNCX09U
R19CQVNFCQkoTDRfNDRYWF9CQVNFICsgMHhBQjAwMCkKIAorI2RlZmluZSBPTUFQNF9NTVUxX0JB
U0UJCQkweDU1MDgyMDAwCisjZGVmaW5lIE9NQVA0X01NVTJfQkFTRQkJCTB4NEEwNjYwMDAKKwog
I2VuZGlmIC8qIF9fQVNNX0FSQ0hfT01BUDQ0WFhfSCAqLwogCi0tIAoxLjcuMAoK

--_002_8F7AF80515AF0D4D93307E594F3CB40E4B3BF951dlee03entticom_--
