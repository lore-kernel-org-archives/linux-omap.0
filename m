From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] OMAP: hsmmc: fix memory leak
Date: Mon,  8 Feb 2010 14:33:05 +0200
Message-ID: <1265632385-27448-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28306 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab0BHMcG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 07:32:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: adrian.hunter@nokia.com, jarkko.lavinen@nokia.com

The platform data allocated with kmalloc() will become unreachable once
the init is complete, so it should be freed. The problem was discovered
by kmemleak.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/hsmmc.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 1156b28..9ad2295 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -145,6 +145,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
 	struct omap2_hsmmc_info *c;
 	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
+	int i;
 
 	if (cpu_is_omap2430()) {
 		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
@@ -171,7 +172,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 			      GFP_KERNEL);
 		if (!mmc) {
 			pr_err("Cannot allocate memory for mmc device!\n");
-			return;
+			goto done;
 		}
 
 		if (c->name)
@@ -256,6 +257,10 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 			continue;
 		c->dev = mmc->dev;
 	}
+
+done:
+	for (i = 0; i < nr_hsmmc; i++)
+		kfree(hsmmc_data[i]);
 }
 
 #endif
-- 
1.5.6.5

