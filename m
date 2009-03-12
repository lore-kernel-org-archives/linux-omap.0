From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 10/86] [ARM] omap: remove clk_deny_idle and clk_allow_idle
Date: Thu, 12 Mar 2009 11:27:20 -0700
Message-ID: <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423AbZCLS3i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:29:38 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:29:37 -0700 (PDT)
In-Reply-To: <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Nothing makes any use of these functions, so there's little point in
providing them.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-omap/clock.c              |   28 ----------------------------
 arch/arm/plat-omap/include/mach/clock.h |    2 --
 arch/arm/plat-omap/include/mach/pm.h    |   12 ------------
 3 files changed, 0 insertions(+), 42 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index c53205c..7b04007 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -316,34 +316,6 @@ void clk_unregister(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_unregister);
 
-void clk_deny_idle(struct clk *clk)
-{
-	unsigned long flags;
-
-	if (clk == NULL || IS_ERR(clk))
-		return;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_deny_idle)
-		arch_clock->clk_deny_idle(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-}
-EXPORT_SYMBOL(clk_deny_idle);
-
-void clk_allow_idle(struct clk *clk)
-{
-	unsigned long flags;
-
-	if (clk == NULL || IS_ERR(clk))
-		return;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_allow_idle)
-		arch_clock->clk_allow_idle(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-}
-EXPORT_SYMBOL(clk_allow_idle);
-
 void clk_enable_init_clocks(void)
 {
 	struct clk *clkp;
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 6c24835..4831bbd 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -119,8 +119,6 @@ extern void clk_unregister(struct clk *clk);
 extern void propagate_rate(struct clk *clk);
 extern void recalculate_root_clocks(void);
 extern void followparent_recalc(struct clk * clk);
-extern void clk_allow_idle(struct clk *clk);
-extern void clk_deny_idle(struct clk *clk);
 extern int clk_get_usecount(struct clk *clk);
 extern void clk_enable_init_clocks(void);
 
diff --git a/arch/arm/plat-omap/include/mach/pm.h b/arch/arm/plat-omap/include/mach/pm.h
index 2a9c27a..ca81830 100644
--- a/arch/arm/plat-omap/include/mach/pm.h
+++ b/arch/arm/plat-omap/include/mach/pm.h
@@ -118,18 +118,6 @@
 extern void prevent_idle_sleep(void);
 extern void allow_idle_sleep(void);
 
-/**
- * clk_deny_idle - Prevents the clock from being idled during MPU idle
- * @clk: clock signal handle
- */
-void clk_deny_idle(struct clk *clk);
-
-/**
- * clk_allow_idle - Counters previous clk_deny_idle
- * @clk: clock signal handle
- */
-void clk_allow_idle(struct clk *clk);
-
 extern void omap_pm_idle(void);
 extern void omap_pm_suspend(void);
 extern void omap730_cpu_suspend(unsigned short, unsigned short);
-- 
1.6.1.2

