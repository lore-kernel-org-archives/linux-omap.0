From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv7 1/7] OMAP3: PM: Added support functions for omap3 pwrdm handling
Date: Fri, 12 Mar 2010 17:39:11 +0200
Message-ID: <1268408357-15621-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53980 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757705Ab0CLNyl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 08:54:41 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2CDrxZ5008613
	for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2010 07:54:40 -0600
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2CDsV8i003701
	for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2010 15:54:32 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Added omap3_pwrdm_set_next_pwrst and omap3_pwrdm_read_next_pwrst. These
functions add support for INACTIVE and ON states to the standard OMAP
powerdomain functions, and add caching logic for the next state. HW
directly supports the reading of INACTIVE / ON from the previous state
register, but programming INACTIVE / ON can't be done directly.

These functions are used in subsequent patches to simplify the logic of
the idle loop.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm.h     |    2 +
 arch/arm/mach-omap2/pm34xx.c |   65 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b761be5..5f35911 100644
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
index a30941a..da4e684 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -576,6 +576,68 @@ int omap3_can_sleep(void)
 	return 1;
 }
 
+struct powerdomain_data {
+	u8 next_state;
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
+static void omap3_pwrdm_init_pwrst_cache(struct powerdomain *pwrdm)
+{
+	struct powerdomain_data *data = get_pwrdm_data(pwrdm);
+	if (data)
+		data->next_state = pwrdm_read_next_pwrst(pwrdm);
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
+	if (data->next_state == pwrst)
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
+	if (!data)
+		return pwrdm_read_next_pwrst(pwrdm);
+	return data->next_state;
+}
+
 /* This sets pwrdm state (other than mpu & core. Currently only ON &
  * RET are supported. Function is assuming that clkdm doesn't have
  * hw_sup mode enabled. */
@@ -604,7 +666,7 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 		pwrdm_wait_transition(pwrdm);
 	}
 
-	ret = pwrdm_set_next_pwrst(pwrdm, state);
+	ret = omap3_pwrdm_set_next_pwrst(pwrdm, state);
 	if (ret) {
 		printk(KERN_ERR "Unable to set state of powerdomain: %s\n",
 		       pwrdm->name);
@@ -1103,6 +1165,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrdm->pwrsts)
 		return 0;
 
+	omap3_pwrdm_init_pwrst_cache(pwrdm);
 	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
 	if (!pwrst)
 		return -ENOMEM;
-- 
1.5.4.3

