From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 03/10] OMAP: PM: Add closures to clkdm_for_each and pwrdm_for_each.
Date: Thu, 13 Aug 2009 09:52:32 -0700
Message-ID: <1250182359-18830-4-git-send-email-khilman@deeprootsystems.com>
References: <1250182359-18830-1-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-2-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-3-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1250182359-18830-3-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter 'p2' De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Peter 'p2' De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Add some infrastructure to easily iterate over clock and power
domains.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 arch/arm/mach-omap2/clockdomain.c             |    5 +++--
 arch/arm/mach-omap2/pm24xx.c                  |    4 ++--
 arch/arm/mach-omap2/pm34xx.c                  |    8 ++++----
 arch/arm/plat-omap/include/mach/clockdomain.h |    3 ++-
 arch/arm/plat-omap/include/mach/powerdomain.h |    3 ++-
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 5b0b90b..4ef7b4f 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -299,7 +299,8 @@ struct clockdomain *clkdm_lookup(const char *name)
  * anything else to indicate failure; or -EINVAL if the function pointer
  * is null.
  */
-int clkdm_for_each(int (*fn)(struct clockdomain *clkdm))
+int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
+			void *user)
 {
 	struct clockdomain *clkdm;
 	int ret = 0;
@@ -309,7 +310,7 @@ int clkdm_for_each(int (*fn)(struct clockdomain *clkdm))
 
 	mutex_lock(&clkdm_mutex);
 	list_for_each_entry(clkdm, &clkdm_list, node) {
-		ret = (*fn)(clkdm);
+		ret = (*fn)(clkdm, user);
 		if (ret)
 			break;
 	}
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 528dbdc..bff5c4e 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -333,7 +333,7 @@ static struct platform_suspend_ops omap_pm_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
-static int _pm_clkdm_enable_hwsup(struct clockdomain *clkdm)
+static int _pm_clkdm_enable_hwsup(struct clockdomain *clkdm, void *unused)
 {
 	omap2_clkdm_allow_idle(clkdm);
 	return 0;
@@ -385,7 +385,7 @@ static void __init prcm_setup_regs(void)
 	omap2_clkdm_sleep(gfx_clkdm);
 
 	/* Enable clockdomain hardware-supervised control for all clkdms */
-	clkdm_for_each(_pm_clkdm_enable_hwsup);
+	clkdm_for_each(_pm_clkdm_enable_hwsup, NULL);
 
 	/* Enable clock autoidle for all domains */
 	cm_write_mod_reg(OMAP24XX_AUTO_CAM |
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index f197624..331dfca 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -664,7 +664,7 @@ static void __init prcm_setup_regs(void)
 	omap3_d2d_idle();
 }
 
-static int __init pwrdms_setup(struct powerdomain *pwrdm)
+static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
 
@@ -689,7 +689,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
  * supported. Initiate sleep transition for other clockdomains, if
  * they are not used
  */
-static int __init clkdms_setup(struct clockdomain *clkdm)
+static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
 	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
 		omap2_clkdm_allow_idle(clkdm);
@@ -722,13 +722,13 @@ static int __init omap3_pm_init(void)
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
1.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
