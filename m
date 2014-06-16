From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: omap: rework platform selection
Date: Mon, 16 Jun 2014 12:04:58 +0200
Message-ID: <5701099.0P1SIXsHc1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:54155 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948AbaFPKFK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2014 06:05:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arm@kernel.org, rob.herring@linaro.org

Commit 9851b662f659 ("ARM: use menuconfig for sub-arch menus") did more
than expected, which led to two OMAP specific bugs:

* Turning CONFIG_ARCH_OMAP into a user-selectable option makes it possible
  to have a configuration with ARCH_OMAP enabled but none of the specific
  OMAP SoCs enabled, which triggers a couple of link errors due to the
  layout of the Makefile

* The plat-omap menu still appears mixed into the normal menuconfig list,
  which is confusing and inconsistent.

To make matters worse, the change did not enable CONFIG_ARCH_OMAP in the
defconfig files, which through some ripple effects disabled options that
were implicitly enabled from OMAP2, and that caused all machines to
fail booting with the unchanged config files.

This reorders the OMAP Kconfig files some more, to be consistent with
the others, and also changes the defconfig files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Tony, can you have a look at this please? I'd like to send out the
fixes for 3.16, but this is needed on top of Rob's Kconfig changes.


diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 245058b..fcf6ddf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -973,10 +973,6 @@ source "arch/arm/mach-nspire/Kconfig"
 
 source "arch/arm/plat-omap/Kconfig"
 
-source "arch/arm/mach-omap1/Kconfig"
-
-source "arch/arm/mach-omap2/Kconfig"
-
 source "arch/arm/mach-orion5x/Kconfig"
 
 source "arch/arm/mach-picoxcell/Kconfig"
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e2d6204..d77bb9e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -23,6 +23,7 @@ CONFIG_ARCH_BERLIN=y
 CONFIG_MACH_BERLIN_BG2=y
 CONFIG_MACH_BERLIN_BG2CD=y
 CONFIG_MACH_BERLIN_BG2Q=y
+CONFIG_ARCH_OMAP_ENABLE=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_HI3xxx=y
 CONFIG_ARCH_KEYSTONE=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 536a137..85de0a1 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -25,6 +25,7 @@ CONFIG_POWER_AVS_OMAP=y
 CONFIG_POWER_AVS_OMAP_CLASS3=y
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_MUX_DEBUG=y
+CONFIG_ARCH_OMAP_ENABLE=y
 CONFIG_ARCH_OMAP2=y
 CONFIG_ARCH_OMAP3=y
 CONFIG_ARCH_OMAP4=y
diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index cdd05f2..53a802c 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -1,8 +1,6 @@
 if ARCH_OMAP1
 
-menu "TI OMAP1 specific features"
-
-comment "OMAP Core Type"
+comment "OMAP1 Core Type"
 	depends on ARCH_OMAP1
 
 config ARCH_OMAP730
@@ -164,6 +162,4 @@ config MACH_OMAP_GENERIC
           custom OMAP boards. Say Y here if you have a custom
           board.
 
-endmenu
-
 endif
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4e81860..0006012 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -1,7 +1,5 @@
-menuconfig ARCH_OMAP
-	bool "TI OMAP/AM/DRA Based" if (ARCH_MULTI_V6 || ARCH_MULTI_V7)
-
-if ARCH_OMAP
+config ARCH_OMAP
+	bool
 
 config ARCH_OMAP2
 	bool "TI OMAP2"
@@ -82,6 +80,7 @@ config ARCH_OMAP2PLUS
 	bool
 	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_OMAP
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
@@ -342,5 +341,3 @@ config OMAP4_ERRATA_I688
 endmenu
 
 endif
-
-endif
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 02fc10d..8aa2dd2 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -1,6 +1,11 @@
-if ARCH_OMAP
+menuconfig ARCH_OMAP_ENABLE
+	bool "TI OMAP platforms" if ARCH_MULTI_V6 || ARCH_MULTI_V7
+	default ARCH_OMAP1
 
-menu "TI OMAP Common Features"
+if ARCH_OMAP_ENABLE
+
+source "arch/arm/mach-omap1/Kconfig"
+source "arch/arm/mach-omap2/Kconfig"
 
 config ARCH_OMAP_OTG
 	bool
@@ -153,6 +158,4 @@ config OMAP_PM_NOOP
 
 endchoice
 
-endmenu
-
 endif

