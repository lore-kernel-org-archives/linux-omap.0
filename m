From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 6/8] RX-51: Audio: Add usage of regulator framework to control VMMC2
Date: Thu,  8 Oct 2009 14:58:55 +0300
Message-ID: <1255003137-1034-7-git-send-email-eduardo.valentin@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45220 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757827AbZJHMBJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 08:01:09 -0400
In-Reply-To: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch adds two supplies for VMMC2 on rx51 boards.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 92f7dfa..9177b1c 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -129,8 +129,9 @@ static struct regulator_consumer_supply rx51_vaux3_supply = {
 	.supply			= "vmmc",
 };
 
-static struct regulator_consumer_supply rx51_vmmc2_supply = {
-	.supply			= "vmmc",
+static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
+	REGULATOR_SUPPLY("avdd_dac", "2-0018"), /* tlv320aic3x */
+	REGULATOR_SUPPLY("vdd", "2-0060"), /* tpa6130a2*/
 };
 
 static struct regulator_consumer_supply rx51_vsim_supply = {
@@ -230,8 +231,8 @@ static struct regulator_init_data rx51_vmmc2 = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &rx51_vmmc2_supply,
+	.num_consumer_supplies	= ARRAY_SIZE(rx51_vmmc2_supplies),
+	.consumer_supplies	= rx51_vmmc2_supplies,
 };
 
 static struct regulator_init_data rx51_vsim = {
@@ -442,10 +443,9 @@ static int __init rx51_i2c_init(void)
 	if ((system_rev >= SYSTEM_REV_S_USES_VAUX3 && system_rev < 0x100) ||
 	    system_rev >= SYSTEM_REV_B_USES_VAUX3)
 		rx51_twldata.vaux3 = &rx51_vaux3_mmc;
-	else {
+	else
 		rx51_twldata.vaux3 = &rx51_vaux3_cam;
-		rx51_twldata.vmmc2 = &rx51_vmmc2;
-	}
+	rx51_twldata.vmmc2 = &rx51_vmmc2;
 	omap_register_i2c_bus(1, 2600, rx51_peripherals_i2c_board_info_1,
 			ARRAY_SIZE(rx51_peripherals_i2c_board_info_1));
 	omap_register_i2c_bus(2, 100, NULL, 0);
-- 
1.6.4.183.g04423

