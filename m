From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv6 1/9] OMAP3: PM: Added support functions for omap3 pwrdm handling
Date: Fri, 12 Feb 2010 20:27:37 +0200
Message-ID: <1265999265-4363-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1265999265-4363-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25036 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757052Ab0BLQjh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 11:39:37 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGdYia022894
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 18:39:35 +0200
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGdVLs021112
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 18:39:33 +0200
In-Reply-To: <1265999265-4363-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Added omap3_pwrdm_set_next_pwrst and omap3_pwrdm_read_next_pwrst. These
functions add support for INACTIVE and ON states to the standard OMAP
powerdomain functions, and add caching logic for the next state. These
functions are used in subsequent patches to simplify the logic of the idle
loop.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm.h     |    2 +
 arch/arm/mach-omap2/pm34xx.c |   60 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 75aa685..1d9a740 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -67,6 +67,8 @@ static inline void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
 
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
+extern int omap3_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
+extern int omap3_pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
 
 extern u32 wakeup_timer_seconds;
 extern struct omap_dm_timer *gptimer_wakeup;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1359ec9..f20d3d8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -576,6 +576,64 @@ int omap3_can_sleep(void)
 	return 1;
 }
 
+struct powerdomain_data {
+	u8 next_state;
+	u8 init_done;
+};
+
+static struct powerdomain_data mpu_pwrdm_data;
+static struct powerdomain_data core_pwrdm_data;
+static struct powerdomain_data neon_pwrdm_data;
+
+static struct powerdomain_data *get_pwrdm_data(struct powerdomain *pwrdm)
+{
+	if (pwrdm == mpu_pwrdm)
+		return &mpu_pwrdm_data;
+	else if (pwrdm == core_pwrdm)
+		return &core_pwrdm_data;
+	else if (pwrdm == neon_pwrdm)
+		return &neon_pwrdm_data;
+	return NULL;
+}
+
+int omap3_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	struct powerdomain_data *data = get_pwrdm_data(pwrdm);
+	u8 prg_pwrst;
+
+	if (!data)
+		return pwrdm_set_next_pwrst(pwrdm, pwrst);
+
+	if (!data->init_done)
+		data->init_done = 1;
+	else if (data->next_state == pwrst)
+		return 0;
+
+	if (pwrst == PWRDM_POWER_INACTIVE)
+		prg_pwrst = PWRDM_POWER_ON;
+	else
+		prg_pwrst = pwrst;
+
+	pwrdm_set_next_pwrst(pwrdm, prg_pwrst);
+
+	if (pwrst == PWRDM_POWER_ON)
+		omap2_clkdm_deny_idle(pwrdm->pwrdm_clkdms[0]);
+	else
+		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+
+	data->next_state = pwrst;
+	return 0;
+}
+
+int omap3_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
+{
+	struct powerdomain_data *data = get_pwrdm_data(pwrdm);
+
+	if (!data || !data->init_done)
+		return pwrdm_read_next_pwrst(pwrdm);
+	return data->next_state;
+}
+
 /* This sets pwrdm state (other than mpu & core. Currently only ON &
  * RET are supported. Function is assuming that clkdm doesn't have
  * hw_sup mode enabled. */
@@ -604,7 +662,7 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 		pwrdm_wait_transition(pwrdm);
 	}
 
-	ret = pwrdm_set_next_pwrst(pwrdm, state);
+	ret = omap3_pwrdm_set_next_pwrst(pwrdm, state);
 	if (ret) {
 		printk(KERN_ERR "Unable to set state of powerdomain: %s\n",
 		       pwrdm->name);
-- 
1.5.4.3

