From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv3 5/6] omap3: Add i2c eeprom driver to read EDID on IGEP v2.
Date: Fri,  1 Oct 2010 23:09:08 +0200
Message-ID: <1285967349-32767-6-git-send-email-eballetbo@gmail.com>
References: <1285967349-32767-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44636 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab0JAVJ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:09:27 -0400
Received: by wwj40 with SMTP id 40so1907346wwj.1
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 14:09:25 -0700 (PDT)
In-Reply-To: <1285967349-32767-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Add i2c eeprom driver to access monitor EDID binary information
from user space, something that is required by 'decode-edid' and
'parse-edid'.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index ad4bcb1..e253ebc 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -541,7 +541,7 @@ static struct twl4030_platform_data igep2_twldata = {
 
 };
 
-static struct i2c_board_info __initdata igep2_i2c_boardinfo[] = {
+static struct i2c_board_info __initdata igep2_i2c1_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("twl4030", 0x48),
 		.flags		= I2C_CLIENT_WAKE,
@@ -550,13 +550,23 @@ static struct i2c_board_info __initdata igep2_i2c_boardinfo[] = {
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
 
@@ -633,7 +643,7 @@ static void __init igep2_init(void)
 
 	/* Get IGEP2 hardware revision */
 	igep2_get_revision();
-
+	/* Register I2C busses and drivers */
 	igep2_i2c_init();
 	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
 	omap_serial_init();
-- 
1.7.0.4

