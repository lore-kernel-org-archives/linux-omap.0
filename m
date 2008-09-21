From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc6-omap 2/2] twl4030: board init updates
Date: Sun, 21 Sep 2008 14:12:23 -0700
Message-ID: <200809211412.23342.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:41232 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752675AbYIUVUT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Sep 2008 17:20:19 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

For boards with twl4030/tps65950 chips, update board setup code to
provide the appropriate board info.

This should evolve a bunch more over time; right now too much of this
data is globally defined (like IRQ and GPIO numbering).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
NOTE:  run-tested only on Beagle so far.

 arch/arm/mach-omap2/board-2430sdp.c     |   21 ++++++++++++++++-----
 arch/arm/mach-omap2/board-3430sdp.c     |   17 ++++++++++++++++-
 arch/arm/mach-omap2/board-ldp.c         |   17 ++++++++++++++++-
 arch/arm/mach-omap2/board-omap2evm.c    |   21 ++++++++++++++++-----
 arch/arm/mach-omap2/board-omap3beagle.c |   19 ++++++++++++++++++-
 arch/arm/mach-omap2/board-omap3evm.c    |   22 +++++++++++++++++++---
 arch/arm/mach-omap2/board-overo.c       |   20 +++++++++++++++++++-
 7 files changed, 120 insertions(+), 17 deletions(-)

--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -353,14 +353,25 @@ static struct omap_board_config_kernel s
 	{OMAP_TAG_SERIAL_CONSOLE, &sdp2430_serial_console_config},
 };
 
+static struct twl4030_platform_data sdp2430_twldata = {
+	.irq_base	= TWL4030_IRQ_BASE,
+	.irq_end	= TWL4030_IRQ_END,
+};
+
+static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl4030", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = INT_24XX_SYS_NIRQ,
+		.platform_data = &sdp2430_twldata,
+	},
+};
+
 static int __init omap2430_i2c_init(void)
 {
-	/*
-	 * Registering bus 2 first to avoid twl4030 misbehaving as 2430SDP
-	 * has twl4030 on bus 2
-	 */
-	omap_register_i2c_bus(2, 2600, NULL, 0);
 	omap_register_i2c_bus(1, 400, NULL, 0);
+	omap_register_i2c_bus(2, 2600, sdp2430_i2c_boardinfo,
+			ARRAY_SIZE(sdp2430_i2c_boardinfo));
 	return 0;
 }
 
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -309,9 +309,24 @@ static struct omap_board_config_kernel s
 	{ OMAP_TAG_LCD,		&sdp3430_lcd_config },
 };
 
+static struct twl4030_platform_data sdp3430_twldata = {
+	.irq_base	= TWL4030_IRQ_BASE,
+	.irq_end	= TWL4030_IRQ_END,
+};
+
+static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl4030", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = INT_34XX_SYS_NIRQ,
+		.platform_data = &sdp3430_twldata,
+	},
+};
+
 static int __init omap3430_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, NULL, 0);
+	omap_register_i2c_bus(1, 2600, sdp3430_i2c_boardinfo,
+			ARRAY_SIZE(sdp3430_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -183,9 +183,24 @@ static struct omap_board_config_kernel l
 	{ OMAP_TAG_UART,	&ldp_uart_config },
 };
 
+static struct twl4030_platform_data ldp_twldata = {
+	.irq_base	= TWL4030_IRQ_BASE,
+	.irq_end	= TWL4030_IRQ_END,
+};
+
+static struct i2c_board_info __initdata ldp_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl4030", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = INT_34XX_SYS_NIRQ,
+		.platform_data = &ldp_twldata,
+	},
+};
+
 static int __init omap_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, NULL, 0);
+	omap_register_i2c_bus(1, 2600, ldp_i2c_boardinfo,
+			ARRAY_SIZE(ldp_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -234,14 +234,25 @@ static struct omap_board_config_kernel o
 	{ OMAP_TAG_LCD,		&omap2_evm_lcd_config },
 };
 
+static struct twl4030_platform_data omap2evm_twldata = {
+	.irq_base	= TWL4030_IRQ_BASE,
+	.irq_end	= TWL4030_IRQ_END,
+};
+
+static struct i2c_board_info __initdata omap2evm_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl4030", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = INT_24XX_SYS_NIRQ,
+		.platform_data = &omap2evm_twldata,
+	},
+};
+
 static int __init omap2_evm_i2c_init(void)
 {
-	/*
-	 * Registering bus 2 first to avoid twl4030 misbehaving as OMAP2EVM
-	 * has twl4030 on bus 2
-	 */
-	omap_register_i2c_bus(2, 2600, NULL, 0);
 	omap_register_i2c_bus(1, 400, NULL, 0);
+	omap_register_i2c_bus(2, 2600, omap2evm_i2c_boardinfo,
+			ARRAY_SIZE(omap2evm_i2c_boardinfo));
 	return 0;
 }
 
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -24,6 +24,8 @@
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 
+#include <linux/i2c/twl4030.h>
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
@@ -108,9 +110,24 @@ static struct omap_uart_config omap3_bea
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+static struct twl4030_platform_data beagle_twldata = {
+	.irq_base	= TWL4030_IRQ_BASE,
+	.irq_end	= TWL4030_IRQ_END,
+};
+
+static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl4030", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = INT_34XX_SYS_NIRQ,
+		.platform_data = &beagle_twldata,
+	},
+};
+
 static int __init omap3_beagle_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, NULL, 0);
+	omap_register_i2c_bus(1, 2600, beagle_i2c_boardinfo,
+			ARRAY_SIZE(beagle_i2c_boardinfo));
 #ifdef CONFIG_I2C2_OMAP_BEAGLE
 	omap_register_i2c_bus(2, 400, NULL, 0);
 #endif
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -20,6 +20,9 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/input.h>
+
+#include <linux/i2c/twl4030.h>
+
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
@@ -27,8 +30,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <linux/io.h>
-#include <linux/delay.h>
 
 #include <mach/gpio.h>
 #include <mach/keypad.h>
@@ -88,9 +89,24 @@ static struct omap_uart_config omap3_evm
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+static struct twl4030_platform_data omap3evm_twldata = {
+	.irq_base	= TWL4030_IRQ_BASE,
+	.irq_end	= TWL4030_IRQ_END,
+};
+
+static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl4030", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = INT_34XX_SYS_NIRQ,
+		.platform_data = &omap3evm_twldata,
+	},
+};
+
 static int __init omap3_evm_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, NULL, 0);
+	omap_register_i2c_bus(1, 2600, omap3evm_i2c_boardinfo,
+			ARRAY_SIZE(omap3evm_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -26,6 +26,9 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+
+#include <linux/i2c/twl4030.h>
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
@@ -143,9 +146,24 @@ static struct omap_uart_config overo_uar
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+static struct twl4030_platform_data overo_twldata = {
+	.irq_base	= TWL4030_IRQ_BASE,
+	.irq_end	= TWL4030_IRQ_END,
+};
+
+static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl4030", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = INT_34XX_SYS_NIRQ,
+		.platform_data = &overo_twldata,
+	},
+};
+
 static int __init overo_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, NULL, 0);
+	omap_register_i2c_bus(1, 2600, overo_i2c_boardinfo,
+			ARRAY_SIZE(overo_i2c_boardinfo));
 	/* i2c2 pins are used for gpio */
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
