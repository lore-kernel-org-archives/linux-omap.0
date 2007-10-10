From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 1/2] To add basic support for Mistral's OMAP2430 OSK
Date: Wed, 10 Oct 2007 18:22:03 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701F4A225@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Adds minimal booting support for MISTRAL's OMAP2430 OSK=20

All Credit and Thanks to Mistral's 2430 OSK Team

Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>

File:
 arch/arm/mach-omap2/Kconfig
 arch/arm/mach-omap2/Makefile
 arch/arm/mach-omap2/board-2430osk.c

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

diff -purN linux-omap/arch/arm/mach-omap2/Kconfig =
my_linux-omap/arch/arm/mach-omap2/Kconfig
--- linux-omap/arch/arm/mach-omap2/Kconfig	2007-09-22 06:35:39.000000000 =
-0500
+++ my_linux-omap/arch/arm/mach-omap2/Kconfig	2007-10-10 =
10:54:09.000000000 -0500
@@ -104,3 +104,6 @@ config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
=20
+config MACH_OMAP_2430OSK
+	bool "OMAP 2430 OSK board"
+	depends on ARCH_OMAP2 && ARCH_OMAP24XX

diff -purN linux-omap/arch/arm/mach-omap2/Makefile =
my_linux-omap/arch/arm/mach-omap2/Makefile
--- linux-omap/arch/arm/mach-omap2/Makefile	2007-10-09 =
18:14:08.000000000 -0500
+++ my_linux-omap/arch/arm/mach-omap2/Makefile	2007-10-10 =
10:55:00.000000000 -0500
@@ -27,6 +27,7 @@ obj-$(CONFIG_MACH_OMAP_H4)		+=3D board-h4.
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+=3D board-2430sdp.o \
 					   board-2430sdp-flash.o \
 					   board-2430sdp-usb.o
+obj-$(CONFIG_MACH_OMAP_2430OSK)		+=3D board-2430osk.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+=3D board-3430sdp.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+=3D board-apollon.o \
 					   board-apollon-keys.o

diff -purN linux-omap/arch/arm/mach-omap2/board-2430osk.c =
my_linux-omap/arch/arm/mach-omap2/board-2430osk.c
--- linux-omap/arch/arm/mach-omap2/board-2430osk.c	1969-12-31 =
18:00:00.000000000 -0600
+++ my_linux-omap/arch/arm/mach-omap2/board-2430osk.c	2007-10-10 =
17:49:49.000000000 -0500
@@ -0,0 +1,142 @@
+/*
+ * linux/arch/arm/mach-omap2/board-2430osk.c
+ *
+ * Copyright (C) 2007 Mistral Software Pvt Ltd
+ *
+ * Modified from mach-omap2/board-generic.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <asm/arch/gpio.h>
+#include <asm/arch/board.h>
+#include <asm/arch/common.h>
+
+#include <asm/io.h>
+
+static void __init omap_2430osk_init_irq(void)
+{
+	omap2_init_common_hw();
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static struct omap_uart_config osk2430_uart_config __initdata =3D {
+	.enabled_uarts	=3D ((1 << 0) | (1 << 1) | (1 << 2)),
+};
+
+static struct omap_board_config_kernel osk2430_config[] __initdata =3D =
{
+
+	{OMAP_TAG_UART, &osk2430_uart_config},
+};
+
+#if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
+
+#define OMAP2_I2C_BASE1		0x48070000
+#define OMAP2_I2C_BASE2		0x48072000
+#define OMAP2_I2C_INT1		56
+#define OMAP2_I2C_INT2		57
+
+static u32 omap2_i2c1_clkrate	=3D 400;
+static u32 omap2_i2c2_clkrate	=3D 2600;
+
+static struct resource i2c_resources1[] =3D {
+	{
+		.start	=3D OMAP2_I2C_BASE1,
+		.end	=3D OMAP2_I2C_BASE1 + 0x3f,
+		.flags	=3D IORESOURCE_MEM,
+	},
+	{
+		.start	=3D OMAP2_I2C_INT1,
+		.flags	=3D IORESOURCE_IRQ,
+	},
+};
+
+static struct resource i2c_resources2[] =3D {
+	{
+		.start	=3D OMAP2_I2C_BASE2,
+		.end	=3D OMAP2_I2C_BASE2 + 0x3f,
+		.flags	=3D IORESOURCE_MEM,
+	},
+	{
+		.start	=3D OMAP2_I2C_INT2,
+		.flags	=3D IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap_i2c_device1 =3D {
+	.name		=3D "i2c_omap",
+	.id		=3D 1,
+	.num_resources	=3D ARRAY_SIZE(i2c_resources1),
+	.resource	=3D i2c_resources1,
+	.dev		=3D {
+		.platform_data	=3D &omap2_i2c1_clkrate,
+	},
+};
+
+static struct platform_device omap_i2c_device2 =3D {
+	.name		=3D "i2c_omap",
+	.id		=3D 2,
+	.num_resources	=3D ARRAY_SIZE(i2c_resources2),
+	.resource	=3D i2c_resources2,
+	.dev		=3D {
+		.platform_data	=3D &omap2_i2c2_clkrate,
+	},
+};
+
+static void omap_init_i2c(void)
+{
+	(void) platform_device_register(&omap_i2c_device2);
+	(void) platform_device_register(&omap_i2c_device1);
+}
+
+#else
+
+static void omap_init_i2c(void) {}
+
+#endif
+
+static int __init omap2430_i2c_init(void)
+{
+	omap_init_i2c();
+	return 0;
+}
+
+static void __init omap_2430osk_init(void)
+{
+	omap_board_config =3D osk2430_config;
+	omap_board_config_size =3D ARRAY_SIZE(osk2430_config);
+	omap_serial_init();
+}
+
+static void __init omap_2430osk_map_io(void)
+{
+	omap2_map_common_io();
+}
+
+arch_initcall(omap2430_i2c_init);
+
+MACHINE_START(OMAP_2430OSK, "OMAP2430 2430OSK board")
+	/* Maintainer: Syed Khasim */
+	.phys_io	=3D 0x48000000,
+	.io_pg_offst	=3D ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	=3D 0x80000100,
+	.map_io		=3D omap_2430osk_map_io,
+	.init_irq	=3D omap_2430osk_init_irq,
+	.init_machine	=3D omap_2430osk_init,
+	.timer		=3D &omap_timer,
+MACHINE_END
