From: jean.pihet@newoldbits.com
Subject: [PATCH 13/13] OMAP2+: PM: build PM functionality as modules
Date: Wed, 18 May 2011 19:32:30 +0200
Message-ID: <1305739950-11695-14-git-send-email-j-pihet@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62820 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933344Ab1ERRdE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:33:04 -0400
Received: by mail-yx0-f174.google.com with SMTP id 7so624062yxs.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:33:03 -0700 (PDT)
In-Reply-To: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

A new config option CONFIG_OMAP_PM is defined. This option allows
for the whole OMAP2+ PM to completely enabled, disabled or be built
as modules.

The PM functionality is split into the following modules:
- omap_pm_debug
- omap2_pm
- omap3_pm
- omap4_pm

The following functionality is moved to the modules:
- platform specific PM core
- suspend
- cpuidle
- PM debug

The following functionality is needed at boot time and so is left
in the PM core code (i.e. not built as modules):
- PRCM
- clock domains
- power domains
- voltage domains
- hwmod
- smart reflex
- per-platform PRCM data
- per-platform clock data
- per-platform power domains data
- per-platform hwmod data
- per-platform OPP data

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/Makefile |   36 ++++++++++++++++++++++++++----------
 arch/arm/plat-omap/Kconfig   |    9 +++++++++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 0fe8a5b..29e0588 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -53,22 +53,38 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 # Power Management
 #  Includes core PM, powerdomain, clockdomain, smartreflex, voltagedomain, OPP
 ifeq ($(CONFIG_PM),y)
-obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
-obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
-obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o \
-					   cpuidle34xx.o pm_bus.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
-obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
+
+obj-y					+= pm_bus.o
+ifeq ($(CONFIG_PM_VERBOSE),y)
+CFLAGS_pm_bus.o				+= -DDEBUG
+endif
+
+ifeq ($(CONFIG_PM_DEBUG),y)
+obj-$(CONFIG_OMAP_PM)			+= omap_pm_debug.o
+omap_pm_debug-y				:= pm-debug.o
+endif
+
+ifeq ($(CONFIG_ARCH_OMAP2),y)
+obj-$(CONFIG_OMAP_PM)			+= omap2_pm.o
+omap2_pm-y				:= pm24xx.o sleep24xx.o
+endif
+
+ifeq ($(CONFIG_ARCH_OMAP3),y)
+obj-$(CONFIG_OMAP_PM)			+= omap3_pm.o
+omap3_pm-y				:= pm34xx.o sleep34xx.o cpuidle34xx.o
+endif
+
+ifeq ($(CONFIG_ARCH_OMAP4),y)
+obj-$(CONFIG_OMAP_PM)			+= omap4_pm.o
+omap4_pm-y				:= pm44xx.o
+endif
+
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 
-ifeq ($(CONFIG_PM_VERBOSE),y)
-CFLAGS_pm_bus.o				+= -DDEBUG
-endif
-
 # OMAP voltage domains
 voltagedomain-common			:= voltage.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common)
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index cd5f993..28154db 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -204,6 +204,15 @@ config OMAP_SERIAL_WAKE
 	  to data on the serial RX line. This allows you to wake the
 	  system from serial console.
 
+config OMAP_PM
+	tristate "OMAP PM support"
+	depends on ARCH_OMAP2PLUS && PM
+	default y
+	help
+	  Select this option if you want to have OMAP2+ PM support enabled.
+	  Can also be set to 'm' for the whole OMAP2+ PM to be built
+	  as a module.
+
 choice
 	prompt "OMAP PM layer selection"
 	depends on ARCH_OMAP
-- 
1.7.4.1

