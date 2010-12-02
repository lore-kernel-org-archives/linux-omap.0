From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH v2 0/5] Split powerdomain framework into plat specific/independent
Date: Thu, 2 Dec 2010 18:05:45 +0530
Message-ID: <699e6818fd0b2162302926a3c724749f@mail.gmail.com>
References: <1291131848-31640-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1012011254460.2515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016363101e540655e04966ca9d6
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34876 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757253Ab0LBMfr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 07:35:47 -0500
Received: by mail-qy0-f182.google.com with SMTP id 36so5596288qyk.20
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 04:35:47 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012011254460.2515@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>

--0016363101e540655e04966ca9d6
Content-Type: text/plain; charset=ISO-8859-1

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, December 02, 2010 1:39 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com;
b-cousson@ti.com
> Subject: Re: [PATCH v2 0/5] Split powerdomain framework into plat
specific/independent
>
>
> Hi,
>
> thanks for making the requested changes.  However, this series results
in
> compilation warnings:

Sorry about that, my bad. Should have caught those before
posting the series :(

>
>   CC      arch/arm/mach-omap2/powerdomain2xxx_3xxx.o
> arch/arm/mach-omap2/powerdomains.h:116: warning: 'powerdomains_omap'
> defined but not used
>   CC      arch/arm/mach-omap2/powerdomain44xx.o
> arch/arm/mach-omap2/powerdomains.h:116: warning: 'powerdomains_omap'
> defined but not used

This seems to be popping up with powerdomains.h file (which now
has func declarations) being included in multiple source files. It earlier
had only static structs and was included in one source file.

I thought the right way to fix this was to probably move the static
structs from the header into a source file.
See if the below patch makes sense. Also attached as I don't trust
my mailer.

>From 130363d172d6c6821f48b1a4fa93c512eb18e0ef Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@t.com>
Date: Thu, 2 Dec 2010 17:26:13 +0530
Subject: [PATCH] OMAP: powerdomain: Move static structs out of
powerdomains.h header

powerdomains.h header today has only static struct
definitions. Adding any function declarations into
it and including it in multiple source file is
expected to cause issues.
Hence move the powerdomains.h file into
powerdomains_data.c file.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |    2 +-
 arch/arm/mach-omap2/clockdomains.h                 |    5 +++++
 arch/arm/mach-omap2/io.c                           |    3 +--
 .../{powerdomains.h => powerdomains_data.c}        |   10 +++++-----
 arch/arm/plat-omap/include/plat/powerdomain.h      |    1 +
 5 files changed, 13 insertions(+), 8 deletions(-)
 rename arch/arm/mach-omap2/{powerdomains.h => powerdomains_data.c} (97%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 60e51bc..5e20bc5 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -9,7 +9,7 @@ obj-y := id.o io.o control.o mux.o devices.o serial.o
gpmc.o timer-gp.o pm.o \
 omap-2-3-common				= irq.o sdrc.o
prm2xxx_3xxx.o
 hwmod-common				= omap_hwmod.o \
 					  omap_hwmod_common_data.o
-prcm-common				= prcm.o powerdomain.o
+prcm-common				= prcm.o powerdomain.o
powerdomains_data.o
 clock-common				= clock.o clock_common_data.o \
 					  clockdomain.o clkt_dpll.o \
 					  clkt_clksel.o
diff --git a/arch/arm/mach-omap2/clockdomains.h
b/arch/arm/mach-omap2/clockdomains.h
index 8fc19ff..2a3b10a 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -38,6 +38,11 @@
 #include <plat/clockdomain.h>
 #include "cm.h"
 #include "prm.h"
+#include "cm-regbits-24xx.h"
+#include "cm-regbits-34xx.h"
+#include "cm-regbits-44xx.h"
+#include "prm-regbits-24xx.h"
+#include "prm-regbits-34xx.h"

 /*
  * Clockdomain dependencies for wkdeps/sleepdeps
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 40562dd..889999d 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -40,7 +40,6 @@

 #include <plat/omap-pm.h>
 #include <plat/powerdomain.h>
-#include "powerdomains.h"

 #include <plat/clockdomain.h>
 #include "clockdomains.h"
@@ -316,7 +315,7 @@ void __init omap2_init_common_hw(struct
omap_sdrc_params *sdrc_cs0,
 {
 	u8 skip_setup_idle = 0;

-	pwrdm_init(powerdomains_omap);
+	pwrdm_initialise();
 	clkdm_init(clockdomains_omap, clkdm_autodeps);
 	if (cpu_is_omap242x())
 		omap2420_hwmod_init();
diff --git a/arch/arm/mach-omap2/powerdomains.h
b/arch/arm/mach-omap2/powerdomains_data.c
similarity index 97%
rename from arch/arm/mach-omap2/powerdomains.h
rename to arch/arm/mach-omap2/powerdomains_data.c
index 105cbca..dc6b7f8 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains_data.c
@@ -18,9 +18,6 @@
  *    Clock Domain Framework
  */

-#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS
-#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS
-
 /*
  * This file contains all of the powerdomains that have some element
  * of software control for the OMAP24xx and OMAP34xx chips.
@@ -49,6 +46,7 @@
  * address offset is different between the C55 and C64 DSPs.
  */

+#include <linux/init.h>
 #include <plat/powerdomain.h>

 #include "prcm-common.h"
@@ -149,5 +147,7 @@ static struct powerdomain *powerdomains_omap[]
__initdata = {
 	NULL
 };

-
-#endif
+void pwrdm_initialise(void)
+{
+	pwrdm_init(powerdomains_omap);
+}
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h
b/arch/arm/plat-omap/include/plat/powerdomain.h
index 9ca420d..5e96793 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -118,6 +118,7 @@ struct powerdomain {
 };


+void pwrdm_initialise(void);
 void pwrdm_init(struct powerdomain **pwrdm_list);

 struct powerdomain *pwrdm_lookup(const char *name);
-- 
1.7.0.4

--0016363101e540655e04966ca9d6
Content-Type: application/octet-stream;
	name="0001-OMAP-powerdomain-Move-static-structs-out-of-powerdom.patch"
Content-Disposition: attachment;
	filename="0001-OMAP-powerdomain-Move-static-structs-out-of-powerdom.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f15468946a78ecba_0.1

RnJvbSAxMzAzNjNkMTcyZDZjNjgyMWY0OGIxYTRmYTkzYzUxMmViMThlMGVmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWplbmRyYSBOYXlhayA8cm5heWFrQHQuY29tPgpEYXRlOiBU
aHUsIDIgRGVjIDIwMTAgMTc6MjY6MTMgKzA1MzAKU3ViamVjdDogW1BBVENIXSBPTUFQOiBwb3dl
cmRvbWFpbjogTW92ZSBzdGF0aWMgc3RydWN0cyBvdXQgb2YgcG93ZXJkb21haW5zLmggaGVhZGVy
Cgpwb3dlcmRvbWFpbnMuaCBoZWFkZXIgdG9kYXkgaGFzIG9ubHkgc3RhdGljIHN0cnVjdApkZWZp
bml0aW9ucy4gQWRkaW5nIGFueSBmdW5jdGlvbiBkZWNsYXJhdGlvbnMgaW50bwppdCBhbmQgaW5j
bHVkaW5nIGl0IGluIG11bHRpcGxlIHNvdXJjZSBmaWxlIGlzCmV4cGVjdGVkIHRvIGNhdXNlIGlz
c3Vlcy4KSGVuY2UgbW92ZSB0aGUgcG93ZXJkb21haW5zLmggZmlsZSBpbnRvCnBvd2VyZG9tYWlu
c19kYXRhLmMgZmlsZS4KClNpZ25lZC1vZmYtYnk6IFJhamVuZHJhIE5heWFrIDxybmF5YWtAdGku
Y29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgMiArLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9jbG9ja2RvbWFpbnMuaCAgICAgICAg
ICAgICAgICAgfCAgICA1ICsrKysrCiBhcmNoL2FybS9tYWNoLW9tYXAyL2lvLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgIDMgKy0tCiAuLi4ve3Bvd2VyZG9tYWlucy5oID0+IHBvd2Vy
ZG9tYWluc19kYXRhLmN9ICAgICAgICB8ICAgMTAgKysrKystLS0tLQogYXJjaC9hcm0vcGxhdC1v
bWFwL2luY2x1ZGUvcGxhdC9wb3dlcmRvbWFpbi5oICAgICAgfCAgICAxICsKIDUgZmlsZXMgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKIHJlbmFtZSBhcmNoL2FybS9t
YWNoLW9tYXAyL3twb3dlcmRvbWFpbnMuaCA9PiBwb3dlcmRvbWFpbnNfZGF0YS5jfSAoOTclKQoK
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUgYi9hcmNoL2FybS9tYWNo
LW9tYXAyL01ha2VmaWxlCmluZGV4IDYwZTUxYmMuLjVlMjBiYzUgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtL21hY2gtb21hcDIvTWFrZWZpbGUKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9NYWtlZmls
ZQpAQCAtOSw3ICs5LDcgQEAgb2JqLXkgOj0gaWQubyBpby5vIGNvbnRyb2wubyBtdXgubyBkZXZp
Y2VzLm8gc2VyaWFsLm8gZ3BtYy5vIHRpbWVyLWdwLm8gcG0ubyBcCiBvbWFwLTItMy1jb21tb24J
CQkJPSBpcnEubyBzZHJjLm8gcHJtMnh4eF8zeHh4Lm8KIGh3bW9kLWNvbW1vbgkJCQk9IG9tYXBf
aHdtb2QubyBcCiAJCQkJCSAgb21hcF9od21vZF9jb21tb25fZGF0YS5vCi1wcmNtLWNvbW1vbgkJ
CQk9IHByY20ubyBwb3dlcmRvbWFpbi5vCitwcmNtLWNvbW1vbgkJCQk9IHByY20ubyBwb3dlcmRv
bWFpbi5vIHBvd2VyZG9tYWluc19kYXRhLm8KIGNsb2NrLWNvbW1vbgkJCQk9IGNsb2NrLm8gY2xv
Y2tfY29tbW9uX2RhdGEubyBcCiAJCQkJCSAgY2xvY2tkb21haW4ubyBjbGt0X2RwbGwubyBcCiAJ
CQkJCSAgY2xrdF9jbGtzZWwubwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9jbG9j
a2RvbWFpbnMuaCBiL2FyY2gvYXJtL21hY2gtb21hcDIvY2xvY2tkb21haW5zLmgKaW5kZXggOGZj
MTlmZi4uMmEzYjEwYSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9jbG9ja2RvbWFp
bnMuaAorKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2Nsb2NrZG9tYWlucy5oCkBAIC0zOCw2ICsz
OCwxMSBAQAogI2luY2x1ZGUgPHBsYXQvY2xvY2tkb21haW4uaD4KICNpbmNsdWRlICJjbS5oIgog
I2luY2x1ZGUgInBybS5oIgorI2luY2x1ZGUgImNtLXJlZ2JpdHMtMjR4eC5oIgorI2luY2x1ZGUg
ImNtLXJlZ2JpdHMtMzR4eC5oIgorI2luY2x1ZGUgImNtLXJlZ2JpdHMtNDR4eC5oIgorI2luY2x1
ZGUgInBybS1yZWdiaXRzLTI0eHguaCIKKyNpbmNsdWRlICJwcm0tcmVnYml0cy0zNHh4LmgiCiAK
IC8qCiAgKiBDbG9ja2RvbWFpbiBkZXBlbmRlbmNpZXMgZm9yIHdrZGVwcy9zbGVlcGRlcHMKZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvaW8uYyBiL2FyY2gvYXJtL21hY2gtb21hcDIv
aW8uYwppbmRleCA0MDU2MmRkLi44ODk5OTlkIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9t
YXAyL2lvLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9pby5jCkBAIC00MCw3ICs0MCw2IEBA
CiAKICNpbmNsdWRlIDxwbGF0L29tYXAtcG0uaD4KICNpbmNsdWRlIDxwbGF0L3Bvd2VyZG9tYWlu
Lmg+Ci0jaW5jbHVkZSAicG93ZXJkb21haW5zLmgiCiAKICNpbmNsdWRlIDxwbGF0L2Nsb2NrZG9t
YWluLmg+CiAjaW5jbHVkZSAiY2xvY2tkb21haW5zLmgiCkBAIC0zMTYsNyArMzE1LDcgQEAgdm9p
ZCBfX2luaXQgb21hcDJfaW5pdF9jb21tb25faHcoc3RydWN0IG9tYXBfc2RyY19wYXJhbXMgKnNk
cmNfY3MwLAogewogCXU4IHNraXBfc2V0dXBfaWRsZSA9IDA7CiAKLQlwd3JkbV9pbml0KHBvd2Vy
ZG9tYWluc19vbWFwKTsKKwlwd3JkbV9pbml0aWFsaXNlKCk7CiAJY2xrZG1faW5pdChjbG9ja2Rv
bWFpbnNfb21hcCwgY2xrZG1fYXV0b2RlcHMpOwogCWlmIChjcHVfaXNfb21hcDI0MngoKSkKIAkJ
b21hcDI0MjBfaHdtb2RfaW5pdCgpOwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9w
b3dlcmRvbWFpbnMuaCBiL2FyY2gvYXJtL21hY2gtb21hcDIvcG93ZXJkb21haW5zX2RhdGEuYwpz
aW1pbGFyaXR5IGluZGV4IDk3JQpyZW5hbWUgZnJvbSBhcmNoL2FybS9tYWNoLW9tYXAyL3Bvd2Vy
ZG9tYWlucy5oCnJlbmFtZSB0byBhcmNoL2FybS9tYWNoLW9tYXAyL3Bvd2VyZG9tYWluc19kYXRh
LmMKaW5kZXggMTA1Y2JjYS4uZGM2YjdmOCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9wb3dlcmRvbWFpbnMuaAorKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3Bvd2VyZG9tYWluc19k
YXRhLmMKQEAgLTE4LDkgKzE4LDYgQEAKICAqICAgIENsb2NrIERvbWFpbiBGcmFtZXdvcmsKICAq
LwogCi0jaWZuZGVmIEFSQ0hfQVJNX01BQ0hfT01BUDJfUE9XRVJET01BSU5TCi0jZGVmaW5lIEFS
Q0hfQVJNX01BQ0hfT01BUDJfUE9XRVJET01BSU5TCi0KIC8qCiAgKiBUaGlzIGZpbGUgY29udGFp
bnMgYWxsIG9mIHRoZSBwb3dlcmRvbWFpbnMgdGhhdCBoYXZlIHNvbWUgZWxlbWVudAogICogb2Yg
c29mdHdhcmUgY29udHJvbCBmb3IgdGhlIE9NQVAyNHh4IGFuZCBPTUFQMzR4eCBjaGlwcy4KQEAg
LTQ5LDYgKzQ2LDcgQEAKICAqIGFkZHJlc3Mgb2Zmc2V0IGlzIGRpZmZlcmVudCBiZXR3ZWVuIHRo
ZSBDNTUgYW5kIEM2NCBEU1BzLgogICovCiAKKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CiAjaW5j
bHVkZSA8cGxhdC9wb3dlcmRvbWFpbi5oPgogCiAjaW5jbHVkZSAicHJjbS1jb21tb24uaCIKQEAg
LTE0OSw1ICsxNDcsNyBAQCBzdGF0aWMgc3RydWN0IHBvd2VyZG9tYWluICpwb3dlcmRvbWFpbnNf
b21hcFtdIF9faW5pdGRhdGEgPSB7CiAJTlVMTAogfTsKIAotCi0jZW5kaWYKK3ZvaWQgcHdyZG1f
aW5pdGlhbGlzZSh2b2lkKQoreworCXB3cmRtX2luaXQocG93ZXJkb21haW5zX29tYXApOworfQpk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9wb3dlcmRvbWFpbi5o
IGIvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9wb3dlcmRvbWFpbi5oCmluZGV4IDlj
YTQyMGQuLjVlOTY3OTMgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3Bs
YXQvcG93ZXJkb21haW4uaAorKysgYi9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L3Bv
d2VyZG9tYWluLmgKQEAgLTExOCw2ICsxMTgsNyBAQCBzdHJ1Y3QgcG93ZXJkb21haW4gewogfTsK
IAogCit2b2lkIHB3cmRtX2luaXRpYWxpc2Uodm9pZCk7CiB2b2lkIHB3cmRtX2luaXQoc3RydWN0
IHBvd2VyZG9tYWluICoqcHdyZG1fbGlzdCk7CiAKIHN0cnVjdCBwb3dlcmRvbWFpbiAqcHdyZG1f
bG9va3VwKGNvbnN0IGNoYXIgKm5hbWUpOwotLSAKMS43LjAuNAoK
--0016363101e540655e04966ca9d6--
