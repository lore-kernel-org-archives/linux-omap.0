From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: [PATCH] omap2/3/4: serial: Half revert multiboot changes
Date: Wed, 24 Feb 2010 01:30:30 -0600
Message-ID: <A24693684029E5489D1D202277BE8944538C6D68@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE8944538C6D68dlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38546 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477Ab0BXHag (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Feb 2010 02:30:36 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

--_002_A24693684029E5489D1D202277BE8944538C6D68dlee02entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 14bc4ee14ac5a3dab79d9292bf22ab0401879cd5 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Wed, 24 Feb 2010 01:15:55 -0600
Subject: [PATCH] omap2/3/4: serial: Half revert multiboot changes

The patch named:
  "omap2/3/4: Fix mach-omap2/serial.c for multiboot"

Which added UART4 init also for 36xx based boards, broke zoom3
booting. External UART must be correctly initialized already
by board-zoom-debugboard.c file, therefore the addition on UART4
initialization can't be done blindly (i.e. board agnostic)

This patch removes the 36xx uart4 init for the above reason.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/serial.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b79bc89..fe3122b 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -115,7 +115,6 @@ static struct plat_serial8250_port serial_platform_data=
2[] =3D {
 	}
 };
=20
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct plat_serial8250_port serial_platform_data3[] =3D {
 	{
 		.irq		=3D 70,
@@ -132,11 +131,6 @@ static inline void omap2_set_globals_uart4(struct omap=
_globals *omap2_globals)
 {
 	serial_platform_data3[0].mapbase =3D omap2_globals->uart4_phys;
 }
-#else
-static inline void omap2_set_globals_uart4(struct omap_globals *omap2_glob=
als)
-{
-}
-#endif
=20
 void __init omap2_set_globals_uart(struct omap_globals *omap2_globals)
 {
@@ -597,7 +591,7 @@ static struct omap_uart_state omap_uart[] =3D {
 			},
 		},
 	},
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP4
 	{
 		.pdev =3D {
 			.name			=3D "serial8250",
@@ -764,7 +758,7 @@ void __init omap_serial_init(void)
 {
 	int i, nr_ports;
=20
-	if (!(cpu_is_omap3630() || cpu_is_omap4430()))
+	if (!cpu_is_omap4430())
 		nr_ports =3D 3;
 	else
 		nr_ports =3D ARRAY_SIZE(omap_uart);
--=20
1.6.3.3


--_002_A24693684029E5489D1D202277BE8944538C6D68dlee02entticom_
Content-Type: application/octet-stream;
	name="0001-omap2-3-4-serial-Half-revert-multiboot-changes.patch"
Content-Description: 0001-omap2-3-4-serial-Half-revert-multiboot-changes.patch
Content-Disposition: attachment;
	filename="0001-omap2-3-4-serial-Half-revert-multiboot-changes.patch";
	size=1954; creation-date="Wed, 24 Feb 2010 01:27:55 GMT";
	modification-date="Wed, 24 Feb 2010 01:27:55 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxNGJjNGVlMTRhYzVhM2RhYjc5ZDkyOTJiZjIyYWIwNDAxODc5Y2Q1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gQWd1aXJyZSA8c2FhZ3VpcnJlQHRpLmNvbT4KRGF0
ZTogV2VkLCAyNCBGZWIgMjAxMCAwMToxNTo1NSAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIG9tYXAy
LzMvNDogc2VyaWFsOiBIYWxmIHJldmVydCBtdWx0aWJvb3QgY2hhbmdlcwoKVGhlIHBhdGNoIG5h
bWVkOgogICJvbWFwMi8zLzQ6IEZpeCBtYWNoLW9tYXAyL3NlcmlhbC5jIGZvciBtdWx0aWJvb3Qi
CgpXaGljaCBhZGRlZCBVQVJUNCBpbml0IGFsc28gZm9yIDM2eHggYmFzZWQgYm9hcmRzLCBicm9r
ZSB6b29tMwpib290aW5nLiBFeHRlcm5hbCBVQVJUIG11c3QgYmUgY29ycmVjdGx5IGluaXRpYWxp
emVkIGFscmVhZHkKYnkgYm9hcmQtem9vbS1kZWJ1Z2JvYXJkLmMgZmlsZSwgdGhlcmVmb3JlIHRo
ZSBhZGRpdGlvbiBvbiBVQVJUNAppbml0aWFsaXphdGlvbiBjYW4ndCBiZSBkb25lIGJsaW5kbHkg
KGkuZS4gYm9hcmQgYWdub3N0aWMpCgpUaGlzIHBhdGNoIHJlbW92ZXMgdGhlIDM2eHggdWFydDQg
aW5pdCBmb3IgdGhlIGFib3ZlIHJlYXNvbi4KClNpZ25lZC1vZmYtYnk6IFNlcmdpbyBBZ3VpcnJl
IDxzYWFndWlycmVAdGkuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvc2VyaWFsLmMgfCAg
IDEwICsrLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvc2VyaWFsLmMgYi9hcmNo
L2FybS9tYWNoLW9tYXAyL3NlcmlhbC5jCmluZGV4IGI3OWJjODkuLmZlMzEyMmIgMTAwNjQ0Ci0t
LSBhL2FyY2gvYXJtL21hY2gtb21hcDIvc2VyaWFsLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9zZXJpYWwuYwpAQCAtMTE1LDcgKzExNSw2IEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdF9zZXJpYWw4
MjUwX3BvcnQgc2VyaWFsX3BsYXRmb3JtX2RhdGEyW10gPSB7CiAJfQogfTsKIAotI2lmIGRlZmlu
ZWQoQ09ORklHX0FSQ0hfT01BUDMpIHx8IGRlZmluZWQoQ09ORklHX0FSQ0hfT01BUDQpCiBzdGF0
aWMgc3RydWN0IHBsYXRfc2VyaWFsODI1MF9wb3J0IHNlcmlhbF9wbGF0Zm9ybV9kYXRhM1tdID0g
ewogCXsKIAkJLmlycQkJPSA3MCwKQEAgLTEzMiwxMSArMTMxLDYgQEAgc3RhdGljIGlubGluZSB2
b2lkIG9tYXAyX3NldF9nbG9iYWxzX3VhcnQ0KHN0cnVjdCBvbWFwX2dsb2JhbHMgKm9tYXAyX2ds
b2JhbHMpCiB7CiAJc2VyaWFsX3BsYXRmb3JtX2RhdGEzWzBdLm1hcGJhc2UgPSBvbWFwMl9nbG9i
YWxzLT51YXJ0NF9waHlzOwogfQotI2Vsc2UKLXN0YXRpYyBpbmxpbmUgdm9pZCBvbWFwMl9zZXRf
Z2xvYmFsc191YXJ0NChzdHJ1Y3Qgb21hcF9nbG9iYWxzICpvbWFwMl9nbG9iYWxzKQotewotfQot
I2VuZGlmCiAKIHZvaWQgX19pbml0IG9tYXAyX3NldF9nbG9iYWxzX3VhcnQoc3RydWN0IG9tYXBf
Z2xvYmFscyAqb21hcDJfZ2xvYmFscykKIHsKQEAgLTU5Nyw3ICs1OTEsNyBAQCBzdGF0aWMgc3Ry
dWN0IG9tYXBfdWFydF9zdGF0ZSBvbWFwX3VhcnRbXSA9IHsKIAkJCX0sCiAJCX0sCiAJfSwKLSNp
ZiBkZWZpbmVkKENPTkZJR19BUkNIX09NQVAzKSB8fCBkZWZpbmVkKENPTkZJR19BUkNIX09NQVA0
KQorI2lmZGVmIENPTkZJR19BUkNIX09NQVA0CiAJewogCQkucGRldiA9IHsKIAkJCS5uYW1lCQkJ
PSAic2VyaWFsODI1MCIsCkBAIC03NjQsNyArNzU4LDcgQEAgdm9pZCBfX2luaXQgb21hcF9zZXJp
YWxfaW5pdCh2b2lkKQogewogCWludCBpLCBucl9wb3J0czsKIAotCWlmICghKGNwdV9pc19vbWFw
MzYzMCgpIHx8IGNwdV9pc19vbWFwNDQzMCgpKSkKKwlpZiAoIWNwdV9pc19vbWFwNDQzMCgpKQog
CQlucl9wb3J0cyA9IDM7CiAJZWxzZQogCQlucl9wb3J0cyA9IEFSUkFZX1NJWkUob21hcF91YXJ0
KTsKLS0gCjEuNi4zLjMKCg==

--_002_A24693684029E5489D1D202277BE8944538C6D68dlee02entticom_--
