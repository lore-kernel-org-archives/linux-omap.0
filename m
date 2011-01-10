From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH v4 3/4] TI816X: Create board support and enable build for TI816X EVM
Date: Mon, 10 Jan 2011 22:08:00 +0530
Message-ID: <1294677480-18806-1-git-send-email-hemantp@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50838 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959Ab1AJQiG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Jan 2011 11:38:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Hemant Pedanekar <hemantp@ti.com>

This patch adds minimal support and build configuration for TI816X EVM.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/Kconfig           |    5 +++
 arch/arm/mach-omap2/Makefile          |    1 +
 arch/arm/mach-omap2/board-ti8168evm.c |   58 +++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-ti8168evm.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index dd723d6..2ab6d2a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -304,6 +304,11 @@ config MACH_OMAP_3630SDP
 	default y
 	select OMAP_PACKAGE_CBP
 
+config MACH_TI8168EVM
+	bool "TI8168 Evaluation Module"
+	depends on ARCH_OMAP3
+	default y
+
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	default y
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4ab82f6..86b05a3 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -219,6 +219,7 @@ obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
 
 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o \
 					   hsmmc.o
+obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
 # Platform specific device init code
 usbfs-$(CONFIG_ARCH_OMAP_OTG)		:= usb-fs.o
 obj-y					+= $(usbfs-m) $(usbfs-y)
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
new file mode 100644
index 0000000..e175ca4
--- /dev/null
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -0,0 +1,58 @@
+/*
+ * Code for TI8168 EVM.
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <plat/irqs.h>
+#include <plat/board.h>
+#include <plat/common.h>
+
+static struct omap_board_config_kernel ti8168_evm_config[] __initdata = {
+};
+
+static void __init ti8168_evm_init_irq(void)
+{
+	omap_board_config = ti8168_evm_config;
+	omap_board_config_size = ARRAY_SIZE(ti8168_evm_config);
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
+	omap_init_irq();
+}
+
+static void __init ti8168_evm_init(void)
+{
+	omap_serial_init();
+}
+
+
+static void __init ti8168_evm_map_io(void)
+{
+	omap2_set_globals_ti816x();
+	omap34xx_map_common_io();
+}
+
+MACHINE_START(TI8168EVM, "ti8168evm")
+	/* Maintainer: Texas Instruments */
+	.boot_params	= 0x80000100,
+	.map_io		= ti8168_evm_map_io,
+	.init_irq	= ti8168_evm_init_irq,
+	.init_machine	= ti8168_evm_init,
+	.timer		= &omap_timer,
+MACHINE_END
-- 
1.6.2.4

