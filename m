From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/13] omap4: mmc: Fix the regulator resource for MMC2 on
	4430sdp
Date: Wed, 07 Jul 2010 12:44:35 +0300
Message-ID: <20100707094435.2562.27410.stgit@baageli.muru.com>
References: <20100707094308.2562.91921.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59247 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab0GGJol (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 05:44:41 -0400
In-Reply-To: <20100707094308.2562.91921.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Kishore Kadiyala <kishore.kadiyala@ti.com>, Rajendra Nayak <rnayak@ti.com>, Sukumar Ghorai <s-ghorai@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

The MMC1 and MMC2 cards have seperate LDO supplies. Current code assumes
that they are powered by same LDO.

This patch fixes the same and has VAUX1 as supply to MMC2 card.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Tested-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index e4a5d66..216870b 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -156,14 +156,16 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
+static struct regulator_consumer_supply sdp4430_vaux_supply[] = {
 	{
 		.supply = "vmmc",
-		.dev_name = "mmci-omap-hs.0",
+		.dev_name = "mmci-omap-hs.1",
 	},
+};
+static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
 	{
 		.supply = "vmmc",
-		.dev_name = "mmci-omap-hs.1",
+		.dev_name = "mmci-omap-hs.0",
 	},
 };
 
@@ -210,6 +212,8 @@ static struct regulator_init_data sdp4430_vaux1 = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies  = 1,
+	.consumer_supplies      = sdp4430_vaux_supply,
 };
 
 static struct regulator_init_data sdp4430_vaux2 = {
@@ -250,7 +254,7 @@ static struct regulator_init_data sdp4430_vmmc = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = 2,
+	.num_consumer_supplies  = 1,
 	.consumer_supplies      = sdp4430_vmmc_supply,
 };
 

