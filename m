From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH] ARM: Overo: Fix smsc911x platform device resource value
Date: Wed, 29 Jul 2009 16:44:06 -0500
Message-ID: <A24693684029E5489D1D202277BE894449BD64D0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE894449BD64D0dlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52343 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178AbZG2Vq5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jul 2009 17:46:57 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Steve Sakoman <steve@sakoman.com>

--_002_A24693684029E5489D1D202277BE894449BD64D0dlee02entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 7a35b843689937256399ece6ef807d43b6e9296a Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Wed, 29 Jul 2009 16:30:46 -0500
Subject: [PATCH] ARM: Overo: Fix smsc911x platform device resource value

Fixes a wrong setting of resource parameter list in
SMSC911x platform driver data structure for Overo case.

This fixes folowing warning when compiling for Overo board:

	warning: initialization from incompatible pointer type

Introduced since commit id:
	commit 172ef275444efa12d834fb9d1b1acdac92db47f7
	Author: Steve Sakoman <sakoman@gmail.com>
	Date:   Mon Feb 2 06:27:49 2009 +0000

	    ARM: Add SMSC911X support to Overo platform (V2)

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-overo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-=
overo.c
index 501d020..7e54713 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -146,7 +146,7 @@ static struct platform_device overo_smsc911x_device =3D=
 {
 	.name		=3D "smsc911x",
 	.id		=3D -1,
 	.num_resources	=3D ARRAY_SIZE(overo_smsc911x_resources),
-	.resource	=3D &overo_smsc911x_resources,
+	.resource	=3D overo_smsc911x_resources,
 	.dev		=3D {
 		.platform_data =3D &overo_smsc911x_config,
 	},
--=20
1.6.3.2

--_002_A24693684029E5489D1D202277BE894449BD64D0dlee02entticom_
Content-Type: text/x-patch;
	name="0001-ARM-Overo-Fix-smsc911x-platform-device-resource-valu.patch"
Content-Description: 0001-ARM-Overo-Fix-smsc911x-platform-device-resource-valu.patch
Content-Disposition: attachment;
	filename="0001-ARM-Overo-Fix-smsc911x-platform-device-resource-valu.patch";
	size=1331; creation-date="Wed, 29 Jul 2009 16:46:30 GMT";
	modification-date="Wed, 29 Jul 2009 16:46:30 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3YTM1Yjg0MzY4OTkzNzI1NjM5OWVjZTZlZjgwN2Q0M2I2ZTkyOTZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gQWd1aXJyZSA8c2FhZ3VpcnJlQHRpLmNvbT4KRGF0
ZTogV2VkLCAyOSBKdWwgMjAwOSAxNjozMDo0NiAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFSTTog
T3Zlcm86IEZpeCBzbXNjOTExeCBwbGF0Zm9ybSBkZXZpY2UgcmVzb3VyY2UgdmFsdWUKCkZpeGVz
IGEgd3Jvbmcgc2V0dGluZyBvZiByZXNvdXJjZSBwYXJhbWV0ZXIgbGlzdCBpbgpTTVNDOTExeCBw
bGF0Zm9ybSBkcml2ZXIgZGF0YSBzdHJ1Y3R1cmUgZm9yIE92ZXJvIGNhc2UuCgpUaGlzIGZpeGVz
IGZvbG93aW5nIHdhcm5pbmcgd2hlbiBjb21waWxpbmcgZm9yIE92ZXJvIGJvYXJkOgoKCXdhcm5p
bmc6IGluaXRpYWxpemF0aW9uIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZQoKSW50cm9k
dWNlZCBzaW5jZSBjb21taXQgaWQ6Cgljb21taXQgMTcyZWYyNzU0NDRlZmExMmQ4MzRmYjlkMWIx
YWNkYWM5MmRiNDdmNwoJQXV0aG9yOiBTdGV2ZSBTYWtvbWFuIDxzYWtvbWFuQGdtYWlsLmNvbT4K
CURhdGU6ICAgTW9uIEZlYiAyIDA2OjI3OjQ5IDIwMDkgKzAwMDAKCgkgICAgQVJNOiBBZGQgU01T
QzkxMVggc3VwcG9ydCB0byBPdmVybyBwbGF0Zm9ybSAoVjIpCgpTaWduZWQtb2ZmLWJ5OiBTZXJn
aW8gQWd1aXJyZSA8c2FhZ3VpcnJlQHRpLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL2Jv
YXJkLW92ZXJvLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW92
ZXJvLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW92ZXJvLmMKaW5kZXggNTAxZDAyMC4u
N2U1NDcxMyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1vdmVyby5jCisr
KyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb3Zlcm8uYwpAQCAtMTQ2LDcgKzE0Niw3IEBA
IHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIG92ZXJvX3Ntc2M5MTF4X2RldmljZSA9IHsK
IAkubmFtZQkJPSAic21zYzkxMXgiLAogCS5pZAkJPSAtMSwKIAkubnVtX3Jlc291cmNlcwk9IEFS
UkFZX1NJWkUob3Zlcm9fc21zYzkxMXhfcmVzb3VyY2VzKSwKLQkucmVzb3VyY2UJPSAmb3Zlcm9f
c21zYzkxMXhfcmVzb3VyY2VzLAorCS5yZXNvdXJjZQk9IG92ZXJvX3Ntc2M5MTF4X3Jlc291cmNl
cywKIAkuZGV2CQk9IHsKIAkJLnBsYXRmb3JtX2RhdGEgPSAmb3Zlcm9fc21zYzkxMXhfY29uZmln
LAogCX0sCi0tIAoxLjYuMy4yCgo=

--_002_A24693684029E5489D1D202277BE894449BD64D0dlee02entticom_--
