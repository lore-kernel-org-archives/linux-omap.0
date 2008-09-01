From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP2: Fix Nokia N8x0 second I2C bus device registration
Date: Mon,  1 Sep 2008 16:05:04 +0300
Message-ID: <1220274304-23744-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43481 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbYIANF1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 09:05:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Jarkko Nikula <jarkko.nikula@nokia.com>

- TSL2563 and LP5521 are found only in N810
- Fix one typo

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/board-n800.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index 95cc84a..1df9f3d 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -649,12 +649,6 @@ static struct i2c_board_info __initdata_or_module n8x0_i2c_board_info_2[] = {
 		.platform_data = &n800_tcm825x_platform_data,
 #endif
 	},
-	{
-		I2C_BOARD_INFO("tsl2563", 0x29),
-	},
-	{
-		I2C_BOARD_INFO("lp5521", 0x32),
-	},
 };
 
 
@@ -670,6 +664,12 @@ static struct i2c_board_info __initdata_or_module n810_i2c_board_info_2[] = {
 		.irq		= OMAP_GPIO_IRQ(109),
 		.platform_data	= &lm8323_pdata,
 	},
+	{
+		I2C_BOARD_INFO("tsl2563", 0x29),
+	},
+	{
+		I2C_BOARD_INFO("lp5521", 0x32),
+	},
 };
 
 void __init nokia_n800_common_init(void)
@@ -694,7 +694,7 @@ void __init nokia_n800_common_init(void)
 	omap_register_i2c_bus(1, 400, n800_i2c_board_info_1,
 			      ARRAY_SIZE(n800_i2c_board_info_1));
 	omap_register_i2c_bus(2, 400, n8x0_i2c_board_info_2,
-			      ARRAY_SIZE(n800_i2c_board_info_2));
+			      ARRAY_SIZE(n8x0_i2c_board_info_2));
 	if (machine_is_nokia_n800())
 		i2c_register_board_info(2, n800_i2c_board_info_2,
 			ARRAY_SIZE(n800_i2c_board_info_2));
-- 
1.5.6.3

