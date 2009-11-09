From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: [PATCH 2/2] omap: rx51: Enable RX-51 ambient light sensor
Date: Mon,  9 Nov 2009 15:14:55 +0200
Message-ID: <1257772495-4221-1-git-send-email-amit.kucheria@verdurent.com>
References: <1257772468-4004-1-git-send-email-amit.kucheria@verdurent.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22570 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230AbZKINPG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 08:15:06 -0500
In-Reply-To: <1257772468-4004-1-git-send-email-amit.kucheria@verdurent.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: List Linux Kernel <linux-kernel@vger.kernel.org>
Cc: tony@atomide.com, Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>, linux-omap@vger.kernel.org

The driver is at staging/iio/light/tsl2563.c for now since the IIO subsystem
seems to be the preferred subsystems for such drivers now.

Enable it on the RX-51 for now. The ugly #include will get fixed when IIO
moves from staging to its own subsystem.

Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: tony@atomide.com
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-omap@vger.kernel.org
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index cf4583a..1923699 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -31,6 +31,7 @@
 #include <plat/onenand.h>
 #include <plat/gpmc-smc91x.h>
 
+#include "../../../drivers/staging/iio/light/tsl2563.h"
 #include "mmc-twl4030.h"
 
 #define SYSTEM_REV_B_USES_VAUX3	0x1699
@@ -290,6 +291,10 @@ static struct twl4030_usb_data rx51_usb_data = {
 	.usb_mode		= T2_USB_MODE_ULPI,
 };
 
+static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
+	.cover_comp_gain = 16,
+};
+
 static struct twl4030_ins sleep_on_seq[] __initdata = {
 /*
  * Turn off VDD1 and VDD2.
@@ -435,6 +440,14 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 	},
 };
 
+static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
+	{
+		I2C_BOARD_INFO("tsl2563", 0x29),
+		.platform_data = &rx51_tsl2563_platform_data,
+	},
+};
+
+
 static int __init rx51_i2c_init(void)
 {
 	if ((system_rev >= SYSTEM_REV_S_USES_VAUX3 && system_rev < 0x100) ||
@@ -446,7 +459,8 @@ static int __init rx51_i2c_init(void)
 	}
 	omap_register_i2c_bus(1, 2200, rx51_peripherals_i2c_board_info_1,
 			ARRAY_SIZE(rx51_peripherals_i2c_board_info_1));
-	omap_register_i2c_bus(2, 100, NULL, 0);
+	omap_register_i2c_bus(2, 100, rx51_peripherals_i2c_board_info_2,
+			ARRAY_SIZE(rx51_peripherals_i2c_board_info_2));
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
 }
-- 
1.6.3.3

