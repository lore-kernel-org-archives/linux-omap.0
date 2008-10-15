From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/3] Add closures to clkdm_for_each and pwrdm_for_each.
Date: Wed, 15 Oct 2008 18:13:47 +0300
Message-ID: <1224083629-25061-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1224083629-25061-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19034 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789AbYJOPN5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 11:13:57 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9FFDrsn022244
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 18:13:55 +0300
In-Reply-To: <1224083629-25061-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

First add some infrastructure to easily iterate over clock and power domains.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/clockdomain.c             |    5 +++--
 arch/arm/mach-omap2/pm34xx.c                  |    8 ++++----
 arch/arm/plat-omap/include/mach/clockdomain.h |    3 ++-
 arch/arm/plat-omap/include/mach/powerdomain.h |    3 ++-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 5249fe8..b0b5885 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -295,7 +295,8 @@ struct clockdomain *clkdm_lookup(const char *name)
  * anything else to indicate failure; or -EINVAL if the function pointer
  * is null.
  */
-int clkdm_for_each(int (*fn)(struct clockdomain *clkdm))
+int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
+			void *user)
 {
 	struct clockdomain *clkdm;
 	int ret = 0;
@@ -305,7 +306,7 @@ int clkdm_for_each(int (*fn)(struct clockdomain *clkdm))
 
 	mutex_lock(&clkdm_mutex);
 	list_for_each_entry(clkdm, &clkdm_list, node) {
-		ret = (*fn)(clkdm);
+		ret = (*fn)(clkdm, user);
 		if (ret)
 			break;
 	}
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1fbb690..be69839 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -518,7 +518,7 @@ static void __init prcm_setup_regs(void)
 			OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
 }
 
-static int __init pwrdms_setup(struct powerdomain *pwrdm)
+static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
 
@@ -538,7 +538,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 }
 
-static int __init clkdms_setup(struct clockdomain *clkdm)
+static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
 	omap2_clkdm_allow_idle(clkdm);
 	return 0;
@@ -564,13 +564,13 @@ int __init omap3_pm_init(void)
 		goto err1;
 	}
 
-	ret = pwrdm_for_each(pwrdms_setup);
+	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		printk(KERN_ERR "Failed to setup powerdomains\n");
 		goto err2;
 	}
 
-	(void) clkdm_for_each(clkdms_setup);
+	(void) clkdm_for_each(clkdms_setup, NULL);
 
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
 	if (mpu_pwrdm == NULL) {
diff --git a/arch/arm/plat-omap/include/mach/clockdomain.h b/arch/arm/plat-omap/include/mach/clockdomain.h
index b9d0dd2..99ebd88 100644
--- a/arch/arm/plat-omap/include/mach/clockdomain.h
+++ b/arch/arm/plat-omap/include/mach/clockdomain.h
@@ -95,7 +95,8 @@ int clkdm_register(struct clockdomain *clkdm);
 int clkdm_unregister(struct clockdomain *clkdm);
 struct clockdomain *clkdm_lookup(const char *name);
 
-int clkdm_for_each(int (*fn)(struct clockdomain *clkdm));
+int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
+			void *user);
 struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
 
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
index 52663fc..de03f3d 100644
--- a/arch/arm/plat-omap/include/mach/powerdomain.h
+++ b/arch/arm/plat-omap/include/mach/powerdomain.h
@@ -128,7 +128,8 @@ int pwrdm_register(struct powerdomain *pwrdm);
 int pwrdm_unregister(struct powerdomain *pwrdm);
 struct powerdomain *pwrdm_lookup(const char *name);
 
-int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm));
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
+			void *user);
 
 int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
 int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
-- 
1.5.6.3

