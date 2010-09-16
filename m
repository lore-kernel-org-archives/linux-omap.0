From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 1/5] omap3: Introduce CompuLab CM-T3517 module.
Date: Thu, 16 Sep 2010 10:54:37 +0200
Message-ID: <1284627281-26059-2-git-send-email-grinberg@compulab.co.il>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:52537 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601Ab0IPIyu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 04:54:50 -0400
In-Reply-To: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

Add basic suppot, enable uart and led.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/Kconfig          |    7 ++
 arch/arm/mach-omap2/Makefile         |    1 +
 arch/arm/mach-omap2/board-cm-t3517.c |  109 ++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-cm-t3517.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b48bacf..da1c37d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -214,6 +214,13 @@ config MACH_CM_T35
 	select OMAP_PACKAGE_CUS
 	select OMAP_MUX
 
+config MACH_CM_T3517
+	bool "CompuLab CM-T3517 module"
+	depends on ARCH_OMAP3
+	default y
+	select OMAP_PACKAGE_CBB
+	select OMAP_MUX
+
 config MACH_IGEP0020
 	bool "IGEP v2 board"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 88d3a1e..7d991d0 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -146,6 +146,7 @@ obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
 					   hsmmc.o
+obj-$(CONFIG_MACH_CM_T3517)		+= board-cm-t3517.o
 obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
new file mode 100644
index 0000000..507d2d5
--- /dev/null
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -0,0 +1,109 @@
+/*
+ * linux/arch/arm/mach-omap2/board-cm-t3517.c
+ *
+ * Support for the CompuLab CM-T3517 modules
+ *
+ * Copyright (C) 2010 CompuLab, Ltd.
+ * Author: Igor Grinberg <grinberg@compulab.co.il>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/control.h>
+
+#include "mux.h"
+
+#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+static struct gpio_led cm_t3517_leds[] = {
+	[0] = {
+		.gpio			= 186,
+		.name			= "cm-t3517:green",
+		.default_trigger	= "heartbeat",
+		.active_low		= 0,
+	},
+};
+
+static struct gpio_led_platform_data cm_t3517_led_pdata = {
+	.num_leds	= ARRAY_SIZE(cm_t3517_leds),
+	.leds		= cm_t3517_leds,
+};
+
+static struct platform_device cm_t3517_led_device = {
+	.name		= "leds-gpio",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &cm_t3517_led_pdata,
+	},
+};
+
+static void __init cm_t3517_init_leds(void)
+{
+	platform_device_register(&cm_t3517_led_device);
+}
+#else
+static inline void cm_t3517_init_leds(void) {}
+#endif
+
+
+static struct omap_board_config_kernel cm_t3517_config[] __initdata = {
+};
+
+static void __init cm_t3517_init_irq(void)
+{
+	omap_board_config = cm_t3517_config;
+	omap_board_config_size = ARRAY_SIZE(cm_t3517_config);
+
+	omap2_init_common_hw(NULL, NULL);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static struct omap_board_mux board_mux[] __initdata = {
+	/* GPIO186 - Green LED */
+	OMAP3_MUX(SYS_CLKOUT2, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
+
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+
+static void __init cm_t3517_init(void)
+{
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+	omap_serial_init();
+	cm_t3517_init_leds();
+}
+
+MACHINE_START(CM_T3517, "Compulab CM-T3517")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= omap3_map_io,
+	.reserve        = omap_reserve,
+	.init_irq	= cm_t3517_init_irq,
+	.init_machine	= cm_t3517_init,
+	.timer		= &omap_timer,
+MACHINE_END
-- 
1.7.1

