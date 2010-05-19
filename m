From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] tsl2563 ALS support for Nokia N900
Date: Wed, 19 May 2010 19:11:30 +0300
Message-ID: <63bae8d024cc56ac3ea380dee21ac9add900a7e0.1274285408.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25639 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab0ESQMO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 12:12:14 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o4JGBFB6005449
	for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 11:12:13 -0500
Received: from localhost.localdomain (esdhcp04343.research.nokia.com [172.21.43.43])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o4JGBubj023027
	for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 19:11:56 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This commit will enable usage of tsl2563 ambient light sensor on Nokia N900.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 966f5f8..82d5ac7 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/mmc/host.h>
+#include <../drivers/staging/iio/light/tsl2563.h>
 
 #include <plat/mcspi.h>
 #include <plat/mux.h>
@@ -54,6 +55,10 @@ static struct omap2_mcspi_device_config wl1251_mcspi_config = {
 	.single_channel	= 1,
 };
 
+static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
+	.cover_comp_gain = 16,
+	};
+
 static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 	[RX51_SPI_WL1251] = {
 		.modalias		= "wl1251",
@@ -686,6 +691,9 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 		.irq = INT_34XX_SYS_NIRQ,
 		.platform_data = &rx51_twldata,
 	},
+	{	I2C_BOARD_INFO("tsl2563", 0x29),
+		.platform_data = &rx51_tsl2563_platform_data,
+	},
 };
 
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
-- 
1.6.3.3

