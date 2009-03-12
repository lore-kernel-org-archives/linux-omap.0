From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 11/86] [ARM] omap: provide a standard clk_get_parent() implementation
Date: Thu, 12 Mar 2009 11:27:21 -0700
Message-ID: <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448AbZCLS3k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:29:40 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:29:39 -0700 (PDT)
In-Reply-To: <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

which only has to return clk->parent.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-omap/clock.c              |   13 +------------
 arch/arm/plat-omap/include/mach/clock.h |    1 -
 2 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 7b04007..ae77e10 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -207,18 +207,7 @@ EXPORT_SYMBOL(clk_set_parent);
 
 struct clk *clk_get_parent(struct clk *clk)
 {
-	unsigned long flags;
-	struct clk * ret = NULL;
-
-	if (clk == NULL || IS_ERR(clk))
-		return ret;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_get_parent)
-		ret = arch_clock->clk_get_parent(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return ret;
+	return clk->parent;
 }
 EXPORT_SYMBOL(clk_get_parent);
 
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 4831bbd..06dd38a 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -102,7 +102,6 @@ struct clk_functions {
 	long		(*clk_round_rate)(struct clk *clk, unsigned long rate);
 	int		(*clk_set_rate)(struct clk *clk, unsigned long rate);
 	int		(*clk_set_parent)(struct clk *clk, struct clk *parent);
-	struct clk *	(*clk_get_parent)(struct clk *clk);
 	void		(*clk_allow_idle)(struct clk *clk);
 	void		(*clk_deny_idle)(struct clk *clk);
 	void		(*clk_disable_unused)(struct clk *clk);
-- 
1.6.1.2

