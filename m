From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [RFC PATCH] hmc5843: Digital compass board file
Date: Mon, 16 Aug 2010 12:01:29 +0530
Message-ID: <1281940289-18188-1-git-send-email-shubhrajyoti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39702 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502Ab0HPGbf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 02:31:35 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7G6VVIa031100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 Aug 2010 01:31:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>

The  board file changes for the digital compass hmc5843.
The interface to the device is i2c.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9447644..5b6a48d 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -412,6 +412,11 @@ static struct i2c_board_info __initdata sdp4430_i2c_3_boardinfo[] = {
 		I2C_BOARD_INFO("tmp105", 0x48),
 	},
 };
+static struct i2c_board_info __initdata sdp4430_i2c_4_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("hmc5843", 0x1e),
+	},
+};
 static int __init omap4_i2c_init(void)
 {
 	/*
@@ -423,7 +428,8 @@ static int __init omap4_i2c_init(void)
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
 				ARRAY_SIZE(sdp4430_i2c_3_boardinfo));
-	omap_register_i2c_bus(4, 400, NULL, 0);
+	omap_register_i2c_bus(4, 400, sdp4430_i2c_4_boardinfo,
+				ARRAY_SIZE(sdp4430_i2c_4_boardinfo));
 	return 0;
 }
 static void __init omap_4430sdp_init(void)
-- 
1.7.0.4

