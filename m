From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 04/09] OMAP3 clock: Revert "OMAP2/3 clock: add clk
 post-rate-change notifiers"
Date: Fri, 20 Mar 2009 18:56:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF21@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46706 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbZCTN0N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:26:13 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KDQ4Hf013425
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 08:26:11 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KDQ47G002993
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 18:56:04 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This reverts commit 6b7ce1691c9084d562af4a1f3ffa2996a058ad06.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index fe07d11..c29ea77 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -783,7 +783,6 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	int ret = -EINVAL;
-	unsigned long temp_rate;
 
 	if (!clk->set_rate)
 		return -EINVAL;
@@ -798,11 +797,6 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 
 	ret = clk->set_rate(clk, rate);
 
-	temp_rate = clk->rate;
-	clk->rate = clk->temp_rate;
-	omap_clk_notify_downstream(clk, CLK_POST_RATE_CHANGE);
-	clk->rate = temp_rate;
-
 	return ret;
 }
 
@@ -878,14 +872,11 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 		_omap2_clk_enable(clk);
 
 	clk->parent = new_parent;
+	clk->rate = new_rate;
 
 	pr_debug("clock: %s: set parent to %s (orig rate %ld, new rate %ld)\n",
 		 clk->name, clk->parent->name, orig_rate, new_rate);
 
-	omap_clk_notify_downstream(clk, CLK_POST_RATE_CHANGE);
-
-	clk->rate = new_rate;
-
 	return 0;
 }
 
-- 
1.5.4.3
