From: Viral Mehta <viral.vkm@gmail.com>
Subject: [PATCH v2] omap: Add I2C bus 1 initialisation
Date: Fri, 16 Apr 2010 10:20:25 +0530
Message-ID: <x2v94efb1e51004152150zf0f327d8g167ce3b1303b9cb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:63868 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab0DPEu3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 00:50:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org

From: Viral Mehta <viral.mehta@lntinfotech.com>

Initialize isp1301 FS USB transceiver and
add I2C bus1 initialization code for OMAP2430 SDP

Signed-off-by: Viral Mehta <viral.mehta@lntinfotech.com>
---
one more effort,
V2: no mangling between tabs and spaces, hopefully :)

 arch/arm/mach-omap2/board-2430sdp.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c
b/arch/arm/mach-omap2/board-2430sdp.c
index 01d113f..346e1d2 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -174,9 +174,17 @@ static struct i2c_board_info __initdata
sdp2430_i2c_boardinfo[] = {
 	},
 };

+static struct i2c_board_info __initdata sdp2430_i2c1_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("isp1301_omap", 0x2D),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = OMAP_GPIO_IRQ(78),
+	},
+}
 static int __init omap2430_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 400, NULL, 0);
+	omap_register_i2c_bus(1, 100, sdp2430_i2c1_boardinfo,
+			ARRAY_SIZE(sdp2430_i2c1_boardinfo));
 	omap_register_i2c_bus(2, 2600, sdp2430_i2c_boardinfo,
 			ARRAY_SIZE(sdp2430_i2c_boardinfo));
 	return 0;
-- 
1.6.6
