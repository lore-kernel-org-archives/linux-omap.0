From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH 3/3] TI814X: Create board support and enable build for TI8148 EVM
Date: Thu, 4 Aug 2011 23:15:03 +0530
Message-ID: <1312479903-22909-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48900 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755042Ab1HDRpN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Aug 2011 13:45:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Hemant Pedanekar <hemantp@ti.com>

This patch adds minimal support and build configuration for TI8148 EVM. Also
adds support for low level debugging on UART1 console on the EVM.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/Kconfig                  |    5 ++
 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/board-ti8148evm.c        |   57 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h |    3 +
 4 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-ti8148evm.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 242d9ab..4dacb8e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -317,6 +317,11 @@ config MACH_TI8168EVM
 	depends on SOC_OMAPTI81XX
 	default y
 
+config MACH_TI8148EVM
+	bool "TI8148 Evaluation Module"
+	depends on SOC_OMAPTI81XX
+	default y
+
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	default y
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fb02937..fa54361 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -262,6 +262,7 @@ obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
+obj-$(CONFIG_MACH_TI8148EVM)		+= board-ti8148evm.o
 # Platform specific device init code
 usbfs-$(CONFIG_ARCH_OMAP_OTG)		:= usb-fs.o
 obj-y					+= $(usbfs-m) $(usbfs-y)
diff --git a/arch/arm/mach-omap2/board-ti8148evm.c b/arch/arm/mach-omap2/board-ti8148evm.c
new file mode 100644
index 0000000..588d6b7
--- /dev/null
+++ b/arch/arm/mach-omap2/board-ti8148evm.c
@@ -0,0 +1,57 @@
+/*
+ * Code for TI8148 EVM.
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
+static struct omap_board_config_kernel ti8148_evm_config[] __initdata = {
+};
+
+static void __init ti8148_init_early(void)
+{
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
+}
+
+static void __init ti8148_evm_init(void)
+{
+	omap_serial_init();
+	omap_board_config = ti8148_evm_config;
+	omap_board_config_size = ARRAY_SIZE(ti8148_evm_config);
+}
+
+static void __init ti8148_evm_map_io(void)
+{
+	omap2_set_globals_ti81xx();
+	omapti81xx_map_common_io();
+}
+
+MACHINE_START(TI8148EVM, "ti8148evm")
+	/* Maintainer: Texas Instruments */
+	.boot_params	= 0x80000100,
+	.map_io		= ti8148_evm_map_io,
+	.init_early	= ti8148_init_early,
+	.init_irq	= ti81xx_init_irq,
+	.timer		= &omap3_timer,
+	.init_machine	= ti8148_evm_init,
+MACHINE_END
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 40336ad..8d052e7 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -175,6 +175,9 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		/* TI8168 base boards using UART3 */
 		DEBUG_LL_TI81XX(3, ti8168evm);
 
+		/* TI8148 base boards using UART1 */
+		DEBUG_LL_TI81XX(1, ti8148evm);
+
 	} while (0);
 }
 
-- 
1.7.3.5

