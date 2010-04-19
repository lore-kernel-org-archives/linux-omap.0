From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 3/9] AM3517: rename the i2c boardinfo to make it more readable
Date: Mon, 19 Apr 2010 18:20:41 +0800
Message-ID: <1271672447-3639-4-git-send-email-stanley.miao@windriver.com>
References: <1271672447-3639-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51720 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab0DSKMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 06:12:00 -0400
In-Reply-To: <1271672447-3639-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, hvaibhav@ti.com, srk@ti.com

There are three i2c buses on am3517, now rename these three boardinfo
structure name to am3517evm_i2c1_boardinfo, am3517evm_i2c2_boardinfo,
and am3517evm_i2c3_boardinfo, to make it more readable.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 6ae8805..3acfcae 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -39,7 +39,7 @@
 #define LCD_PANEL_BKLIGHT_PWR	182
 #define LCD_PANEL_PWM		181
 
-static struct i2c_board_info __initdata am3517evm_i2c_boardinfo[] = {
+static struct i2c_board_info __initdata am3517evm_i2c1_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("s35390a", 0x30),
 		.type		= "s35390a",
@@ -69,7 +69,7 @@ static void __init am3517_evm_rtc_init(void)
 		gpio_free(GPIO_RTCS35390A_IRQ);
 		return;
 	}
-	am3517evm_i2c_boardinfo[0].irq = gpio_to_irq(GPIO_RTCS35390A_IRQ);
+	am3517evm_i2c1_boardinfo[0].irq = gpio_to_irq(GPIO_RTCS35390A_IRQ);
 }
 
 /*
@@ -80,7 +80,7 @@ static void __init am3517_evm_rtc_init(void)
 static struct pca953x_platform_data am3517evm_gpio_expander_info_0 = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 };
-static struct i2c_board_info __initdata am3517evm_tca6416_info_0[] = {
+static struct i2c_board_info __initdata am3517evm_i2c2_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("tca6416", 0x21),
 		.platform_data = &am3517evm_gpio_expander_info_0,
@@ -94,7 +94,7 @@ static struct pca953x_platform_data am3517evm_ui_gpio_expander_info_1 = {
 static struct pca953x_platform_data am3517evm_ui_gpio_expander_info_2 = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES + 32,
 };
-static struct i2c_board_info __initdata am3517evm_ui_tca6416_info[] = {
+static struct i2c_board_info __initdata am3517evm_i2c3_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("tca6416", 0x20),
 		.platform_data = &am3517evm_ui_gpio_expander_info_1,
@@ -108,10 +108,10 @@ static struct i2c_board_info __initdata am3517evm_ui_tca6416_info[] = {
 static int __init am3517_evm_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 400, NULL, 0);
-	omap_register_i2c_bus(2, 400, am3517evm_tca6416_info_0,
-			ARRAY_SIZE(am3517evm_tca6416_info_0));
-	omap_register_i2c_bus(3, 400, am3517evm_ui_tca6416_info,
-			ARRAY_SIZE(am3517evm_ui_tca6416_info));
+	omap_register_i2c_bus(2, 400, am3517evm_i2c2_boardinfo,
+			ARRAY_SIZE(am3517evm_i2c2_boardinfo));
+	omap_register_i2c_bus(3, 400, am3517evm_i2c3_boardinfo,
+			ARRAY_SIZE(am3517evm_i2c3_boardinfo));
 
 	return 0;
 }
@@ -311,8 +311,8 @@ static void __init am3517_evm_init(void)
 	/* RTC - S35390A */
 	am3517_evm_rtc_init();
 
-	i2c_register_board_info(1, am3517evm_i2c_boardinfo,
-				ARRAY_SIZE(am3517evm_i2c_boardinfo));
+	i2c_register_board_info(1, am3517evm_i2c1_boardinfo,
+				ARRAY_SIZE(am3517evm_i2c1_boardinfo));
 }
 
 static void __init am3517_evm_map_io(void)
-- 
1.5.4.3

