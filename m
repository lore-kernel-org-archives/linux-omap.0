From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/8] ARM: OMAP3: Add support for OMAP3 Zoom2 board, v2
Date: Thu, 28 May 2009 14:13:06 -0700
Message-ID: <20090528211306.GJ32453@atomide.com>
References: <20090525174517.19679.18805.stgit@localhost> <20090525175335.19679.3398.stgit@localhost> <20090528160535.GE20736@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pZs/OQEoSSbxGlYw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57604 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975AbZE1VNX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 17:13:23 -0400
Content-Disposition: inline
In-Reply-To: <20090528160535.GE20736@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Mikkel Christensen <mlc@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090528 09:05]:
> On Mon, May 25, 2009 at 10:53:35AM -0700, Tony Lindgren wrote:
> > diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
> > new file mode 100644
> > index 0000000..91f07c1
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
> > @@ -0,0 +1,160 @@
> > +/*
> > + * Copyright (C) 2009 Texas Instruments Inc.
> > + * Mikkel Christensen <mlc@ti.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/serial_8250.h>
> > +#include <linux/smsc911x.h>
> > +
> > +#include <mach/gpio.h>
> 
> linux/gpio.h please.
> 
> > diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
> > new file mode 100644
> > index 0000000..d4cd7ff
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/board-zoom2.c
> > @@ -0,0 +1,110 @@
> > +/*
> > + * Copyright (C) 2009 Texas Instruments Inc.
> > + * Mikkel Christensen <mlc@ti.com>
> > + *
> > + * Modified from mach-omap2/board-ldp.c
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/i2c/twl4030.h>
> > +
> > +#include <asm/mach-types.h>
> > +#include <asm/mach/arch.h>
> > +
> > +#include <mach/gpio.h>
> 
> Ditto.

Good eye. Here's this one updated.

Tony

--pZs/OQEoSSbxGlYw
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="zoom2-v2.patch"

>From 577145f45487b41b4d47eeaedb9d37e494f80715 Mon Sep 17 00:00:00 2001
From: Vikram Pandita <vikram.pandita@ti.com>
Date: Thu, 28 May 2009 14:04:04 -0700
Subject: [PATCH] ARM: OMAP3: Add support for OMAP3 Zoom2 board

This patch creates the minimal OMAP3 Zoom2 board support.

Signed-off-by: Mikkel Christensen <mlc@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 64ab386..f6cf903 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -67,3 +67,7 @@ config MACH_OMAP_3430SDP
 config MACH_NOKIA_RX51
 	bool "Nokia RX-51 board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
+config MACH_OMAP_ZOOM2
+	bool "OMAP3 Zoom2 board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index e4f6f61..4cdb318 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -53,7 +53,9 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
 					   mmc-twl4030.o
-
+obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
+					   mmc-twl4030.o \
+					   board-zoom-debugboard.o
 # Platform specific device init code
 ifeq ($(CONFIG_USB_MUSB_SOC),y)
 obj-y					+= usb-musb.o
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
new file mode 100644
index 0000000..bac5c43
--- /dev/null
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -0,0 +1,160 @@
+/*
+ * Copyright (C) 2009 Texas Instruments Inc.
+ * Mikkel Christensen <mlc@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+#include <linux/serial_8250.h>
+#include <linux/smsc911x.h>
+
+#include <mach/gpmc.h>
+
+#define ZOOM2_SMSC911X_CS	7
+#define ZOOM2_SMSC911X_GPIO	158
+#define ZOOM2_QUADUART_CS	3
+#define ZOOM2_QUADUART_GPIO	102
+#define QUART_CLK		1843200
+#define DEBUG_BASE		0x08000000
+#define ZOOM2_ETHR_START	DEBUG_BASE
+
+static struct resource zoom2_smsc911x_resources[] = {
+	[0] = {
+		.start	= ZOOM2_ETHR_START,
+		.end	= ZOOM2_ETHR_START + SZ_4K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
+	},
+};
+
+static struct smsc911x_platform_config zoom2_smsc911x_config = {
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
+	.flags		= SMSC911X_USE_32BIT,
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+};
+
+static struct platform_device zoom2_smsc911x_device = {
+	.name		= "smsc911x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(zoom2_smsc911x_resources),
+	.resource	= zoom2_smsc911x_resources,
+	.dev		= {
+		.platform_data = &zoom2_smsc911x_config,
+	},
+};
+
+static inline void __init zoom2_init_smsc911x(void)
+{
+	int eth_cs;
+	unsigned long cs_mem_base;
+	int eth_gpio = 0;
+
+	eth_cs = ZOOM2_SMSC911X_CS;
+
+	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
+		printk(KERN_ERR "Failed to request GPMC mem for smsc911x\n");
+		return;
+	}
+
+	zoom2_smsc911x_resources[0].start = cs_mem_base + 0x0;
+	zoom2_smsc911x_resources[0].end   = cs_mem_base + 0xff;
+
+	eth_gpio = ZOOM2_SMSC911X_GPIO;
+
+	zoom2_smsc911x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
+
+	if (gpio_request(eth_gpio, "smsc911x irq") < 0) {
+		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
+				eth_gpio);
+		return;
+	}
+	gpio_direction_input(eth_gpio);
+}
+
+static struct plat_serial8250_port serial_platform_data[] = {
+	{
+		.mapbase	= 0x10000000,
+		.irq		= OMAP_GPIO_IRQ(102),
+		.flags		= UPF_BOOT_AUTOCONF|UPF_IOREMAP|UPF_SHARE_IRQ,
+		.iotype		= UPIO_MEM,
+		.regshift	= 1,
+		.uartclk	= QUART_CLK,
+	}, {
+		.flags		= 0
+	}
+};
+
+static struct platform_device zoom2_debugboard_serial_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM1,
+	.dev			= {
+		.platform_data	= serial_platform_data,
+	},
+};
+
+static inline void __init zoom2_init_quaduart(void)
+{
+	int quart_cs;
+	unsigned long cs_mem_base;
+	int quart_gpio = 0;
+
+	quart_cs = ZOOM2_QUADUART_CS;
+
+	if (gpmc_cs_request(quart_cs, SZ_1M, &cs_mem_base) < 0) {
+		printk(KERN_ERR "Failed to request GPMC mem"
+				"for Quad UART(TL16CP754C)\n");
+		return;
+	}
+
+	quart_gpio = ZOOM2_QUADUART_GPIO;
+
+	if (gpio_request(quart_gpio, "TL16CP754C GPIO") < 0) {
+		printk(KERN_ERR "Failed to request GPIO%d for TL16CP754C\n",
+								quart_gpio);
+		return;
+	}
+	gpio_direction_input(quart_gpio);
+}
+
+static inline int omap_zoom2_debugboard_detect(void)
+{
+	int debug_board_detect = 0;
+
+	debug_board_detect = ZOOM2_SMSC911X_GPIO;
+
+	if (gpio_request(debug_board_detect, "Zoom2 debug board detect") < 0) {
+		printk(KERN_ERR "Failed to request GPIO%d for Zoom2 debug"
+		"board detect\n", debug_board_detect);
+		return 0;
+	}
+	gpio_direction_input(debug_board_detect);
+
+	if (!gpio_get_value(debug_board_detect)) {
+		gpio_free(debug_board_detect);
+		return 0;
+	}
+	return 1;
+}
+
+static struct platform_device *zoom2_devices[] __initdata = {
+	&zoom2_smsc911x_device,
+	&zoom2_debugboard_serial_device,
+};
+
+int __init omap_zoom2_debugboard_init(void)
+{
+	if (!omap_zoom2_debugboard_detect())
+		return 0;
+
+	zoom2_init_smsc911x();
+	zoom2_init_quaduart();
+	return platform_add_devices(zoom2_devices, ARRAY_SIZE(zoom2_devices));
+}
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
new file mode 100644
index 0000000..bcc0f76
--- /dev/null
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -0,0 +1,110 @@
+/*
+ * Copyright (C) 2009 Texas Instruments Inc.
+ * Mikkel Christensen <mlc@ti.com>
+ *
+ * Modified from mach-omap2/board-ldp.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/i2c/twl4030.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/common.h>
+#include <mach/usb.h>
+
+#include "mmc-twl4030.h"
+
+static void __init omap_zoom2_init_irq(void)
+{
+	omap2_init_common_hw(NULL);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static struct omap_uart_config zoom2_uart_config __initdata = {
+	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
+};
+
+static struct omap_board_config_kernel zoom2_config[] __initdata = {
+	{ OMAP_TAG_UART,	&zoom2_uart_config },
+};
+
+static struct twl4030_gpio_platform_data zoom2_gpio_data = {
+	.gpio_base	= OMAP_MAX_GPIO_LINES,
+	.irq_base	= TWL4030_GPIO_IRQ_BASE,
+	.irq_end	= TWL4030_GPIO_IRQ_END,
+};
+
+static struct twl4030_platform_data zoom2_twldata = {
+	.irq_base	= TWL4030_IRQ_BASE,
+	.irq_end	= TWL4030_IRQ_END,
+
+	/* platform_data for children goes here */
+	.gpio		= &zoom2_gpio_data,
+};
+
+static struct i2c_board_info __initdata zoom2_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl4030", 0x48),
+		.flags		= I2C_CLIENT_WAKE,
+		.irq		= INT_34XX_SYS_NIRQ,
+		.platform_data	= &zoom2_twldata,
+	},
+};
+
+static int __init omap_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 2600, zoom2_i2c_boardinfo,
+			ARRAY_SIZE(zoom2_i2c_boardinfo));
+	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, 0);
+	return 0;
+}
+
+static struct twl4030_hsmmc_info mmc[] __initdata = {
+	{
+		.mmc		= 1,
+		.wires		= 4,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+	},
+	{}	/* Terminator */
+};
+
+extern int __init omap_zoom2_debugboard_init(void);
+
+static void __init omap_zoom2_init(void)
+{
+	omap_i2c_init();
+	omap_board_config = zoom2_config;
+	omap_board_config_size = ARRAY_SIZE(zoom2_config);
+	omap_serial_init();
+	omap_zoom2_debugboard_init();
+	twl4030_mmc_init(mmc);
+	usb_musb_init();
+}
+
+static void __init omap_zoom2_map_io(void)
+{
+	omap2_set_globals_343x();
+	omap2_map_common_io();
+}
+
+MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= omap_zoom2_map_io,
+	.init_irq	= omap_zoom2_init_irq,
+	.init_machine	= omap_zoom2_init,
+	.timer		= &omap_timer,
+MACHINE_END

--pZs/OQEoSSbxGlYw--
