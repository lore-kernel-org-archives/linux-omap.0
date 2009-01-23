From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: [PATCH] RX51: Initial support
Date: Fri, 23 Jan 2009 23:08:46 +0200
Message-ID: <1232744927-21010-2-git-send-email-lauri.leukkunen@nokia.com>
References: <1232744927-21010-1-git-send-email-lauri.leukkunen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64156 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338AbZAWVK1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 16:10:27 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0NL88UU030644
	for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2009 15:10:25 -0600
In-Reply-To: <1232744927-21010-1-git-send-email-lauri.leukkunen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lauri Leukkunen <lauri.leukkunen@nokia.com>

Adds board files and related headers for Nokia RX-51
Internet Tablet.

Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
---
 arch/arm/mach-omap2/Kconfig                  |    4 +
 arch/arm/mach-omap2/Makefile                 |    9 +
 arch/arm/mach-omap2/board-rx51-flash.c       |   75 ++++++++
 arch/arm/mach-omap2/board-rx51-peripherals.c |  250 ++++++++++++++++++=
++++++++
 arch/arm/mach-omap2/board-rx51-sdram.c       |  219 ++++++++++++++++++=
++++
 arch/arm/mach-omap2/board-rx51-video.c       |   79 ++++++++
 arch/arm/mach-omap2/board-rx51.c             |  102 +++++++++++
 arch/arm/plat-omap/include/mach/board-rx51.h |   47 +++++
 arch/arm/plat-omap/include/mach/hardware.h   |    5 +
 9 files changed, 790 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-rx51-flash.c
 create mode 100644 arch/arm/mach-omap2/board-rx51-peripherals.c
 create mode 100644 arch/arm/mach-omap2/board-rx51-sdram.c
 create mode 100644 arch/arm/mach-omap2/board-rx51-video.c
 create mode 100644 arch/arm/mach-omap2/board-rx51.c
 create mode 100644 arch/arm/plat-omap/include/mach/board-rx51.h

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0a86a88..8fa650d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -53,6 +53,10 @@ config MACH_NOKIA_N810_WIMAX
 	depends on MACH_NOKIA_N800
 	select MACH_NOKIA_N810
=20
+config MACH_NOKIA_RX51
+	bool "Nokia RX-51 board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 config MACH_OMAP2_TUSB6010
 	bool
 	depends on ARCH_OMAP2 && ARCH_OMAP2420
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index 00b2fb8..631166d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -74,6 +74,15 @@ obj-$(CONFIG_MACH_NOKIA_N800)		+=3D board-n800.o boa=
rd-n800-flash.o \
 					   board-n800-dsp.o \
 					   board-n800-camera.o
 obj-$(CONFIG_MACH_NOKIA_N810)		+=3D board-n810.o
