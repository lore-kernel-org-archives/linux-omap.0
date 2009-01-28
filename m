From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH F 04/12] OMAP clock: drop clk_get_usecount()
Date: Wed, 28 Jan 2009 12:35:09 -0700
Message-ID: <20090128193506.2396.29611.stgit@localhost.localdomain>
References: <20090128193326.2396.9437.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47813 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487AbZA1UcP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:32:15 -0500
In-Reply-To: <20090128193326.2396.9437.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

This function is race-prone and mistakenly conveys the impression to
drivers that it is part of the clock interface.  Get rid of it: core
code that absolutely needs this can just check clk->usecount.  Drivers
should not use it at all.

linux-omap source commit is 5df9e4adc2f6a6d55aca53ee27b8baad18897c05.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/clock.c              |   16 ----------------
 arch/arm/plat-omap/include/mach/clock.h |    1 -
 2 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 2a4819f..f4a89c5 100644
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
index 9d38a25..2a30268 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -142,7 +142,6 @@ extern void followparent_recalc(struct clk *clk, unsigned long parent_rate,
 				u8 rate_storage);
 extern void clk_allow_idle(struct clk *clk);
 extern void clk_deny_idle(struct clk *clk);
-extern int clk_get_usecount(struct clk *clk);
 extern void clk_enable_init_clocks(void);
 #ifdef CONFIG_CPU_FREQ
 extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);


