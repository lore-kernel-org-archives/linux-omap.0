From: "Que, Simon" <sque@ti.com>
Subject: [PATCH 2/4 v2] omap: hwspinlock: Add HWSPINLOCK base address
 information in omap44xx.h
Date: Wed, 11 Aug 2010 19:29:47 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E47@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F39349C6FA641B4A831B7BF4EBF4D4E1480D9E47dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56807 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759336Ab0HLA3v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Aug 2010 20:29:51 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1480D9E47dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Add HWSPINLOCK base address information in omap44xx.h

Signed-off-by: Simon Que <sque@ti.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/include/plat/omap44xx.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-oma=
p/include/plat/omap44xx.h
index 8b3f12f..8016508 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -52,5 +52,7 @@
 #define OMAP4_MMU1_BASE                        0x55082000
 #define OMAP4_MMU2_BASE                        0x4A066000

+#define OMAP44XX_SPINLOCK_BASE         (L4_44XX_BASE + 0xF6000)
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
--
1.7.1

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1480D9E47dlee03entticom_
Content-Type: application/octet-stream; name=
	"0002-omap-hwspinlock-Add-HWSPINLOCK-base-address-information-in-omap44xx..patch"
Content-Description: 0002-omap-hwspinlock-Add-HWSPINLOCK-base-address-information-in-omap44xx..patch
Content-Disposition: attachment; filename=
	"0002-omap-hwspinlock-Add-HWSPINLOCK-base-address-information-in-omap44xx..patch";
	size=846; creation-date="Fri, 06 Aug 2010 11:06:58 GMT";
	modification-date="Fri, 06 Aug 2010 11:06:58 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmNTQ1NzkwYWFmMDYwZTYyZjRlMzdmZGU3NTdlMTBhOWM1ODBiMjU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBRdWUgPHNxdWVAdGkuY29tPgpEYXRlOiBGcmksIDYg
QXVnIDIwMTAgMTA6MzY6MTcgLTA1MDAKU3ViamVjdDogW1BBVENIIDIvNF0gQWRkIEhXU1BJTkxP
Q0sgYmFzZSBhZGRyZXNzIGluZm9ybWF0aW9uIGluIG9tYXA0NHh4LmgKClNpZ25lZC1vZmYtYnk6
IFNpbW9uIFF1ZSA8c3F1ZUB0aS5jb20+ClNpZ25lZC1vZmYtYnk6IEhhcmkgS2FuaWdlcmkgPGgt
a2FuaWdlcmkyQHRpLmNvbT4KLS0tCiBhcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L29t
YXA0NHh4LmggfCAgICAyICsrCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0
L29tYXA0NHh4LmggYi9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L29tYXA0NHh4LmgK
aW5kZXggOGIzZjEyZi4uODAxNjUwOCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2lu
Y2x1ZGUvcGxhdC9vbWFwNDR4eC5oCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3Bs
YXQvb21hcDQ0eHguaApAQCAtNTIsNSArNTIsNyBAQAogI2RlZmluZSBPTUFQNF9NTVUxX0JBU0UJ
CQkweDU1MDgyMDAwCiAjZGVmaW5lIE9NQVA0X01NVTJfQkFTRQkJCTB4NEEwNjYwMDAKIAorI2Rl
ZmluZSBPTUFQNDRYWF9TUElOTE9DS19CQVNFCQkoTDRfNDRYWF9CQVNFICsgMHhGNjAwMCkKKwog
I2VuZGlmIC8qIF9fQVNNX0FSQ0hfT01BUDQ0WFhfSCAqLwogCi0tIAoxLjcuMAoK

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1480D9E47dlee03entticom_--
