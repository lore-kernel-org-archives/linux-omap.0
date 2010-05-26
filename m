From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/3] omap: rx51: Add platform_data for tlv320aic3x with reset gpio number
Date: Wed, 26 May 2010 10:30:15 +0300
Message-ID: <1274859017-19509-2-git-send-email-jhnikula@gmail.com>
References: <1274859017-19509-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:33953 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab0EZH36 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 03:29:58 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so748155ewy.28
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 00:29:57 -0700 (PDT)
In-Reply-To: <1274859017-19509-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>

Proper operation of the tlv320aic3x audio codec requires that reset
sequencing is done in pair with supply voltages when using the regulator
framework. Add the codec reset gpio used in Nokia RX51 to tlv320aic3x
data.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index abdf321..7a604e0 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -33,6 +33,8 @@
 #include <plat/onenand.h>
 #include <plat/gpmc-smc91x.h>
 
+#include <sound/tlv320aic3x.h>
+
 #include "mux.h"
 #include "hsmmc.h"
 
@@ -707,6 +709,10 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
 	.vio			= &rx51_vio,
 };
 
+static struct aic3x_pdata rx51_aic3x_data __initdata = {
+	.gpio_reset		= 60,
+};
+
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 	{
 		I2C_BOARD_INFO("twl5030", 0x48),
@@ -719,6 +725,7 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
+		.platform_data = &rx51_aic3x_data,
 	},
 };
 
-- 
1.7.1

