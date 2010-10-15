From: srinath@mistralsolutions.com
Subject: [Added craneboard support 1/1] Added-craneboard-basic-support
Date: Fri, 15 Oct 2010 15:57:12 +0530
Message-ID: <1287138432-23880-2-git-send-email-srinath@mistralsolutions.com>
References: <1287138432-23880-1-git-send-email-srinath@mistralsolutions.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48719 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab0JOKj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Oct 2010 06:39:29 -0400
Received: by gwj17 with SMTP id 17so258873gwj.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Oct 2010 03:39:28 -0700 (PDT)
In-Reply-To: <1287138432-23880-1-git-send-email-srinath@mistralsolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, jdk@ti.com, nagendra@mistralsolutions.com, umeshk@mistralsolutions.com, Srinath <srinath@mistralsolutions.com>

From: Srinath <srinath@mistralsolutions.com>


Signed-off-by: Srinath <srinath@mistralsolutions.com>
---
 arch/arm/configs/omap2plus_defconfig    |    1 +
 arch/arm/mach-omap2/Kconfig             |    6 +++
 arch/arm/mach-omap2/Makefile            |    2 +
 arch/arm/mach-omap2/board-am3517crane.c |   68 +++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 0 deletions(-)
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
index ab784bf..f4cf968 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -174,6 +174,12 @@ config MACH_OMAP3517EVM
 	default y
 	select OMAP_PACKAGE_CBB
 
+config MACH_CRANEBOARD
+	bool "AM3517/05 CRANE board"
+	depends on ARCH_OMAP3
+	default y
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
index 0000000..c9390ce
--- /dev/null
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -0,0 +1,68 @@
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
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/usb.h>
+
+/*
+ * Board initialization
+ */
+static struct omap_board_config_kernel am3517_crane_config[] __initdata = {
+};
+
+static struct platform_device *am3517_crane_devices[] __initdata = {
+};
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
+	platform_add_devices(am3517_crane_devices,
+			ARRAY_SIZE(am3517_crane_devices));
+	omap_serial_init();
+}
+
+MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= omap3_map_io,
+	.reserve        = omap_reserve,
+	.init_irq	= am3517_crane_init_irq,
+	.init_machine	= am3517_crane_init,
+	.timer		= &omap_timer,
+MACHINE_END
-- 
1.7.1.226.g770c5

