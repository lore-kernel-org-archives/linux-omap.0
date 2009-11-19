From: Gregoire Gentil <gregoire@gentil.com>
Subject: [PATCH 8/8] AI TB: Additional files for Always Innovating
 OMAP3-based Touch Book
Date: Wed, 18 Nov 2009 18:58:07 -0800
Message-ID: <1258599487.8001.39.camel@gregoire-laptop>
References: <1258228079.16065.17.camel@runt>
	 <1258345850.9089.21.camel@gregoire-laptop>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-7S3LdAlK+ZngP0RWle6F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:49092 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758051AbZKSC6E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 21:58:04 -0500
Received: by mail-yw0-f202.google.com with SMTP id 40so944791ywh.33
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 18:58:10 -0800 (PST)
In-Reply-To: <1258345850.9089.21.camel@gregoire-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>


--=-7S3LdAlK+ZngP0RWle6F
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>From 64919217ca10bd1954f4a4b07c9de72a1a60a0e8 Mon Sep 17 00:00:00 2001
From: Gregoire Gentil <gregoire@gentil.com>
Date: Wed, 18 Nov 2009 18:34:39 -0800
Subject: [PATCH] Additional file for Always Innovating OMAP3-based Touch
Book


Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
---
arch/arm/mach-omap2/Kconfig  |    5 +++++
arch/arm/mach-omap2/Makefile |    2 ++
2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 034d990..6d32d1b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -73,6 +73,11 @@ config MACH_OMAP3_PANDORA
bool "OMAP3 Pandora"
depends on ARCH_OMAP3 && ARCH_OMAP34XX

+config MACH_OMAP3_TOUCHBOOK
+ bool "OMAP3 Touch Book"
+ depends on ARCH_OMAP3 && ARCH_OMAP34XX
+ select BACKLIGHT_CLASS_DEVICE
+
config MACH_OMAP_3430SDP
bool "OMAP 3430 SDP board"
depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 59b0ccc..b6b5c7f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -90,6 +90,8 @@ obj-$(CONFIG_MACH_CM_T35) += board-cm-t35.o \
   mmc-twl4030.o
obj-$(CONFIG_MACH_IGEP0020) += board-igep0020.o \
   mmc-twl4030.o
+obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK) += board-omap3touchbook.o \
+    mmc-twl4030.o

obj-$(CONFIG_MACH_OMAP_4430SDP) += board-4430sdp.o

-- 
1.6.0.4



--=-7S3LdAlK+ZngP0RWle6F
Content-Disposition: attachment; filename*0=0008-Additional-file-for-Always-Innovating-OMAP3-based-To.pat; filename*1=ch
Content-Type: text/x-patch; name="0008-Additional-file-for-Always-Innovating-OMAP3-based-To.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 64919217ca10bd1954f4a4b07c9de72a1a60a0e8 Mon Sep 17 00:00:00 2001
From: Gregoire Gentil <gregoire@gentil.com>
Date: Wed, 18 Nov 2009 18:34:39 -0800
Subject: [PATCH] Additional file for Always Innovating OMAP3-based Touch Book


Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
---
 arch/arm/mach-omap2/Kconfig  |    5 +++++
 arch/arm/mach-omap2/Makefile |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 034d990..6d32d1b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -73,6 +73,11 @@ config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_OMAP3_TOUCHBOOK
+	bool "OMAP3 Touch Book"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	select BACKLIGHT_CLASS_DEVICE
+
 config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 59b0ccc..b6b5c7f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -90,6 +90,8 @@ obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
 					   mmc-twl4030.o
+obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
+					   mmc-twl4030.o
 
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 
-- 
1.6.0.4


--=-7S3LdAlK+ZngP0RWle6F
Content-Disposition: attachment; filename*0=0008-Additional-file-for-Always-Innovating-OMAP3-based-To.pat; filename*1=ch.zip
Content-Type: application/zip; name*0=0008-Additional-file-for-Always-Innovating-OMAP3-based-To.patch.z; name*1=ip
Content-Transfer-Encoding: base64

UEsDBBQAAAAIAIaUcjtlGumQgAIAAI8FAAA/ABUAMDAwOC1BZGRpdGlvbmFsLWZpbGUtZm9yLUFs
d2F5cy1Jbm5vdmF0aW5nLU9NQVAzLWJhc2VkLVRvLnBhdGNoVVQJAAMcrwRLk68ES1V4BADoA+gD
lVNrT9swFP1c/4orNCGq4NR59JFqmwgptBWUVrTbkLapcmwnDTRxlQQY0n787PCGUpgVWfHx9fG5
91wf5jKFlutZnm21GbVIyC2v6UYudUPSZh4XbZtatEUoER0YyQymYgVWGwjpVh/YhFjoUNF0oZ+L
WCa5gL7IymQJn+M7YC+uAJPJ9Cvq0VJ04Yfgu2B14EReaQpP/Xcdt+t4gEmHEDS9DM8FK7vwc+LP
gsFv8DlPykRmdAlRshQQyRz85TW9KWCYZfKKlkkWw3jkTxwc0kJwmMlLtoB9KS8QQtMkzgTHMopw
ePNRqRhjBDRniwbN00ZK2QLLlK7sxhGTWZTEAH9BjSYYeqwPHdELUQmuQm3QcXaVQgFsQbNYF6IN
SVaIXOdX7Bj1XSDAxVLcrnEdIZ5EEWAcJyXQxiZF4aZdlGRc/AHiuNzziGm2uGNzKwSLkJbr6nQ3
syOV5Ts37O0Bbju7LTDUbFmg1nfKRn4wmFf+zCf+SW986iOohVIuYatCYUIzLnO6pWAuViLjBah+
80/vj8H29pOVe3aGABmvyWfjb8Fgfzw+QsYz+sd22FI7H7zBqBXKB1bCvh8cHQ/7g9k8OPan03nv
4PswOEDKzJcK5o7rkGlv8iw70CAoFEJJc/4fOb7r/EODrTfmfvvO+6YXEsaYaYatsMna0fvePxC8
bf5DiHbfI9p9NXe0+TI8x592gvHJ4bA/r2oUjOYzp1mv1Ywvt8XALMWl0zQl/FJl0UM9lDRluLxe
usQhpkRraIb9gwkhNnlKlMRipbFNVMZrqhd9U38k1Ok5pW4cZeVFRWu8oXCdxqod3Nt2eKpTQwVf
VcdU3ZFltkxiugj9A1BLAQIXAxQAAAAIAIaUcjtlGumQgAIAAI8FAAA/AA0AAAAAAAEAAACkgQAA
AAAwMDA4LUFkZGl0aW9uYWwtZmlsZS1mb3ItQWx3YXlzLUlubm92YXRpbmctT01BUDMtYmFzZWQt
VG8ucGF0Y2hVVAUAAxyvBEtVeAAAUEsFBgAAAAABAAEAegAAAPICAAAAAA==


--=-7S3LdAlK+ZngP0RWle6F--

