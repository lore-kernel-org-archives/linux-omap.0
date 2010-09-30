From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Thu, 30 Sep 2010 13:25:28 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CD02FA6@dbde02.ent.ti.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
 <20100928201844.GI3117@atomide.com> <87tyl8rxwp.fsf@deeprootsystems.com>
 <20100930021819.GD3117@atomide.com> <20100930022937.GF3117@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_EAF47CD23C76F840A9E7FCE10091EFAB030CD02FA6dbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50507 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755152Ab0I3Hzf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 03:55:35 -0400
In-Reply-To: <20100930022937.GF3117@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

--_002_EAF47CD23C76F840A9E7FCE10091EFAB030CD02FA6dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, September 30, 2010 8:00 AM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; Varadarajan, Charulatha; Nayak, Rajendra;
> Raja, Govindraj; Kevin Hilman
> Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions:
> watchdog, UART, i2c
>=20
> * Tony Lindgren <tony@atomide.com> [100929 19:10]:
> >
> > Then trying to build for omap1 OSK fails with:
> >
> > In file included from arch/arm/plat-omap/common.c:35:
> > arch/arm/plat-omap/include/plat/control.h:20:40: error:
> mach/ctrl_module_core_44xx.h: No such file or directory
> > arch/arm/plat-omap/include/plat/control.h:21:40: error:
> mach/ctrl_module_wkup_44xx.h: No such file or directory
> > arch/arm/plat-omap/include/plat/control.h:22:44: error:
> mach/ctrl_module_pad_core_44xx.h: No such file or directory
> > arch/arm/plat-omap/include/plat/control.h:23:44: error:
> mach/ctrl_module_pad_wkup_44xx.h: No such file or directory
>=20
> This seems to be related to Santosh' commit 802edcb7.
>
:(
=20
> Santosh, can you do a patch to fix this against the current
> omap-for-linus branch?
>
Below is the patch(also attached)which fixes the OMAP1 build issue.
---------
>From c06e887f402ceff03e6c28bb377bcbfe35318719 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 30 Sep 2010 12:23:07 +0530
Subject: [PATCH] omap: control: Fix the omap1 build break

The commit 802edcb7 broke the omap1 build

In file included from arch/arm/plat-omap/common.c:35:
arch/arm/plat-omap/include/plat/control.h:20:
fatal error: mach/ctrl_module_core_44xx.h: No such file or directory
compilation terminated.
make[1]: *** [arch/arm/plat-omap/common.o] Error 1
make: *** [arch/arm/plat-omap] Error 2

Fix it by creating the headers needed for compiling under
mach-omap1/include/mach and mach-omap2/include/mach.
Also move omap4 specific headers under mach-omap2/control.h

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap1/include/mach/control.h |    3 +++
 arch/arm/mach-omap2/include/mach/control.h |    8 ++++++++
 arch/arm/plat-omap/include/plat/control.h  |    5 +----
 3 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/control.h
 create mode 100644 arch/arm/mach-omap2/include/mach/control.h

diff --git a/arch/arm/mach-omap1/include/mach/control.h b/arch/arm/mach-oma=
p1/include/mach/control.h
new file mode 100644
index 0000000..c1fd4c0
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/control.h
@@ -0,0 +1,3 @@
+/*
+ * arch/arm/mach-omap1/include/mach/control.h
+ */
diff --git a/arch/arm/mach-omap2/include/mach/control.h b/arch/arm/mach-oma=
p2/include/mach/control.h
new file mode 100644
index 0000000..dd41272
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/control.h
@@ -0,0 +1,8 @@
+/*
+ * arch/arm/mach-omap2/include/mach/control.h
+ */
+#include <mach/ctrl_module_core_44xx.h>
+#include <mach/ctrl_module_wkup_44xx.h>
+#include <mach/ctrl_module_pad_core_44xx.h>
+#include <mach/ctrl_module_pad_wkup_44xx.h>
+
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap=
/include/plat/control.h
index 19c9b2a..7b047e5 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -17,10 +17,7 @@
 #define __ASM_ARCH_CONTROL_H
=20
 #include <mach/io.h>
-#include <mach/ctrl_module_core_44xx.h>
-#include <mach/ctrl_module_wkup_44xx.h>
-#include <mach/ctrl_module_pad_core_44xx.h>
-#include <mach/ctrl_module_pad_wkup_44xx.h>
+#include <mach/control.h>
=20
 #ifndef __ASSEMBLY__
 #define OMAP242X_CTRL_REGADDR(reg)					\
--=20
1.6.0.4

=20


--_002_EAF47CD23C76F840A9E7FCE10091EFAB030CD02FA6dbde02enttico_
Content-Type: application/octet-stream;
	name="0001-omap-control-Fix-the-omap1-build-break.patch"
Content-Description: 0001-omap-control-Fix-the-omap1-build-break.patch
Content-Disposition: attachment;
	filename="0001-omap-control-Fix-the-omap1-build-break.patch"; size=2442;
	creation-date="Thu, 30 Sep 2010 12:41:07 GMT";
	modification-date="Thu, 30 Sep 2010 12:41:07 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjMDZlODg3ZjQwMmNlZmYwM2U2YzI4YmIzNzdiY2JmZTM1MzE4NzE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBUaHUsIDMwIFNlcCAyMDEwIDEyOjIzOjA3ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gb21hcDogY29udHJvbDogRml4IHRoZSBvbWFwMSBidWlsZCBicmVhawoKVGhlIGNvbW1p
dCA4MDJlZGNiNyBicm9rZSB0aGUgb21hcDEgYnVpbGQKCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBh
cmNoL2FybS9wbGF0LW9tYXAvY29tbW9uLmM6MzU6CmFyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRl
L3BsYXQvY29udHJvbC5oOjIwOgpmYXRhbCBlcnJvcjogbWFjaC9jdHJsX21vZHVsZV9jb3JlXzQ0
eHguaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLgpt
YWtlWzFdOiAqKiogW2FyY2gvYXJtL3BsYXQtb21hcC9jb21tb24ub10gRXJyb3IgMQptYWtlOiAq
KiogW2FyY2gvYXJtL3BsYXQtb21hcF0gRXJyb3IgMgoKRml4IGl0IGJ5IGNyZWF0aW5nIHRoZSBo
ZWFkZXJzIG5lZWRlZCBmb3IgY29tcGlsaW5nIHVuZGVyCm1hY2gtb21hcDEvaW5jbHVkZS9tYWNo
IGFuZCBtYWNoLW9tYXAyL2luY2x1ZGUvbWFjaC4KQWxzbyBtb3ZlIG9tYXA0IHNwZWNpZmljIGhl
YWRlcnMgdW5kZXIgbWFjaC1vbWFwMi9jb250cm9sLmgKClNpZ25lZC1vZmYtYnk6IFNhbnRvc2gg
U2hpbGlta2FyIDxzYW50b3NoLnNoaWxpbWthckB0aS5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1v
bWFwMS9pbmNsdWRlL21hY2gvY29udHJvbC5oIHwgICAgMyArKysKIGFyY2gvYXJtL21hY2gtb21h
cDIvaW5jbHVkZS9tYWNoL2NvbnRyb2wuaCB8ICAgIDggKysrKysrKysKIGFyY2gvYXJtL3BsYXQt
b21hcC9pbmNsdWRlL3BsYXQvY29udHJvbC5oICB8ICAgIDUgKy0tLS0KIDMgZmlsZXMgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBh
cmNoL2FybS9tYWNoLW9tYXAxL2luY2x1ZGUvbWFjaC9jb250cm9sLmgKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBhcmNoL2FybS9tYWNoLW9tYXAyL2luY2x1ZGUvbWFjaC9jb250cm9sLmgKCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9tYWNoLW9tYXAxL2luY2x1ZGUvbWFjaC9jb250cm9sLmggYi9hcmNoL2Fy
bS9tYWNoLW9tYXAxL2luY2x1ZGUvbWFjaC9jb250cm9sLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMC4uYzFmZDRjMAotLS0gL2Rldi9udWxsCisrKyBiL2FyY2gvYXJtL21hY2gt
b21hcDEvaW5jbHVkZS9tYWNoL2NvbnRyb2wuaApAQCAtMCwwICsxLDMgQEAKKy8qCisgKiBhcmNo
L2FybS9tYWNoLW9tYXAxL2luY2x1ZGUvbWFjaC9jb250cm9sLmgKKyAqLwpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vbWFjaC1vbWFwMi9pbmNsdWRlL21hY2gvY29udHJvbC5oIGIvYXJjaC9hcm0vbWFj
aC1vbWFwMi9pbmNsdWRlL21hY2gvY29udHJvbC5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4
IDAwMDAwMDAuLmRkNDEyNzIKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL2FybS9tYWNoLW9tYXAy
L2luY2x1ZGUvbWFjaC9jb250cm9sLmgKQEAgLTAsMCArMSw4IEBACisvKgorICogYXJjaC9hcm0v
bWFjaC1vbWFwMi9pbmNsdWRlL21hY2gvY29udHJvbC5oCisgKi8KKyNpbmNsdWRlIDxtYWNoL2N0
cmxfbW9kdWxlX2NvcmVfNDR4eC5oPgorI2luY2x1ZGUgPG1hY2gvY3RybF9tb2R1bGVfd2t1cF80
NHh4Lmg+CisjaW5jbHVkZSA8bWFjaC9jdHJsX21vZHVsZV9wYWRfY29yZV80NHh4Lmg+CisjaW5j
bHVkZSA8bWFjaC9jdHJsX21vZHVsZV9wYWRfd2t1cF80NHh4Lmg+CisKZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvY29udHJvbC5oIGIvYXJjaC9hcm0vcGxhdC1v
bWFwL2luY2x1ZGUvcGxhdC9jb250cm9sLmgKaW5kZXggMTljOWIyYS4uN2IwNDdlNSAxMDA2NDQK
LS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9jb250cm9sLmgKKysrIGIvYXJj
aC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9jb250cm9sLmgKQEAgLTE3LDEwICsxNyw3IEBA
CiAjZGVmaW5lIF9fQVNNX0FSQ0hfQ09OVFJPTF9ICiAKICNpbmNsdWRlIDxtYWNoL2lvLmg+Ci0j
aW5jbHVkZSA8bWFjaC9jdHJsX21vZHVsZV9jb3JlXzQ0eHguaD4KLSNpbmNsdWRlIDxtYWNoL2N0
cmxfbW9kdWxlX3drdXBfNDR4eC5oPgotI2luY2x1ZGUgPG1hY2gvY3RybF9tb2R1bGVfcGFkX2Nv
cmVfNDR4eC5oPgotI2luY2x1ZGUgPG1hY2gvY3RybF9tb2R1bGVfcGFkX3drdXBfNDR4eC5oPgor
I2luY2x1ZGUgPG1hY2gvY29udHJvbC5oPgogCiAjaWZuZGVmIF9fQVNTRU1CTFlfXwogI2RlZmlu
ZSBPTUFQMjQyWF9DVFJMX1JFR0FERFIocmVnKQkJCQkJXAotLSAKMS42LjAuNAoK

--_002_EAF47CD23C76F840A9E7FCE10091EFAB030CD02FA6dbde02enttico_--
