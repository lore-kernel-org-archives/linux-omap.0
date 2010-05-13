From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 1/3] AM3517: rename the i2c boardinfo to make it more readable
Date: Thu, 13 May 2010 20:39:29 +0800
Message-ID: <1273754371-26014-2-git-send-email-stanley.miao@windriver.com>
References: <1273754371-26014-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44953 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab0EMM3Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 08:29:24 -0400
In-Reply-To: <1273754371-26014-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: stanley.miao@windriver.com, tony@atomide.com

There are three i2c buses on am3517, and each i2c bus has several devices
on it, so we can't name the i2c boardinfo structures with one of these
devices. In order to make it more readable, now rename these three boardinfo
structures based on i2c indexes.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Acked-By: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 19b9e41..af383a8 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -136,7 +136,7 @@ void am3517_evm_ethernet_init(struct emac_platform_data *pdata)
 #define LCD_PANEL_BKLIGHT_PWR	182
 #define LCD_PANEL_PWM		181
 
-static struct i2c_board_info __initdata am3517evm_i2c_boardinfo[] = {
+static struct i2c_board_info __initdata am3517evm_i2c1_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("s35390a", 0x30),
 		.type		= "s35390a",
@@ -166,7 +166,7 @@ static void __init am3517_evm_rtc_init(void)
 		gpio_free(GPIO_RTCS35390A_IRQ);
 		return;
 	}
-	am3517evm_i2c_boardinfo[0].irq = gpio_to_irq(GPIO_RTCS35390A_IRQ);
+	am3517evm_i2c1_boardinfo[0].irq = gpio_to_irq(GPIO_RTCS35390A_IRQ);
 }
 
 /*
@@ -177,7 +177,7 @@ static void __init am3517_evm_rtc_init(void)
 static struct pca953x_platform_data am3517evm_gpio_expander_info_0 = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 };
-static struct i2c_board_info __initdata am3517evm_tca6416_info_0[] = {
+static struct i2c_board_info __initdata am3517evm_i2c2_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("tca6416", 0x21),
 		.platform_data = &am3517evm_gpio_expander_info_0,
@@ -191,7 +191,7 @@ static struct pca953x_platform_data am3517evm_ui_gpio_expander_info_1 = {
 static struct pca953x_platform_data am3517evm_ui_gpio_expander_info_2 = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES + 32,
 };
-static struct i2c_board_info __initdata am3517evm_ui_tca6416_info[] = {
+static struct i2c_board_info __initdata am3517evm_i2c3_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("tca6416", 0x20),
 		.platform_data = &am3517evm_ui_gpio_expander_info_1,
@@ -205,10 +205,10 @@ static struct i2c_board_info __initdata am3517evm_ui_tca6416_info[] = {
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
@@ -455,8 +455,8 @@ static void __init am3517_evm_init(void)
 	/* RTC - S35390A */
 	am3517_evm_rtc_init();
 
-	i2c_register_board_info(1, am3517evm_i2c_boardinfo,
-				ARRAY_SIZE(am3517evm_i2c_boardinfo));
+	i2c_register_board_info(1, am3517evm_i2c1_boardinfo,
+				ARRAY_SIZE(am3517evm_i2c1_boardinfo));
 	/*Ethernet*/
 	am3517_evm_ethernet_init(&am3517_evm_emac_pdata);
 }
-- 
1.5.4.3

