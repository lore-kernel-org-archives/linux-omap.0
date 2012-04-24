From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFT 1/3] ARM: OMAP2+: powerdomain: allow pre/post transtion to be per pwrdm
Date: Tue, 24 Apr 2012 07:23:38 -0700
Message-ID: <1335277420-29124-2-git-send-email-khilman@ti.com>
References: <1335277420-29124-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36643 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754679Ab2DXOWy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 10:22:54 -0400
Received: by pbbrp2 with SMTP id rp2so97526pbb.15
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:22:52 -0700 (PDT)
In-Reply-To: <1335277420-29124-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Iteration over all power domains in the idle path is unnecessary since
only power domains that are transitioning need to be accounted for.
Also PRCM register accesses are known to be expensive, so the
additional latency added to the idle path is signficiant.

In order allow the pre/post transitions to be isolated and called
per-pwrdm, change the API so passing in a specific power domain will
trigger the pre/post transtion accounting for only that specific power
domain.  Passing NULL means iterating over all power domains as is
current behavior.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 ++--
 arch/arm/mach-omap2/pm34xx.c              |    4 ++--
 arch/arm/mach-omap2/powerdomain.c         |   16 ++++++++++++----
 arch/arm/mach-omap2/powerdomain.h         |    4 ++--
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 13670aa..e35a86b 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -255,7 +255,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 		return -ENXIO;
 	}
 
-	pwrdm_pre_transition();
+	pwrdm_pre_transition(NULL);
 
 	/*
 	 * Check MPUSS next state and save interrupt controller if needed.
@@ -287,7 +287,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	wakeup_cpu = smp_processor_id();
 	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
 
-	pwrdm_post_transition();
+	pwrdm_post_transition(NULL);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 703bd10..2451b90 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -307,7 +307,7 @@ void omap_sram_idle(void)
 			omap3_enable_io_chain();
 	}
 
-	pwrdm_pre_transition();
+	pwrdm_pre_transition(NULL);
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
@@ -372,7 +372,7 @@ void omap_sram_idle(void)
 	}
 	omap3_intc_resume_idle();
 
-	pwrdm_post_transition();
+	pwrdm_post_transition(NULL);
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 96ad3dbe..0baf8c3 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -991,15 +991,23 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm)
 	return -EINVAL;
 }
 
-int pwrdm_pre_transition(void)
+int pwrdm_pre_transition(struct powerdomain *pwrdm)
 {
-	pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
+	if (pwrdm) 
+		_pwrdm_pre_transition_cb(pwrdm, NULL);
+	else 
+		pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
+
 	return 0;
 }
 
-int pwrdm_post_transition(void)
+int pwrdm_post_transition(struct powerdomain *pwrdm)
 {
-	pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
+	if (pwrdm)
+		_pwrdm_post_transition_cb(pwrdm, NULL);
+	else
+		pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0d72a8a..a468de4 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -214,8 +214,8 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm);
 
 int pwrdm_state_switch(struct powerdomain *pwrdm);
 int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
-int pwrdm_pre_transition(void);
-int pwrdm_post_transition(void);
+int pwrdm_pre_transition(struct powerdomain *pwrdm);
+int pwrdm_post_transition(struct powerdomain *pwrdm);
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
-- 
1.7.9.2

