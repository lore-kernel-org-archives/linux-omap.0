From: David Anders <x0132446@ti.com>
Subject: [PATCH 1/4] omap4: pandaboard: remove unused hsmmc definition
Date: Wed,  6 Oct 2010 16:14:30 -0500
Message-ID: <1286399673-912-2-git-send-email-x0132446@ti.com>
References: <1286399673-912-1-git-send-email-x0132446@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37791 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933101Ab0JFVOt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 17:14:49 -0400
In-Reply-To: <1286399673-912-1-git-send-email-x0132446@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Anders <x0132446@ti.com>, Anand Gadiyar <gadiyar@ti.com>

remove the second hsmmc definition as it is only used on the
expansion header of the PandaBoard and can be mux for other
functions.

Signed-off-by: David Anders <x0132446@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 96f5bbb..093d13b 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -67,10 +67,6 @@ static struct regulator_consumer_supply omap4_panda_vmmc_supply[] = {
 		.supply = "vmmc",
 		.dev_name = "mmci-omap-hs.0",
 	},
-	{
-		.supply = "vmmc",
-		.dev_name = "mmci-omap-hs.1",
-	},
 };
 
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
@@ -156,7 +152,7 @@ static struct regulator_init_data omap4_panda_vmmc = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = 2,
+	.num_consumer_supplies  = 1,
 	.consumer_supplies      = omap4_panda_vmmc_supply,
 };
 
-- 
1.7.0.4

