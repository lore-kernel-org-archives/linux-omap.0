From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] OMAP: board-omap3evm: Fix compillation error
Date: Tue, 28 Jun 2011 13:16:55 +0300
Message-ID: <1309256215-9879-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60316 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755438Ab1F1KRC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 06:17:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hello Tony,

While rebasing my series on top of your devel-cleanup branch,
I found this compillation error.
You can pick it right away, or I can queue this within my series.
But I still waiting for Samuel's saying on the series, so it might
be faster if you just pick this, I'll rebase my series before I
send you the pull request anyways.

Regards,
Peter

 arch/arm/mach-omap2/board-omap3evm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index e2202dd..c2ea437 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -510,7 +510,7 @@ static struct regulator_init_data omap3evm_vio = {
 #define OMAP3EVM_WLAN_IRQ_GPIO		(149)
 
 static struct regulator_consumer_supply omap3evm_vmmc2_supply[] = {
-	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1"),
 };
 
 /* VMMC2 for driving the WL12xx module */
@@ -518,7 +518,7 @@ static struct regulator_init_data omap3evm_vmmc2 = {
 	.constraints = {
 		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= ARRAY_SIZE(omap3evm_vmmc2_supply);,
+	.num_consumer_supplies	= ARRAY_SIZE(omap3evm_vmmc2_supply),
 	.consumer_supplies	= omap3evm_vmmc2_supply,
 };
 
-- 
1.7.5.3

