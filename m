From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] OMAP: clock: fix race in disable all clocks
Date: Thu, 15 Mar 2012 13:24:31 -0500
Message-ID: <1331835871-13328-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41302 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760507Ab2COSYg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Mar 2012 14:24:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

clk_disable_unused is invoked when CONFIG_OMAP_RESET_CLOCKS=y.
Since clk_disable_unused is called as lateinitcall, there can
be more than a few workqueues executing off secondary CPU(s).
The current code does the following:
a) checks if clk is unused
b) holds lock
c) disables clk
d) unlocks

Between (a) and (b) being executed on CPU0, It is possible to
have a driver executing on CPU1 which could do a get_sync->clk_get
(and increase the use_count) of the clock which was just about
to be disabled by clk_disable_unused.

We ensure instead that the entire list traversal is protected by
the lock allowing for parent child clock traversal which could be
potentially be done by runtime operations to be safe as well.

Reported-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
To confirm this in reality happens, I setup a trap as follows:
  @@ -450,6 +450,8 @@ static int __init clk_disable_unused(void)
  			continue;
  
  		spin_lock_irqsave(&clockfw_lock, flags);
 +		WARN(ck->usecount, "XXXX->RACECONDITION FOR CLOCK %s\n",
 +			ck->name);
  		arch_clock->clk_disable_unused(ck);
  		spin_unlock_irqrestore(&clockfw_lock, flags);
  	}
Resultant log: http://pastebin.pandaboard.org/index.php/view/66400792

 arch/arm/plat-omap/clock.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 567e4b5..8030cc1 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -442,6 +442,8 @@ static int __init clk_disable_unused(void)
 		return 0;
 
 	pr_info("clock: disabling unused clocks to save power\n");
+
+	spin_lock_irqsave(&clockfw_lock, flags);
 	list_for_each_entry(ck, &clocks, node) {
 		if (ck->ops == &clkops_null)
 			continue;
@@ -449,10 +451,9 @@ static int __init clk_disable_unused(void)
 		if (ck->usecount > 0 || !ck->enable_reg)
 			continue;
 
-		spin_lock_irqsave(&clockfw_lock, flags);
 		arch_clock->clk_disable_unused(ck);
-		spin_unlock_irqrestore(&clockfw_lock, flags);
 	}
+	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return 0;
 }
-- 
1.7.0.4

