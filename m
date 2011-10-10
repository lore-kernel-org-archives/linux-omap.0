From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH v4 3/3] ARM: OMAP: TI814X: Create board support and enable build for TI8148 EVM
Date: Mon, 10 Oct 2011 07:10:10 +0530
Message-ID: <1318210810-2559-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58297 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab1JJBkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Oct 2011 21:40:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Hemant Pedanekar <hemantp@ti.com>

This patch adds minimal support and build configuration for TI8148 EVM. Also
adds support for low level debugging on UART1 console on the EVM.

Note that existing TI8168 EVM file (board-ti8168evm.c) is updated with machine
info for TI8148 EVM.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/Kconfig                  |    5 +++++
 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/board-ti8168evm.c        |   22 ++++++++++++++++------
 arch/arm/plat-omap/include/plat/uncompress.h |    3 +++
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index caebeb7..59942b2 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -325,6 +325,11 @@ config MACH_TI8168EVM
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
index 5ee4cd6..0e27e43 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -240,6 +240,7 @@ obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
 
 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
 obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
+obj-$(CONFIG_MACH_TI8148EVM)		+= board-ti8168evm.o
 
 # Platform specific device init code
 
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index 7935fc9..b858921 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -1,5 +1,5 @@
 /*
- * Code for TI8168 EVM.
+ * Code for TI8168/TI8148 EVM.
  *
  * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
  *
@@ -24,15 +24,15 @@
 #include <plat/board.h>
 #include <plat/common.h>
 
-static struct omap_board_config_kernel ti8168_evm_config[] __initdata = {
+static struct omap_board_config_kernel ti81xx_evm_config[] __initdata = {
 };
 
-static void __init ti8168_evm_init(void)
+static void __init ti81xx_evm_init(void)
 {
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
-	omap_board_config = ti8168_evm_config;
-	omap_board_config_size = ARRAY_SIZE(ti8168_evm_config);
+	omap_board_config = ti81xx_evm_config;
+	omap_board_config_size = ARRAY_SIZE(ti81xx_evm_config);
 }
 
 MACHINE_START(TI8168EVM, "ti8168evm")
@@ -42,5 +42,15 @@ MACHINE_START(TI8168EVM, "ti8168evm")
 	.init_early	= ti81xx_init_early,
 	.init_irq	= ti81xx_init_irq,
 	.timer		= &omap3_timer,
-	.init_machine	= ti8168_evm_init,
+	.init_machine	= ti81xx_evm_init,
+MACHINE_END
+
+MACHINE_START(TI8148EVM, "ti8148evm")
+	/* Maintainer: Texas Instruments */
+	.atag_offset	= 0x100,
+	.map_io		= ti81xx_map_io,
+	.init_early	= ti81xx_init_early,
+	.init_irq	= ti81xx_init_irq,
+	.timer		= &omap3_timer,
+	.init_machine	= ti81xx_evm_init,
 MACHINE_END
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index a8e5187..27d9d31 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -181,6 +181,9 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		/* TI8168 base boards using UART3 */
 		DEBUG_LL_TI81XX(3, ti8168evm);
 
+		/* TI8148 base boards using UART1 */
+		DEBUG_LL_TI81XX(1, ti8148evm);
+
 	} while (0);
 }
 
-- 
1.7.3.5

