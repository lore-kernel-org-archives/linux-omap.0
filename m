From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/10] OMAP clock: resolve old checkpatch and CodingStyle
	issues with plat-omap/clock.c
Date: Mon, 26 Apr 2010 01:04:38 -0600
Message-ID: <20100426070435.9743.25021.stgit@localhost.localdomain>
References: <20100426070217.9743.92728.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52256 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab0DZHHg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 03:07:36 -0400
In-Reply-To: <20100426070217.9743.92728.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Clean up comment style, remove unnecessary includes, and resolve some
checkpatch warnings in plat-omap/clock.c.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/clock.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 5261a09..c9cd98a 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -12,14 +12,12 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/clk.h>
 #include <linux/mutex.h>
-#include <linux/platform_device.h>
 #include <linux/cpufreq.h>
 #include <linux/debugfs.h>
 #include <linux/io.h>
@@ -32,9 +30,9 @@ static DEFINE_SPINLOCK(clockfw_lock);
 
 static struct clk_functions *arch_clock;
 
-/*-------------------------------------------------------------------------
+/*
  * Standard clock functions defined in include/linux/clk.h
- *-------------------------------------------------------------------------*/
+ */
 
 int clk_enable(struct clk *clk)
 {
@@ -92,9 +90,9 @@ unsigned long clk_get_rate(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_rate);
 
-/*-------------------------------------------------------------------------
+/*
  * Optional clock functions defined in include/linux/clk.h
- *-------------------------------------------------------------------------*/
+ */
 
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
@@ -140,9 +138,11 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	unsigned long flags;
 	int ret = -EINVAL;
 
-	if (cpu_is_omap44xx())
-	/* OMAP4 clk framework not supported yet */
+	if (cpu_is_omap44xx()) {
+		WARN(1, "clock: %s: not supported yet on OMAP4\n", __func__);
 		return 0;
+	}
+
 	if (clk == NULL || IS_ERR(clk) || parent == NULL || IS_ERR(parent))
 		return ret;
 
@@ -169,9 +169,9 @@ struct clk *clk_get_parent(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_parent);
 
-/*-------------------------------------------------------------------------
+/*
  * OMAP specific clock functions shared between omap1 and omap2
- *-------------------------------------------------------------------------*/
+ */
 
 int __initdata mpurate;
 
@@ -222,7 +222,7 @@ void clk_reparent(struct clk *child, struct clk *parent)
 }
 
 /* Propagate rate to children */
-void propagate_rate(struct clk * tclk)
+void propagate_rate(struct clk *tclk)
 {
 	struct clk *clkp;
 
@@ -389,7 +389,9 @@ void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
 }
 #endif
 
-/*-------------------------------------------------------------------------*/
+/*
+ *
+ */
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 /*
@@ -404,7 +406,7 @@ static int __init clk_disable_unused(void)
 		if (ck->ops == &clkops_null)
 			continue;
 
-		if (ck->usecount > 0 || ck->enable_reg == 0)
+		if (ck->usecount > 0 || !ck->enable_reg)
 			continue;
 
 		spin_lock_irqsave(&clockfw_lock, flags);