+obj-$(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51.o \
+					   board-n800-flash.o \
+					   board-rx51-flash.o \
+					   board-rx51-sdram.o \
+					   board-rx51-video.o \
+					   board-rx51-peripherals.o \
+					   mmc-twl4030.o \
+					   usb-musb.o
+
 obj-$(CONFIG_MACH_OVERO)		+=3D board-overo.o \
 					   mmc-twl4030.o \
 					   usb-musb.o \
diff --git a/arch/arm/mach-omap2/board-rx51-flash.c b/arch/arm/mach-oma=
p2/board-rx51-flash.c
new file mode 100644
index 0000000..7af0d46
--- /dev/null
+++ b/arch/arm/mach-omap2/board-rx51-flash.c
@@ -0,0 +1,75 @@
+/*
+ * linux/arch/arm/mach-omap2/board-rx51-flash.c
+ *
+ * Copyright (C) 2008 Nokia
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <asm/mach/flash.h>
+
+#include <mach/onenand.h>
+
+#include "mmc-twl4030.h"
+
+#define	RX51_FLASH_CS	0
+
+extern struct mtd_partition n800_partitions[ONENAND_MAX_PARTITIONS];
+extern int n800_onenand_setup(void __iomem *onenand_base, int freq);
+extern void __init n800_flash_init(void);
+
+static struct flash_platform_data rx51_flash_data =3D {
+	.map_name	=3D "cfi_probe",
+	.width		=3D 2,
+	.parts		=3D n800_partitions,
+	.nr_parts	=3D ARRAY_SIZE(n800_partitions),
+};
+
+static struct resource rx51_flash_resource =3D {
+	.flags		=3D IORESOURCE_MEM,
+};
+
+static struct platform_device rx51_flash_device =3D {
+	.name		=3D "omapflash",
+	.id		=3D 0,
+	.dev		=3D {
+		.platform_data	=3D &rx51_flash_data,
+	},
+	.num_resources	=3D 1,
+	.resource	=3D &rx51_flash_resource,
+};
+
+static struct platform_device *rx51_flash_devices[] =3D {
+	&rx51_flash_device,
+};
+
+static struct twl4030_hsmmc_info mmc[] __initdata =3D {
+	{
+		.mmc		=3D 1,
+		.wires		=3D 8,
+		.gpio_cd	=3D 160,
+		.gpio_wp	=3D -EINVAL,
+	},
+	{
+		.mmc		=3D 2,
+		.wires		=3D 8,
+		.gpio_cd	=3D -EINVAL,
+		.gpio_wp	=3D -EINVAL,
+	},
+	{}	/* Terminator */
+};
+
+void __init rx51_flash_init(void)
+{
+	platform_add_devices(rx51_flash_devices, ARRAY_SIZE(rx51_flash_device=
s));
+	n800_flash_init();
+	twl4030_mmc_init(mmc);
+}
+
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/ma=
ch-omap2/board-rx51-peripherals.c
new file mode 100644
index 0000000..9da0187
--- /dev/null
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -0,0 +1,250 @@
+/*
+ * linux/arch/arm/mach-omap2/board-rx51-flash.c
+ *
+ * Copyright (C) 2008 Nokia
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2005.h>
+#include <linux/i2c.h>
+#include <linux/i2c/twl4030.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+
+#include <mach/mcspi.h>
+#include <mach/gpio.h>
+#include <mach/mux.h>
+#include <mach/board.h>
+#include <mach/common.h>
+#include <mach/keypad.h>
+#include <mach/dma.h>
+#include <mach/gpmc.h>
+
+#define RX51_DEBUG_BASE			0x08000000  /* debug board */
+#define RX51_ETHR_START			RX51_DEBUG_BASE
+#define RX51_ETHR_GPIO_IRQ		54
+
+#define RX51_TSC2005_RESET_GPIO		104
+#define RX51_TSC2005_IRQ_GPIO		100
+
+#define	RX51_SMC91X_CS			1
+
+static struct resource rx51_smc91x_resources[] =3D {
+	[0] =3D {
+		.start	=3D RX51_ETHR_START,
+		.end	=3D RX51_ETHR_START + SZ_4K,
+		.flags		=3D IORESOURCE_MEM,
+	},
+	[1] =3D {
+		.start		=3D OMAP_GPIO_IRQ(RX51_ETHR_GPIO_IRQ),
+		.end	=3D 0,
+		.flags		=3D IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
+	},
+};
+
+static struct platform_device rx51_smc91x_device =3D {
+	.name		=3D "smc91x",
+	.id		=3D -1,
+	.num_resources	=3D ARRAY_SIZE(rx51_smc91x_resources),
+	.resource	=3D rx51_smc91x_resources,
+};
+
+static struct tsc2005_platform_data tsc2005_config =3D {
+	.reset_gpio 		=3D RX51_TSC2005_RESET_GPIO, /* not used */
+
+	.ts_x_plate_ohm		=3D 280,
+	.ts_hw_avg		=3D 0,
+	.ts_touch_pressure	=3D 1500,
+	.ts_stab_time		=3D 1000,
+	.ts_pressure_max	=3D 2048,
+	.ts_pressure_fudge	=3D 2,
+	.ts_x_max		=3D 4096,
+	.ts_x_fudge		=3D 4,
+	.ts_y_max		=3D 4096,
+	.ts_y_fudge		=3D 7,
+};
+
+static struct omap2_mcspi_device_config tsc2005_mcspi_config =3D {
+	.turbo_mode	=3D 0,
+	.single_channel =3D 1,
+};
+
+
+static struct spi_board_info rx51_peripherals_spi_board_info[] =3D {
+	[0] =3D {
+		.modalias		=3D "tsc2005",
+		.bus_num		=3D 1,
+		.chip_select		=3D 0,
+		.irq	 		=3D OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),
+		.max_speed_hz   	=3D 6000000,
+		.controller_data	=3D &tsc2005_mcspi_config,
+		.platform_data		=3D &tsc2005_config,
+	},
+};
+
+static int rx51_keymap[] =3D {
+	KEY(0, 0, KEY_Q),
+	KEY(0, 1, KEY_W),
+	KEY(0, 2, KEY_E),
+	KEY(0, 3, KEY_R),
+	KEY(0, 4, KEY_T),
+	KEY(0, 5, KEY_Y),
+	KEY(0, 6, KEY_U),
+	KEY(0, 7, KEY_I),
+	KEY(1, 0, KEY_O),
+	KEY(1, 1, KEY_D),
+	KEY(1, 2, KEY_DOT ),
+	KEY(1, 3, KEY_V),
+	KEY(1, 4, KEY_DOWN ),
+	KEY(2, 0, KEY_P),
+	KEY(2, 1, KEY_F),
+	KEY(2, 2, KEY_UP ),
+	KEY(2, 3, KEY_B),
+	KEY(2, 4, KEY_RIGHT ),
+	KEY(3, 0, KEY_COMMA ),
+	KEY(3, 1, KEY_G),
+	KEY(3, 2, KEY_ENTER ),
+	KEY(3, 3, KEY_N),
+	KEY(4, 0, KEY_BACKSPACE ),
+	KEY(4, 1, KEY_H),
+	KEY(4, 3, KEY_M),
+	KEY(4, 4, KEY_LEFTCTRL),
+	KEY(5, 1, KEY_J),
+	KEY(5, 2, KEY_Z),
+	KEY(5, 3, KEY_SPACE),
+	KEY(5, 4, KEY_LEFTSHIFT),
+	KEY(6, 0, KEY_A),
+	KEY(6, 1, KEY_K),
+	KEY(6, 2, KEY_X),
+	KEY(6, 3, KEY_SPACE),
+	KEY(6, 4, KEY_FN ),
+	KEY(7, 0, KEY_S),
+	KEY(7, 1, KEY_L),
+	KEY(7, 2, KEY_C),
+	KEY(7, 3, KEY_LEFT),
+	KEY(0xff, 0, KEY_F6),
+	KEY(0xff, 1, KEY_F7),
+	KEY(0xff, 2, KEY_F8),
+	KEY(0xff, 4, KEY_F9),
+	KEY(0xff, 5, KEY_F10),
+};
+
+static struct twl4030_keypad_data rx51_kp_data =3D {
+	.rows		=3D 8,
+	.cols		=3D 8,
+	.keymap 	=3D rx51_keymap,
+	.keymapsize 	=3D ARRAY_SIZE(rx51_keymap),
+	.rep		=3D 1,
+};
+
+static struct platform_device *rx51_peripherals_devices[] =3D {
+	&rx51_smc91x_device,
+};
+
+static void __init rx51_init_smc91x(void)
+{
+	int eth_cs;
+	unsigned long cs_mem_base;
+	unsigned int rate;
+	struct clk *l3ck;
+
+	eth_cs	=3D RX51_SMC91X_CS;
+
+	l3ck =3D clk_get(NULL, "core_l3_ck");
+	if (IS_ERR(l3ck))
+		rate =3D 100000000;
+	else
+		rate =3D clk_get_rate(l3ck);
+
+	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
+		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
+		return;
+	}
+
+	rx51_smc91x_resources[0].start =3D cs_mem_base + 0x0;
+	rx51_smc91x_resources[0].end   =3D cs_mem_base + 0xf;
+	udelay(100);
+
+	if (gpio_request(RX51_ETHR_GPIO_IRQ, "SMC91X irq") < 0) {
+		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
+			RX51_ETHR_GPIO_IRQ);
+		return;
+	}
+	gpio_direction_input(RX51_ETHR_GPIO_IRQ);
+}
+
+static void __init rx51_init_tsc2005(void)
+{
+	int r;
+
+	r =3D gpio_request(RX51_TSC2005_IRQ_GPIO, "tsc2005 DAV IRQ");
+	if (r >=3D 0) {
+		gpio_direction_input(RX51_TSC2005_IRQ_GPIO);
+	} else {
+		printk(KERN_ERR "unable to get DAV GPIO");
+	}
+}
+
+static struct twl4030_usb_data rx51_usb_data =3D {
+	.usb_mode		=3D T2_USB_MODE_ULPI,
+};
+
+static struct twl4030_madc_platform_data rx51_madc_data =3D {
+	.irq_line		=3D 1,
+};
+
+static struct twl4030_gpio_platform_data rx51_gpio_data =3D {
+	.gpio_base		=3D OMAP_MAX_GPIO_LINES,
+	.irq_base		=3D TWL4030_GPIO_IRQ_BASE,
+	.irq_end		=3D TWL4030_GPIO_IRQ_END,
+};
+
+static struct twl4030_platform_data rx51_twldata =3D {
+	.irq_base		=3D TWL4030_IRQ_BASE,
+	.irq_end		=3D TWL4030_IRQ_END,
+
+	/* platform_data for children goes here */
+	.gpio			=3D &rx51_gpio_data,
+	.keypad			=3D &rx51_kp_data,
+	.madc			=3D &rx51_madc_data,
+	.usb			=3D &rx51_usb_data,
+};
+
+static struct i2c_board_info __initdata rx51_peripherals_i2c_board_inf=
o_1[] =3D {
+	{
+		I2C_BOARD_INFO("twl4030", 0x48),
+		.flags =3D I2C_CLIENT_WAKE,
+		.irq =3D INT_34XX_SYS_NIRQ,
+		.platform_data =3D &rx51_twldata,
+	},
+};
+
+static int __init rx51_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 2600, rx51_peripherals_i2c_board_info_1,
+			ARRAY_SIZE(rx51_peripherals_i2c_board_info_1));
+	omap_register_i2c_bus(2, 100, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, 0);
+	return 0;
+}
+
+
+void __init rx51_peripherals_init(void)
+{
+	platform_add_devices(rx51_peripherals_devices,
+				ARRAY_SIZE(rx51_peripherals_devices));
+	spi_register_board_info(rx51_peripherals_spi_board_info,
+				ARRAY_SIZE(rx51_peripherals_spi_board_info));
+	rx51_i2c_init();
+	rx51_init_smc91x();
+	rx51_init_tsc2005();
+}
+
diff --git a/arch/arm/mach-omap2/board-rx51-sdram.c b/arch/arm/mach-oma=
p2/board-rx51-sdram.c
new file mode 100644
index 0000000..32b5da4
--- /dev/null
+++ b/arch/arm/mach-omap2/board-rx51-sdram.c
@@ -0,0 +1,219 @@
+/*
+ * SDRC register values for the Samsung K4X1G323PC
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Lauri Leukkunen <lauri.leukkunen@nokia.com>
+ *
+ * Original code by Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@solidboot.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <mach/io.h>
+#include <mach/common.h>
+#include <mach/clock.h>
+#include <mach/sdrc.h>
+
+
+/* In picoseconds, except for tREF */
+struct sdram_timings {
+	u32 casl;
+	u32 tDAL;
+	u32 tDPL;
+	u32 tRRD;
+	u32 tRCD;
+	u32 tRP;
+	u32 tRAS;
+	u32 tRC;
+	u32 tRFC;
+	u32 tXSR;
+
+	u32 tREF; /* in ms */
+};
+
+struct sdram_info {
+	u8 row_lines;
+};
+
+
+struct omap_sdrc_params rx51_sdrc_params[2];
+
+static const struct sdram_timings rx51_timings[] =3D {
+	{
+		.casl =3D 3,
+		.tDAL =3D 15000 + 18000,
+		.tDPL =3D 15000,
+		.tRRD =3D 12000,
+		.tRCD =3D 18000,
+		.tRP =3D 18000,
+		.tRAS =3D 42000,
+		.tRC =3D 66000,
+		.tRFC =3D 97500,
+		.tXSR =3D 120000,
+
+		.tREF =3D 64,
+	},
+};
+
+static const struct sdram_info rx51_info =3D {
+	.row_lines =3D 13,
+};
+
+#define CM_BASE		    0x48004000
+
+#define CM_CLKSEL_CORE      0x0a40
+#define CM_CLKSEL1_PLL      0x0d40
+
+#define PRM_CLKSEL          0x48306d40
+#define PRM_CLKSRC_CTRL     0x48307270
+
+static u32 cm_base =3D CM_BASE;
+
+static inline u32 cm_read_reg(int idx)
+{
+	return *(u32 *)OMAP2_IO_ADDRESS(cm_base + idx);
+}
+
+static const unsigned long sys_clk_rate_table[] =3D {
+	12000, 13000, 19200, 26000, 38400, 16800
+};
+
+static unsigned long get_sys_clk_rate(void)
+{
+	unsigned long rate;
+
+	rate =3D sys_clk_rate_table[*(u32 *)OMAP2_IO_ADDRESS(PRM_CLKSEL) & 0x=
07];
+	if (((*(u32 *)OMAP2_IO_ADDRESS(PRM_CLKSRC_CTRL) >> 6) & 0x03) =3D=3D =
0x02)
+		rate /=3D 2;
+	return rate;
+}
+
+static unsigned long get_core_rate(void)
+{
+	unsigned long rate;
+	u32 l;
+
+	l =3D cm_read_reg(CM_CLKSEL1_PLL);
+	rate =3D get_sys_clk_rate();
+	rate *=3D ((l >> 16) & 0x7ff);
+	rate /=3D ((l >> 8) & 0x7f) + 1;
+	rate /=3D (l >> 27) & 0x1f;
+
+	return rate;
+}
+
+static unsigned long get_l3_rate(void)
+{
+	u32 l;
+
+	l =3D cm_read_reg(CM_CLKSEL_CORE);
+	return get_core_rate() / (l & 0x03);
+}
+
+
+
+static unsigned long sdrc_get_fclk_period(void)
+{
+	/* In picoseconds */
+	return 1000000000 / get_l3_rate();
+}
+
+static unsigned int sdrc_ps_to_ticks(unsigned int time_ps)
+{
+	unsigned long tick_ps;
+
+	/* Calculate in picosecs to yield more exact results */
+	tick_ps =3D sdrc_get_fclk_period();
+
+	return (time_ps + tick_ps - 1) / tick_ps;
+}
+#undef DEBUG
+#ifdef DEBUG
+static int set_sdrc_timing_regval(u32 *regval, int st_bit, int end_bit=
,
+			       int time, const char *name)
+#else
+static int set_sdrc_timing_regval(u32 *regval, int st_bit, int end_bit=
,
+			       int time)
+#endif
+{
+	int ticks, mask, nr_bits;
+
+	if (time =3D=3D 0)
+		ticks =3D 0;
+	else
+		ticks =3D sdrc_ps_to_ticks(time);
+	nr_bits =3D end_bit - st_bit + 1;
+	if (ticks >=3D 1 << nr_bits)
+		return -1;
+	mask =3D (1 << nr_bits) - 1;
+	*regval &=3D ~(mask << st_bit);
+	*regval |=3D ticks << st_bit;
+#ifdef DEBUG
+	printk("SDRC %s: %i ticks %i ns\n", name, ticks,
+			(unsigned int)sdrc_get_fclk_period() * ticks / 1000);
+#endif
+
+	return 0;
+}
+
+#ifdef DEBUG
+#define SDRC_SET_ONE(reg, st, end, field) \
+	if (set_sdrc_timing_regval((reg), (st), (end), rx51_timings->field, #=
field) < 0) \
+		err =3D -1
+#else
+#define SDRC_SET_ONE(reg, st, end, field) \
+	if (set_sdrc_timing_regval((reg), (st), (end), rx51_timings->field) <=
 0) \
