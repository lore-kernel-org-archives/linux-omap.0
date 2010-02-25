From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH 2/2] AM3517EVM : correct typo - tca6416 mispelt as tca6516.
Date: Thu, 25 Feb 2010 16:15:49 +0530
Message-ID: <1267094749-5593-2-git-send-email-srk@ti.com>
References: <1267094749-5593-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54604 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759138Ab0BYKpy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 05:45:54 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1PAjp0A001040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 25 Feb 2010 04:45:53 -0600
In-Reply-To: <1267094749-5593-1-git-send-email-srk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sriramakrishnan <srk@ti.com>

Correct instances where tca6416 is misspelt as tca6516 in
the board-am3517evm file.

Signed-off-by: Sriramakrishnan <srk@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index e6b8967..b336adc 100644
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
-- 
1.6.2.4

