From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 01/09] OMAP3 clock: Revert "OMAP2/3 clock: add clock
 abort-rate-change notifications"
Date: Fri, 20 Mar 2009 18:55:39 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF1E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41061 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325AbZCTNZt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:25:49 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KDPeZZ021042
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 08:25:47 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KDPeeg002929
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 18:55:40 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This reverts commit 39562d52cb454606790cf2036b6d491d3610953b.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 3d10ae4..d90b98a 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -798,7 +798,6 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 	if (r == NOTIFY_BAD) {
 		pr_debug("clock: %s: clk_set_rate() aborted by notifier\n",
 			 clk->name);
-		omap_clk_notify_downstream(clk, CLK_ABORT_RATE_CHANGE);
 		return -EAGAIN;
 	}
 
@@ -809,16 +808,10 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 
 	ret = clk->set_rate(clk, rate);
 
-	if (ret == 0) {
-		temp_rate = clk->rate;
-		clk->rate = clk->temp_rate;
-		omap_clk_notify_downstream(clk, CLK_POST_RATE_CHANGE);
-		clk->rate = temp_rate;
-	} else {
-		pr_debug("clock: %s: clk_set_rate() aborted by failed "
-			 "set_rate(): %d\n", clk->name, ret);
-		omap_clk_notify_downstream(clk, CLK_ABORT_RATE_CHANGE);
-	}
+	temp_rate = clk->rate;
+	clk->rate = clk->temp_rate;
+	omap_clk_notify_downstream(clk, CLK_POST_RATE_CHANGE);
+	clk->rate = temp_rate;
 
 	return ret;
 }
@@ -884,7 +877,6 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	if (r == NOTIFY_BAD) {
 		pr_debug("clock: %s: clk_set_parent() aborted by notifier\n",
 			 clk->name);
-		omap_clk_notify_downstream(clk, CLK_ABORT_RATE_CHANGE);
 		return -EAGAIN;
 	}
 
-- 
1.5.4.3
