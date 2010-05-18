From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] omap: rx51: Add supplies and data for the tpa6130a2 headphone amplifier
Date: Tue, 18 May 2010 14:06:01 +0300
Message-ID: <1274180761-14221-2-git-send-email-jhnikula@gmail.com>
References: <1274180761-14221-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56926 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560Ab0ERLEP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 07:04:15 -0400
Received: by wyb39 with SMTP id 39so1203530wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 04:04:14 -0700 (PDT)
In-Reply-To: <1274180761-14221-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
This is build and boot safe but required if wanting to add support for
headphones in upcoming sound/soc/omap/rx51.c.
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ead7ee1..2376ef7 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -33,6 +33,8 @@
 #include <plat/onenand.h>
 #include <plat/gpmc-smc91x.h>
 
+#include <sound/tpa6130a2-plat.h>
+
 #include "mux.h"
 #include "hsmmc.h"
 
@@ -285,6 +287,9 @@ static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
 	/* tlv320aic3x analog supplies */
 	REGULATOR_SUPPLY("AVDD", "2-0018"),
 	REGULATOR_SUPPLY("DRVDD", "2-0018"),
+	/* tpa6130a2 */
+	REGULATOR_SUPPLY("CPVSS", "2-0060"),
+	REGULATOR_SUPPLY("Vdd", "2-0060"),
 	/* Keep vmmc as last item. It is not iterated for newer boards */
 	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1"),
 };
@@ -652,10 +657,19 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 	},
 };
 
+static struct tpa6130a2_platform_data rx51_tpa6130a2_data __initdata = {
+	.id			= TPA6130A2,
+	.power_gpio		= 98,
+};
+
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
 	},
+	{
+		I2C_BOARD_INFO("tpa6130a2", 0x60),
+		.platform_data = &rx51_tpa6130a2_data,
+	}
 };
 
 static int __init rx51_i2c_init(void)
-- 
1.7.1

