From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] perf: Use raw_smp_processor_id insted of smp_processor_id
Date: Wed, 12 Sep 2012 14:50:10 +0300
Message-ID: <1347450610-4342-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52067 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737Ab2ILLuv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 07:50:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: jean.pihet@newoldbits.com, sboyd@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

gets rid of below messages with CONFIG_DEBUG_PREEMPT enabled

[   28.832916] debug_smp_processor_id: 18 callbacks suppressed
[   28.832946] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/1763
[   28.841491] caller is pwrdm_set_next_pwrst+0x54/0x120

Tested with perf on OMAP4 Panda.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/clock.c       |    6 +++---
 arch/arm/mach-omap2/pm34xx.c      |   11 +++++++----
 arch/arm/mach-omap2/powerdomain.c |    4 ++--
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index ea3f565..2765acd 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -285,7 +285,7 @@ void omap2_clk_disable(struct clk *clk)
 	pr_debug("clock: %s: disabling in hardware\n", clk->name);
 
 	if (clk->ops && clk->ops->disable) {
-		trace_clock_disable(clk->name, 0, smp_processor_id());
+		trace_clock_disable(clk->name, 0, raw_smp_processor_id());
 		clk->ops->disable(clk);
 	}
 
@@ -339,7 +339,7 @@ int omap2_clk_enable(struct clk *clk)
 	}
 
 	if (clk->ops && clk->ops->enable) {
-		trace_clock_enable(clk->name, 1, smp_processor_id());
+		trace_clock_enable(clk->name, 1, raw_smp_processor_id());
 		ret = clk->ops->enable(clk);
 		if (ret) {
 			WARN(1, "clock: %s: could not enable: %d\n",
@@ -380,7 +380,7 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 
 	/* dpll_ck, core_ck, virt_prcm_set; plus all clksel clocks */
 	if (clk->set_rate) {
-		trace_clock_set_rate(clk->name, rate, smp_processor_id());
+		trace_clock_set_rate(clk->name, rate, raw_smp_processor_id());
 		ret = clk->set_rate(clk, rate);
 	}
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 05bd8f0..d384068 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -346,18 +346,21 @@ void omap_sram_idle(void)
 
 static void omap3_pm_idle(void)
 {
+	int cpu;
+
 	local_fiq_disable();
 
 	if (omap_irq_pending())
 		goto out;
 
-	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
-	trace_cpu_idle(1, smp_processor_id());
+	cpu = raw_smp_processor_id();
+	trace_power_start(POWER_CSTATE, 1, cpu);
+	trace_cpu_idle(1, cpu);
 
 	omap_sram_idle();
 
-	trace_power_end(smp_processor_id());
-	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
+	trace_power_end(cpu);
+	trace_cpu_idle(PWR_EVENT_EXIT, cpu);
 
 out:
 	local_fiq_enable();
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 69b36e1..f1d0d69 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -169,7 +169,7 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 				       ((state & OMAP_POWERSTATE_MASK) << 8) |
 				       ((prev & OMAP_POWERSTATE_MASK) << 0));
 			trace_power_domain_target(pwrdm->name, trace_state,
-						  smp_processor_id());
+						  raw_smp_processor_id());
 		}
 		break;
 	default:
@@ -491,7 +491,7 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
 		/* Trace the pwrdm desired target state */
 		trace_power_domain_target(pwrdm->name, pwrst,
-					  smp_processor_id());
+					  raw_smp_processor_id());
 		/* Program the pwrdm desired target state */
 		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
 	}
-- 
1.7.4.1

