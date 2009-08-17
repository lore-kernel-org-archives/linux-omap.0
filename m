From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH][PM] ARM: OMAP34xx: Fix compilation warning
Date: Mon, 17 Aug 2009 09:46:17 -0500
Message-ID: <A24693684029E5489D1D202277BE89444A81FBB9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE89444A81FBB9dlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52645 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406AbZHQOmW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Aug 2009 10:42:22 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

--_002_A24693684029E5489D1D202277BE89444A81FBB9dlee02entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: Sergio Aguirre <saaguirre@ti.com>

This fixes the following compilation warnings:

In file included from arch/arm/mach-omap2/resource34xx.c:26:
arch/arm/mach-omap2/resource34xx.h:32: warning: function declaration isn't =
a prototype
arch/arm/mach-omap2/resource34xx.h:33: warning: function declaration isn't =
a prototype

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/resource34xx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.h b/arch/arm/mach-omap2/resou=
rce34xx.h
index 5b5618a..3c70eef 100644
--- a/arch/arm/mach-omap2/resource34xx.h
+++ b/arch/arm/mach-omap2/resource34xx.h
@@ -29,8 +29,8 @@
 #include <mach/omap34xx.h>
=20
 extern int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_=
vsel);
-extern void lock_scratchpad_sem();
-extern void unlock_scratchpad_sem();
+extern void lock_scratchpad_sem(void);
+extern void unlock_scratchpad_sem(void);
=20
 /*
  * mpu_latency/core_latency are used to control the cpuidle C state.
--=20
1.6.3.2


--_002_A24693684029E5489D1D202277BE89444A81FBB9dlee02entticom_
Content-Type: application/octet-stream;
	name="0002-ARM-OMAP34xx-Fix-compilation-warning.patch"
Content-Description: 0002-ARM-OMAP34xx-Fix-compilation-warning.patch
Content-Disposition: attachment;
	filename="0002-ARM-OMAP34xx-Fix-compilation-warning.patch"; size=1214;
	creation-date="Mon, 17 Aug 2009 09:43:06 GMT";
	modification-date="Mon, 17 Aug 2009 09:43:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmOTU4Y2NjMmQyMWQ5ODhiMzVhOGNhMmM1YTI4Y2VlZjY2NmYyNTVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gQWd1aXJyZSA8c2FhZ3VpcnJlQHRpLmNvbT4KRGF0
ZTogV2VkLCAxMiBBdWcgMjAwOSAxMjo1MzoyNiAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFSTTog
T01BUDM0eHg6IEZpeCBjb21waWxhdGlvbiB3YXJuaW5nCgpUaGlzIGZpeGVzIHRoZSBmb2xsb3dp
bmcgY29tcGlsYXRpb24gd2FybmluZ3M6CgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gYXJjaC9hcm0v
bWFjaC1vbWFwMi9yZXNvdXJjZTM0eHguYzoyNjoKYXJjaC9hcm0vbWFjaC1vbWFwMi9yZXNvdXJj
ZTM0eHguaDozMjogd2FybmluZzogZnVuY3Rpb24gZGVjbGFyYXRpb24gaXNuJ3QgYSBwcm90b3R5
cGUKYXJjaC9hcm0vbWFjaC1vbWFwMi9yZXNvdXJjZTM0eHguaDozMzogd2FybmluZzogZnVuY3Rp
b24gZGVjbGFyYXRpb24gaXNuJ3QgYSBwcm90b3R5cGUKClNpZ25lZC1vZmYtYnk6IFNlcmdpbyBB
Z3VpcnJlIDxzYWFndWlycmVAdGkuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvcmVzb3Vy
Y2UzNHh4LmggfCAgICA0ICsrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvcmVzb3VyY2Uz
NHh4LmggYi9hcmNoL2FybS9tYWNoLW9tYXAyL3Jlc291cmNlMzR4eC5oCmluZGV4IDViNTYxOGEu
LjNjNzBlZWYgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvcmVzb3VyY2UzNHh4LmgK
KysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9yZXNvdXJjZTM0eHguaApAQCAtMjksOCArMjksOCBA
QAogI2luY2x1ZGUgPG1hY2gvb21hcDM0eHguaD4KIAogZXh0ZXJuIGludCBzcl92b2x0YWdlc2Nh
bGVfdmNieXBhc3ModTMyIHRfb3BwLCB1MzIgY19vcHAsIHU4IHRfdnNlbCwgdTggY192c2VsKTsK
LWV4dGVybiB2b2lkIGxvY2tfc2NyYXRjaHBhZF9zZW0oKTsKLWV4dGVybiB2b2lkIHVubG9ja19z
Y3JhdGNocGFkX3NlbSgpOworZXh0ZXJuIHZvaWQgbG9ja19zY3JhdGNocGFkX3NlbSh2b2lkKTsK
K2V4dGVybiB2b2lkIHVubG9ja19zY3JhdGNocGFkX3NlbSh2b2lkKTsKIAogLyoKICAqIG1wdV9s
YXRlbmN5L2NvcmVfbGF0ZW5jeSBhcmUgdXNlZCB0byBjb250cm9sIHRoZSBjcHVpZGxlIEMgc3Rh
dGUuCi0tIAoxLjYuMy4yCgo=

--_002_A24693684029E5489D1D202277BE89444A81FBB9dlee02entticom_--
