From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH 2/3] Adding basic compile support for OMAP2EVM
Date: Wed, 11 Jun 2008 16:04:54 +0530
Message-ID: <c656a4d20806110334l2ad4cda9n6a4ec5b7735f7a31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_20004_21477121.1213180494117"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.152]:30994 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbYFKKez (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 06:34:55 -0400
Received: by po-out-1718.google.com with SMTP id c31so5986433poi.1
        for <linux-omap@vger.kernel.org>; Wed, 11 Jun 2008 03:34:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

------=_Part_20004_21477121.1213180494117
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>From f24b517daecd23377d92c706bb28e218431d1887 Mon Sep 17 00:00:00 2001
From: arun <arunedarath@mistralsolutions.com>
Date: Wed, 11 Jun 2008 14:48:49 +0530
Subject: [PATCH] Adding basic compile support for OMAP2EVM


Signed-off-by: arun <arunedarath@mistralsolutions.com>
---
 arch/arm/configs/omap2_evm_defconfig |    2 +-
 arch/arm/mach-omap2/Kconfig          |    4 ++--
 arch/arm/mach-omap2/Makefile         |    2 +-
 include/asm-arm/arch-omap/hardware.h |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/omap2_evm_defconfig
b/arch/arm/configs/omap2_evm_defconfig
index 12a1298..38f37d9 100644
--- a/arch/arm/configs/omap2_evm_defconfig
+++ b/arch/arm/configs/omap2_evm_defconfig
@@ -181,7 +181,7 @@ CONFIG_ARCH_OMAP2430=y
 # CONFIG_MACH_OMAP_APOLLON is not set
 # CONFIG_MACH_OMAP_APOLLON_PLUS is not set
 # CONFIG_MACH_OMAP_2430SDP is not set
-CONFIG_MACH_OMAP_2430OSK=y
+CONFIG_MACH_OMAP2EVM=y

 #
 # Boot options
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ac9a7e1..072aded 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -102,8 +102,8 @@ config MACH_OMAP_LDP
 	bool "OMAP 3 LDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX

-config MACH_OMAP_2430OSK
-	bool "OMAP 2430 OSK board"
+config MACH_OMAP2EVM
+	bool "OMAP 2530 EVM board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX

 config MACH_OMAP_3430SDP
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 5a572b0..4d86f07 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
 					   hsmmc.o \
 					   usb-musb.o \
 					   usb-ehci.o
-obj-$(CONFIG_MACH_OMAP_2430OSK)		+= board-2430osk.o
+obj-$(CONFIG_MACH_OMAP2EVM)		+= board-omap2evm.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   hsmmc.o \
 					   usb-musb.o \
diff --git a/include/asm-arm/arch-omap/hardware.h
b/include/asm-arm/arch-omap/hardware.h
index 513a813..2d44590 100644
--- a/include/asm-arm/arch-omap/hardware.h
+++ b/include/asm-arm/arch-omap/hardware.h
@@ -326,8 +326,8 @@
 #include "board-2430sdp.h"
 #endif

-#ifdef CONFIG_MACH_OMAP_2430OSK
-#include "board-2430osk.h"
+#ifdef CONFIG_MACH_OMAP2EVM
+#include "board-omap2evm.h"
 #endif

 #ifdef CONFIG_MACH_OMAP_3430SDP
-- 
1.5.3.4

------=_Part_20004_21477121.1213180494117
Content-Type: text/x-patch;
 name=0002-Adding-basic-compile-support-for-OMAP2EVM.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhbq2mij0
Content-Disposition: attachment;
 filename=0002-Adding-basic-compile-support-for-OMAP2EVM.patch

