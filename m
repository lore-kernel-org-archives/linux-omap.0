From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 03/09] OMAP3 clock: Revert "OMAP2/3 clock: add clock
 pre-rate-change notification"
Date: Fri, 20 Mar 2009 18:55:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF20@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46702 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbZCTN0G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:26:06 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KDPvsw013417
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 08:26:04 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KDPvTP002973
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 18:55:57 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This reverts commit a02d5a56ed7919a20dbe3c06086ddc77aae45b34.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 31b5b13..fe07d11 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -796,8 +796,6 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 	pr_debug("clock: %s: set_rate from %ld Hz to %ld Hz\n", clk->name,
 		 clk->rate, rate);
 
-	omap_clk_notify_downstream(clk, CLK_PRE_RATE_CHANGE);
-
 	ret = clk->set_rate(clk, rate);
 
 	temp_rate = clk->rate;
@@ -864,8 +862,6 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 		propagate_rate(clk, TEMP_RATE);
 	}
 
-	omap_clk_notify_downstream(clk, CLK_PRE_RATE_CHANGE);
-
 	if (clk->usecount > 0)
 		_omap2_clk_disable(clk);
 
-- 
1.5.4.3
