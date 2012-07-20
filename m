From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 2/4] ARM: OMAP: PM: Get rid of Powerdomain book-keeping from cpuidle
Date: Fri, 20 Jul 2012 11:34:42 +0530
Message-ID: <1342764284-8143-3-git-send-email-rnayak@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54075 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab2GTGFm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jul 2012 02:05:42 -0400
In-Reply-To: <1342764284-8143-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, t-kristo@ti.com, Rajendra Nayak <rnayak@ti.com>

pwrdm_pre_transition()/pwrdm_post_transition() have always been high latency
operations done within cpuidle to do Powerdomain level book-keeping to know
what state transitions for different Powerdomains have been triggered.
This is also useful to do a restore-on-demand in some cases when we know
the context for the given Powerdomain was lost etc.

Now that we have definitive entry/exit points (thanks to the Powerdomain
level usecounting) for Powerdomain transitions, these book-keeping functions
can very well be moved from within CPUidle into pwrdm_clkdm_enable()/pwrdm_
clkdm_disable() functions.

Also rename _pwrdm_pre/post_transition_cb() to pwrdm_pre/post_transition()
and get rid of the original ones which iterate over all powerdomains.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 ++--
 arch/arm/mach-omap2/pm34xx.c              |    4 ++--
 arch/arm/mach-omap2/powerdomain.c         |   28 ++++++++--------------------
 arch/arm/mach-omap2/powerdomain.h         |    4 ++--
 4 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 13670aa..ea19439 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -255,7 +255,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 		return -ENXIO;
 	}
 
-	pwrdm_pre_transition();
+	pwrdm_cpu_idle();
 
 	/*
 	 * Check MPUSS next state and save interrupt controller if needed.
@@ -287,7 +287,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	wakeup_cpu = smp_processor_id();
 	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
 
-	pwrdm_post_transition();
+	pwrdm_cpu_wakeup();
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8d96b1f..9bdf53c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -290,7 +290,7 @@ void omap_sram_idle(void)
 			omap3_enable_io_chain();
 	}
 
-	pwrdm_pre_transition();
+	pwrdm_cpu_idle();
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
@@ -355,7 +355,7 @@ void omap_sram_idle(void)
 	}
 	omap3_intc_resume_idle();
 
-	pwrdm_post_transition();
+	pwrdm_cpu_wakeup();
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON)
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 39a45a9..f435819 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -187,14 +187,14 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 	return 0;
 }
 
-static int _pwrdm_pre_transition_cb(struct powerdomain *pwrdm, void *unused)
+int pwrdm_pre_transition(struct powerdomain *pwrdm)
 {
 	pwrdm_clear_all_prev_pwrst(pwrdm);
 	_pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
 	return 0;
 }
 
-static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
+int pwrdm_post_transition(struct powerdomain *pwrdm)
 {
 	_pwrdm_state_switch(pwrdm, PWRDM_STATE_PREV);
 	return 0;
@@ -995,8 +995,10 @@ void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return;
 
-	if (atomic_inc_return(&pwrdm->usecount) == 1)
+	if (atomic_inc_return(&pwrdm->usecount) == 1) {
+		pwrdm_post_transition(pwrdm);
 		voltdm_pwrdm_enable(pwrdm->voltdm.ptr);
+	}
 }
 
 /**
@@ -1015,28 +1017,14 @@ void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
 
 	val = atomic_dec_return(&pwrdm->usecount);
 
-	if (!val)
+	if (!val) {
 		voltdm_pwrdm_disable(pwrdm->voltdm.ptr);
+		pwrdm_pre_transition(pwrdm);
+	}
 
 	BUG_ON(val < 0);
 }
 
-int pwrdm_pre_transition(void)
-{
-	pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
-	/* Decrease mpu / core usecounts to indicate we are entering idle */
-	pwrdm_cpu_idle();
-	return 0;
-}
-
-int pwrdm_post_transition(void)
-{
-	/* Increase mpu / core usecounts to indicate we are leaving idle */
-	pwrdm_cpu_wakeup();
-	pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
-	return 0;
-}
-
 /**
  * pwrdm_get_context_loss_count - get powerdomain's context loss count
  * @pwrdm: struct powerdomain * to wait for
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index ecf7d3d..52a99cf 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -214,8 +214,8 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
 int pwrdm_wait_transition(struct powerdomain *pwrdm);
 
 int pwrdm_state_switch(struct powerdomain *pwrdm);
-int pwrdm_pre_transition(void);
-int pwrdm_post_transition(void);
+int pwrdm_pre_transition(struct powerdomain *pwrdm);
+int pwrdm_post_transition(struct powerdomain *pwrdm);
 
 void pwrdm_clkdm_enable(struct powerdomain *pwrdm);
 void pwrdm_clkdm_disable(struct powerdomain *pwrdm);
-- 
1.7.1

