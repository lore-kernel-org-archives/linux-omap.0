From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/8] ARM: OMAP2+: Enable ARCH_MULTIPLATFORM support
Date: Wed, 19 Dec 2012 11:26:33 -0800
Message-ID: <20121219192633.22098.28350.stgit@muffinssi.local>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62827 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753699Ab2LST0e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 14:26:34 -0500
In-Reply-To: <20121219192354.22098.33408.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

Flip on multiplatform support for omap2+.

No changes to omap2plus_defconfig needed, but please note
that you may need to update your custom config files to
make sure you have:

CONFIG_ARCH_MULTIPLATFORM=y
CONFIG_ARCH_MULTI_V7=y
CONFIG_ARCH_OMAP2PLUS=y

And may need CONFIG_ARCH_MULTI_V6=y if booting omap2 boards.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig                     |   13 ++++++++++---
 arch/arm/configs/omap2plus_defconfig |    2 +-
 arch/arm/mach-omap2/Kconfig          |   23 +++++++++++++++++++++++
 arch/arm/mach-omap2/Makefile         |    3 +++
 arch/arm/plat-omap/Kconfig           |   30 ------------------------------
 arch/arm/plat-omap/Makefile          |    2 ++
 6 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ae97414..93b6acd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -940,17 +940,24 @@ config ARCH_DAVINCI
 	help
 	  Support for TI's DaVinci platform.
 
-config ARCH_OMAP
-	bool "TI OMAP"
+config ARCH_OMAP1
+	bool "TI OMAP1"
 	depends on MMU
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_OMAP
 	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_CHIP
 	select HAVE_CLK
+	select HAVE_IDE
+	select IRQ_DOMAIN
+	select NEED_MACH_IO_H if PCCARD
+	select NEED_MACH_MEMORY_H
 	help
-	  Support for TI's OMAP platform (OMAP1/2/3/4).
+	  Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
 
 config ARCH_VT8500_SINGLE
 	bool "VIA/WonderMedia 85xx"
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 82ce8d7..db05745 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -20,7 +20,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_OMAP=y
+CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_MUX_DEBUG=y
 CONFIG_ARM_THUMBEE=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 492d764..c3c033f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -1,3 +1,26 @@
+config ARCH_OMAP
+	bool
+
+config ARCH_OMAP2PLUS
+	bool "TI OMAP2/3/4/5 SoCs with device tree support" if (ARCH_MULTI_V6 || ARCH_MULTI_V7)
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_OMAP
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_CHIP
+	select HAVE_CLK
+	select OMAP_DM_TIMER
+	select PINCTRL
+	select PROC_DEVICETREE if PROC_FS
+	select SPARSE_IRQ
+	select USE_OF
+	help
+	  Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
+
+
 if ARCH_OMAP2PLUS
 
 menu "TI OMAP2/3/4 Specific Features"
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 947cafe..65fb6fb 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -2,6 +2,9 @@
 # Makefile for the linux kernel.
 #
 
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+	-I$(srctree)/arch/arm/plat-omap/include
+
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 665870d..886af14 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -5,36 +5,6 @@ menu "TI OMAP Common Features"
 config ARCH_OMAP_OTG
 	bool
 
-choice
-	prompt "OMAP System Type"
-	default ARCH_OMAP2PLUS
-
-config ARCH_OMAP1
-	bool "TI OMAP1"
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select GENERIC_IRQ_CHIP
-	select HAVE_IDE
-	select IRQ_DOMAIN
-	select NEED_MACH_IO_H if PCCARD
-	select NEED_MACH_MEMORY_H
-	help
-	  "Systems based on omap7xx, omap15xx or omap16xx"
-
-config ARCH_OMAP2PLUS
-	bool "TI OMAP2/3/4"
-	select CLKDEV_LOOKUP
-	select GENERIC_IRQ_CHIP
-	select OMAP_DM_TIMER
-	select PINCTRL
-	select PROC_DEVICETREE if PROC_FS
-	select SPARSE_IRQ
-	select USE_OF
-	help
-	  "Systems based on OMAP2, OMAP3, OMAP4 or OMAP5"
-
-endchoice
-
 comment "OMAP Feature Selections"
 
 config OMAP_DEBUG_DEVICES
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index a14a78a..3119941 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux kernel.
 #
 
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-omap/include
+
 # Common support
 obj-y := sram.o dma.o counter_32k.o
 obj-m :=

