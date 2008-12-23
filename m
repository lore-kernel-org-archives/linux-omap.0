From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 15/22] OMAP clock: drop clk_get_usecount()
Date: Mon, 22 Dec 2008 23:38:40 -0700
Message-ID: <20081223063839.8542.91210.stgit@localhost.localdomain>
References: <20081223063709.8542.82882.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52918 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbYLWGjz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:39:55 -0500
In-Reply-To: <20081223063709.8542.82882.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

This function is race-prone and mistakenly conveys the impression to
drivers that it is part of the clock interface.  Get rid of it: core
code that absolutely needs this can just check clk->usecount.  Drivers
should not use it at all.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/pm-debug.c          |    2 +-
 arch/arm/mach-omap2/pm24xx.c            |    2 +-
 arch/arm/plat-omap/clock.c              |   16 ----------------
 arch/arm/plat-omap/include/mach/clock.h |    1 -
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 0b5c044..0832e05 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -93,7 +93,7 @@ void serial_console_sleep(int enable)
 
 	if (enable) {
 		BUG_ON(serial_console_clock_disabled);
-		if (clk_get_usecount(console_fclk) == 0)
+		if (console_fclk->usecount == 0)
 			return;
 		if ((int) serial_console_next_disable - (int) omap2_read_32k_sync_counter() >= 0)
 			return;
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 60ff04f..2798e87 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -249,7 +249,7 @@ static int omap2_can_sleep(void)
 		return 0;
 	if (atomic_read(&sleep_block) > 0)
 		return 0;
-	if (clk_get_usecount(osc_ck) > 1)
+	if (osc_ck->usecount > 1)
 		return 0;
 	if (omap_dma_running())
 		return 0;
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index ab3d879..8d43d78 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -260,22 +260,6 @@ out:
 }
 EXPORT_SYMBOL(clk_disable);
 
-int clk_get_usecount(struct clk *clk)
-{
-	unsigned long flags;
-	int ret = 0;
-
-	if (clk == NULL || IS_ERR(clk))
-		return 0;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	ret = clk->usecount;
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_get_usecount);
-
 unsigned long clk_get_rate(struct clk *clk)
 {
 	unsigned long flags;
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 2f1c5cd..f0194bc 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -138,7 +138,6 @@ extern void followparent_recalc(struct clk *clk, unsigned long parent_rate,
 				u8 rate_storage);
 extern void clk_allow_idle(struct clk *clk);
 extern void clk_deny_idle(struct clk *clk);
-extern int clk_get_usecount(struct clk *clk);
 extern void clk_enable_init_clocks(void);
 #ifdef CONFIG_CPU_FREQ
 extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);


