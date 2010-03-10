From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] omap3: pandora: add missing i2c3 board_info
Date: Wed, 10 Mar 2010 13:13:53 +0200
Message-ID: <1268219633-2154-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:61142 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab0CJLOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 06:14:12 -0500
Received: by fg-out-1718.google.com with SMTP id 16so3355206fgg.1
        for <linux-omap@vger.kernel.org>; Wed, 10 Mar 2010 03:14:10 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>

This will allow BQ27500 fuel gauge to function.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---

BQ27500 support got in during this merge window, so would be
nice to see this in some -rc.

 arch/arm/mach-omap2/board-omap3pandora.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 4827f46..9d79153 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -459,12 +459,20 @@ static struct i2c_board_info __initdata omap3pandora_i2c_boardinfo[] = {
 	},
 };
 
+static struct i2c_board_info __initdata omap3pandora_i2c3_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("bq27500", 0x55),
+		.flags = I2C_CLIENT_WAKE,
+	},
+};
+
 static int __init omap3pandora_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 2600, omap3pandora_i2c_boardinfo,
 			ARRAY_SIZE(omap3pandora_i2c_boardinfo));
 	/* i2c2 pins are not connected */
-	omap_register_i2c_bus(3, 100, NULL, 0);
+	omap_register_i2c_bus(3, 100, omap3pandora_i2c3_boardinfo,
+			ARRAY_SIZE(omap3pandora_i2c3_boardinfo));
 	return 0;
 }
 
-- 
1.6.3.3

