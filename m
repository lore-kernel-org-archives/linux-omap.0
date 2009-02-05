From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 14/21] OMAP: PM: Add closures to clkdm_for_each and pwrdm_for_each.
Date: Wed,  4 Feb 2009 18:06:00 -0800
Message-ID: <1233799567-22250-15-git-send-email-khilman@deeprootsystems.com>
References: <1233799567-22250-1-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-2-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-3-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-4-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-5-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-6-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-7-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-8-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-9-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-10-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-11-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-12-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-13-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-14-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:13429 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758226AbZBECHS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 21:07:18 -0500
Received: by an-out-0708.google.com with SMTP id c2so43anc.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 18:07:17 -0800 (PST)
In-Reply-To: <1233799567-22250-14-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

First add some infrastructure to easily iterate over clock and power domains.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clockdomain.c             |    5 +++--
 arch/arm/mach-omap2/pm24xx.c                  |    4 ++--
 arch/arm/mach-omap2/pm34xx.c                  |    8 ++++----
 arch/arm/plat-omap/include/mach/clockdomain.h |    3 ++-
 arch/arm/plat-omap/include/mach/powerdomain.h |    3 ++-
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 6650d44..fa55b6f 100644
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
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 64985f5..ec1a291 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -348,7 +348,7 @@ static struct platform_suspend_ops omap_pm_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
-static int _pm_clkdm_enable_hwsup(struct clockdomain *clkdm)
+static int _pm_clkdm_enable_hwsup(struct clockdomain *clkdm, void *unused)
 {
 	omap2_clkdm_allow_idle(clkdm);
 	return 0;
@@ -400,7 +400,7 @@ static void __init prcm_setup_regs(void)
 	omap2_clkdm_sleep(gfx_clkdm);
 
 	/* Enable clockdomain hardware-supervised control for all clkdms */
-	clkdm_for_each(_pm_clkdm_enable_hwsup);
+	clkdm_for_each(_pm_clkdm_enable_hwsup, NULL);
 
 	/* Enable clock autoidle for all domains */
 	cm_write_mod_reg(OMAP24XX_AUTO_CAM |
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 253ab97..84ec1e3 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -597,7 +597,7 @@ static void __init prcm_setup_regs(void)
 	omap3_iva_idle();
 }
 
-static int __init pwrdms_setup(struct powerdomain *pwrdm)
+static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
 
@@ -622,7 +622,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
  * supported. Initiate sleep transition for other clockdomains, if
  * they are not used
  */
-static int __init clkdms_setup(struct clockdomain *clkdm)
+static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
 	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
 		omap2_clkdm_allow_idle(clkdm);
@@ -652,13 +652,13 @@ int __init omap3_pm_init(void)
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
1.6.1

