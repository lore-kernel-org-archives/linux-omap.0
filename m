From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap4: mmc: Fix the regulator resource for MMC2
Date: Fri, 28 May 2010 21:38:04 +0530
Message-ID: <1275062884-8584-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55007 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758930Ab0E1QIJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 May 2010 12:08:09 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4SG86QF004647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 28 May 2010 11:08:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Sukumar Ghorai <s-ghorai@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>

The MMC1 and MMC2 cards have seperate LDO supplies. Current code assumes
that they are powered by same LDO.

This patch fixes the same and has VAUX1 as supply to MMC2 card.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Tested-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Tested with omap3_defconfig on OMAP4430SDP

 arch/arm/mach-omap2/board-4430sdp.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 7a78986..f62042e 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -384,14 +384,16 @@ static struct omap2_hsmmc_info mmc[] = {
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
 
@@ -447,6 +449,8 @@ static struct regulator_init_data sdp4430_vaux1 = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies  = 1,
+	.consumer_supplies      = sdp4430_vaux_supply,
 };
 
 static struct regulator_init_data sdp4430_vaux2 = {
@@ -487,7 +491,7 @@ static struct regulator_init_data sdp4430_vmmc = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = 2,
+	.num_consumer_supplies  = 1,
 	.consumer_supplies      = sdp4430_vmmc_supply,
 };
 
-- 
1.6.0.4

