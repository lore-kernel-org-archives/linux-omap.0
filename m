From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: OMAP2+: Remove legacy booting support for LogicPD
 Torpedo
Date: Thu, 16 Jul 2015 04:59:10 -0700
Message-ID: <1437047951-22300-2-git-send-email-tony@atomide.com>
References: <1437047951-22300-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437047951-22300-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tim Nordell <tim.nordell@logicpd.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We've been moving all omap2+ based systems to boot in device tree only
mode for a few years now. Only omap3 has legacy booting support
remaining. Most omap3 boards already have related arch/arm/boot/*.dts*
files for booting with device tree.

This board has support for device tree based booting, and we've been
printing warnings about the legacy booting being deprecated for a
few merge cycles now. Let's attempt to remove the legacy booting
for it.

The reason for removing the legacy booting support now rather than
later is we can simply revert this patch if necessary if we run
into some unexpected issues that are not trivial to fix for the
device tree based booting.

Cc: Tim Nordell <tim.nordell@logicpd.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig            |  20 ---
 arch/arm/mach-omap2/Makefile           |   2 -
 arch/arm/mach-omap2/board-omap3logic.c | 249 ---------------------------------
 3 files changed, 271 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-omap3logic.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ecc04ff..e68ad9f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -177,26 +177,6 @@ config MACH_OMAP_LDP
 	default y
 	select OMAP_PACKAGE_CBB
 
-config MACH_OMAP3530_LV_SOM
-	bool "OMAP3 Logic 3530 LV SOM board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-	help
-	 Support for the LogicPD OMAP3530 SOM Development kit
-	 for full description please see the products webpage at
-	 http://www.logicpd.com/products/development-kits/texas-instruments-zoom%E2%84%A2-omap35x-development-kit
-
-config MACH_OMAP3_TORPEDO
-	bool "OMAP3 Logic 35x Torpedo board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-	help
-	 Support for the LogicPD OMAP35x Torpedo Development kit
-	 for full description please see the products webpage at
-	 http://www.logicpd.com/products/development-kits/zoom-omap35x-torpedo-development-kit
-
 config MACH_OMAP3517EVM
 	bool "OMAP3517/ AM3517 EVM board"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 903c85b..9e4b17a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -243,8 +243,6 @@ obj-$(CONFIG_SOC_OMAP2420)		+= msdi.o
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o pdata-quirks.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o
-obj-$(CONFIG_MACH_OMAP3530_LV_SOM)      += board-omap3logic.o
-obj-$(CONFIG_MACH_OMAP3_TORPEDO)        += board-omap3logic.o
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o sdram-nokia.o
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
deleted file mode 100644
index 6049f60..0000000
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ /dev/null
@@ -1,249 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/board-omap3logic.c
- *
- * Copyright (C) 2010 Li-Pro.Net
- * Stephan Linz <linz@li-pro.net>
- *
- * Copyright (C) 2010-2012 Logic Product Development, Inc.
- * Peter Barada <peter.barada@logicpd.com>
- * Ashwin BIhari <ashwin.bihari@logicpd.com>
- *
- * Modified from Beagle, EVM, and RX51
- *
- * This program is free software; you can redistribute it and/or modify
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
-#include <linux/gpio.h>
-
-#include <linux/regulator/fixed.h>
-#include <linux/regulator/machine.h>
-
-#include <linux/i2c/twl.h>
-#include <linux/mmc/host.h>
-#include <linux/usb/phy.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include "common.h"
-#include "mux.h"
-#include "hsmmc.h"
-#include "control.h"
-#include "common-board-devices.h"
-#include "gpmc.h"
-#include "gpmc-smsc911x.h"
-
-#define OMAP3LOGIC_SMSC911X_CS			1
-
-#define OMAP3530_LV_SOM_MMC_GPIO_CD		110
-#define OMAP3530_LV_SOM_MMC_GPIO_WP		126
-#define OMAP3530_LV_SOM_SMSC911X_GPIO_IRQ	152
-
-#define OMAP3_TORPEDO_MMC_GPIO_CD		127
-#define OMAP3_TORPEDO_SMSC911X_GPIO_IRQ		129
-
-static struct regulator_consumer_supply omap3logic_vmmc1_supply[] = {
-	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
-};
-
-/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
-static struct regulator_init_data omap3logic_vmmc1 = {
-	.constraints = {
-		.name			= "VMMC1",
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies  = ARRAY_SIZE(omap3logic_vmmc1_supply),
-	.consumer_supplies      = omap3logic_vmmc1_supply,
-};
-
-static struct twl4030_gpio_platform_data omap3logic_gpio_data = {
-	.use_leds	= true,
-	.pullups	= BIT(1),
-	.pulldowns	= BIT(2)  | BIT(6)  | BIT(7)  | BIT(8)
-			| BIT(13) | BIT(15) | BIT(16) | BIT(17),
-};
-
-static struct twl4030_usb_data omap3logic_usb_data = {
-	.usb_mode	= T2_USB_MODE_ULPI,
-};
-
-
-static struct twl4030_platform_data omap3logic_twldata = {
-	/* platform_data for children goes here */
-	.gpio		= &omap3logic_gpio_data,
-	.vmmc1		= &omap3logic_vmmc1,
-	.usb		= &omap3logic_usb_data,
-};
-
-static int __init omap3logic_i2c_init(void)
-{
-	omap3_pmic_init("twl4030", &omap3logic_twldata);
-	return 0;
-}
-
-static struct omap2_hsmmc_info __initdata board_mmc_info[] = {
-	{
-		.name		= "external",
-		.mmc		= 1,
-		.caps		= MMC_CAP_4_BIT_DATA,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-	},
-	{}      /* Terminator */
-};
-
-static void __init board_mmc_init(void)
-{
-	if (machine_is_omap3530_lv_som()) {
-		/* OMAP3530 LV SOM board */
-		board_mmc_info[0].gpio_cd = OMAP3530_LV_SOM_MMC_GPIO_CD;
-		board_mmc_info[0].gpio_wp = OMAP3530_LV_SOM_MMC_GPIO_WP;
-		omap_mux_init_signal("gpio_110", OMAP_PIN_OUTPUT);
-		omap_mux_init_signal("gpio_126", OMAP_PIN_OUTPUT);
-	} else if (machine_is_omap3_torpedo()) {
-		/* OMAP3 Torpedo board */
-		board_mmc_info[0].gpio_cd = OMAP3_TORPEDO_MMC_GPIO_CD;
-		omap_mux_init_signal("gpio_127", OMAP_PIN_OUTPUT);
-	} else {
-		/* unsupported board */
-		printk(KERN_ERR "%s(): unknown machine type\n", __func__);
-		return;
-	}
-
-	omap_hsmmc_init(board_mmc_info);
-}
-
-static struct omap_smsc911x_platform_data __initdata board_smsc911x_data = {
-	.cs             = OMAP3LOGIC_SMSC911X_CS,
-	.gpio_irq       = -EINVAL,
-	.gpio_reset     = -EINVAL,
-};
-
-/* TODO/FIXME (comment by Peter Barada, LogicPD):
- * Fix the PBIAS voltage for Torpedo MMC1 pins that
- * are used for other needs (IRQs, etc).            */
-static void omap3torpedo_fix_pbias_voltage(void)
-{
-	u16 control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
-	u32 reg;
-
-	if (machine_is_omap3_torpedo())
-	{
-		/* Set the bias for the pin */
-		reg = omap_ctrl_readl(control_pbias_offset);
-
-		reg &= ~OMAP343X_PBIASLITEPWRDNZ1;
-		omap_ctrl_writel(reg, control_pbias_offset);
-
-		/* 100ms delay required for PBIAS configuration */
-		msleep(100);
-
-		reg |= OMAP343X_PBIASLITEVMODE1;
-		reg |= OMAP343X_PBIASLITEPWRDNZ1;
-		omap_ctrl_writel(reg | 0x300, control_pbias_offset);
-	}
-}
-
-static inline void __init board_smsc911x_init(void)
-{
-	if (machine_is_omap3530_lv_som()) {
-		/* OMAP3530 LV SOM board */
-		board_smsc911x_data.gpio_irq =
-					OMAP3530_LV_SOM_SMSC911X_GPIO_IRQ;
-		omap_mux_init_signal("gpio_152", OMAP_PIN_INPUT);
-	} else if (machine_is_omap3_torpedo()) {
-		/* OMAP3 Torpedo board */
-		board_smsc911x_data.gpio_irq = OMAP3_TORPEDO_SMSC911X_GPIO_IRQ;
-		omap_mux_init_signal("gpio_129", OMAP_PIN_INPUT);
-	} else {
-		/* unsupported board */
-		printk(KERN_ERR "%s(): unknown machine type\n", __func__);
-		return;
-	}
-
-	gpmc_smsc911x_init(&board_smsc911x_data);
-}
-
-#ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata = {
-	/* mUSB */
-	OMAP3_MUX(HSUSB0_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
-	OMAP3_MUX(HSUSB0_STP, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
-	OMAP3_MUX(HSUSB0_DIR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
-	OMAP3_MUX(HSUSB0_NXT, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
-	OMAP3_MUX(HSUSB0_DATA0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
-	OMAP3_MUX(HSUSB0_DATA1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
-	OMAP3_MUX(HSUSB0_DATA2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
-	OMAP3_MUX(HSUSB0_DATA3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
-	OMAP3_MUX(HSUSB0_DATA4, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
-	OMAP3_MUX(HSUSB0_DATA5, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
-	OMAP3_MUX(HSUSB0_DATA6, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
-	OMAP3_MUX(HSUSB0_DATA7, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
-
-	{ .reg_offset = OMAP_MUX_TERMINATOR },
-};
-#endif
-
-static struct regulator_consumer_supply dummy_supplies[] = {
-	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
-	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
-};
-
-static void __init omap3logic_init(void)
-{
-	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
-	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap3torpedo_fix_pbias_voltage();
-	omap3logic_i2c_init();
-	omap_serial_init();
-	omap_sdrc_init(NULL, NULL);
-	board_mmc_init();
-	board_smsc911x_init();
-
-	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
-	usb_musb_init(NULL);
-
-	/* Ensure SDRC pins are mux'd for self-refresh */
-	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
-	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
-}
-
-MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
-	.atag_offset	= 0x100,
-	.reserve	= omap_reserve,
-	.map_io		= omap3_map_io,
-	.init_early	= omap35xx_init_early,
-	.init_irq	= omap3_init_irq,
-	.init_machine	= omap3logic_init,
-	.init_late	= omap35xx_init_late,
-	.init_time	= omap3_sync32k_timer_init,
-	.restart	= omap3xxx_restart,
-MACHINE_END
-
-MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
-	.atag_offset	= 0x100,
-	.reserve	= omap_reserve,
-	.map_io		= omap3_map_io,
-	.init_early	= omap35xx_init_early,
-	.init_irq	= omap3_init_irq,
-	.init_machine	= omap3logic_init,
-	.init_late	= omap35xx_init_late,
-	.init_time	= omap3_sync32k_timer_init,
-	.restart	= omap3xxx_restart,
-MACHINE_END
-- 
2.1.4
