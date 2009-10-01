From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 08/28] OMAP3: PM: handle PER/NEON/CORE in idle
Date: Thu,  1 Oct 2009 16:58:38 -0700
Message-ID: <1254441538-9257-9-git-send-email-khilman@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-4-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-5-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-6-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-7-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-8-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:58920 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbZJAX7K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:10 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so574597pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:15 -0700 (PDT)
In-Reply-To: <1254441538-9257-8-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   64 +++++++++++++++++++++++++++++++++++------
 1 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9dbb5a0..7eab539 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -49,7 +49,10 @@ static LIST_HEAD(pwrst_list);
 
 static void (*_omap_sram_idle)(u32 *addr, int save_state);
 
-static struct powerdomain *mpu_pwrdm;
+static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
+static struct powerdomain *core_pwrdm, *per_pwrdm;
+
+static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 
 /*
  * PRCM Interrupt Handler Helper Function
@@ -169,13 +172,22 @@ static void omap_sram_idle(void)
 	/* save_state = 1 => Only L1 and logic lost */
 	/* save_state = 2 => Only L2 lost */
 	/* save_state = 3 => L1, L2 and logic lost */
-	int save_state = 0, mpu_next_state;
+	int save_state = 0;
+	int mpu_next_state = PWRDM_POWER_ON;
+	int per_next_state = PWRDM_POWER_ON;
+	int core_next_state = PWRDM_POWER_ON;
 
 	if (!_omap_sram_idle)
 		return;
 
+	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
+	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
+	pwrdm_clear_all_prev_pwrst(core_pwrdm);
+	pwrdm_clear_all_prev_pwrst(per_pwrdm);
+
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
+	case PWRDM_POWER_ON:
 	case PWRDM_POWER_RET:
 		/* No need to save context */
 		save_state = 0;
@@ -187,18 +199,37 @@ static void omap_sram_idle(void)
 	}
 	pwrdm_pre_transition();
 
-	omap2_gpio_prepare_for_retention();
-	omap_uart_prepare_idle(0);
-	omap_uart_prepare_idle(1);
-	omap_uart_prepare_idle(2);
+	/* NEON control */
+	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
+		set_pwrdm_state(neon_pwrdm, mpu_next_state);
+
+	/* CORE & PER */
+	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
+	if (core_next_state < PWRDM_POWER_ON) {
+		omap2_gpio_prepare_for_retention();
+		omap_uart_prepare_idle(0);
+		omap_uart_prepare_idle(1);
+		/* PER changes only with core */
+		per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
+		if (per_next_state < PWRDM_POWER_ON)
+			omap_uart_prepare_idle(2);
+		/* Enable IO-PAD wakeup */
+		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+	}
 
 	_omap_sram_idle(NULL, save_state);
 	cpu_init();
 
-	omap_uart_resume_idle(2);
-	omap_uart_resume_idle(1);
-	omap_uart_resume_idle(0);
-	omap2_gpio_resume_after_retention();
+	if (core_next_state < PWRDM_POWER_ON) {
+		if (per_next_state < PWRDM_POWER_ON)
+			omap_uart_resume_idle(2);
+		omap_uart_resume_idle(1);
+		omap_uart_resume_idle(0);
+
+		/* Disable IO-PAD wakeup */
+		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+		omap2_gpio_resume_after_retention();
+	}
 
 	pwrdm_post_transition();
 
@@ -791,6 +822,10 @@ static int __init omap3_pm_init(void)
 		goto err2;
 	}
 
+	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
+	per_pwrdm = pwrdm_lookup("per_pwrdm");
+	core_pwrdm = pwrdm_lookup("core_pwrdm");
+
 	omap_push_sram_idle();
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
@@ -798,6 +833,15 @@ static int __init omap3_pm_init(void)
 
 	pm_idle = omap3_pm_idle;
 
+	pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
+	/*
+	 * REVISIT: This wkdep is only necessary when GPIO2-6 are enabled for
+	 * IO-pad wakeup.  Otherwise it will unnecessarily waste power
+	 * waking up PER with every CORE wakeup - see
+	 * http://marc.info/?l=linux-omap&m=121852150710062&w=2
+	*/
+	pwrdm_add_wkdep(per_pwrdm, core_pwrdm);
+
 err1:
 	return ret;
 err2:
-- 
1.6.4.3

