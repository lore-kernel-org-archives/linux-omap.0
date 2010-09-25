From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 5/6] omap3: Add i2c eeprom driver to read EDID on IGEP v2.
Date: Sat, 25 Sep 2010 20:19:05 +0200
Message-ID: <1285438746-7311-6-git-send-email-eballetbo@gmail.com>
References: <1285438746-7311-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42781 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756401Ab0IYSTX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Sep 2010 14:19:23 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so2805411wyb.19
        for <linux-omap@vger.kernel.org>; Sat, 25 Sep 2010 11:19:22 -0700 (PDT)
In-Reply-To: <1285438746-7311-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Add i2c eeprom driver to access monitor EDID binary information
from user space, something that is required by 'decode-edid' and
'parse-edid'.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index ec7da7f..c5eaa43 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -539,7 +539,7 @@ static struct twl4030_platform_data igep2_twldata = {
 
 };
 
-static struct i2c_board_info __initdata igep2_i2c_boardinfo[] = {
+static struct i2c_board_info __initdata igep2_i2c1_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("twl4030", 0x48),
 		.flags		= I2C_CLIENT_WAKE,
@@ -548,13 +548,23 @@ static struct i2c_board_info __initdata igep2_i2c_boardinfo[] = {
 	},
 };
 
+static struct i2c_board_info __initdata igep2_i2c3_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("eeprom", 0x50),
+	},
+};
+
 static int __init igep2_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, igep2_i2c_boardinfo,
-			ARRAY_SIZE(igep2_i2c_boardinfo));
-	/* Bus 3 is attached to the DVI port where devices like the pico DLP
-	 * projector don't work reliably with 400kHz */
-	omap_register_i2c_bus(3, 100, NULL, 0);
+	omap_register_i2c_bus(1, 2600, igep2_i2c1_boardinfo,
+			ARRAY_SIZE(igep2_i2c1_boardinfo));
+	/*
+	 * Bus 3 is attached to the DVI port where devices like the pico DLP
+	 * projector don't work reliably with 400kHz
+	 */
+	omap_register_i2c_bus(3, 100, igep2_i2c3_boardinfo,
+			 ARRAY_SIZE(igep2_i2c3_boardinfo));
+
 	return 0;
 }
 
@@ -631,7 +641,7 @@ static void __init igep2_init(void)
 
 	/* Get IGEP2 hardware revision */
 	igep2_get_revision();
-
+	/* Register I2C busses and drivers */
 	igep2_i2c_init();
 	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
 	omap_serial_init();
-- 
1.7.0.4

