From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v3 3/8] omap: zoom: drop i2c-1 speed to 2400
Date: Wed, 11 Nov 2009 17:41:31 -0600
Message-ID: <1257982896-25087-4-git-send-email-vikram.pandita@ti.com>
References: <1257982896-25087-1-git-send-email-vikram.pandita@ti.com>
 <1257982896-25087-2-git-send-email-vikram.pandita@ti.com>
 <1257982896-25087-3-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37887 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759663AbZKKXmI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 18:42:08 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nABNgDW2002932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 17:42:13 -0600
In-Reply-To: <1257982896-25087-3-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

The I2C-1 bus frequency on zoom2/zoom3/sdp3630 should be 2.4 MHz.
The speed is limited by TWL5030/GAIA; a higher speed could lead to errors
on the interface.

The maximum I2C speed depends on the system clock for GAIA:
2.2 MHz (sys-clk = 19.2 MHz)
2.4 MHz (sys-clk = 26 MHz)
2.9 MHz (sys-clk = 38.4 MHz)

For Zoom2/Zoom3/SDP3630 the system clock is 26Mhz
and hence choose 2.4Mhz for I2C1 bus speed

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/board-zoom-peripherals.c

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
old mode 100644
new mode 100755
index 4ca9c20..54619d5
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -235,7 +235,7 @@ static struct twl4030_platform_data zoom_twldata = {
 
 static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
 	{
-		I2C_BOARD_INFO("twl4030", 0x48),
+		I2C_BOARD_INFO("twl5030", 0x48),
 		.flags		= I2C_CLIENT_WAKE,
 		.irq		= INT_34XX_SYS_NIRQ,
 		.platform_data	= &zoom_twldata,
@@ -244,7 +244,7 @@ static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
 
 static int __init omap_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, zoom_i2c_boardinfo,
+	omap_register_i2c_bus(1, 2400, zoom_i2c_boardinfo,
 			ARRAY_SIZE(zoom_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
-- 
1.6.5.1.69.g36942

