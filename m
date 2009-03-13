From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] Clean-up rx51 a bit and set the regulators.
Date: Fri, 13 Mar 2009 11:03:35 -0700
Message-ID: <20090313180335.1548.94607.stgit@localhost>
References: <20090313180123.1548.1188.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61793 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbZCMSDf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 14:03:35 -0400
In-Reply-To: <20090313180123.1548.1188.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Lauri Leukkunen <lauri.leukkunen@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |  158 +++++++++++++++++++++++---
 1 files changed, 139 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 9da0187..49c3d80 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -1,7 +1,7 @@
 /*
  * linux/arch/arm/mach-omap2/board-rx51-flash.c
  *
- * Copyright (C) 2008 Nokia
+ * Copyright (C) 2008-2009 Nokia
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -18,18 +18,16 @@
 #include <linux/i2c/twl4030.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/regulator/machine.h>
 
 #include <mach/mcspi.h>
 #include <mach/gpio.h>
 #include <mach/mux.h>
 #include <mach/board.h>
 #include <mach/common.h>
-#include <mach/keypad.h>
 #include <mach/dma.h>
 #include <mach/gpmc.h>
 
-#define RX51_DEBUG_BASE			0x08000000  /* debug board */
-#define RX51_ETHR_START			RX51_DEBUG_BASE
 #define RX51_ETHR_GPIO_IRQ		54
 
 #define RX51_TSC2005_RESET_GPIO		104
@@ -39,13 +37,9 @@
 
 static struct resource rx51_smc91x_resources[] = {
 	[0] = {
-		.start	= RX51_ETHR_START,
-		.end	= RX51_ETHR_START + SZ_4K,
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start		= OMAP_GPIO_IRQ(RX51_ETHR_GPIO_IRQ),
-		.end	= 0,
 		.flags		= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
 };
@@ -58,7 +52,7 @@ static struct platform_device rx51_smc91x_device = {
 };
 
 static struct tsc2005_platform_data tsc2005_config = {
-	.reset_gpio 		= RX51_TSC2005_RESET_GPIO, /* not used */
+	.reset_gpio		= RX51_TSC2005_RESET_GPIO, /* not used */
 
 	.ts_x_plate_ohm		= 280,
 	.ts_hw_avg		= 0,
@@ -83,8 +77,8 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] = {
 		.modalias		= "tsc2005",
 		.bus_num		= 1,
 		.chip_select		= 0,
-		.irq	 		= OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),
-		.max_speed_hz   	= 6000000,
+		.irq			= OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),
+		.max_speed_hz		= 6000000,
 		.controller_data	= &tsc2005_mcspi_config,
 		.platform_data		= &tsc2005_config,
 	},
@@ -140,8 +134,8 @@ static int rx51_keymap[] = {
 static struct twl4030_keypad_data rx51_kp_data = {
 	.rows		= 8,
 	.cols		= 8,
-	.keymap 	= rx51_keymap,
-	.keymapsize 	= ARRAY_SIZE(rx51_keymap),
+	.keymap		= rx51_keymap,
+	.keymapsize	= ARRAY_SIZE(rx51_keymap),
 	.rep		= 1,
 };
 
@@ -179,6 +173,7 @@ static void __init rx51_init_smc91x(void)
 		return;
 	}
 	gpio_direction_input(RX51_ETHR_GPIO_IRQ);
+	rx51_smc91x_resources[1].start = gpio_to_irq(RX51_ETHR_GPIO_IRQ);
 }
 
 static void __init rx51_init_tsc2005(void)
@@ -193,18 +188,135 @@ static void __init rx51_init_tsc2005(void)
 	}
 }
 
-static struct twl4030_usb_data rx51_usb_data = {
-	.usb_mode		= T2_USB_MODE_ULPI,
-};
-
 static struct twl4030_madc_platform_data rx51_madc_data = {
 	.irq_line		= 1,
 };
 
+static struct regulator_init_data rx51_vaux1 = {
+	.constraints = {
+		.name			= "V28",
+		.min_uV			= 2800000,
+		.max_uV			= 2800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data rx51_vaux2 = {
+	.constraints = {
+		.name			= "VCSI",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+/* VAUX3 - adds more power to VIO_18 rail */
+static struct regulator_init_data rx51_vaux3 = {
+	.constraints = {
+		.name			= "VCAM_DIG_18",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data rx51_vaux4 = {
+	.constraints = {
+		.name			= "VCAM_ANA_28",
+		.min_uV			= 2800000,
+		.max_uV			= 2800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data rx51_vmmc1 = {
+	.constraints = {
+		.min_uV			= 1850000,
+		.max_uV			= 3150000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data rx51_vmmc2 = {
+	.constraints = {
+		.name			= "VMMC2_30",
+		.min_uV			= 1850000,
+		.max_uV			= 3150000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data rx51_vsim = {
+	.constraints = {
+		.name			= "VMMC2_IO_18",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data rx51_vdac = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
+{
+	/* FIXME this gpio setup is just a placeholder for now */
+	gpio_request(gpio + 6, "backlight_pwm");
+	gpio_direction_output(gpio + 6, 0);
+	gpio_request(gpio + 7, "speaker_en");
+	gpio_direction_output(gpio + 7, 1);
+
+	/* FIXME connect power supplies to devices; register MMC */
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data rx51_gpio_data = {
 	.gpio_base		= OMAP_MAX_GPIO_LINES,
 	.irq_base		= TWL4030_GPIO_IRQ_BASE,
 	.irq_end		= TWL4030_GPIO_IRQ_END,
+	.pulldowns		= BIT(0) | BIT(1) | BIT(2) | BIT(3)
+				| BIT(4) | BIT(5)
+				| BIT(8) | BIT(9) | BIT(10) | BIT(11)
+				| BIT(12) | BIT(13) | BIT(14) | BIT(15)
+				| BIT(16) | BIT(17) ,
+	.setup			= rx51_twlgpio_setup,
 };
 
 static struct twl4030_platform_data rx51_twldata = {
@@ -215,12 +327,20 @@ static struct twl4030_platform_data rx51_twldata = {
 	.gpio			= &rx51_gpio_data,
 	.keypad			= &rx51_kp_data,
 	.madc			= &rx51_madc_data,
-	.usb			= &rx51_usb_data,
+
+	.vaux1			= &rx51_vaux1,
+	.vaux2			= &rx51_vaux2,
+	.vaux3			= &rx51_vaux3,
+	.vaux4			= &rx51_vaux4,
+	.vmmc1			= &rx51_vmmc1,
+	.vmmc2			= &rx51_vmmc2,
+	.vsim			= &rx51_vsim,
+	.vdac			= &rx51_vdac,
 };
 
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 	{
-		I2C_BOARD_INFO("twl4030", 0x48),
+		I2C_BOARD_INFO("twl5030", 0x48),
 		.flags = I2C_CLIENT_WAKE,
 		.irq = INT_34XX_SYS_NIRQ,
 		.platform_data = &rx51_twldata,

