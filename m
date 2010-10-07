From: David Anders <x0132446@ti.com>
Subject: [PATCH 1/3] omap4: pandaboard: remove unused hsmmc definition
Date: Thu,  7 Oct 2010 14:36:28 -0500
Message-ID: <1286480190-20632-2-git-send-email-x0132446@ti.com>
References: <1286480190-20632-1-git-send-email-x0132446@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59833 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174Ab0JGTgg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 15:36:36 -0400
In-Reply-To: <1286480190-20632-1-git-send-email-x0132446@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jayabharath@ti.com, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com
Cc: David Anders <x0132446@ti.com>

remove the second hsmmc definition as it is only used on the
expansion header of the PandaBoard and can be mux for other
functions.

Signed-off-by: David Anders <x0132446@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 992a03e..dc16884 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -98,10 +98,6 @@ static struct regulator_consumer_supply omap4_panda_vmmc_supply[] = {
 		.supply = "vmmc",
 		.dev_name = "mmci-omap-hs.0",
 	},
-	{
-		.supply = "vmmc",
-		.dev_name = "mmci-omap-hs.1",
-	},
 };
 
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
@@ -187,7 +183,7 @@ static struct regulator_init_data omap4_panda_vmmc = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = 2,
+	.num_consumer_supplies  = 1,
 	.consumer_supplies      = omap4_panda_vmmc_supply,
 };
 
-- 
1.7.0.4

