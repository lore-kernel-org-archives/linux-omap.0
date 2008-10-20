From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH 2/2] OMAP: Add clk_get_parent() for OMAP2/3
Date: Tue, 21 Oct 2008 00:24:24 +0100
Message-ID: <1224545064-25551-2-git-send-email-mans@mansr.com>
References: <yw1xhc76hmvi.fsf@thrashbarg.mansr.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from agrajag.mansr.com ([78.86.181.102]:33085 "EHLO mail.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748AbYJTXY0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Oct 2008 19:24:26 -0400
Received: from thrashbarg.mansr.com (thrashbarg.mansr.com [78.86.181.100])
	by mail.mansr.com (Postfix) with ESMTP id 842D81C0095
	for <linux-omap@vger.kernel.org>; Tue, 21 Oct 2008 00:24:24 +0100 (BST)
In-Reply-To: <yw1xhc76hmvi.fsf@thrashbarg.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This makes clk_get_parent() work on OMAP2/3.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/mach-omap2/clock.c     |    5 +++++
 arch/arm/mach-omap2/clock.h     |    1 +
 arch/arm/mach-omap2/clock24xx.c |    1 +
 arch/arm/mach-omap2/clock34xx.c |    1 +
 4 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index c3af24e..9e502a0 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -817,6 +817,11 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	return 0;
 }
 
+struct clk *omap2_clk_get_parent(struct clk *clk)
+{
+	return clk->parent;
+}
+
 /* DPLL rate rounding code */
 
 /**
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index bcb0c03..a5183d0 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -29,6 +29,7 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate);
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent);
 int omap2_dpll_set_rate_tolerance(struct clk *clk, unsigned int tolerance);
 long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate);
+struct clk *omap2_clk_get_parent(struct clk *clk);
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 void omap2_clk_disable_unused(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index a54f10f..4382e60 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -416,6 +416,7 @@ static struct clk_functions omap2_clk_functions = {
 	.clk_round_rate		= omap2_clk_round_rate,
 	.clk_set_rate		= omap2_clk_set_rate,
 	.clk_set_parent		= omap2_clk_set_parent,
+	.clk_get_parent		= omap2_clk_get_parent,
 	.clk_disable_unused	= omap2_clk_disable_unused,
 #ifdef	CONFIG_CPU_FREQ
 	.clk_init_cpufreq_table	= omap2_clk_init_cpufreq_table,
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index c89d6bc..5a6a2da 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -635,6 +635,7 @@ static struct clk_functions omap2_clk_functions = {
 	.clk_round_rate		= omap2_clk_round_rate,
 	.clk_set_rate		= omap2_clk_set_rate,
 	.clk_set_parent		= omap2_clk_set_parent,
+	.clk_get_parent		= omap2_clk_get_parent,
 	.clk_disable_unused	= omap2_clk_disable_unused,
 };
 
-- 
1.6.0.2

