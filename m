From: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
Subject: [PATCH] I2C_OMAP configuration and Makefile fixes.
Date: Thu, 12 Feb 2009 10:53:10 +0200
Message-ID: <1234428790-6263-1-git-send-email-ext-atal.shargorodsky@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22134 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbZBLIxv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 03:53:51 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1C8qxc1027762
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 02:53:48 -0600
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: core-sw@ok.research.nokia.com
Cc: linux-omap@vger.kernel.org, Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>

Allow I2C_OMAP to be compiled as a module,
introduce selection of I2C_OMAP by TWL4030_CORE
and remove doubled 'obj-$(CONFIG_I2C_OMAP)' line from makefile.

Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
---
 arch/arm/plat-omap/Kconfig  |    3 +++
 arch/arm/plat-omap/Makefile |    2 +-
 drivers/i2c/busses/Kconfig  |    1 +
 drivers/i2c/busses/Makefile |    1 -
 drivers/mfd/Kconfig         |    1 +
 5 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 5bc8e3b..4d19d6b 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -99,6 +99,9 @@ config OMAP_RESET_CLOCKS
 	  probably do not want this option enabled until your
 	  device drivers work properly.
 
+config I2C_OMAP_ENABLE
+	bool
+
 config OMAP_BOOT_TAG
 	bool "OMAP bootloader information passing"
         depends on ARCH_OMAP
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 175bfd6..e610bc9 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_OMAP_COMPONENT_VERSION) += component-version.o
 obj-$(CONFIG_OMAP_GPIO_SWITCH) += gpio-switch.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
-obj-$(CONFIG_I2C_OMAP) += i2c.o
+obj-$(CONFIG_I2C_OMAP_ENABLE) += i2c.o
 
 # OMAP MMU framework
 obj-$(CONFIG_OMAP_MMU_FWK) += mmu.o
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index eb94378..176e053 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -400,6 +400,7 @@ config I2C_OCORES
 config I2C_OMAP
 	tristate "OMAP I2C adapter"
 	depends on ARCH_OMAP
+	select I2C_OMAP_ENABLE
 	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
 	help
 	  If you say yes to this option, support will be included for the
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index d4dc22d..97dbfa2 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -66,7 +66,6 @@ obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
 obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
-obj-$(CONFIG_I2C_OMAP)          += i2c-omap.o
 
 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 91c0417..1bc03bd 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -53,6 +53,7 @@ config HTC_PASIC3
 config TWL4030_CORE
 	bool "Texas Instruments TWL4030/TPS659x0 Support"
 	depends on I2C=y && GENERIC_HARDIRQS && (ARCH_OMAP2 || ARCH_OMAP3)
+	select I2C_OMAP
 	help
 	  Say yes here if you have TWL4030 family chip on your board.
 	  This core driver provides register access and IRQ handling
-- 
1.5.4.3

