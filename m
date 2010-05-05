From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 16/18] omap: rx51: Add i2c2 board_info with tlv320aic3x
Date: Wed, 05 May 2010 12:33:20 -0700
Message-ID: <20100505193320.21568.26640.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50246 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757981Ab0EETdV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 15:33:21 -0400
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

From: Jarkko Nikula <jhnikula@gmail.com>

This makes possible to probe the audio codec and add another i2c2
components in the future.

Fix also indentation for the first omap_register_i2c_bus.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

