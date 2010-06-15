From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: [RFC] [PATCH] Board changes for tmp105 temperature sensor
Date: Tue, 15 Jun 2010 20:15:11 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B34A6404@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49747 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757890Ab0FOOpv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jun 2010 10:45:51 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>

Adding board configuration for the tmp105
temperature sensor. The interface to the sensor
is I2C.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/board-4430sdp.c

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
old mode 100644
new mode 100755
index 4bb2c5d..3e3b222
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -353,6 +353,11 @@ static struct i2c_board_info __initdata sdp4430_i2c_boardinfo[] = {
 		.platform_data = &sdp4430_twldata,
 	},
 };
+static struct i2c_board_info __initdata sdp4430_i2c_3_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("tmp105", 0x48),
+	},
+};
 static int __init omap4_i2c_init(void)
 {
 	/*
@@ -362,7 +367,8 @@ static int __init omap4_i2c_init(void)
 	omap_register_i2c_bus(1, 400, sdp4430_i2c_boardinfo,
 			ARRAY_SIZE(sdp4430_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
+				ARRAY_SIZE(sdp4430_i2c_3_boardinfo));
 	omap_register_i2c_bus(4, 400, NULL, 0);
 	return 0;
 }
-- 
1.5.4.7

