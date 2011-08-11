From: <hvaibhav@ti.com>
Subject: [RFC: PATCH 3/4] AM335X: Create board support and enable build for AM335XEVM
Date: Thu, 11 Aug 2011 16:00:29 +0530
Message-ID: <1313058630-32447-4-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41597 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755162Ab1HKKat (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Aug 2011 06:30:49 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Afzal Mohammed <afzal@ti.com>

This patch adds minimal support and build configuration for
AM335X EVM.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/Kconfig           |    5 +++
 arch/arm/mach-omap2/Makefile          |    2 +
 arch/arm/mach-omap2/board-am335xevm.c |   57 +++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-am335xevm.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f9f5776..96b1d35 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -322,6 +322,11 @@ config MACH_TI8148EVM
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
index fa54361..31ecd72 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -263,6 +263,8 @@ obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
 obj-$(CONFIG_MACH_TI8148EVM)		+= board-ti8148evm.o
+obj-$(CONFIG_MACH_AM335XEVM)		+= board-am335xevm.o
+
 # Platform specific device init code
 usbfs-$(CONFIG_ARCH_OMAP_OTG)		:= usb-fs.o
 obj-y					+= $(usbfs-m) $(usbfs-y)
diff --git a/arch/arm/mach-omap2/board-am335xevm.c b/arch/arm/mach-omap2/board-am335xevm.c
new file mode 100644
index 0000000..704b2ab
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
+	omap2_init_common_devices(NULL, NULL);
+}
+
+static void __init am335x_evm_init(void)
+{
+	omap_serial_init();
+	omap_board_config = am335x_evm_config;
+	omap_board_config_size = ARRAY_SIZE(am335x_evm_config);
+}
+
+static void __init am335x_evm_map_io(void)
+{
+	omap2_set_globals_ti81xx();
+	omapti81xx_map_common_io();
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

