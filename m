From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 12/86] [ARM] omap: move clock propagation into core omap clock code
Date: Thu, 12 Mar 2009 11:27:22 -0700
Message-ID: <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618AbZCLS3n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:29:43 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:29:42 -0700 (PDT)
In-Reply-To: <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Move the clock propagation calls for set_parent and set_rate into
the core omap clock code, rather than having these calls scattered
throughout the OMAP1 and OMAP2 implementations.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c |    3 ---
 arch/arm/mach-omap2/clock.c |    6 ------
 arch/arm/plat-omap/clock.c  |    6 +++++-
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index ff40810..ee1b9f2 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -628,9 +628,6 @@ static int omap1_clk_set_rate(struct clk *clk, unsigned long rate)
 		ret = 0;
 	}
 
-	if (unlikely(ret == 0 && (clk->flags & RATE_PROPAGATES)))
-		propagate_rate(clk);
-
 	return ret;
 }
 
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 76afb7b..7a1d56a 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -684,9 +684,6 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->set_rate != NULL)
 		ret = clk->set_rate(clk, rate);
 
-	if (unlikely(ret == 0 && (clk->flags & RATE_PROPAGATES)))
-		propagate_rate(clk);
-
 	return ret;
 }
 
@@ -774,9 +771,6 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	pr_debug("clock: set parent of %s to %s (new rate %ld)\n",
 		 clk->name, clk->parent->name, clk->rate);
 
-	if (unlikely(clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
-
 	return 0;
 }
 
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index ae77e10..b7137c5 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -182,6 +182,8 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	spin_lock_irqsave(&clockfw_lock, flags);
 	if (arch_clock->clk_set_rate)
 		ret = arch_clock->clk_set_rate(clk, rate);
+	if (ret == 0 && (clk->flags & RATE_PROPAGATES))
+		propagate_rate(clk);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
@@ -198,7 +200,9 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 
 	spin_lock_irqsave(&clockfw_lock, flags);
 	if (arch_clock->clk_set_parent)
-		ret =  arch_clock->clk_set_parent(clk, parent);
+		ret = arch_clock->clk_set_parent(clk, parent);
+	if (ret == 0 && (clk->flags & RATE_PROPAGATES))
+		propagate_rate(clk);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
-- 
1.6.1.2

