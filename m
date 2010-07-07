From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/13] omap: rx51: Use REGULATOR_SUPPLY macro when
	initializingregulator consumers
Date: Wed, 07 Jul 2010 12:44:23 +0300
Message-ID: <20100707094423.2562.78977.stgit@baageli.muru.com>
References: <20100707094308.2562.91921.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59759 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab0GGJo2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 05:44:28 -0400
In-Reply-To: <20100707094308.2562.91921.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Jarkko Nikula <jhnikula@gmail.com>

There is REGULATOR_SUPPLY macro available for initializing the struct
regulator_consumer_supply so use it where applicable (all other supplies
than vdds_sdi) as it improves the readability.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Eduardo Valentin <eduardo.valentin@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   43 +++++++-------------------
 1 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e350f0b..b4c3dd7 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -301,48 +301,27 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
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

