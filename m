From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/13] omap: rx51: Add supply and data for the tpa6130a2
	headphoneamplifier
Date: Wed, 07 Jul 2010 12:44:29 +0300
Message-ID: <20100707094429.2562.1171.stgit@baageli.muru.com>
References: <20100707094308.2562.91921.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59081 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab0GGJob (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 05:44:31 -0400
In-Reply-To: <20100707094308.2562.91921.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

From: Jarkko Nikula <jhnikula@gmail.com>

With these and upcoming change to tpa6130a2 driver it's possible to add
support for the TPA6130A2 headphone amplifier.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index b4c3dd7..3c3f975 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -33,6 +33,7 @@
 #include <plat/gpmc-smc91x.h>
 
 #include <sound/tlv320aic3x.h>
+#include <sound/tpa6130a2-plat.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -314,6 +315,8 @@ static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
 	/* tlv320aic3x analog supplies */
 	REGULATOR_SUPPLY("AVDD", "2-0018"),
 	REGULATOR_SUPPLY("DRVDD", "2-0018"),
+	/* tpa6130a2 */
+	REGULATOR_SUPPLY("Vdd", "2-0060"),
 	/* Keep vmmc as last item. It is not iterated for newer boards */
 	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1"),
 };
@@ -692,6 +695,11 @@ static struct aic3x_pdata rx51_aic3x_data __initdata = {
 	.gpio_reset		= 60,
 };
 
+static struct tpa6130a2_platform_data rx51_tpa6130a2_data __initdata = {
+	.id			= TPA6130A2,
+	.power_gpio		= 98,
+};
+
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 	{
 		I2C_BOARD_INFO("twl5030", 0x48),
@@ -706,6 +714,10 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
 		.platform_data = &rx51_aic3x_data,
 	},
+	{
+		I2C_BOARD_INFO("tpa6130a2", 0x60),
+		.platform_data = &rx51_tpa6130a2_data,
+	}
 };
 
 static int __init rx51_i2c_init(void)

