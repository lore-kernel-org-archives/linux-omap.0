From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv3 2/3] omap: rx51: Use REGULATOR_SUPPLY macro when initializing regulator consumers
Date: Wed, 26 May 2010 10:30:16 +0300
Message-ID: <1274859017-19509-3-git-send-email-jhnikula@gmail.com>
References: <1274859017-19509-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:33953 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab0EZHaB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 03:30:01 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so748155ewy.28
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 00:30:00 -0700 (PDT)
In-Reply-To: <1274859017-19509-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>

There is REGULATOR_SUPPLY macro available for initializing the struct
regulator_consumer_supply so use it where applicable (all other supplies
than vdds_sdi) as it improves the readability.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
v3:
No functional changes. Rebased on top of 1/3.

v2:
No functional changes but short description added, rebased on top of 7b93a0d
and added Eduardo's ack to v1.
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   43 ++++++-------------------
 1 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 7a604e0..0f9d2e9 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -302,48 +302,27 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
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
 
 #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
-- 
1.7.1

