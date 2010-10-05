From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv4 5/6] omap3: Add i2c eeprom driver to read EDID on IGEP v2.
Date: Tue,  5 Oct 2010 16:15:21 +0200
Message-ID: <1286288122-16834-6-git-send-email-eballetbo@gmail.com>
References: <1286288122-16834-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57932 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab0JEOPk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 10:15:40 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so6055516wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 07:15:39 -0700 (PDT)
In-Reply-To: <1286288122-16834-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Add i2c eeprom driver to access monitor EDID binary information
from user space, something that is required by 'decode-edid' and
'parse-edid'.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   33 ++++++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index ddc740a..aa7b8bd 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -541,7 +541,7 @@ static struct twl4030_platform_data igep2_twldata = {
 
 };
 
-static struct i2c_board_info __initdata igep2_i2c_boardinfo[] = {
+static struct i2c_board_info __initdata igep2_i2c1_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("twl4030", 0x48),
 		.flags		= I2C_CLIENT_WAKE,
@@ -550,14 +550,29 @@ static struct i2c_board_info __initdata igep2_i2c_boardinfo[] = {
 	},
 };
 
-static int __init igep2_i2c_init(void)
+static struct i2c_board_info __initdata igep2_i2c3_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("eeprom", 0x50),
+	},
+};
+
+static void __init igep2_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, igep2_i2c_boardinfo,
-			ARRAY_SIZE(igep2_i2c_boardinfo));
-	/* Bus 3 is attached to the DVI port where devices like the pico DLP
-	 * projector don't work reliably with 400kHz */
-	omap_register_i2c_bus(3, 100, NULL, 0);
-	return 0;
+	int ret;
+
+	ret = omap_register_i2c_bus(1, 2600, igep2_i2c1_boardinfo,
+		ARRAY_SIZE(igep2_i2c1_boardinfo));
+	if (ret)
+		pr_warning("IGEP2: Could not register I2C1 bus (%d)\n", ret);
+
+	/*
+	 * Bus 3 is attached to the DVI port where devices like the pico DLP
+	 * projector don't work reliably with 400kHz
+	 */
+	ret = omap_register_i2c_bus(3, 100, igep2_i2c3_boardinfo,
+		ARRAY_SIZE(igep2_i2c3_boardinfo));
+	if (ret)
+		pr_warning("IGEP2: Could not register I2C3 bus (%d)\n", ret);
 }
 
 static struct omap_musb_board_data musb_board_data = {
@@ -635,7 +650,7 @@ static void __init igep2_init(void)
 
 	/* Get IGEP2 hardware revision */
 	igep2_get_revision();
-
+	/* Register I2C busses and drivers */
 	igep2_i2c_init();
 	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
 	omap_serial_init();
-- 
1.7.0.4

