From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] ARM: OMAP: Allow I2C bus driver to be compiled as a module
Date: Wed, 04 Mar 2009 10:29:10 -0800
Message-ID: <20090304182910.27331.77892.stgit@localhost>
References: <20090304182342.27331.35004.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50206 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbZCDS3Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 13:29:16 -0500
In-Reply-To: <20090304182342.27331.35004.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>, Aaro Koskinen <Aaro.Koskinen@nokia.com>

From: Aaro Koskinen <Aaro.Koskinen@nokia.com>

Fixes a linker error when OMAP I2C bus driver is compiled as a module:

   ERROR: "i2c_register_board_info" [arch/arm/plat-omap/i2c.ko] undefined!

The I2C utility functions used for board initialization should be always
built-in.

Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Acked-by: Jarkko Nikula  <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/Makefile              |    3 ++-
 arch/arm/plat-omap/include/mach/common.h |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index deaff58..04a100c 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -18,7 +18,8 @@ obj-$(CONFIG_CPU_FREQ) += cpu-omap.o
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
-obj-$(CONFIG_I2C_OMAP) += i2c.o
+i2c-omap-$(CONFIG_I2C_OMAP) := i2c.o
+obj-y += $(i2c-omap-m) $(i2c-omap-y)
 
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index ef70e2b..e746ec7 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -35,7 +35,7 @@ extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 extern void omap_serial_init(void);
 extern void omap_serial_enable_clocks(int enable);
-#ifdef CONFIG_I2C_OMAP
+#if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,
 				 unsigned len);

