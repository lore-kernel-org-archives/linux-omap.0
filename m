From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/8] ARM: OMAP3: RX51: Connect VAUX3 to MMC2
Date: Mon, 25 May 2009 10:52:18 -0700
Message-ID: <20090525175218.19679.40204.stgit@localhost>
References: <20090525174517.19679.18805.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50107 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbZEYRwS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 13:52:18 -0400
In-Reply-To: <20090525174517.19679.18805.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Adrian Hunter <adrian.hunter@nokia.com>

Connect VAUX3 to MMC2

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   30 +++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 233c745..da93b86 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -32,6 +32,9 @@
 
 #include "mmc-twl4030.h"
 
+#define SYSTEM_REV_B_USES_VAUX3	0x1699
+#define SYSTEM_REV_S_USES_VAUX3 0x8
+
 static int rx51_keymap[] = {
 	KEY(0, 0, KEY_Q),
 	KEY(0, 1, KEY_W),
@@ -147,7 +150,7 @@ static struct regulator_init_data rx51_vaux2 = {
 };
 
 /* VAUX3 - adds more power to VIO_18 rail */
-static struct regulator_init_data rx51_vaux3 = {
+static struct regulator_init_data rx51_vaux3_cam = {
 	.constraints = {
 		.name			= "VCAM_DIG_18",
 		.min_uV			= 1800000,
@@ -160,6 +163,22 @@ static struct regulator_init_data rx51_vaux3 = {
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
@@ -270,10 +289,8 @@ static struct twl4030_platform_data rx51_twldata = {
 
 	.vaux1			= &rx51_vaux1,
 	.vaux2			= &rx51_vaux2,
-	.vaux3			= &rx51_vaux3,
 	.vaux4			= &rx51_vaux4,
 	.vmmc1			= &rx51_vmmc1,
-	.vmmc2			= &rx51_vmmc2,
 	.vsim			= &rx51_vsim,
 	.vdac			= &rx51_vdac,
 };
@@ -289,6 +306,13 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 
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

