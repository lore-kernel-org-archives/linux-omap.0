From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 15/16] OMAP3: Dynamic enable/disable of OFF support
Date: Wed, 01 Oct 2008 14:25:09 +0300
Message-ID: <87wsgstv56.fsf@deeprootsystems.com>
References: <024801c92201$506cf780$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:46186 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbYJALZU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 07:25:20 -0400
Received: by fk-out-0910.google.com with SMTP id 18so56980fkq.5
        for <linux-omap@vger.kernel.org>; Wed, 01 Oct 2008 04:25:18 -0700 (PDT)
In-Reply-To: <024801c92201$506cf780$LocalHost@wipultra1382> (Rajendra Nayak's message of "Mon\, 29 Sep 2008 12\:32\:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"Rajendra Nayak" <rnayak@ti.com> writes:

> I just managed to see that this patch seems to break suspend
> functionality.  If after bootup I enable OFF mode the subsequent
> suspend tries to put a few power domains to OFF which are currently
> in RET, and since there is no code in place today to handle RET to
> OFF transitions, they don't transition to OFF and remain in RET.

Rajendra,

Try this patch on top of your series, it works for me to hit OFF in
suspend and idle after having first hit RET in suspend and idle.

Note that my tests on 3430SDP-ES2 show that dynamic-idle with off-mode
enabled eventually hangs.  I am not seeing this hang on custom HW.

Kevin 

===========================

>From a03d3cfd71e9438c9446365519f0cb9ced75d1dd Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Tue, 30 Sep 2008 16:12:55 +0300
Subject: [PATCH] ARM: OMAP3: PM: allow runtime enable/disable of OFF mode

To enable off mode:

  echo 1 > /sys/power/enable_off_mode

to disable:

  echo 0 > /sys/power/enable_off_mode

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm.c     |    5 +++--
 arch/arm/mach-omap2/pm.h     |    2 +-
 arch/arm/mach-omap2/pm34xx.c |   42 ++++++++++++++++--------------------------
 3 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 412fc86..10f8058 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -80,8 +80,9 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 	} else if (attr == &clocks_off_while_idle_attr) {
 		clocks_off_while_idle = value;
 	} else if (attr == &enable_off_mode_attr) {
-		enable_off_mode = value;
-		pwrdm_for_each(set_next_pwrst);
+		int enable = (value > 0) ? 1 : 0;
+
+		omap3_pm_off_mode_enable(enable);
 	} else {
 		return -EINVAL;
 	}
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 7e2c88a..901db2c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -23,7 +23,7 @@ extern atomic_t sleep_block;
 
 extern void omap2_block_sleep(void);
 extern void omap2_allow_sleep(void);
-extern int set_next_pwrst(struct powerdomain *pwrdm);
+extern void omap3_pm_off_mode_enable(int);
 
 #define OMAP343X_TABLE_ADDRESS_OFFSET 0x31
 #define OMAP343X_TABLE_VALUE_OFFSET   0x30
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 05509e9..e6a18ea 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -395,32 +395,6 @@ static int omap3_can_sleep(void)
 	return 1;
 }
 
-int set_next_pwrst(struct powerdomain *pwrdm)
-{
-	struct power_state *pwrst;
-	int ret = 0;
-	u32 state;
-
-	if (!pwrdm->pwrsts)
-		return 0;
-
-	if (enable_off_mode)
-		state = PWRDM_POWER_OFF;
-	else
-		state = PWRDM_POWER_RET;
-
-	ret = pwrdm_set_next_pwrst(pwrdm, state);
-	if (ret) {
-		printk(KERN_ERR "Unable to set state of powerdomain: %s\n",
-		       pwrdm->name);
-		goto err;
-	}
-	list_for_each_entry(pwrst, &pwrst_list, node)
-		pwrst->next_state = state;
-err:
-	return ret;
-}
-
 /* This sets pwrdm state (other than mpu & core. Currently only ON &
  * RET are supported. Function is assuming that clkdm doesn't have
  * hw_sup mode enabled. */
@@ -706,6 +680,22 @@ static void __init prcm_setup_regs(void)
 			OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
 }
 
+void omap3_pm_off_mode_enable(int enable)
+{
+	struct power_state *pwrst;
+	u32 state;
+
+	if (enable)
+		state = PWRDM_POWER_OFF;
+	else
+		state = PWRDM_POWER_RET;
+
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		pwrst->next_state = state;
+		set_pwrdm_state(pwrst->pwrdm, state);
+	}
+}
+
 static int __init pwrdms_setup(struct powerdomain *pwrdm)
 {
 	struct power_state *pwrst;
-- 
1.6.0

