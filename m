From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH v2 4/6] TI816X: Create board support for TI816X_EVM
Date: Wed, 11 Aug 2010 22:41:12 +0530
Message-ID: <1281546672-11517-1-git-send-email-hemantp@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52911 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668Ab0HKRLR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Aug 2010 13:11:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Hemant Pedanekar <hemantp@ti.com>

This patch adds minimal support for TI816X EVM to enable kernel boot.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/Kconfig           |    8 ++++
 arch/arm/mach-omap2/board-ti8168evm.c |   58 +++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-ti8168evm.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3a91a10..75bb208 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -249,6 +249,14 @@ config MACH_OMAP4_PANDA
 	default y
 	depends on ARCH_OMAP4
 
+comment "TI816X Board Type"
+	depends on ARCH_TI816X
+
+config MACH_TI8168EVM
+	bool "TI8168 Evaluation Module"
+	default y
+	depends on ARCH_TI816X
+
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
new file mode 100644
index 0000000..406bdbd
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
+#include <plat/timer-gp.h>
+
+static void __init ti8168_evm_init_irq(void)
+{
+	/* Timer1 is reserved on TI816X so skip to first available */
+	omap2_gp_clockevent_set_gptimer(2);
+
+	omap2_init_common_hw(NULL, NULL);
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
+	ti816x_map_common_io();
+}
+
+MACHINE_START(TI8168EVM, "ti8168evm")
+	/* Maintainer: Texas Instruments */
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= ti8168_evm_map_io,
+	.init_irq	= ti8168_evm_init_irq,
+	.init_machine	= ti8168_evm_init,
+	.timer		= &omap_timer,
+MACHINE_END
-- 
1.6.2.4

