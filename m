From: Mathias Nyman <mathias.nyman@nokia.com>
Subject: [PATCH] omap: rx51: Platform support for tsl2563 ALS
Date: Fri,  9 Jul 2010 11:01:20 +0300
Message-ID: <1278662480-12496-1-git-send-email-mathias.nyman@nokia.com>
References: <20100709071835.GF24913@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50518 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab0GIIBj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 04:01:39 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o6981W2A008191
	for <linux-omap@vger.kernel.org>; Fri, 9 Jul 2010 03:01:38 -0500
Received: from localhost.localdomain (esdhcp038119.research.nokia.com [172.21.38.119])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o6981OAZ003193
	for <linux-omap@vger.kernel.org>; Fri, 9 Jul 2010 11:01:24 +0300
In-Reply-To: <20100709071835.GF24913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Mathias Nyman <mathias.nyman@nokia.com>

This will enable usage of tsl2563 ambient light sensor on Nokia N900.


Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 3c3f975..a3a396c 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -35,6 +35,8 @@
 #include <sound/tlv320aic3x.h>
 #include <sound/tpa6130a2-plat.h>
 
+#include <../drivers/staging/iio/light/tsl2563.h>
+
 #include "mux.h"
 #include "hsmmc.h"
 
@@ -53,6 +55,12 @@ enum {
 
 static struct wl12xx_platform_data wl1251_pdata;
 
+#if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
+static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
+	.cover_comp_gain = 16,
+};
+#endif
+
 static struct omap2_mcspi_device_config wl1251_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel	= 1,
@@ -714,6 +722,12 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
 		.platform_data = &rx51_aic3x_data,
 	},
+#if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
+	{
+		I2C_BOARD_INFO("tsl2563", 0x29),
+		.platform_data = &rx51_tsl2563_platform_data,
+	},
+#endif
 	{
 		I2C_BOARD_INFO("tpa6130a2", 0x60),
 		.platform_data = &rx51_tpa6130a2_data,
-- 
1.7.0.4

