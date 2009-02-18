From: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Subject: [PATCH] ARM: OMAP: Allow I2C bus driver to be compiled as a module
Date: Wed, 18 Feb 2009 11:22:18 +0200
Message-ID: <1234948938-6979-1-git-send-email-Aaro.Koskinen@nokia.com>
References: <20090217235018.GF11928@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57461 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbZBRJWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 04:22:52 -0500
In-Reply-To: <20090217235018.GF11928@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, jarkko.nikula@nokia.com, ext-atal.shargorodsky@nokia.com

Fixes a linker error when OMAP I2C bus driver is compiled as a module:

   ERROR: "i2c_register_board_info" [arch/arm/plat-omap/i2c.ko] undefined!

The I2C utility functions used for board initialization should be always
built-in.

Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
---
 arch/arm/plat-omap/Makefile              |    3 ++-
 arch/arm/plat-omap/include/mach/common.h |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index b3f0e6b..3ebc09e 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -21,7 +21,8 @@ obj-$(CONFIG_OMAP_COMPONENT_VERSION) += component-version.o
 obj-$(CONFIG_OMAP_GPIO_SWITCH) += gpio-switch.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
-obj-$(CONFIG_I2C_OMAP) += i2c.o
+i2c-omap-$(CONFIG_I2C_OMAP) := i2c.o
+obj-y += $(i2c-omap-m) $(i2c-omap-y)
 
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index af4105f..8c1b965 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -33,7 +33,7 @@ struct sys_timer;
 
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
-#ifdef CONFIG_I2C_OMAP
+#if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,
 				 unsigned len);
-- 
1.5.4.3

