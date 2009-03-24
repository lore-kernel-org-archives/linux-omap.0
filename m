From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH] RX51: connect VAUX3 to MMC2
Date: Tue, 24 Mar 2009 14:17:05 +0200
Message-ID: <49C8CF41.2040103@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41779 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbZCXMQ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 08:16:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>

>From 6d7a4c9322e70e83bdcf66d151c1ce56ba2f949f Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   29 +++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 6e23587..41bb392 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -30,6 +30,8 @@
 
 #include "mmc-twl4030.h"
 
+#define SYSTEM_REV_B_USES_VAUX3 0x1699
+#define SYSTEM_REV_S_USES_VAUX3 0x8
 
 #define SMC91X_CS			1
 #define SMC91X_GPIO_IRQ			54
@@ -306,7 +308,7 @@ static struct regulator_init_data rx51_vaux2 = {
 };
 
 /* VAUX3 - adds more power to VIO_18 rail */
-static struct regulator_init_data rx51_vaux3 = {
+static struct regulator_init_data rx51_vaux3_cam = {
 	.constraints = {
 		.name			= "VCAM_DIG_18",
 		.min_uV			= 1800000,
@@ -319,6 +321,22 @@ static struct regulator_init_data rx51_vaux3 = {
 	},
 };
 
+static struct regulator_init_data rx51_vaux3_mmc = {
+	.constraints = {
+		.name			= "VMMC2_30",
+		.min_uV			= 2800000,
+		.max_uV			= 3000000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &rx51_vmmc2_supply,
+};
+
 static struct regulator_init_data rx51_vaux4 = {
 	.constraints = {
 		.name			= "VCAM_ANA_28",
@@ -429,10 +447,8 @@ static struct twl4030_platform_data rx51_twldata = {
 
 	.vaux1			= &rx51_vaux1,
 	.vaux2			= &rx51_vaux2,
-	.vaux3			= &rx51_vaux3,
 	.vaux4			= &rx51_vaux4,
 	.vmmc1			= &rx51_vmmc1,
-	.vmmc2			= &rx51_vmmc2,
 	.vsim			= &rx51_vsim,
 	.vdac			= &rx51_vdac,
 };
@@ -448,6 +464,13 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 
 static int __init rx51_i2c_init(void)
 {
+	if ((system_rev >= SYSTEM_REV_S_USES_VAUX3 && system_rev < 0x100) ||
+	    system_rev >= SYSTEM_REV_B_USES_VAUX3)
+		rx51_twldata.vaux3 = &rx51_vaux3_mmc;
+	else {
+		rx51_twldata.vaux3 = &rx51_vaux3_cam;
+		rx51_twldata.vmmc2 = &rx51_vmmc2;
+	}
 	omap_register_i2c_bus(1, 2600, rx51_peripherals_i2c_board_info_1,
 			ARRAY_SIZE(rx51_peripherals_i2c_board_info_1));
 	omap_register_i2c_bus(2, 100, NULL, 0);
-- 
1.5.6.3
