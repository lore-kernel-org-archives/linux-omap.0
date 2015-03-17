From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: OMAP2+: Remove legacy support for omap3 TouchBook
Date: Mon, 16 Mar 2015 17:25:11 -0700
Message-ID: <1426551911-17356-4-git-send-email-tony@atomide.com>
References: <1426551911-17356-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tkt-001-i373.relay.mailchannels.net ([174.136.5.175]:3473 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751989AbbCQAag convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2015 20:30:36 -0400
In-Reply-To: <1426551911-17356-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Gregoire Gentil <gregoire@gentil.com>, Radek Pilar <mrkva@mrkva.eu>

We've been moving all omap2+ based systems to boot in device tree only
mode for a few years now. Only omap3 has legacy booting support
remaining. Most omap3 boards already have related arch/arm/boot/*.dts*
files for booting with device tree.

As it seems this board only has minimal support upstreamed for the
legacy booting and has not seen activity for on the mailing lists
for a few years, let's attempt to remove the related legacy board-*.c
file.

I do not have this board, but it seems getting the same level of
support with device tree based booting is mostly just configuring
the .dts file. And there is no need to upgrade the boot loader as
we can boot with appended DTB too. And most of the omap3 boards
seem to be related to omap3-evm, and omap3beagleboard that are
supported with device tree based booting.

If somebody is using this board actively with the mainline kernel,
please communicate this to the linux-omap mailing list so we can
get the board booting with device tree based support. I can help
some too getting the minimal device tree based booting going if
help is needed.

The reason for attempting to remove this board now is that I'd
rather get the remaining omap3 legacy booting support into a known
state where we at least have a .dts file being written for the
remaining legacy boards. That is because for the next few merge
cycles we can still revert this patch if absolutely necessary,
but I'd rather not get suprised by missing .dts files at the point
where we are ready to drop all remaining omap3 legacy booting
support later on.

Cc: Gregoire Gentil <gregoire@gentil.com>
Cc: Radek Pilar <mrkva@mrkva.eu>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig                |   6 -
 arch/arm/mach-omap2/Makefile               |   1 -
 arch/arm/mach-omap2/board-omap3touchbook.c | 395 ---------------------=
--------
 3 files changed, 402 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-omap3touchbook.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 559e287..276a755 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -219,12 +219,6 @@ config MACH_OMAP3_PANDORA
 	select OMAP_PACKAGE_CBB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
=20
-config MACH_TOUCHBOOK
-	bool "OMAP3 Touch Book"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-
 config MACH_NOKIA_N810
        bool
=20
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index c346b48..ec002bd 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -253,7 +253,6 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51.o sd=
ram-nokia.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51-peripherals.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51-video.o
 obj-$(CONFIG_MACH_CM_T35)		+=3D board-cm-t35.o
-obj-$(CONFIG_MACH_TOUCHBOOK)		+=3D board-omap3touchbook.o
=20
 # Platform specific device init code
=20
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach=
-omap2/board-omap3touchbook.c
deleted file mode 100644
index a01993e..0000000
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ /dev/null
@@ -1,395 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/board-omap3touchbook.c
- *
- * Copyright (C) 2009 Always Innovating
- *
- * Modified from mach-omap2/board-omap3beagleboard.c
- *
- * Initial code: Gr=C3=A9goire Gentil, Tim Yamin
- *
- * This program is free software; you can redistribute it and/or modif=
y
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/leds.h>
-#include <linux/gpio.h>
-#include <linux/input.h>
-#include <linux/gpio_keys.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/nand.h>
-#include <linux/mmc/host.h>
-#include <linux/usb/phy.h>
-
-#include <linux/platform_data/spi-omap2-mcspi.h>
-#include <linux/spi/spi.h>
-
-#include <linux/spi/ads7846.h>
-
-#include <linux/regulator/machine.h>
-#include <linux/i2c/twl.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/flash.h>
-#include <asm/system_info.h>
-
-#include "common.h"
-#include "gpmc.h"
-#include <linux/platform_data/mtd-nand-omap2.h>
-
-#include "mux.h"
-#include "hsmmc.h"
-#include "board-flash.h"
-#include "common-board-devices.h"
-
-#include <asm/setup.h>
-
-#define OMAP3_AC_GPIO		136
-#define OMAP3_TS_GPIO		162
-#define TB_BL_PWM_TIMER		9
-#define TB_KILL_POWER_GPIO	168
-
-#define	NAND_CS			0
-
-static unsigned long touchbook_revision;
-
-static struct mtd_partition omap3touchbook_nand_partitions[] =3D {
-	/* All the partition sizes are listed in terms of NAND block size */
-	{
-		.name		=3D "X-Loader",
-		.offset		=3D 0,
-		.size		=3D 4 * NAND_BLOCK_SIZE,
-		.mask_flags	=3D MTD_WRITEABLE,	/* force read-only */
-	},
-	{
-		.name		=3D "U-Boot",
-		.offset		=3D MTDPART_OFS_APPEND,	/* Offset =3D 0x80000 */
-		.size		=3D 15 * NAND_BLOCK_SIZE,
-		.mask_flags	=3D MTD_WRITEABLE,	/* force read-only */
-	},
-	{
-		.name		=3D "U-Boot Env",
-		.offset		=3D MTDPART_OFS_APPEND,	/* Offset =3D 0x260000 */
-		.size		=3D 1 * NAND_BLOCK_SIZE,
-	},
-	{
-		.name		=3D "Kernel",
-		.offset		=3D MTDPART_OFS_APPEND,	/* Offset =3D 0x280000 */
-		.size		=3D 32 * NAND_BLOCK_SIZE,
-	},
-	{
-		.name		=3D "File System",
-		.offset		=3D MTDPART_OFS_APPEND,	/* Offset =3D 0x680000 */
-		.size		=3D MTDPART_SIZ_FULL,
-	},
-};
-
-#include "sdram-micron-mt46h32m32lf-6.h"
-
-static struct omap2_hsmmc_info mmc[] =3D {
-	{
-		.mmc		=3D 1,
-		.caps		=3D MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
-		.gpio_wp	=3D 29,
-		.deferred	=3D true,
-	},
-	{}	/* Terminator */
-};
-
-static struct regulator_consumer_supply touchbook_vmmc1_supply[] =3D {
-	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
-};
-
-static struct regulator_consumer_supply touchbook_vsim_supply[] =3D {
-	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.0"),
-};
-
-static struct gpio_led gpio_leds[];
-
-static int touchbook_twl_gpio_setup(struct device *dev,
-		unsigned gpio, unsigned ngpio)
-{
-	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	mmc[0].gpio_cd =3D gpio + 0;
-	omap_hsmmc_late_init(mmc);
-
-	/* REVISIT: need ehci-omap hooks for external VBUS
-	 * power switch and overcurrent detect
-	 */
-	gpio_request_one(gpio + 1, GPIOF_IN, "EHCI_nOC");
-
-	/* TWL4030_GPIO_MAX + 0 =3D=3D ledA, EHCI nEN_USB_PWR (out, active lo=
w) */
-	gpio_request_one(gpio + TWL4030_GPIO_MAX, GPIOF_OUT_INIT_LOW,
-			 "nEN_USB_PWR");
-
-	/* TWL4030_GPIO_MAX + 1 =3D=3D ledB, PMU_STAT (out, active low LED) *=
/
-	gpio_leds[2].gpio =3D gpio + TWL4030_GPIO_MAX + 1;
-
-	return 0;
-}
-
-static struct twl4030_gpio_platform_data touchbook_gpio_data =3D {
-	.use_leds	=3D true,
-	.pullups	=3D BIT(1),
-	.pulldowns	=3D BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
-				| BIT(15) | BIT(16) | BIT(17),
-	.setup		=3D touchbook_twl_gpio_setup,
-};
-
-static struct regulator_consumer_supply touchbook_vdac_supply[] =3D {
-{
-	.supply		=3D "vdac",
-},
-};
-
-static struct regulator_consumer_supply touchbook_vdvi_supply[] =3D {
-{
-	.supply		=3D "vdvi",
-},
-};
-
-/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card =3D=3D m=
ax 220 mA) */
-static struct regulator_init_data touchbook_vmmc1 =3D {
-	.constraints =3D {
-		.min_uV			=3D 1850000,
-		.max_uV			=3D 3150000,
-		.valid_modes_mask	=3D REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		=3D REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	=3D ARRAY_SIZE(touchbook_vmmc1_supply),
-	.consumer_supplies	=3D touchbook_vmmc1_supply,
-};
-
-/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card =3D=3D max 50 mA) */
-static struct regulator_init_data touchbook_vsim =3D {
-	.constraints =3D {
-		.min_uV			=3D 1800000,
-		.max_uV			=3D 3000000,
-		.valid_modes_mask	=3D REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		=3D REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	=3D ARRAY_SIZE(touchbook_vsim_supply),
-	.consumer_supplies	=3D touchbook_vsim_supply,
-};
-
-static struct twl4030_platform_data touchbook_twldata =3D {
-	/* platform_data for children goes here */
-	.gpio		=3D &touchbook_gpio_data,
-	.vmmc1		=3D &touchbook_vmmc1,
-	.vsim		=3D &touchbook_vsim,
-};
-
-static struct i2c_board_info __initdata touchBook_i2c_boardinfo[] =3D =
{
-	{
-		I2C_BOARD_INFO("bq27200", 0x55),
-	},
-};
-
-static int __init omap3_touchbook_i2c_init(void)
-{
-	/* Standard TouchBook bus */
-	omap3_pmic_get_config(&touchbook_twldata,
-			TWL_COMMON_PDATA_USB | TWL_COMMON_PDATA_AUDIO,
-			TWL_COMMON_REGULATOR_VDAC | TWL_COMMON_REGULATOR_VPLL2);
-
-	touchbook_twldata.vdac->num_consumer_supplies =3D
-					ARRAY_SIZE(touchbook_vdac_supply);
-	touchbook_twldata.vdac->consumer_supplies =3D touchbook_vdac_supply;
-
-	touchbook_twldata.vpll2->constraints.name =3D "VDVI";
-	touchbook_twldata.vpll2->num_consumer_supplies =3D
-					ARRAY_SIZE(touchbook_vdvi_supply);
-	touchbook_twldata.vpll2->consumer_supplies =3D touchbook_vdvi_supply;
-
-	omap3_pmic_init("twl4030", &touchbook_twldata);
-	/* Additional TouchBook bus */
-	omap_register_i2c_bus(3, 100, touchBook_i2c_boardinfo,
-			ARRAY_SIZE(touchBook_i2c_boardinfo));
-
-	return 0;
-}
-
-static struct ads7846_platform_data ads7846_pdata =3D {
-	.x_min			=3D 100,
-	.y_min			=3D 265,
-	.x_max			=3D 3950,
-	.y_max			=3D 3750,
-	.x_plate_ohms		=3D 40,
-	.pressure_max		=3D 255,
-	.debounce_max		=3D 10,
-	.debounce_tol		=3D 5,
-	.debounce_rep		=3D 1,
-	.gpio_pendown		=3D OMAP3_TS_GPIO,
-	.keep_vref_on		=3D 1,
-};
-
-static struct gpio_led gpio_leds[] =3D {
-	{
-		.name			=3D "touchbook::usr0",
-		.default_trigger	=3D "heartbeat",
-		.gpio			=3D 150,
-	},
-	{
-		.name			=3D "touchbook::usr1",
-		.default_trigger	=3D "mmc0",
-		.gpio			=3D 149,
-	},
-	{
-		.name			=3D "touchbook::pmu_stat",
-		.gpio			=3D -EINVAL,	/* gets replaced */
-		.active_low		=3D true,
-	},
-};
-
-static struct gpio_led_platform_data gpio_led_info =3D {
-	.leds		=3D gpio_leds,
-	.num_leds	=3D ARRAY_SIZE(gpio_leds),
-};
-
-static struct platform_device leds_gpio =3D {
-	.name	=3D "leds-gpio",
-	.id	=3D -1,
-	.dev	=3D {
-		.platform_data	=3D &gpio_led_info,
-	},
-};
-
-static struct gpio_keys_button gpio_buttons[] =3D {
-	{
-		.code			=3D BTN_EXTRA,
-		.gpio			=3D 7,
-		.desc			=3D "user",
-		.wakeup			=3D 1,
-	},
-	{
-		.code			=3D KEY_POWER,
-		.gpio			=3D 183,
-		.desc			=3D "power",
-		.wakeup			=3D 1,
-	},
-};
-
-static struct gpio_keys_platform_data gpio_key_info =3D {
-	.buttons	=3D gpio_buttons,
-	.nbuttons	=3D ARRAY_SIZE(gpio_buttons),
-};
-
-static struct platform_device keys_gpio =3D {
-	.name	=3D "gpio-keys",
-	.id	=3D -1,
-	.dev	=3D {
-		.platform_data	=3D &gpio_key_info,
-	},
-};
-
-#ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata =3D {
-	{ .reg_offset =3D OMAP_MUX_TERMINATOR },
-};
-#endif
-
-static struct usbhs_phy_data phy_data[] __initdata =3D {
-	{
-		.port =3D 2,
-		.reset_gpio =3D 147,
-		.vcc_gpio =3D -EINVAL,
-	},
-};
-
-static struct platform_device *omap3_touchbook_devices[] __initdata =3D=
 {
-	&leds_gpio,
-	&keys_gpio,
-};
-
-static struct usbhs_omap_platform_data usbhs_bdata __initdata =3D {
-	.port_mode[0] =3D OMAP_EHCI_PORT_MODE_PHY,
-	.port_mode[1] =3D OMAP_EHCI_PORT_MODE_PHY,
-};
-
-static void omap3_touchbook_poweroff(void)
-{
-	int pwr_off =3D TB_KILL_POWER_GPIO;
-
-	if (gpio_request_one(pwr_off, GPIOF_OUT_INIT_LOW, "DVI reset") < 0)
-		printk(KERN_ERR "Unable to get kill power GPIO\n");
-}
-
-static int __init early_touchbook_revision(char *p)
-{
-	if (!p)
-		return 0;
-
-	return kstrtoul(p, 10, &touchbook_revision);
-}
-early_param("tbr", early_touchbook_revision);
-
-static void __init omap3_touchbook_init(void)
-{
-	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-
-	pm_power_off =3D omap3_touchbook_poweroff;
-
-	if (system_rev >=3D 0x20 && system_rev <=3D 0x34301000) {
-		omap_mux_init_gpio(23, OMAP_PIN_INPUT);
-		mmc[0].gpio_wp =3D 23;
-	} else {
-		omap_mux_init_gpio(29, OMAP_PIN_INPUT);
-	}
-	omap_hsmmc_init(mmc);
-
-	omap3_touchbook_i2c_init();
-	platform_add_devices(omap3_touchbook_devices,
-			ARRAY_SIZE(omap3_touchbook_devices));
-	omap_serial_init();
-	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
-				  mt46h32m32lf6_sdrc_params);
-
-	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_request_one(176, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
-
-	/* Touchscreen and accelerometer */
-	omap_ads7846_init(4, OMAP3_TS_GPIO, 310, &ads7846_pdata);
-	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
-	usb_musb_init(NULL);
-
-	usbhs_init_phys(phy_data, ARRAY_SIZE(phy_data));
-	usbhs_init(&usbhs_bdata);
-	board_nand_init(omap3touchbook_nand_partitions,
-			ARRAY_SIZE(omap3touchbook_nand_partitions), NAND_CS,
-			NAND_BUSWIDTH_16, NULL);
-
-	/* Ensure SDRC pins are mux'd for self-refresh */
-	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
-	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
-}
-
-MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
-	/* Maintainer: Gregoire Gentil - http://www.alwaysinnovating.com */
-	.atag_offset	=3D 0x100,
-	.reserve	=3D omap_reserve,
-	.map_io		=3D omap3_map_io,
-	.init_early	=3D omap3430_init_early,
-	.init_irq	=3D omap3_init_irq,
-	.init_machine	=3D omap3_touchbook_init,
-	.init_late	=3D omap3430_init_late,
-	.init_time	=3D omap3_secure_sync32k_timer_init,
-	.restart	=3D omap3xxx_restart,
-MACHINE_END
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
