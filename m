From: srinath@mistralsolutions.com
Subject: [PATCH 1/1] OMAP: AM3517/05: craneboard: Add craneboard support
Date: Mon, 25 Oct 2010 19:04:25 +0530
Message-ID: <1288013665-2487-1-git-send-email-srinath@mistralsolutions.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34282 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab0JYNtN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Oct 2010 09:49:13 -0400
Received: by pwj8 with SMTP id 8so390550pwj.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Oct 2010 06:49:13 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jdk@ti.com, tony@atomide.com, khilman@deeprootsystems.com, nm@ti.com, nagendra@mistralsolutions.com, umeshk@mistralsolutions.com, Srinath <srinath@mistralsolutions.com>

From: Srinath <srinath@mistralsolutions.com>

This patch adds basic board file. Detailed support will follow in
subsequent patches.

      [1] http://www.ti.com/sitara
      [2] http://www.mistralsolutions.com/products/craneboard.php

This patch has been created against omap-next branch.

Signed-off-by: Srinath <srinath@mistralsolutions.com>
---
 arch/arm/configs/omap2plus_defconfig         |    1 +
 arch/arm/mach-omap2/Kconfig                  |    5 ++
 arch/arm/mach-omap2/Makefile                 |    2 +
 arch/arm/mach-omap2/board-am3517crane.c      |   74 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 5 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-am3517crane.c

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index ccedde1..8c93f86 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -40,6 +40,7 @@ CONFIG_MACH_OMAP_LDP=y
 CONFIG_MACH_OVERO=y
 CONFIG_MACH_OMAP3EVM=y
 CONFIG_MACH_OMAP3517EVM=y
+CONFIG_MACH_CRANEBOARD=y
 CONFIG_MACH_OMAP3_PANDORA=y
 CONFIG_MACH_OMAP3_TOUCHBOOK=y
 CONFIG_MACH_OMAP_3430SDP=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ab784bf..3688515 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -174,6 +174,11 @@ config MACH_OMAP3517EVM
 	default y
 	select OMAP_PACKAGE_CBB
 
+config MACH_CRANEBOARD
+	bool "AM3517/05 CRANE board"
+	depends on ARCH_OMAP3
+	select OMAP_PACKAGE_CBB
+
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 7352412..f885037 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -170,6 +170,8 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
 
 obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
 
+obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
+
 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o \
 					   hsmmc.o
 # Platform specific device init code
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
new file mode 100644
index 0000000..152f6ee
--- /dev/null
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -0,0 +1,74 @@
+/*
+ * linux/arch/arm/mach-omap2/board-am3517crane.c
+ *
+ * Copyright (C) 2010 Mistral Solutions Pvt Ltd. <www.mistralsolutions.com>
+ * Author: R.Srinath <srinath@mistralsolutions.com>
+ *
+ * Based on mach-omap2/board-am3517evm.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as  published by the
+ * Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
+ * whether express or implied; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <plat/board.h>
+#include <plat/common.h>
+
+#include "mux.h"
+
+/* Board initialization */
+static struct omap_board_config_kernel am3517_crane_config[] __initdata = {
+};
+
+static struct platform_device *am3517_crane_devices[] __initdata = {
+};
+
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
+static void __init am3517_crane_init_irq(void)
+{
+	omap_board_config = am3517_crane_config;
+	omap_board_config_size = ARRAY_SIZE(am3517_crane_config);
+
+	omap2_init_common_hw(NULL, NULL);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static void __init am3517_crane_init(void)
+{
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+	platform_add_devices(am3517_crane_devices,
+			ARRAY_SIZE(am3517_crane_devices));
+	omap_serial_init();
+}
+
+MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
+	.boot_params	= 0x80000100,
+	.map_io		= omap3_map_io,
+	.reserve        = omap_reserve,
+	.init_irq	= am3517_crane_init_irq,
+	.init_machine	= am3517_crane_init,
+	.timer		= &omap_timer,
+MACHINE_END
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 9036e37..229fbf2 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -145,6 +145,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		/* omap3 based boards using UART3 */
 		DEBUG_LL_OMAP3(3, cm_t35);
 		DEBUG_LL_OMAP3(3, cm_t3517);
+		DEBUG_LL_OMAP3(3, craneboard);
 		DEBUG_LL_OMAP3(3, igep0020);
 		DEBUG_LL_OMAP3(3, igep0030);
 		DEBUG_LL_OMAP3(3, nokia_rx51);
-- 
1.7.1.226.g770c5

