From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [RFC][PATCH 3/3]ARM:OMAP4 iommu:provide build support for omap4
 iommu
Date: Fri, 24 Jul 2009 12:22:56 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD46@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E3A8CAD46dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56717 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbZGXRXK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jul 2009 13:23:10 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Pasam, Vijay" <vpasam@ti.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E3A8CAD46dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch provides build support to build OMAP4
IOMMU module. This also adds the changes to Kconfig
file to make iommu option visible in menuconfig.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/Makefile |    2 +-
 arch/arm/plat-omap/Kconfig   |    8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 735bae5..59e0865 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -41,7 +41,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+=3D clock34xx.o
=20
 iommu-y					+=3D iommu2.o
 iommu-$(CONFIG_ARCH_OMAP3)		+=3D omap3-iommu.o
-
+iommu-$(CONFIG_ARCH_OMAP4)              +=3D omap4-iommu.o
 obj-$(CONFIG_OMAP_IOMMU)		+=3D $(iommu-y)
=20
 # Specific board support
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index efe85d0..00d7a1e 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -118,8 +118,12 @@ config OMAP_MBOX_FWK
 	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
=20
 config OMAP_IOMMU
-	tristate
-
+	tristate "iommu"
+        depends on ARCH_OMAP
+	default y
+	help
+	  Select this option if you want to use IOMMU support for the
+	  Camera in OMAP3, and for Ducati processor in OMAP4.
 choice
         prompt "System timer"
 	default OMAP_MPU_TIMER
--=20
1.5.4.3


Thank you,
Best regards,
Hari


--_002_8F7AF80515AF0D4D93307E594F3CB40E3A8CAD46dlee03entticom_
Content-Type: application/octet-stream;
	name="0003-ARM-OMAP4-iommu-provide-build-support-for-omap4-iom.patch"
Content-Description: 0003-ARM-OMAP4-iommu-provide-build-support-for-omap4-iom.patch
Content-Disposition: attachment;
	filename="0003-ARM-OMAP4-iommu-provide-build-support-for-omap4-iom.patch";
	size=1542; creation-date="Fri, 24 Jul 2009 11:58:59 GMT";
	modification-date="Fri, 24 Jul 2009 11:58:59 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2Y2NlYjA0NmFkNGMxOGNlYzg5OTRlZTA2MDYwMWFkOTllNzMxYzc5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IFdlZCwgMTUgSnVsIDIwMDkgMTA6NTY6MzUgLTA1MDAKU3ViamVjdDogW1BBVENIXUFSTTpP
TUFQNCBpb21tdTpwcm92aWRlIGJ1aWxkIHN1cHBvcnQgZm9yIG9tYXA0IGlvbW11CgpUaGlzIHBh
dGNoIHByb3ZpZGVzIGJ1aWxkIHN1cHBvcnQgdG8gYnVpbGQgT01BUDQKSU9NTVUgbW9kdWxlLiBU
aGlzIGFsc28gYWRkcyB0aGUgY2hhbmdlcyB0byBLY29uZmlnCmZpbGUgdG8gbWFrZSBpb21tdSBv
cHRpb24gdmlzaWJsZSBpbiBtZW51Y29uZmlnLgoKU2lnbmVkLW9mZi1ieTogSGFyaSBLYW5pZ2Vy
aSA8aC1rYW5pZ2VyaTJAdGkuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUg
fCAgICAyICstCiBhcmNoL2FybS9wbGF0LW9tYXAvS2NvbmZpZyAgIHwgICAgOCArKysrKystLQog
MiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9NYWtlZmlsZSBiL2FyY2gvYXJtL21hY2gtb21hcDIv
TWFrZWZpbGUKaW5kZXggNzM1YmFlNS4uNTllMDg2NSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFj
aC1vbWFwMi9NYWtlZmlsZQorKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL01ha2VmaWxlCkBAIC00
MSw3ICs0MSw3IEBAIG9iai0kKENPTkZJR19BUkNIX09NQVAzKQkJKz0gY2xvY2szNHh4Lm8KIAog
aW9tbXUteQkJCQkJKz0gaW9tbXUyLm8KIGlvbW11LSQoQ09ORklHX0FSQ0hfT01BUDMpCQkrPSBv
bWFwMy1pb21tdS5vCi0KK2lvbW11LSQoQ09ORklHX0FSQ0hfT01BUDQpICAgICAgICAgICAgICAr
PSBvbWFwNC1pb21tdS5vCiBvYmotJChDT05GSUdfT01BUF9JT01NVSkJCSs9ICQoaW9tbXUteSkK
IAogIyBTcGVjaWZpYyBib2FyZCBzdXBwb3J0CmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9t
YXAvS2NvbmZpZyBiL2FyY2gvYXJtL3BsYXQtb21hcC9LY29uZmlnCmluZGV4IGVmZTg1ZDAuLjAw
ZDdhMWUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3BsYXQtb21hcC9LY29uZmlnCisrKyBiL2FyY2gv
YXJtL3BsYXQtb21hcC9LY29uZmlnCkBAIC0xMTgsOCArMTE4LDEyIEBAIGNvbmZpZyBPTUFQX01C
T1hfRldLCiAJICBEU1AsIElWQTEuMCBhbmQgSVZBMiBpbiBPTUFQMS8yLzMuCiAKIGNvbmZpZyBP
TUFQX0lPTU1VCi0JdHJpc3RhdGUKLQorCXRyaXN0YXRlICJpb21tdSIKKyAgICAgICAgZGVwZW5k
cyBvbiBBUkNIX09NQVAKKwlkZWZhdWx0IHkKKwloZWxwCisJICBTZWxlY3QgdGhpcyBvcHRpb24g
aWYgeW91IHdhbnQgdG8gdXNlIElPTU1VIHN1cHBvcnQgZm9yIHRoZQorCSAgQ2FtZXJhIGluIE9N
QVAzLCBhbmQgZm9yIER1Y2F0aSBwcm9jZXNzb3IgaW4gT01BUDQuCiBjaG9pY2UKICAgICAgICAg
cHJvbXB0ICJTeXN0ZW0gdGltZXIiCiAJZGVmYXVsdCBPTUFQX01QVV9USU1FUgotLSAKMS41LjQu
MwoK

--_002_8F7AF80515AF0D4D93307E594F3CB40E3A8CAD46dlee03entticom_--
