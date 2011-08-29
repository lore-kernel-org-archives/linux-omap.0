From: <hvaibhav@ti.com>
Subject: [RFC PATCH-V2 3/4] AM335X: Create board support and enable build for AM335XEVM
Date: Mon, 29 Aug 2011 18:16:15 +0530
Message-ID: <1314621976-25750-4-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60514 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab1H2Mqb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 08:46:31 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Afzal Mohammed <afzal@ti.com>

This patch adds minimal support and build configuration for
AM335X EVM.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/Kconfig           |    5 +++
 arch/arm/mach-omap2/Makefile          |    2 +
 arch/arm/mach-omap2/board-am335xevm.c |   57 +++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-am335xevm.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f437e70..b41aee4 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -326,6 +326,11 @@ config MACH_TI8148EVM
 	depends on SOC_OMAPTI81XX
 	default y

+config MACH_AM335XEVM
+	bool "AM335X Evaluation Module"
+	depends on SOC_OMAPTI81XX
+	default y
+
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	default y
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8bcb2b2..88e6a6f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -239,6 +239,8 @@ obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
 obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
 obj-$(CONFIG_MACH_TI8148EVM)		+= board-ti8148evm.o
+obj-$(CONFIG_MACH_AM335XEVM)		+= board-am335xevm.o
+
 # Platform specific device init code

 omap-flash-$(CONFIG_MTD_NAND_OMAP2)	:= board-flash.o
diff --git a/arch/arm/mach-omap2/board-am335xevm.c b/arch/arm/mach-omap2/board-am335xevm.c
new file mode 100644
index 0000000..e3f5c4e
--- /dev/null
+++ b/arch/arm/mach-omap2/board-am335xevm.c
@@ -0,0 +1,57 @@
+/*
+ * Code for AM335X EVM.
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc. - http://www.ti.com/
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
+static struct omap_board_config_kernel am335x_evm_config[] __initdata = {
+};
+
+static void __init am335x_init_early(void)
+{
+	omap2_init_common_infrastructure();
+}
+
+static void __init am335x_evm_init(void)
+{
+	omap_serial_init();
+	omap_sdrc_init(NULL, NULL);
+	omap_board_config = am335x_evm_config;
+	omap_board_config_size = ARRAY_SIZE(am335x_evm_config);
+}
+
+static void __init am335x_evm_map_io(void)
+{
+	omap2_set_globals_am33xx();
+	omapam33xx_map_common_io();
+}
+
+MACHINE_START(AM335XEVM, "am335xevm")
+	/* Maintainer: Texas Instruments */
+	.boot_params	= 0x80000100,
+	.map_io		= am335x_evm_map_io,
+	.init_early	= am335x_init_early,
+	.init_irq	= ti81xx_init_irq,
+	.timer		= &omap3_timer,
+	.init_machine	= am335x_evm_init,
+MACHINE_END
--
1.6.2.4

