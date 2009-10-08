From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 5/8] board-rx51-peripherals: split vaux3 and vmmc2 supplies
Date: Thu,  8 Oct 2009 14:58:54 +0300
Message-ID: <1255003137-1034-6-git-send-email-eduardo.valentin@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55046 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757665AbZJHMBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 08:01:04 -0400
In-Reply-To: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Use separated supplies for vaux3 and vmmc2.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index b227475..92f7dfa 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -125,6 +125,10 @@ static struct regulator_consumer_supply rx51_vmmc1_supply = {
 	.supply			= "vmmc",
 };
 
+static struct regulator_consumer_supply rx51_vaux3_supply = {
+	.supply			= "vmmc",
+};
+
 static struct regulator_consumer_supply rx51_vmmc2_supply = {
 	.supply			= "vmmc",
 };
@@ -184,7 +188,7 @@ static struct regulator_init_data rx51_vaux3_mmc = {
 					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &rx51_vmmc2_supply,
+	.consumer_supplies	= &rx51_vaux3_supply,
 };
 
 static struct regulator_init_data rx51_vaux4 = {
@@ -266,7 +270,7 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 	/* set up MMC adapters, linking their regulators to them */
 	twl4030_mmc_init(mmc);
 	rx51_vmmc1_supply.dev = mmc[0].dev;
-	rx51_vmmc2_supply.dev = mmc[1].dev;
+	rx51_vaux3_supply.dev = mmc[1].dev;
 	rx51_vsim_supply.dev = mmc[1].dev;
 
 	return 0;
-- 
1.6.4.183.g04423

