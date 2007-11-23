From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: [PATCH] OMAP: Initial N810 support
Date: Fri, 23 Nov 2007 02:38:36 +0200
Message-ID: <1195778318-12008-2-git-send-email-lauri.leukkunen@nokia.com>
References: <1195778318-12008-1-git-send-email-lauri.leukkunen@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1195778318-12008-1-git-send-email-lauri.leukkunen@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Built alongside N800 sharing most of the init code through
board-n800.h. Bootloader tag array size is increased from
512 to 1024.

Many drivers are still missing or don't work correctly,
but at least serial console is functional and jffs2 works
with lzo compression.

Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
---
 arch/arm/mach-omap2/Kconfig      |    4 ++++
 arch/arm/mach-omap2/Makefile     |    1 +
 arch/arm/mach-omap2/board-n800.c |   23 ++++++++++++++---------
 arch/arm/mach-omap2/board-n800.h |   21 +++++++++++++++++++++
 arch/arm/mach-omap2/board-n810.c |   35 +++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/common.c      |    2 +-
 6 files changed, 76 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-n800.h
 create mode 100644 arch/arm/mach-omap2/board-n810.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 95c41bc..4220c89 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -39,6 +39,10 @@ config MACH_NOKIA_N800
 	select MENELAUS if VIDEO_TCM825X
 	select OMAP_GPIO_SWITCH
 
+config MACH_NOKIA_N810
+	bool "Nokia N810"
+	depends on MACH_NOKIA_N800
+
 config MACH_OMAP2_TUSB6010
 	bool
 	depends on ARCH_OMAP2 && ARCH_OMAP2420
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 88adcd4..8c134bf 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o board-n800-flash.o \
 					   board-n800-audio.o board-n800-usb.o \
 					   board-n800-dsp.o \
 					   board-n800-camera.o
+obj-$(CONFIG_MACH_NOKIA_N810)		+= board-n810.o
 
 # TUSB 6010 chips
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index 1604513..13f3188 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -1,7 +1,7 @@
 /*
  * linux/arch/arm/mach-omap2/board-n800.c
  *
- * Copyright (C) 2005 Nokia Corporation
+ * Copyright (C) 2005-2007 Nokia Corporation
  * Author: Juha Yrjola <juha.yrjola@nokia.com>
  *
  * Modified from mach-omap2/board-generic.c
@@ -42,11 +42,11 @@
 #include <../drivers/cbus/tahvo.h>
 #include <../drivers/media/video/tcm825x.h>
 
-#define N800_BLIZZARD_POWERDOWN_GPIO 15
-#define N800_STI_GPIO		62
+#define N800_BLIZZARD_POWERDOWN_GPIO	15
+#define N800_STI_GPIO			62
 #define N800_KEYB_IRQ_GPIO		109
 
-static void __init nokia_n800_init_irq(void)
+void __init nokia_n800_init_irq(void)
 {
 	omap2_init_common_hw();
 	omap_init_irq();
@@ -191,7 +191,6 @@ static void __init blizzard_dev_init(void)
 	omapfb_set_ctrl_platform_data(&n800_blizzard_data);
 }
 
-
 static struct omap_board_config_kernel n800_config[] __initdata = {
 	{ OMAP_TAG_UART,	                &n800_uart_config },
 	{ OMAP_TAG_FBMEM,			&n800_fbmem0_config },
@@ -448,18 +447,16 @@ static struct i2c_board_info __initdata n800_i2c_board_info_2[] = {
 #endif
 };
 
-static void __init nokia_n800_init(void)
+void __init nokia_n800_common_init(void)
 {
 	platform_add_devices(n800_devices, ARRAY_SIZE(n800_devices));
 
 	n800_flash_init();
 	n800_mmc_init();
 	n800_bt_init();
-	n800_audio_init(&tsc2301_config);
 	n800_dsp_init();
 	n800_usb_init();
 	n800_cam_init();
-	n800_ts_set_config();
 	spi_register_board_info(n800_spi_board_info,
 				ARRAY_SIZE(n800_spi_board_info));
 	omap_serial_init();
@@ -469,12 +466,20 @@ static void __init nokia_n800_init(void)
 			      ARRAY_SIZE(n800_i2c_board_info_2));
 	mipid_dev_init();
 	blizzard_dev_init();
+}
+
+static void __init nokia_n800_init(void)
+{
+	nokia_n800_common_init();
+
+	n800_audio_init(&tsc2301_config);
+	n800_ts_set_config();
 	tsc2301_dev_init();
 	omap_register_gpio_switches(n800_gpio_switches,
 				    ARRAY_SIZE(n800_gpio_switches));
 }
 
-static void __init nokia_n800_map_io(void)
+void __init nokia_n800_map_io(void)
 {
 	omap_board_config = n800_config;
 	omap_board_config_size = ARRAY_SIZE(n800_config);
diff --git a/arch/arm/mach-omap2/board-n800.h b/arch/arm/mach-omap2/board-n800.h
new file mode 100644
index 0000000..556d835
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n800.h
@@ -0,0 +1,21 @@
+/*
+ * linux/arch/arm/mach-omap2/board-n800.c
+ *
+ * Copyright (C) 2005-2007 Nokia Corporation
+ * Author: Lauri Leukkunen <lauri.leukkunen@nokia.com>
+ *
+ * Modified from mach-omap2/board-n800.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_BOARD_N800_H
+#define __ARCH_ARM_MACH_OMAP2_BOARD_N800_H
+
+void __init nokia_n800_common_init(void);
+void __init nokia_n800_map_io(void);
+void __init nokia_n800_init_irq(void);
+
+#endif
diff --git a/arch/arm/mach-omap2/board-n810.c b/arch/arm/mach-omap2/board-n810.c
new file mode 100644
index 0000000..c4f4dd5
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n810.c
@@ -0,0 +1,35 @@
+/*
+ * linux/arch/arm/mach-omap2/board-n810.c
+ *
+ * Copyright (C) 2007 Nokia
+ * Author: Lauri Leukkunen <lauri.leukkunen@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/arch/board.h>
+#include <asm/arch/common.h>
+
+#include "board-n800.h"
+
+static void __init nokia_n810_init(void)
+{
+	nokia_n800_common_init();
+}
+
+MACHINE_START(NOKIA_N810, "Nokia N810")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= nokia_n800_map_io,
+	.init_irq	= nokia_n800_init_irq,
+	.init_machine	= nokia_n810_init,
+	.timer		= &omap_timer,
+MACHINE_END
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 87077af..a7f6ae1 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -34,7 +34,7 @@
 
 #define NO_LENGTH_CHECK 0xffffffff
 
-unsigned char omap_bootloader_tag[512];
+unsigned char omap_bootloader_tag[1024];
 int omap_bootloader_tag_len;
 
 struct omap_board_config_kernel *omap_board_config;
-- 
1.5.3.4
