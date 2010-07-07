From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/13] tsl2563 ALS support for Nokia N900
Date: Wed, 07 Jul 2010 12:44:32 +0300
Message-ID: <20100707094432.2562.30773.stgit@baageli.muru.com>
References: <20100707094308.2562.91921.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59899 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab0GGJoe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 05:44:34 -0400
In-Reply-To: <20100707094308.2562.91921.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>

From: Ameya Palande <ameya.palande@nokia.com>

This commit will enable usage of tsl2563 ambient light sensor on Nokia N900.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 3c3f975..3ae3591 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/mmc/host.h>
+#include <../drivers/staging/iio/light/tsl2563.h>
 
 #include <plat/mcspi.h>
 #include <plat/board.h>
@@ -68,6 +69,10 @@ static struct omap2_mcspi_device_config tsc2005_mcspi_config = {
 	.single_channel	= 1,
 };
 
+static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
+	.cover_comp_gain = 16,
+	};
+
 static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 	[RX51_SPI_WL1251] = {
 		.modalias		= "wl1251",
@@ -707,6 +712,9 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 		.irq = INT_34XX_SYS_NIRQ,
 		.platform_data = &rx51_twldata,
 	},
+	{	I2C_BOARD_INFO("tsl2563", 0x29),
+		.platform_data = &rx51_tsl2563_platform_data,
+	},
 };
 
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {

