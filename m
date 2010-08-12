From: "Que, Simon" <sque@ti.com>
Subject: [PATCH 1/4 v2] omap: hwspinlock: uncomment the hwmod part for
 hwspinlock
Date: Wed, 11 Aug 2010 19:29:45 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E46@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F39349C6FA641B4A831B7BF4EBF4D4E1480D9E46dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58712 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759185Ab0HLA3u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Aug 2010 20:29:50 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1480D9E46dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

uncomment the hwmod part for hwspinlock

Signed-off-by: Simon Que <sque@ti.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index bb0c870..81e3f3f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5797,7 +5797,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[=
] =3D {
 /*     &omap44xx_smartreflex_iva_hwmod, */
 /*     &omap44xx_smartreflex_mpu_hwmod, */
        /* spinlock class */
-/*     &omap44xx_spinlock_hwmod, */
+       &omap44xx_spinlock_hwmod,
        /* timer class */
        &omap44xx_timer1_hwmod,
        &omap44xx_timer2_hwmod,
--
1.7.0

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1480D9E46dlee03entticom_
Content-Type: application/octet-stream;
	name="0001-omap-hwspinlock-uncomment-the-hwmod-part-for-hwspinlock.patch"
Content-Description: 0001-omap-hwspinlock-uncomment-the-hwmod-part-for-hwspinlock.patch
Content-Disposition: attachment; filename=
	"0001-omap-hwspinlock-uncomment-the-hwmod-part-for-hwspinlock.patch";
	size=955; creation-date="Fri, 06 Aug 2010 11:06:58 GMT";
	modification-date="Fri, 06 Aug 2010 11:06:58 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0NzJkMDZjZWYyYmJhOWUzNTgxNTk2MGM1ODQ4YjhhMGQwYTJkNjBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBRdWUgPHNxdWVAdGkuY29tPgpEYXRlOiBGcmksIDYg
QXVnIDIwMTAgMTA6Mjg6NTMgLTA1MDAKU3ViamVjdDogW1BBVENIIDEvNF0gdW5jb21tZW50IHRo
ZSBod21vZCBwYXJ0IGZvciBod3NwaW5sb2NrCgpTaWduZWQtb2ZmLWJ5OiBTaW1vbiBRdWUgPHNx
dWVAdGkuY29tPgpTaWduZWQtb2ZmLWJ5OiBIYXJpIEthbmlnZXJpIDxoLWthbmlnZXJpMkB0aS5j
b20+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kXzQ0eHhfZGF0YS5jIHwgICAg
MiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kXzQ0eHhfZGF0YS5jIGIv
YXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kXzQ0eHhfZGF0YS5jCmluZGV4IGJiMGM4NzAu
LjgxZTNmM2YgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcF9od21vZF80NHh4
X2RhdGEuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdtb2RfNDR4eF9kYXRhLmMK
QEAgLTU3OTcsNyArNTc5Nyw3IEBAIHN0YXRpYyBfX2luaXRkYXRhIHN0cnVjdCBvbWFwX2h3bW9k
ICpvbWFwNDR4eF9od21vZHNbXSA9IHsKIC8qCSZvbWFwNDR4eF9zbWFydHJlZmxleF9pdmFfaHdt
b2QsICovCiAvKgkmb21hcDQ0eHhfc21hcnRyZWZsZXhfbXB1X2h3bW9kLCAqLwogCS8qIHNwaW5s
b2NrIGNsYXNzICovCi0vKgkmb21hcDQ0eHhfc3BpbmxvY2tfaHdtb2QsICovCisJJm9tYXA0NHh4
X3NwaW5sb2NrX2h3bW9kLAogCS8qIHRpbWVyIGNsYXNzICovCiAJJm9tYXA0NHh4X3RpbWVyMV9o
d21vZCwKIAkmb21hcDQ0eHhfdGltZXIyX2h3bW9kLAotLSAKMS43LjAKCg==

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1480D9E46dlee03entticom_--
