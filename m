From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/2] omap: rx51: Use REGULATOR_SUPPLY macro when initializing regulator consumers
Date: Tue, 18 May 2010 14:06:00 +0300
Message-ID: <1274180761-14221-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:36743 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560Ab0ERLEL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 07:04:11 -0400
Received: by wwi17 with SMTP id 17so376312wwi.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 04:04:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   43 ++++++-------------------
 1 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 8179d55..ead7ee1 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -272,48 +272,27 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 	{}	/* Terminator */
 };
 
-static struct regulator_consumer_supply rx51_vmmc1_supply = {
-	.supply   = "vmmc",
-	.dev_name = "mmci-omap-hs.0",
-};
+static struct regulator_consumer_supply rx51_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
 
-static struct regulator_consumer_supply rx51_vaux3_supply = {
-	.supply   = "vmmc",
-	.dev_name = "mmci-omap-hs.1",
-};
+static struct regulator_consumer_supply rx51_vaux3_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
 
-static struct regulator_consumer_supply rx51_vsim_supply = {
-	.supply   = "vmmc_aux",
-	.dev_name = "mmci-omap-hs.1",
-};
+static struct regulator_consumer_supply rx51_vsim_supply =
+	REGULATOR_SUPPLY("vmmc_aux", "mmci-omap-hs.1");
 
 static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
 	/* tlv320aic3x analog supplies */
-	{
-		.supply		= "AVDD",
-		.dev_name	= "2-0018",
-	},
-	{
-		.supply		= "DRVDD",
-		.dev_name	= "2-0018",
-	},
+	REGULATOR_SUPPLY("AVDD", "2-0018"),
+	REGULATOR_SUPPLY("DRVDD", "2-0018"),
 	/* Keep vmmc as last item. It is not iterated for newer boards */
-	{
-		.supply		= "vmmc",
-		.dev_name	= "mmci-omap-hs.1",
-	},
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1"),
 };
 
 static struct regulator_consumer_supply rx51_vio_supplies[] = {
 	/* tlv320aic3x digital supplies */
-	{
-		.supply		= "IOVDD",
-		.dev_name	= "2-0018"
-	},
-	{
-		.supply		= "DVDD",
-		.dev_name	= "2-0018"
-	},
+	REGULATOR_SUPPLY("IOVDD", "2-0018"),
+	REGULATOR_SUPPLY("DVDD", "2-0018"),
 };
 
 static struct regulator_init_data rx51_vaux1 = {
-- 
1.7.1

