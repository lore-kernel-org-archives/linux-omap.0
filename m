From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/3] omap: rx51: Add i2c2 board_info with tlv320aic3x
Date: Mon,  3 May 2010 18:56:15 +0300
Message-ID: <1272902176-21033-2-git-send-email-jhnikula@gmail.com>
References: <1272902176-21033-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:42129 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759665Ab0ECPzV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 11:55:21 -0400
Received: by ewy22 with SMTP id 22so730407ewy.37
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 08:55:19 -0700 (PDT)
In-Reply-To: <1272902176-21033-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>

This makes possible to probe the audio codec and add another i2c2
components in the future.

Fix also indentation for the first omap_register_i2c_bus.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index b803f47..3addfe6 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -629,6 +629,12 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 	},
 };
 
+static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
+	{
+		I2C_BOARD_INFO("tlv320aic3x", 0x18),
+	},
+};
+
 static int __init rx51_i2c_init(void)
 {
 	if ((system_rev >= SYSTEM_REV_S_USES_VAUX3 && system_rev < 0x100) ||
@@ -639,8 +645,9 @@ static int __init rx51_i2c_init(void)
 		rx51_twldata.vmmc2 = &rx51_vmmc2;
 	}
 	omap_register_i2c_bus(1, 2200, rx51_peripherals_i2c_board_info_1,
-			ARRAY_SIZE(rx51_peripherals_i2c_board_info_1));
-	omap_register_i2c_bus(2, 100, NULL, 0);
+			      ARRAY_SIZE(rx51_peripherals_i2c_board_info_1));
+	omap_register_i2c_bus(2, 100, rx51_peripherals_i2c_board_info_2,
+			      ARRAY_SIZE(rx51_peripherals_i2c_board_info_2));
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
 }
-- 
1.7.0