+		err =3D -1
+#endif
+
+struct omap_sdrc_params *rx51_get_sdram_timings(void)
+{
+	u32 ticks_per_ms;
+	u32 rfr, l;
+	u32 actim_ctrla, actim_ctrlb;
+	u32 rfr_ctrl;
+	int err =3D 0;
+
+	SDRC_SET_ONE(&actim_ctrla,  0,  4, tDAL);
+	SDRC_SET_ONE(&actim_ctrla,  6,  8, tDPL);
+	SDRC_SET_ONE(&actim_ctrla,  9, 11, tRRD);
+	SDRC_SET_ONE(&actim_ctrla, 12, 14, tRCD);
+	SDRC_SET_ONE(&actim_ctrla, 15, 17, tRP);
+	SDRC_SET_ONE(&actim_ctrla, 18, 21, tRAS);
+	SDRC_SET_ONE(&actim_ctrla, 22, 26, tRC);
+	SDRC_SET_ONE(&actim_ctrla, 27, 31, tRFC);
+
+	SDRC_SET_ONE(&actim_ctrlb,  0,  7, tXSR);
+
+	ticks_per_ms =3D sdrc_ps_to_ticks(1000000000);
+	rfr =3D rx51_timings[0].tREF * ticks_per_ms / (1 << rx51_info.row_lin=
es);
+	if (rfr > 65535 + 50)
+		rfr =3D 65535;
+	else
+		rfr -=3D 50;
+
+	l =3D rfr << 8;
+	rfr_ctrl =3D l | 0x3; /* autorefresh, reload counter with 8xARCV */
+
+	rx51_sdrc_params[0].rate =3D 133333333;
+	rx51_sdrc_params[0].actim_ctrla =3D actim_ctrla;
+	rx51_sdrc_params[0].actim_ctrlb =3D actim_ctrlb;
+	rx51_sdrc_params[0].rfr_ctrl =3D rfr_ctrl;
+	rx51_sdrc_params[0].mr =3D 0x32;
+
+	rx51_sdrc_params[1].rate =3D 0;
+
+	if (err < 0)
+		return NULL;
+
+	return &rx51_sdrc_params[0];
+}
+
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-oma=
p2/board-rx51-video.c
new file mode 100644
index 0000000..6ebdc82
--- /dev/null
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -0,0 +1,79 @@
+/*
+ * linux/arch/arm/mach-omap2/board-rx51-video.c
+ *
+ * Copyright (C) 2008 Nokia
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+
+#include <mach/lcd_mipid.h>
+#include <mach/mcspi.h>
+#include <mach/gpio.h>
+#include <mach/board.h>
+
+
+static struct omap2_mcspi_device_config mipid_mcspi_config =3D {
+	.turbo_mode	=3D 0,
+	.single_channel	=3D 1,
+};
+
+static struct platform_device rx51_lcd_device =3D {
+	.name		=3D "lcd_mipid",
+	.id		=3D -1,
+};
+
+static void mipid_shutdown(struct mipid_platform_data *pdata)
+{
+	if (pdata->nreset_gpio !=3D -1) {
+		pr_info("shutdown LCD\n");
+		gpio_direction_output(pdata->nreset_gpio, 0);
+		msleep(120);
+	}
+}
+
+static struct mipid_platform_data rx51_mipid_platform_data =3D {
+	.shutdown =3D mipid_shutdown,
+};
+
+static void __init mipid_dev_init(void)
+{
+	const struct omap_lcd_config *conf;
+
+	conf =3D omap_get_config(OMAP_TAG_LCD, struct omap_lcd_config);
+	if (conf !=3D NULL) {
+		rx51_mipid_platform_data.nreset_gpio =3D conf->nreset_gpio;
+		rx51_mipid_platform_data.data_lines =3D conf->data_lines;
+	}
+}
+
+static struct spi_board_info rx51_video_spi_board_info[] =3D {
+	[0] =3D {
+		.modalias		=3D "lcd_mipid",
+		.bus_num		=3D 1,
+		.chip_select		=3D 2,
+		.max_speed_hz		=3D 6000000,
+		.controller_data	=3D &mipid_mcspi_config,
+		.platform_data		=3D &rx51_mipid_platform_data,
+	},
+};
+
+static struct platform_device *rx51_video_devices[] =3D {
+	&rx51_lcd_device,
+};
+
+void __init rx51_video_init(void)
+{
+	platform_add_devices(rx51_video_devices, ARRAY_SIZE(rx51_video_device=
s));
+	spi_register_board_info(rx51_video_spi_board_info,
+			ARRAY_SIZE(rx51_video_spi_board_info));
+	mipid_dev_init();
+}
+
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/boa=
rd-rx51.c
new file mode 100644
index 0000000..e845aac
--- /dev/null
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -0,0 +1,102 @@
+/*
+ * linux/arch/arm/mach-omap2/board-rx51.c
+ *
+ * Copyright (C) 2007, 2008 Nokia
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
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
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <mach/mcspi.h>
+#include <mach/gpio.h>
+#include <mach/mux.h>
+#include <mach/board.h>
+#include <mach/common.h>
+#include <mach/keypad.h>
+#include <mach/dma.h>
+#include <mach/gpmc.h>
+#include <mach/usb-musb.h>
+
+#include <asm/io.h>
+#include <asm/delay.h>
+
+
+static struct omap_uart_config rx51_uart_config =3D {
+	.enabled_uarts	=3D ((1 << 0) | (1 << 1) | (1 << 2)),
+};
+
+static struct omap_lcd_config rx51_lcd_config =3D {
+	.ctrl_name	=3D "internal",
+};
+
+static struct omap_fbmem_config rx51_fbmem0_config =3D {
+	.size =3D 752 * 1024,
+};
+
+static struct omap_fbmem_config rx51_fbmem1_config =3D {
+	.size =3D 752 * 1024,
+};
+
+static struct omap_fbmem_config rx51_fbmem2_config =3D {
+	.size =3D 752 * 1024,
+};
+
+static struct omap_board_config_kernel rx51_config[] =3D {
+	{ OMAP_TAG_UART,	&rx51_uart_config },
+	{ OMAP_TAG_FBMEM,	&rx51_fbmem0_config },
+	{ OMAP_TAG_FBMEM,	&rx51_fbmem1_config },
+	{ OMAP_TAG_FBMEM,	&rx51_fbmem2_config },
+	{ OMAP_TAG_LCD,		&rx51_lcd_config },
+};
+
+static void __init rx51_init_irq(void)
+{
+	omap2_init_common_hw(rx51_get_sdram_timings());
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+extern void __init rx51_flash_init(void);
+extern void __init rx51_peripherals_init(void);
+extern void __init rx51_video_init(void);
+
+static void __init rx51_init(void)
+{
+	omap_board_config =3D rx51_config;
+	omap_board_config_size =3D ARRAY_SIZE(rx51_config);
+	omap_serial_init();
+	usb_musb_init();
+	rx51_flash_init();
+	rx51_peripherals_init();
+	rx51_video_init();
+}
+
+static void __init rx51_map_io(void)
+{
+	omap2_set_globals_343x();
+	omap2_map_common_io();
+}
+
+MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
+	/* Maintainer: Lauri Leukkunen <lauri.leukkunen@nokia.com> */
+	.phys_io	=3D 0x48000000,
+	.io_pg_offst	=3D ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	=3D 0x80000100,
+	.map_io		=3D rx51_map_io,
+	.init_irq	=3D rx51_init_irq,
+	.init_machine	=3D rx51_init,
+	.timer		=3D &omap_timer,
+MACHINE_END
diff --git a/arch/arm/plat-omap/include/mach/board-rx51.h b/arch/arm/pl=
at-omap/include/mach/board-rx51.h
new file mode 100644
index 0000000..7b32872
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/board-rx51.h
@@ -0,0 +1,47 @@
+/*
+ * linux/include/asm-arm/arch-omap/board-rx51.h
+ *
+ * Copyright (C) 2007 Nokia
+ *
+ * Hardware definitions for Nokia RX-51
+ * based on board-3430sdp.h
+ *
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License as published by t=
he
+ * Free Software Foundation; either version 2 of the License, or (at y=
our
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES O=
=46
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED=
=2E IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING=
, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS O=
=46
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND=
 ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR =
TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE U=
SE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License a=
long
+ * with this program; if not, write to the Free Software Foundation, I=
nc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_ARCH_OMAP_BOARD_RX51_H
+#define __ASM_ARCH_OMAP_BOARD_RX51_H
+
+#include <mach/board-nokia.h>
+
+#ifdef CONFIG_USB_MUSB_SOC
+extern void rx51_usb_init(void);
+#else
+static inline void rx51_usb_init(void) { }
+#endif
+
+extern void n800_bt_init(void);
+
+struct omap_sdrc_params *rx51_get_sdram_timings(void);
+
+#endif /*  __ASM_ARCH_OMAP_BOARD_RX51_H */
+
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat=
-omap/include/mach/hardware.h
index 3486524..659300e 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -322,6 +322,11 @@
 #include "board-nokia.h"
 #endif
=20
+#ifdef CONFIG_MACH_NOKIA_RX51
+#include "board-rx51.h"
+#endif
+
+
 #ifdef CONFIG_MACH_OMAP_2430SDP
 #include "board-2430sdp.h"
 #endif
--=20
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
