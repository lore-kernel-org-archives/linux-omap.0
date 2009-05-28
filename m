From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 03/06] OMAP3: PM: VDD2 dvfs at higher VDD1 opp
Date: Thu, 28 May 2009 18:13:04 +0530
Message-ID: <1243514587-5323-3-git-send-email-rnayak@ti.com>
References: <1243514587-5323-1-git-send-email-rnayak@ti.com>
 <1243514587-5323-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58676 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758868AbZE1MnO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 May 2009 08:43:14 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4SCh9cn024737
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2009 07:43:15 -0500
In-Reply-To: <1243514587-5323-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch makes sure that VDD2 dvfs always happens at
a higher VDD1 OPP, hence bringing down the VDD2 DVFS latency
to a large extent.
Having a smaller VDD2 dvfs latency helps drivers which are sensitive
to the time during which SDRAM is inaccessible due to SDRC iclk being
disabled.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 9908e52..4c87436 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -353,6 +353,9 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 	int ind;
 
 	if (resp == vdd1_resp) {
+		if (target_level < 3)
+			resource_release("vdd2_opp", &vdd2_dev);
+
 		resource_set_opp_level(VDD1_OPP, target_level, 0);
 		/*
 		 * For VDD1 OPP3 and above, make sure the interconnect
@@ -361,8 +364,6 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 		 */
 		if (target_level >= 3)
 			resource_request("vdd2_opp", &vdd2_dev, 400000);
-		else
-			resource_release("vdd2_opp", &vdd2_dev);
 
 	} else if (resp == vdd2_resp) {
 		tput = target_level;
-- 
1.5.4.7

