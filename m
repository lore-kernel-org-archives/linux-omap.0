From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH v1 3/3] ARM:OMAP4 iommu:provide build support for omap4 iommu
Date: Tue, 4 Aug 2009 17:32:12 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E3ABDBAC2@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8F7AF80515AF0D4D93307E594F3CB40E3ABDBAC2dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38166 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbZHDWcY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 18:32:24 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

--_002_8F7AF80515AF0D4D93307E594F3CB40E3ABDBAC2dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch provides build support to build OMAP4
IOMMU module. This also adds the changes to Kconfig
file to make iommu option visible in menuconfig.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/Makefile |    2 +-
 arch/arm/plat-omap/Kconfig   |    7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

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
index efe85d0..50aaefb 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -118,8 +118,11 @@ config OMAP_MBOX_FWK
 	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
=20
 config OMAP_IOMMU
-	tristate
-
+	tristate "iommu"
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


--_002_8F7AF80515AF0D4D93307E594F3CB40E3ABDBAC2dlee03entticom_
Content-Type: application/octet-stream;
	name="0003-ARM-OMAP4-iommu-provide-build-support-for-omap4-iomm.patch"
Content-Description: 0003-ARM-OMAP4-iommu-provide-build-support-for-omap4-iomm.patch
Content-Disposition: attachment;
	filename="0003-ARM-OMAP4-iommu-provide-build-support-for-omap4-iomm.patch";
	size=1511; creation-date="Tue, 04 Aug 2009 17:19:41 GMT";
	modification-date="Tue, 04 Aug 2009 17:19:41 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiYTdhMzgyMWYzOWJmNjQ5Y2Q4YTA2N2U3NmVlMTZhMTYzZTg5ODk1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5jb20+CkRh
dGU6IFR1ZSwgNCBBdWcgMjAwOSAxNzoxOToxNSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFSTTpP
TUFQNCBpb21tdTpwcm92aWRlIGJ1aWxkIHN1cHBvcnQgZm9yIG9tYXA0IGlvbW11CgpUaGlzIHBh
dGNoIHByb3ZpZGVzIGJ1aWxkIHN1cHBvcnQgdG8gYnVpbGQgT01BUDQKSU9NTVUgbW9kdWxlLiBU
aGlzIGFsc28gYWRkcyB0aGUgY2hhbmdlcyB0byBLY29uZmlnCmZpbGUgdG8gbWFrZSBpb21tdSBv
cHRpb24gdmlzaWJsZSBpbiBtZW51Y29uZmlnLgoKU2lnbmVkLW9mZi1ieTogSGFyaSBLYW5pZ2Vy
aSA8aC1rYW5pZ2VyaTJAdGkuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUg
fCAgICAyICstCiBhcmNoL2FybS9wbGF0LW9tYXAvS2NvbmZpZyAgIHwgICAgNyArKysrKy0tCiAy
IGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL01ha2VmaWxlIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9N
YWtlZmlsZQppbmRleCA3MzViYWU1Li41OWUwODY1IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNo
LW9tYXAyL01ha2VmaWxlCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUKQEAgLTQx
LDcgKzQxLDcgQEAgb2JqLSQoQ09ORklHX0FSQ0hfT01BUDMpCQkrPSBjbG9jazM0eHgubwogCiBp
b21tdS15CQkJCQkrPSBpb21tdTIubwogaW9tbXUtJChDT05GSUdfQVJDSF9PTUFQMykJCSs9IG9t
YXAzLWlvbW11Lm8KLQoraW9tbXUtJChDT05GSUdfQVJDSF9PTUFQNCkgICAgICAgICAgICAgICs9
IG9tYXA0LWlvbW11Lm8KIG9iai0kKENPTkZJR19PTUFQX0lPTU1VKQkJKz0gJChpb21tdS15KQog
CiAjIFNwZWNpZmljIGJvYXJkIHN1cHBvcnQKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21h
cC9LY29uZmlnIGIvYXJjaC9hcm0vcGxhdC1vbWFwL0tjb25maWcKaW5kZXggZWZlODVkMC4uNTBh
YWVmYiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL0tjb25maWcKKysrIGIvYXJjaC9h
cm0vcGxhdC1vbWFwL0tjb25maWcKQEAgLTExOCw4ICsxMTgsMTEgQEAgY29uZmlnIE9NQVBfTUJP
WF9GV0sKIAkgIERTUCwgSVZBMS4wIGFuZCBJVkEyIGluIE9NQVAxLzIvMy4KIAogY29uZmlnIE9N
QVBfSU9NTVUKLQl0cmlzdGF0ZQotCisJdHJpc3RhdGUgImlvbW11IgorCWRlZmF1bHQgeQorCWhl
bHAKKwkgIFNlbGVjdCB0aGlzIG9wdGlvbiBpZiB5b3Ugd2FudCB0byB1c2UgSU9NTVUgc3VwcG9y
dCBmb3IgdGhlCisJICBDYW1lcmEgaW4gT01BUDMsIGFuZCBmb3IgRHVjYXRpIHByb2Nlc3NvciBp
biBPTUFQNC4KIGNob2ljZQogICAgICAgICBwcm9tcHQgIlN5c3RlbSB0aW1lciIKIAlkZWZhdWx0
IE9NQVBfTVBVX1RJTUVSCi0tIAoxLjUuNC4zCgo=

--_002_8F7AF80515AF0D4D93307E594F3CB40E3ABDBAC2dlee03entticom_--
