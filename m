From: "Que, Simon" <sque@ti.com>
Subject: [PATCH 3/3 v3] omap: hwspinlock: Patch to add support to build
 hwspinlock modules
Date: Fri, 13 Aug 2010 14:59:03 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E1481CCCB1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F39349C6FA641B4A831B7BF4EBF4D4E1481CCCB1dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56815 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603Ab0HMT7G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Aug 2010 15:59:06 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1481CCCB1dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Patch to add support to build hwspinlock modules

Signed-off-by: Simon Que <sque@ti.com>
---
 arch/arm/mach-omap2/Makefile |    2 ++
 arch/arm/plat-omap/Makefile  |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 630f880..fe49340 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -176,3 +176,5 @@ obj-y					+=3D $(nand-m) $(nand-y)
=20
 smc91x-$(CONFIG_SMC91X)			:=3D gpmc-smc91x.o
 obj-y					+=3D $(smc91x-m) $(smc91x-y)
+
+obj-$(CONFIG_ARCH_OMAP4)		+=3D hwspinlocks.o
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index ea8e555..c9f79d5 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -34,3 +34,5 @@ obj-$(CONFIG_OMAP_REMOTE_PROC) +=3D remoteproc.o
=20
 obj-$(CONFIG_OMAP_PM_NOOP) +=3D omap-pm-noop.o
 obj-$(CONFIG_OMAP_PM) +=3D omap-pm.o
+
+obj-$(CONFIG_ARCH_OMAP4) +=3D hwspinlock.o
--=20
1.7.0


--_002_F39349C6FA641B4A831B7BF4EBF4D4E1481CCCB1dlee03entticom_
Content-Type: application/octet-stream;
	name="0003-Patch-to-add-support-to-build-hwspinlock-modules.patch"
Content-Description: 0003-Patch-to-add-support-to-build-hwspinlock-modules.patch
Content-Disposition: attachment;
	filename="0003-Patch-to-add-support-to-build-hwspinlock-modules.patch";
	size=1112; creation-date="Fri, 13 Aug 2010 15:05:47 GMT";
	modification-date="Fri, 13 Aug 2010 15:05:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwZmNlYzM3MWI2OTE5ZDEyZjdjOWNjZTQyYjkyNzcyNDViNWVjZmQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBRdWUgPHNxdWVAdGkuY29tPgpEYXRlOiBGcmksIDYg
QXVnIDIwMTAgMTA6NTA6MTUgLTA1MDAKU3ViamVjdDogW1BBVENIIDMvM10gUGF0Y2ggdG8gYWRk
IHN1cHBvcnQgdG8gYnVpbGQgaHdzcGlubG9jayBtb2R1bGVzCgpTaWduZWQtb2ZmLWJ5OiBTaW1v
biBRdWUgPHNxdWVAdGkuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUgfCAg
ICAyICsrCiBhcmNoL2FybS9wbGF0LW9tYXAvTWFrZWZpbGUgIHwgICAgMiArKwogMiBmaWxlcyBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vbWFjaC1vbWFwMi9NYWtlZmlsZSBiL2FyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUK
aW5kZXggNjMwZjg4MC4uZmU0OTM0MCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9N
YWtlZmlsZQorKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL01ha2VmaWxlCkBAIC0xNzYsMyArMTc2
LDUgQEAgb2JqLXkJCQkJCSs9ICQobmFuZC1tKSAkKG5hbmQteSkKIAogc21jOTF4LSQoQ09ORklH
X1NNQzkxWCkJCQk6PSBncG1jLXNtYzkxeC5vCiBvYmoteQkJCQkJKz0gJChzbWM5MXgtbSkgJChz
bWM5MXgteSkKKworb2JqLSQoQ09ORklHX0FSQ0hfT01BUDQpCQkrPSBod3NwaW5sb2Nrcy5vCmRp
ZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvTWFrZWZpbGUgYi9hcmNoL2FybS9wbGF0LW9t
YXAvTWFrZWZpbGUKaW5kZXggZWE4ZTU1NS4uYzlmNzlkNSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0v
cGxhdC1vbWFwL01ha2VmaWxlCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9NYWtlZmlsZQpAQCAt
MzQsMyArMzQsNSBAQCBvYmotJChDT05GSUdfT01BUF9SRU1PVEVfUFJPQykgKz0gcmVtb3RlcHJv
Yy5vCiAKIG9iai0kKENPTkZJR19PTUFQX1BNX05PT1ApICs9IG9tYXAtcG0tbm9vcC5vCiBvYmot
JChDT05GSUdfT01BUF9QTSkgKz0gb21hcC1wbS5vCisKK29iai0kKENPTkZJR19BUkNIX09NQVA0
KSArPSBod3NwaW5sb2NrLm8KLS0gCjEuNy4wCgo=

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1481CCCB1dlee03entticom_--