RnJvbSBmMjRiNTE3ZGFlY2QyMzM3N2Q5MmM3MDZiYjI4ZTIxODQzMWQxODg3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBhcnVuIDxhcnVuZWRhcmF0aEBtaXN0cmFsc29sdXRpb25zLmNv
bT4KRGF0ZTogV2VkLCAxMSBKdW4gMjAwOCAxNDo0ODo0OSArMDUzMApTdWJqZWN0OiBbUEFUQ0hd
IEFkZGluZyBiYXNpYyBjb21waWxlIHN1cHBvcnQgZm9yIE9NQVAyRVZNCgoKU2lnbmVkLW9mZi1i
eTogYXJ1biA8YXJ1bmVkYXJhdGhAbWlzdHJhbHNvbHV0aW9ucy5jb20+Ci0tLQogYXJjaC9hcm0v
Y29uZmlncy9vbWFwMl9ldm1fZGVmY29uZmlnIHwgICAgMiArLQogYXJjaC9hcm0vbWFjaC1vbWFw
Mi9LY29uZmlnICAgICAgICAgIHwgICAgNCArKy0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL01ha2Vm
aWxlICAgICAgICAgfCAgICAyICstCiBpbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2hhcmR3YXJl
LmggfCAgICA0ICsrLS0KIDQgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2NvbmZpZ3Mvb21hcDJfZXZtX2RlZmNvbmZp
ZyBiL2FyY2gvYXJtL2NvbmZpZ3Mvb21hcDJfZXZtX2RlZmNvbmZpZwppbmRleCAxMmExMjk4Li4z
OGYzN2Q5IDEwMDY0NAotLS0gYS9hcmNoL2FybS9jb25maWdzL29tYXAyX2V2bV9kZWZjb25maWcK
KysrIGIvYXJjaC9hcm0vY29uZmlncy9vbWFwMl9ldm1fZGVmY29uZmlnCkBAIC0xODEsNyArMTgx
LDcgQEAgQ09ORklHX0FSQ0hfT01BUDI0MzA9eQogIyBDT05GSUdfTUFDSF9PTUFQX0FQT0xMT04g
aXMgbm90IHNldAogIyBDT05GSUdfTUFDSF9PTUFQX0FQT0xMT05fUExVUyBpcyBub3Qgc2V0CiAj
IENPTkZJR19NQUNIX09NQVBfMjQzMFNEUCBpcyBub3Qgc2V0Ci1DT05GSUdfTUFDSF9PTUFQXzI0
MzBPU0s9eQorQ09ORklHX01BQ0hfT01BUDJFVk09eQogCiAjCiAjIEJvb3Qgb3B0aW9ucwpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9LY29uZmlnIGIvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9LY29uZmlnCmluZGV4IGFjOWE3ZTEuLjA3MmFkZWQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21h
Y2gtb21hcDIvS2NvbmZpZworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL0tjb25maWcKQEAgLTEw
Miw4ICsxMDIsOCBAQCBjb25maWcgTUFDSF9PTUFQX0xEUAogCWJvb2wgIk9NQVAgMyBMRFAgYm9h
cmQiCiAJZGVwZW5kcyBvbiBBUkNIX09NQVAzICYmIEFSQ0hfT01BUDM0WFgKIAotY29uZmlnIE1B
Q0hfT01BUF8yNDMwT1NLCi0JYm9vbCAiT01BUCAyNDMwIE9TSyBib2FyZCIKK2NvbmZpZyBNQUNI
X09NQVAyRVZNIAorCWJvb2wgIk9NQVAgMjUzMCBFVk0gYm9hcmQiCiAJZGVwZW5kcyBvbiBBUkNI
X09NQVAyICYmIEFSQ0hfT01BUDI0WFgKIAogY29uZmlnIE1BQ0hfT01BUF8zNDMwU0RQCmRpZmYg
LS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL01ha2VmaWxlIGIvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9NYWtlZmlsZQppbmRleCA1YTU3MmIwLi40ZDg2ZjA3IDEwMDY0NAotLS0gYS9hcmNoL2FybS9t
YWNoLW9tYXAyL01ha2VmaWxlCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUKQEAg
LTQyLDcgKzQyLDcgQEAgb2JqLSQoQ09ORklHX01BQ0hfT01BUF8yNDMwU0RQKQkJKz0gYm9hcmQt
MjQzMHNkcC5vIFwKIAkJCQkJICAgaHNtbWMubyBcCiAJCQkJCSAgIHVzYi1tdXNiLm8gXAogCQkJ
CQkgICB1c2ItZWhjaS5vCi1vYmotJChDT05GSUdfTUFDSF9PTUFQXzI0MzBPU0spCQkrPSBib2Fy
ZC0yNDMwb3NrLm8KK29iai0kKENPTkZJR19NQUNIX09NQVAyRVZNKQkJKz0gYm9hcmQtb21hcDJl
dm0ubwogb2JqLSQoQ09ORklHX01BQ0hfT01BUF8zNDMwU0RQKQkJKz0gYm9hcmQtMzQzMHNkcC5v
IFwKIAkJCQkJICAgaHNtbWMubyBcCiAJCQkJCSAgIHVzYi1tdXNiLm8gXApkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9oYXJkd2FyZS5oIGIvaW5jbHVkZS9hc20tYXJtL2Fy
Y2gtb21hcC9oYXJkd2FyZS5oCmluZGV4IDUxM2E4MTMuLjJkNDQ1OTAgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvaGFyZHdhcmUuaAorKysgYi9pbmNsdWRlL2FzbS1hcm0v
YXJjaC1vbWFwL2hhcmR3YXJlLmgKQEAgLTMyNiw4ICszMjYsOCBAQAogI2luY2x1ZGUgImJvYXJk
LTI0MzBzZHAuaCIKICNlbmRpZgogCi0jaWZkZWYgQ09ORklHX01BQ0hfT01BUF8yNDMwT1NLCi0j
aW5jbHVkZSAiYm9hcmQtMjQzMG9zay5oIgorI2lmZGVmIENPTkZJR19NQUNIX09NQVAyRVZNCisj
aW5jbHVkZSAiYm9hcmQtb21hcDJldm0uaCIKICNlbmRpZgogCiAjaWZkZWYgQ09ORklHX01BQ0hf
T01BUF8zNDMwU0RQCi0tIAoxLjUuMy40Cgo=
------=_Part_20004_21477121.1213180494117--
