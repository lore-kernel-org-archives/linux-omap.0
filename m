From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 21/86] [ARM] omap: remove pre-CLKDEV clk_get/clk_put
Date: Thu, 12 Mar 2009 11:27:31 -0700
Message-ID: <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
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
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227AbZCLSag (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:30:36 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:30:34 -0700 (PDT)
In-Reply-To: <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-omap/clock.c |   46 --------------------------------------------
 1 files changed, 0 insertions(+), 46 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 6b88f78..5272a22 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -36,45 +36,6 @@ static struct clk_functions *arch_clock;
  * Standard clock functions defined in include/linux/clk.h
  *-------------------------------------------------------------------------*/
 
-#ifndef CONFIG_COMMON_CLKDEV
-/*
- * Returns a clock. Note that we first try to use device id on the bus
- * and clock name. If this fails, we try to use clock name only.
- */
-struct clk * clk_get(struct device *dev, const char *id)
-{
-	struct clk *p, *clk = ERR_PTR(-ENOENT);
-	int idno;
-
-	if (dev == NULL || dev->bus != &platform_bus_type)
-		idno = -1;
-	else
-		idno = to_platform_device(dev)->id;
-
-	mutex_lock(&clocks_mutex);
-
-	list_for_each_entry(p, &clocks, node) {
-		if (p->id == idno && strcmp(id, p->name) == 0) {
-			clk = p;
-			goto found;
-		}
-	}
-
-	list_for_each_entry(p, &clocks, node) {
-		if (strcmp(id, p->name) == 0) {
-			clk = p;
-			break;
-		}
-	}
-
-found:
-	mutex_unlock(&clocks_mutex);
-
-	return clk;
-}
-EXPORT_SYMBOL(clk_get);
-#endif
-
 int clk_enable(struct clk *clk)
 {
 	unsigned long flags;
@@ -147,13 +108,6 @@ unsigned long clk_get_rate(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_rate);
 
-#ifndef CONFIG_COMMON_CLKDEV
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
-#endif
-
 /*-------------------------------------------------------------------------
  * Optional clock functions defined in include/linux/clk.h
  *-------------------------------------------------------------------------*/
-- 
1.6.1.2

