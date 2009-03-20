From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 02/09] OMAP3 clock: Revert "OMAP2/3 clock: add clock
 prepare-rate-change notifications"
Date: Fri, 20 Mar 2009 18:55:47 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF1F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46698 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbZCTNZ6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:25:58 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KDPoNd013408
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 08:25:56 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KDPnEZ002948
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 18:55:49 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This reverts commit 7fa29eca41dfbc2417c68d09e191e56f38072ad6.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d90b98a..31b5b13 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -784,7 +784,6 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	int ret = -EINVAL;
 	unsigned long temp_rate;
-	int r;
 
 	if (!clk->set_rate)
 		return -EINVAL;
@@ -794,13 +793,6 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 		propagate_rate(clk, TEMP_RATE);
 	}
 
-	r = omap_clk_notify_downstream(clk, CLK_PREPARE_RATE_CHANGE);
-	if (r == NOTIFY_BAD) {
-		pr_debug("clock: %s: clk_set_rate() aborted by notifier\n",
-			 clk->name);
-		return -EAGAIN;
-	}
-
 	pr_debug("clock: %s: set_rate from %ld Hz to %ld Hz\n", clk->name,
 		 clk->rate, rate);
 
@@ -853,7 +845,6 @@ static u32 _omap2_clksel_get_src_field(struct clk *src_clk, struct clk *clk,
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 {
 	u32 field_val, v, parent_div;
-	int r;
 	unsigned long orig_rate, new_rate;
 
 	if (!clk->clksel)
@@ -873,13 +864,6 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 		propagate_rate(clk, TEMP_RATE);
 	}
 
-	r = omap_clk_notify_downstream(clk, CLK_PREPARE_RATE_CHANGE);
-	if (r == NOTIFY_BAD) {
-		pr_debug("clock: %s: clk_set_parent() aborted by notifier\n",
-			 clk->name);
-		return -EAGAIN;
-	}
-
 	omap_clk_notify_downstream(clk, CLK_PRE_RATE_CHANGE);
 
 	if (clk->usecount > 0)
-- 
1.5.4.3
