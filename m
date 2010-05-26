From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv3 3/3] omap: rx51: Add supply and data for the tpa6130a2 headphone amplifier
Date: Wed, 26 May 2010 10:30:17 +0300
Message-ID: <1274859017-19509-4-git-send-email-jhnikula@gmail.com>
References: <1274859017-19509-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:65325 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129Ab0EZHaF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 03:30:05 -0400
Received: by ey-out-2122.google.com with SMTP id 9so152498eyd.5
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 00:30:03 -0700 (PDT)
In-Reply-To: <1274859017-19509-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>

With these and upcoming change to tpa6130a2 driver it's possible to add
support for the TPA6130A2 headphone amplifier.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
v3:
- No functional changes. Rebased on top of 1/3.

v2:
- Rebased on top of 7b93a0d
- Only Vdd supply added as the CPVSS turned out to be miss defined in
  tpa6130a2. Thanks to Eduardo Valentin <eduardo.valentin@nokia.com> for
  noticing.
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 0f9d2e9..87e00b8 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -34,6 +34,7 @@
 #include <plat/gpmc-smc91x.h>
 
 #include <sound/tlv320aic3x.h>
+#include <sound/tpa6130a2-plat.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -315,6 +316,8 @@ static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
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
-- 
1.7.1

