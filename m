From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH] OMAP3: PM: Fix compilation error observed when cpufreq is disabled
Date: Fri, 19 Mar 2010 16:16:46 +0530
Message-ID: <1268995606-32018-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50097 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab0CSKqy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Mar 2010 06:46:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, ranjithl@ti.com

Currently on PM branch, compilation fails when cpufreq is disabled

arch/arm/mach-omap2/clock3xxx_data.c: In function 'omap3xxx_clk_init':
arch/arm/mach-omap2/clock3xxx_data.c:3563: error: 'struct clk_functions'
has no member named 'clk_init_cpufreq_table'
arch/arm/mach-omap2/clock3xxx_data.c:3564: error:
'omap3_clk_init_cpufreq_table' undeclared (first use
in this function)
arch/arm/mach-omap2/clock3xxx_data.c:3564: error: (Each undeclared
identifier is reported only once
arch/arm/mach-omap2/clock3xxx_data.c:3564: error: for each function it
appears in.)
make[1]: *** [arch/arm/mach-omap2/clock3xxx_data.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

This patch fixes the issue by avoiding runtime init of
clk_init_cpufreq_table in omap3xxx_clk_init and instead doing it when
omap2_clk_functions are defined.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---
 arch/arm/mach-omap2/clock.c          |    4 ++++
 arch/arm/mach-omap2/clock3xxx_data.c |    2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index a6d0b34..498cb5b 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -492,7 +492,11 @@ struct clk_functions omap2_clk_functions = {
 	.clk_disable_unused	= omap2_clk_disable_unused,
 #ifdef CONFIG_CPU_FREQ
 	/* These will be removed when the OPP code is integrated */
+#ifdef CONFIG_ARCH_OMAP3
+	.clk_init_cpufreq_table	= omap3_clk_init_cpufreq_table,
+#else
 	.clk_init_cpufreq_table	= omap2_clk_init_cpufreq_table,
+#endif
 	.clk_exit_cpufreq_table	= omap2_clk_exit_cpufreq_table,
 #endif
 };
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 57522de..d5153b6 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3560,8 +3560,6 @@ int __init omap3xxx_clk_init(void)
 	else
 		dpll4_dd = dpll4_dd_34xx;
 
-	omap2_clk_functions.clk_init_cpufreq_table =
-		omap3_clk_init_cpufreq_table;
 	clk_init(&omap2_clk_functions);
 
 	for (c = omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clks);
-- 
1.6.2.4

