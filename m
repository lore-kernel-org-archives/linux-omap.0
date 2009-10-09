From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH v2] OMAP: RX-51: Drop I2C-1 speed to 2200
Date: Fri,  9 Oct 2009 19:40:37 +0300
Message-ID: <1255106437-13202-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52092 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZJIQmN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 12:42:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org

The I2C-1 bus frequency on RX-51 should be 2.2 MHz. The speed is limited
by TWL5030/GAIA; a higher speed could lead to errors on the interface. The
maximum speed depends on the system clock for GAIA: 2.2 MHz (if 19.2 MHz),
2.4 MHz (26 MHz) or 2.9 MHz (38.4 MHz).

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
v2: Describe the reason for the change.

 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index c1af532..2b0eb1b 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -444,7 +444,7 @@ static int __init rx51_i2c_init(void)
 		rx51_twldata.vaux3 = &rx51_vaux3_cam;
 		rx51_twldata.vmmc2 = &rx51_vmmc2;
 	}
-	omap_register_i2c_bus(1, 2600, rx51_peripherals_i2c_board_info_1,
+	omap_register_i2c_bus(1, 2200, rx51_peripherals_i2c_board_info_1,
 			ARRAY_SIZE(rx51_peripherals_i2c_board_info_1));
 	omap_register_i2c_bus(2, 100, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
-- 
1.6.0.4

