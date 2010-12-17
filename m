From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 3/3] omap: rx51: Add supplies and data for codec b part of TLV320AIC34
Date: Fri, 17 Dec 2010 21:18:25 +0200
Message-ID: <1292613505-10113-3-git-send-email-jhnikula@gmail.com>
References: <1292613505-10113-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:53601 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab0LQTQ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 14:16:57 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so521061ewy.4
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 11:16:56 -0800 (PST)
In-Reply-To: <1292613505-10113-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>

Upcoming ASoC core and tlv320aic3x changes makes possible to take b part of
TLV320AIC34 into use on RX51/N900. Prepare to this by adding virtual supplies
and platform data for b part of the codec.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 6114e47..ca8cecd 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -343,6 +343,8 @@ static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
 	/* tlv320aic3x analog supplies */
 	REGULATOR_SUPPLY("AVDD", "2-0018"),
 	REGULATOR_SUPPLY("DRVDD", "2-0018"),
+	REGULATOR_SUPPLY("AVDD", "2-0019"),
+	REGULATOR_SUPPLY("DRVDD", "2-0019"),
 	/* tpa6130a2 */
 	REGULATOR_SUPPLY("Vdd", "2-0060"),
 	/* Keep vmmc as last item. It is not iterated for newer boards */
@@ -353,6 +355,8 @@ static struct regulator_consumer_supply rx51_vio_supplies[] = {
 	/* tlv320aic3x digital supplies */
 	REGULATOR_SUPPLY("IOVDD", "2-0018"),
 	REGULATOR_SUPPLY("DVDD", "2-0018"),
+	REGULATOR_SUPPLY("IOVDD", "2-0019"),
+	REGULATOR_SUPPLY("DVDD", "2-0019"),
 };
 
 #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
@@ -743,11 +747,19 @@ static struct aic3x_pdata rx51_aic3x_data = {
 	.gpio_reset = 60,
 };
 
+static struct aic3x_pdata rx51_aic3x_data2 = {
+	.gpio_reset = 60,
+};
+
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
 		.platform_data = &rx51_aic3x_data,
 	},
+	{
+		I2C_BOARD_INFO("tlv320aic3x", 0x19),
+		.platform_data = &rx51_aic3x_data2,
+	},
 #if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
 	{
 		I2C_BOARD_INFO("tsl2563", 0x29),
-- 
1.7.2.3

