From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Move some counter functions to powerdomain.c
Date: Wed, 24 Sep 2008 17:06:50 +0300
Message-ID: <1222265214-7106-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1222265214-7106-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61980 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbYIXOIQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 10:08:16 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8OE6fEl007560
	for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 09:08:12 -0500
In-Reply-To: <1222265214-7106-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/pm-debug.c |  107 ++++++----------------------------------
 1 files changed, 16 insertions(+), 91 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 380a2a0..a375312 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -318,94 +318,20 @@ int pm_dbg_regset_save(int reg_set)
 	return 0;
 }
 
-static int _pm_dbg_state_switch(struct powerdomain *pwrdm, int flag)
+void pm_dbg_update_time(struct powerdomain *pwrdm, int prev)
 {
 	s64 t;
 	struct timespec now;
-	int prev;
-	int state;
 
-	if (pwrdm == NULL)
-		return -EINVAL;
-
-	state = pwrdm_read_pwrst(pwrdm);
-
-	switch (flag) {
-	case PM_DBG_STATE_NOW:
-		prev = pwrdm->state;
-		break;
-	case PM_DBG_STATE_PREV:
-		prev = pwrdm_read_prev_pwrst(pwrdm);
-		if (pwrdm->state != prev)
-			pwrdm->state_counter[prev]++;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (pm_dbg_init_done) {
-		/* Update timer for previous state */
-		getnstimeofday(&now);
-		t = timespec_to_ns(&now);
-
-		pwrdm->state_timer[prev] += t - pwrdm->timer;
-
-		pwrdm->timer = t;
-
-		if (state != prev)
-			pwrdm->state_counter[state]++;
-	}
-
-	pwrdm->state = state;
-
-	return 0;
-}
-
-int pm_dbg_pwrdm_state_switch(struct powerdomain *pwrdm)
-{
-	return _pm_dbg_state_switch(pwrdm, PM_DBG_STATE_NOW);
-}
-
-int pm_dbg_clkdm_state_switch(struct clockdomain *clkdm)
-{
-	if (clkdm != NULL && clkdm->pwrdm.ptr != NULL) {
-		pwrdm_wait_transition(clkdm->pwrdm.ptr);
-		return pm_dbg_pwrdm_state_switch(clkdm->pwrdm.ptr);
-	}
-
-	return -EINVAL;
-}
-
-int pm_dbg_clk_state_switch(struct clk *clk)
-{
-	if (clk != NULL && clk->clkdm.ptr != NULL)
-		return pm_dbg_clkdm_state_switch(clk->clkdm.ptr);
-	return -EINVAL;
-}
+	if (!pm_dbg_init_done)
+		return;
 
-static int pm_dbg_pre_suspend_cb(struct powerdomain *pwrdm)
-{
-	pwrdm_clear_all_prev_pwrst(pwrdm);
-	_pm_dbg_state_switch(pwrdm, PM_DBG_STATE_NOW);
-	return 0;
-}
-
-static int pm_dbg_post_suspend_cb(struct powerdomain *pwrdm)
-{
-	_pm_dbg_state_switch(pwrdm, PM_DBG_STATE_PREV);
-	return 0;
-}
+	getnstimeofday(&now);
+	t = timespec_to_ns(&now);
 
-int pm_dbg_pre_suspend(void)
-{
-	pwrdm_for_each(pm_dbg_pre_suspend_cb);
-	return 0;
-}
+	pwrdm->state_timer[prev] += t - pwrdm->timer;
 
-int pm_dbg_post_suspend(void)
-{
-	pwrdm_for_each(pm_dbg_post_suspend_cb);
-	return 0;
+	pwrdm->timer = t;
 }
 
 enum {
@@ -489,25 +415,23 @@ int pm_dbg_regset_init(int reg_set)
 	return 0;
 }
 
-static int __init pwrdms_setup(struct powerdomain *pwrdm)
+int __init _pwrdm_debug_setup(struct powerdomain *pwrdm, void *user)
 {
-	s64 t;
-	int i;
+	s64 t=0;
 	struct timespec now;
+	int i;
+
+printk("pwrdm: %p\n",pwrdm);
 
 	getnstimeofday(&now);
 	t = timespec_to_ns(&now);
 
+	pwrdm->timer = t;
+
 	for (i = 0; i < 4; i++) {
-		pwrdm->state_counter[i] = 0;
 		pwrdm->state_timer[i] = 0;
 	}
 
-	pwrdm_wait_transition(pwrdm);
-	pwrdm->state = pwrdm_read_pwrst(pwrdm);
-	pwrdm->state_counter[pwrdm->state] = 1;
-	pwrdm->timer = t;
-
 	(void) debugfs_create_file(pwrdm->name, S_IRUGO|S_IWUSR,
 		pm_dbg_dir, pwrdm, &debug_pwrdm_fops);
 
@@ -535,7 +459,7 @@ static int __init pm_dbg_init(void)
 	if (IS_ERR(pm_dbg_dir))
 		return PTR_ERR(pm_dbg_dir);
 
-	pwrdm_for_each(pwrdms_setup);
+	pwrdm_for_each(_pwrdm_debug_setup, NULL);
 
 	pm_dbg_dir = debugfs_create_dir("registers", d);
 	if (IS_ERR(pm_dbg_dir))
@@ -552,6 +476,7 @@ static int __init pm_dbg_init(void)
 
 		}
 
+
 	pm_dbg_init_done = 1;
 
 	return 0;
-- 
1.5.6.3

