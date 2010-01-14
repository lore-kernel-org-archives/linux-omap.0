From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: [PATCH] PM debug: Fix warning when no CONFIG_DEBUG_FS
Date: Thu, 14 Jan 2010 11:05:55 -0600
Message-ID: <A24693684029E5489D1D202277BE894451538FE7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE894451538FE7dlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57478 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756851Ab0ANRDW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jan 2010 12:03:22 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_A24693684029E5489D1D202277BE894451538FE7dlee02entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From ec3f04ec8cf4851fceb249acf832755b7aad1766 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Thu, 14 Jan 2010 11:01:15 -0600
Subject: [PATCH] PM debug: Fix warning when no CONFIG_DEBUG_FS

Fix following warning when CONFIG_DEBUG_FS wasn't selected:

arch/arm/mach-omap2/pm-debug.c:57: warning: 'pm_dbg_init' declared 'static'=
 but never defined

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.=
c
index 860b755..9727484 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -54,8 +54,6 @@ int omap2_pm_debug;
 	regs[reg_count++].val =3D \
 			 __raw_readl(OMAP2_L4_IO_ADDRESS(0x480fe000 + (off)))
=20
-static int __init pm_dbg_init(void);
-
 void omap2_pm_dump(int mode, int resume, unsigned int us)
 {
 	struct reg {
@@ -167,6 +165,8 @@ struct dentry *pm_dbg_dir;
=20
 static int pm_dbg_init_done;
=20
+static int __init pm_dbg_init(void);
+
 enum {
 	DEBUG_FILE_COUNTERS =3D 0,
 	DEBUG_FILE_TIMERS,
--=20
1.6.5.3


--_002_A24693684029E5489D1D202277BE894451538FE7dlee02entticom_
Content-Type: application/octet-stream;
	name="0001-PM-debug-Fix-warning-when-no-CONFIG_DEBUG_FS.patch"
Content-Description: 0001-PM-debug-Fix-warning-when-no-CONFIG_DEBUG_FS.patch
Content-Disposition: attachment;
	filename="0001-PM-debug-Fix-warning-when-no-CONFIG_DEBUG_FS.patch";
	size=1131; creation-date="Thu, 14 Jan 2010 11:04:39 GMT";
	modification-date="Thu, 14 Jan 2010 11:04:39 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlYzNmMDRlYzhjZjQ4NTFmY2ViMjQ5YWNmODMyNzU1YjdhYWQxNzY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gQWd1aXJyZSA8c2FhZ3VpcnJlQHRpLmNvbT4KRGF0
ZTogVGh1LCAxNCBKYW4gMjAxMCAxMTowMToxNSAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIFBNIGRl
YnVnOiBGaXggd2FybmluZyB3aGVuIG5vIENPTkZJR19ERUJVR19GUwoKRml4IGZvbGxvd2luZyB3
YXJuaW5nIHdoZW4gQ09ORklHX0RFQlVHX0ZTIHdhc24ndCBzZWxlY3RlZDoKCmFyY2gvYXJtL21h
Y2gtb21hcDIvcG0tZGVidWcuYzo1Nzogd2FybmluZzogJ3BtX2RiZ19pbml0JyBkZWNsYXJlZCAn
c3RhdGljJyBidXQgbmV2ZXIgZGVmaW5lZAoKU2lnbmVkLW9mZi1ieTogU2VyZ2lvIEFndWlycmUg
PHNhYWd1aXJyZUB0aS5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9wbS1kZWJ1Zy5jIHwg
ICAgNCArKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL3BtLWRlYnVnLmMgYi9hcmNoL2Fy
bS9tYWNoLW9tYXAyL3BtLWRlYnVnLmMKaW5kZXggODYwYjc1NS4uOTcyNzQ4NCAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9wbS1kZWJ1Zy5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21h
cDIvcG0tZGVidWcuYwpAQCAtNTQsOCArNTQsNiBAQCBpbnQgb21hcDJfcG1fZGVidWc7CiAJcmVn
c1tyZWdfY291bnQrK10udmFsID0gXAogCQkJIF9fcmF3X3JlYWRsKE9NQVAyX0w0X0lPX0FERFJF
U1MoMHg0ODBmZTAwMCArIChvZmYpKSkKIAotc3RhdGljIGludCBfX2luaXQgcG1fZGJnX2luaXQo
dm9pZCk7Ci0KIHZvaWQgb21hcDJfcG1fZHVtcChpbnQgbW9kZSwgaW50IHJlc3VtZSwgdW5zaWdu
ZWQgaW50IHVzKQogewogCXN0cnVjdCByZWcgewpAQCAtMTY3LDYgKzE2NSw4IEBAIHN0cnVjdCBk
ZW50cnkgKnBtX2RiZ19kaXI7CiAKIHN0YXRpYyBpbnQgcG1fZGJnX2luaXRfZG9uZTsKIAorc3Rh
dGljIGludCBfX2luaXQgcG1fZGJnX2luaXQodm9pZCk7CisKIGVudW0gewogCURFQlVHX0ZJTEVf
Q09VTlRFUlMgPSAwLAogCURFQlVHX0ZJTEVfVElNRVJTLAotLSAKMS42LjUuMwoK

--_002_A24693684029E5489D1D202277BE894451538FE7dlee02entticom_--
