From: jean.pihet@newoldbits.com
Subject: [PATCH 6/6] ARM: OMAP2+: PM: use power domain functional state in stats counters
Date: Wed, 11 Apr 2012 22:46:12 +0200
Message-ID: <1334177172-28583-7-git-send-email-j-pihet@ti.com>
References: <1334177172-28583-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39478 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933185Ab2DKUqu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 16:46:50 -0400
Received: by wibhj6 with SMTP id hj6so4802421wib.1
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 13:46:48 -0700 (PDT)
In-Reply-To: <1334177172-28583-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ldc_pm_all@list.ti.com, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The PM code uses some counters to keep track of the power domains
transitions, in order to provide the information to drivers (in
pwrdm_get_context_loss_count) and to expose the information to
sysfs for debug purpose.

This patch provides the information for each functional state.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c    |   15 ++++++++-------
 arch/arm/mach-omap2/powerdomain.c |   12 ++++++------
 arch/arm/mach-omap2/powerdomain.h |    4 ++--
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 814bcd9..13c00fb 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -53,9 +53,10 @@ enum {
 	DEBUG_FILE_TIMERS,
 };
 
-static const char pwrdm_state_names[][PWRDM_MAX_PWRSTS] = {
+static const char pwrdm_state_names[][PWRDM_MAX_FUNC_PWRSTS] = {
 	"OFF",
-	"RET",
+	"OSWR",
+	"CSWR",
 	"INA",
 	"ON"
 };
@@ -102,13 +103,13 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 		strncmp(pwrdm->name, "dpll", 4) == 0)
 		return 0;
 
-	if (pwrdm->state != pwrdm_read_pwrst(pwrdm))
+	if (pwrdm->state != pwrdm_read_func_pwrst(pwrdm))
 		printk(KERN_ERR "pwrdm state mismatch(%s) %d != %d\n",
-			pwrdm->name, pwrdm->state, pwrdm_read_pwrst(pwrdm));
+		       pwrdm->name, pwrdm->state, pwrdm_read_func_pwrst(pwrdm));
 
 	seq_printf(s, "%s (%s)", pwrdm->name,
 			pwrdm_state_names[pwrdm->state]);
-	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
+	for (i = 0; i < PWRDM_MAX_FUNC_PWRSTS; i++)
 		seq_printf(s, ",%s:%d", pwrdm_state_names[i],
 			pwrdm->state_counter[i]);
 
@@ -137,7 +138,7 @@ static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
 	seq_printf(s, "%s (%s)", pwrdm->name,
 		pwrdm_state_names[pwrdm->state]);
 
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < PWRDM_MAX_FUNC_PWRSTS; i++)
 		seq_printf(s, ",%s:%lld", pwrdm_state_names[i],
 			pwrdm->state_timer[i]);
 
@@ -211,7 +212,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
 
 	t = sched_clock();
 
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < PWRDM_MAX_FUNC_PWRSTS; i++)
 		pwrdm->state_timer[i] = 0;
 
 	pwrdm->timer = t;
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 3faac62..3f78f16 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -106,7 +106,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	list_add(&pwrdm->node, &pwrdm_list);
 
 	/* Initialize the powerdomain's state counter */
-	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
+	for (i = 0; i < PWRDM_MAX_FUNC_PWRSTS; i++)
 		pwrdm->state_counter[i] = 0;
 
 	pwrdm->ret_logic_off_counter = 0;
@@ -114,7 +114,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 		pwrdm->ret_mem_off_counter[i] = 0;
 
 	pwrdm_wait_transition(pwrdm);
-	pwrdm->state = pwrdm_read_pwrst(pwrdm);
+	pwrdm->state = pwrdm_read_func_pwrst(pwrdm);
 	pwrdm->state_counter[pwrdm->state] = 1;
 
 	pr_debug("powerdomain: registered %s\n", pwrdm->name);
@@ -149,17 +149,17 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 	if (pwrdm == NULL)
 		return -EINVAL;
 
-	state = pwrdm_read_pwrst(pwrdm);
+	state = pwrdm_read_func_pwrst(pwrdm);
 
 	switch (flag) {
 	case PWRDM_STATE_NOW:
 		prev = pwrdm->state;
 		break;
 	case PWRDM_STATE_PREV:
-		prev = pwrdm_read_prev_pwrst(pwrdm);
+		prev = pwrdm_read_prev_func_pwrst(pwrdm);
 		if (pwrdm->state != prev)
 			pwrdm->state_counter[prev]++;
-		if (prev == PWRDM_POWER_RET)
+		if (prev == PWRDM_FUNC_PWRST_OSWR)
 			_update_logic_membank_counters(pwrdm);
 		/*
 		 * If the power domain did not hit the desired state,
@@ -1240,7 +1240,7 @@ int pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
 		return -ENODEV;
 	}
 
-	count = pwrdm->state_counter[PWRDM_POWER_OFF];
+	count = pwrdm->state_counter[PWRDM_FUNC_PWRST_OFF];
 	count += pwrdm->ret_logic_off_counter;
 
 	for (i = 0; i < pwrdm->banks; i++)
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 4e5ce15..9249d42 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -135,13 +135,13 @@ struct powerdomain {
 	struct list_head voltdm_node;
 	struct mutex lock;
 	int state;
-	unsigned state_counter[PWRDM_MAX_PWRSTS];
+	unsigned state_counter[PWRDM_MAX_FUNC_PWRSTS];
 	unsigned ret_logic_off_counter;
 	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
 
 #ifdef CONFIG_PM_DEBUG
 	s64 timer;
-	s64 state_timer[PWRDM_MAX_PWRSTS];
+	s64 state_timer[PWRDM_MAX_FUNC_PWRSTS];
 #endif
 };
 
-- 
1.7.7.6

