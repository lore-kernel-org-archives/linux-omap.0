From: Manikandan Pillai <mani.pillai@ti.com>
Subject: [PATCH 1/2] Put in supportframework for PR785 board.
Date: Thu,  4 Dec 2008 15:53:26 +0530
Message-ID: <1228386206-13513-1-git-send-email-mani.pillai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53021 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbYLDKXg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2008 05:23:36 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mB4ANTFv005048
	for <linux-omap@vger.kernel.org>; Thu, 4 Dec 2008 04:23:35 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manikandan Pillai <mani.pillai@ti.com>

Resending this patch with fixes for comments:
This patch provides the support framework for PR785 boards.
More patches will follow that will allow complete programming
support for PR785 boards.
The board-omap3evm.c contains the I2C devices to be supported.
CONFIG_PR785 is configuration used for the PR785 boards. This patch
provides support for TPS6235x devices on PR785 through I2C2 bus.
Support for I2C2 or I2C4 and selection between them will be given in
subsequent patches.

The selection of TWL4030 or PR785 is for now through compile time
option since a real time check is not clear.

Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   22 +++++++++++++++++++++-
 arch/arm/mach-omap2/mmc-twl4030.c    |    5 +++--
 drivers/mfd/Kconfig                  |   14 ++++++++++++++
 drivers/video/omap/lcd_omap3evm.c    |    4 ++++
 4 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 8a1b86e..22ac2e9 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -42,7 +42,6 @@
 #include "twl4030-generic-scripts.h"
 #include "mmc-twl4030.h"
 
-
 static struct resource omap3evm_smc911x_resources[] = {
 	[0] =	{
 		.start  = OMAP3EVM_ETHR_START,
@@ -90,6 +89,7 @@ static struct omap_uart_config omap3_evm_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+#if defined(CONFIG_TWL4030_CORE)
 static struct twl4030_gpio_platform_data omap3evm_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -151,11 +151,31 @@ static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
 		.platform_data = &omap3evm_twldata,
 	},
 };
+#endif
+
+#if defined(CONFIG_PR785)
+static struct i2c_board_info __initdata tps_6235x_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("tps62352", 0x4A),
+		.flags = I2C_CLIENT_WAKE,
+	},
+	{
+		I2C_BOARD_INFO("tps62353", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+	},
+};
+#endif
 
 static int __init omap3_evm_i2c_init(void)
 {
+#if defined(CONFIG_PR785)
+	omap_register_i2c_bus(1, 2600, tps_6235x_i2c_board_info,
+		ARRAY_SIZE(tps_6235x_i2c_board_info));
+#endif
+#if defined(CONFIG_TWL4030_CORE)
 	omap_register_i2c_bus(1, 2600, omap3evm_i2c_boardinfo,
 			ARRAY_SIZE(omap3evm_i2c_boardinfo));
+#endif
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 626d668..daf10f3 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -167,7 +167,7 @@ static int twl_mmc_resume(struct device *dev, int slot)
  */
 static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 {
-	int ret;
+	int ret = 0;
 	u8 vmmc, dev_grp_val;
 
 	switch (1 << vdd) {
@@ -222,6 +222,7 @@ static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 	else
 		dev_grp_val = LDO_CLR;		/* Power down */
 
+#if defined(CONFIG_TWL4030_CORE)
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					dev_grp_val, c->twl_vmmc_dev_grp);
 	if (ret)
@@ -229,7 +230,7 @@ static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					vmmc, c->twl_mmc_dedicated);
-
+#endif
 	return ret;
 }
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 650b51c..3fee589 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -61,6 +61,8 @@ config UCB1400_CORE
 	  To compile this driver as a module, choose M here: the
 	  module will be called ucb1400_core.
 
+menu "Texas Instruments Power board Support"
+
 config TWL4030_CORE
 	bool "Texas Instruments TWL4030/TPS659x0 Support"
 	depends on I2C=y && GENERIC_HARDIRQS
@@ -84,6 +86,18 @@ config TWL4030_POWER
 	  oscillators are switched off or on or reset when a sleep, wakeup
 	  or warm reset event occurs.
 
+config PR785
+	bool "A Texas Instruments TPS6235X based Power Module"
+	depends on I2C=y && MACH_OMAP3EVM=y && GENERIC_GPIO && (ARCH_OMAP3)
+	default n
+	help
+	Say yes here if you are using the TPS6235x based PR785 Power Module
+	for the EVM boards. This core driver provides register access and IRQ
+	handling facilities, and registers devices for the various functions
+	so that function-specific drivers can bind to them.
+
+endmenu
+
 config MFD_TMIO
 	bool
 	default n
diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
index 1c3d814..ff3a3ed 100644
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -66,9 +66,11 @@ static int omap3evm_panel_init(struct lcd_panel *panel,
 	gpio_direction_output(LCD_PANEL_LR, 1);
 	gpio_direction_output(LCD_PANEL_UD, 1);
 
+#if !defined(CONFIG_PR785)
 	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
+#endif
 	bklight_level = 100;
 
 	return 0;
@@ -97,12 +99,14 @@ static unsigned long omap3evm_panel_get_caps(struct lcd_panel *panel)
 static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
 						unsigned int level)
 {
+#if !defined(CONFIG_PR785)
 	u8 c;
 	if ((level >= 0) && (level <= 100)) {
 		c = (125 * (100 - level)) / 100 + 2;
 		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
 		bklight_level = level;
 	}
+#endif
 	return 0;
 }
 
-- 
1.5.6

