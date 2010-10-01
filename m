From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv2 6/6] omap3: Remove VMMC2 regulator on IGEP v2.
Date: Fri,  1 Oct 2010 21:45:53 +0200
Message-ID: <1285962353-9586-7-git-send-email-eballetbo@gmail.com>
References: <1285962353-9586-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42595 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285Ab0JATqR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 15:46:17 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so1814916wwj.1
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 12:46:16 -0700 (PDT)
In-Reply-To: <1285962353-9586-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

VMMC2 regulator is configured but it's not used for the IGEP v2, so
remove this regulator from board.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   26 +++-----------------------
 1 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index c5eaa43..fa450b1 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -260,10 +260,6 @@ static struct regulator_consumer_supply igep2_vmmc1_supply = {
 	.supply		= "vmmc",
 };
 
-static struct regulator_consumer_supply igep2_vmmc2_supply = {
-	.supply		= "vmmc",
-};
-
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
 static struct regulator_init_data igep2_vmmc1 = {
 	.constraints = {
@@ -279,21 +275,6 @@ static struct regulator_init_data igep2_vmmc1 = {
 	.consumer_supplies      = &igep2_vmmc1_supply,
 };
 
-/* VMMC2 for OMAP VDD_MMC2 (i/o) and MMC2 WIFI */
-static struct regulator_init_data igep2_vmmc2 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies  = 1,
-	.consumer_supplies      = &igep2_vmmc2_supply,
-};
-
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -390,11 +371,11 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
 
-	/* link regulators to MMC adapters ... we "know" the
+	/*
+	 * link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
-	*/
+	 */
 	igep2_vmmc1_supply.dev = mmc[0].dev;
-	igep2_vmmc2_supply.dev = mmc[1].dev;
 
 	/*
 	 * REVISIT: need ehci-omap hooks for external VBUS
@@ -534,7 +515,6 @@ static struct twl4030_platform_data igep2_twldata = {
 	.codec		= &igep2_codec_data,
 	.gpio		= &igep2_twl4030_gpio_pdata,
 	.vmmc1          = &igep2_vmmc1,
-	.vmmc2		= &igep2_vmmc2,
 	.vpll2		= &igep2_vpll2,
 
 };
-- 
1.7.0.4

