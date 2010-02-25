From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] AM3517EVM : correct typo - tca6416 mispelt as tca6516
Date: Thu, 25 Feb 2010 15:03:18 -0800
Message-ID: <20100225230318.26233.34046.stgit@baageli.muru.com>
References: <20100225230116.26233.65157.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65276 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934451Ab0BYXCO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 18:02:14 -0500
In-Reply-To: <20100225230116.26233.65157.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sriramakrishnan <srk@ti.com>, linux-omap@vger.kernel.org

From: Sriram <srk@ti.com>

Correct instances where tca6416 is misspelt as tca6516 in
the board-am3517evm file.

Signed-off-by: Sriramakrishnan <srk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index aee0a02..70c1861 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -80,7 +80,7 @@ static void __init am3517_evm_rtc_init(void)
 static struct pca953x_platform_data am3517evm_gpio_expander_info_0 = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 };
-static struct i2c_board_info __initdata am3517evm_tca6516_info_0[] = {
+static struct i2c_board_info __initdata am3517evm_tca6416_info_0[] = {
 	{
 		I2C_BOARD_INFO("tca6416", 0x21),
 		.platform_data = &am3517evm_gpio_expander_info_0,
@@ -94,7 +94,7 @@ static struct pca953x_platform_data am3517evm_ui_gpio_expander_info_1 = {
 static struct pca953x_platform_data am3517evm_ui_gpio_expander_info_2 = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES + 32,
 };
-static struct i2c_board_info __initdata am3517evm_ui_tca6516_info[] = {
+static struct i2c_board_info __initdata am3517evm_ui_tca6416_info[] = {
 	{
 		I2C_BOARD_INFO("tca6416", 0x20),
 		.platform_data = &am3517evm_ui_gpio_expander_info_1,
@@ -108,10 +108,10 @@ static struct i2c_board_info __initdata am3517evm_ui_tca6516_info[] = {
 static int __init am3517_evm_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 400, NULL, 0);
-	omap_register_i2c_bus(2, 400, am3517evm_tca6516_info_0,
-			ARRAY_SIZE(am3517evm_tca6516_info_0));
-	omap_register_i2c_bus(3, 400, am3517evm_ui_tca6516_info,
-			ARRAY_SIZE(am3517evm_ui_tca6516_info));
+	omap_register_i2c_bus(2, 400, am3517evm_tca6416_info_0,
+			ARRAY_SIZE(am3517evm_tca6416_info_0));
+	omap_register_i2c_bus(3, 400, am3517evm_ui_tca6416_info,
+			ARRAY_SIZE(am3517evm_ui_tca6416_info));
 
 	return 0;
 }

