From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 3/4] OMAP: powerdomain: split pwrdm_init() into two
	functions
Date: Wed, 14 Sep 2011 16:45:13 -0600
Message-ID: <20110914224509.12067.18383.stgit@dusk>
References: <20110914220723.12067.99495.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55759 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab1INWrb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 18:47:31 -0400
In-Reply-To: <20110914220723.12067.99495.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

In preparation for OMAP_CHIP() removal, split pwrdm_init() into three
functions.  This allows some of them to be called multiple times: for
example, pwrdm_register_pwrdms() can be called once to register
powerdomains that are common to a group of SoCs, and once to register
powerdomains that are specific to a single SoC.

The appropriate order to call these functions - which is enforced
by the code - is:

1. pwrdm_register_platform_funcs()
2. pwrdm_register_pwrdms() (can be called multiple times)
3. pwrdm_complete_init()

Convert the OMAP2, 3, and 4 powerdomain init code to use these new
functions.

While here, improve documentation, and increase CodingStyle
conformance by shortening some local variable names.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c           |   84 ++++++++++++++++++++-------
 arch/arm/mach-omap2/powerdomain.h           |    4 +
 arch/arm/mach-omap2/powerdomains2xxx_data.c |    4 +
 arch/arm/mach-omap2/powerdomains3xxx_data.c |    4 +
 arch/arm/mach-omap2/powerdomains44xx_data.c |    4 +
 5 files changed, 74 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index ef71fdd..3483537 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1,7 +1,7 @@
 /*
  * OMAP powerdomain control
  *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008, 2011 Texas Instruments, Inc.
  * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Written by Paul Walmsley
@@ -194,36 +194,76 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 /* Public functions */
 
 /**
- * pwrdm_init - set up the powerdomain layer
- * @pwrdms: array of struct powerdomain pointers to register
- * @custom_funcs: func pointers for arch specific implementations
+ * pwrdm_register_platform_funcs - register powerdomain implementation fns
+ * @po: func pointers for arch specific implementations
  *
- * Loop through the array of powerdomains @pwrdms, registering all
- * that are available on the current CPU.  Also, program all
- * powerdomain target state as ON; this is to prevent domains from
- * hitting low power states (if bootloader has target states set to
- * something other than ON) and potentially even losing context while
- * PM is not fully initialized.  The PM late init code can then program
- * the desired target state for all the power domains.  No return
- * value.
+ * Register the list of function pointers used to implement the
+ * powerdomain functions on different OMAP SoCs.  Should be called
+ * before any other pwrdm_register*() function.  Returns -EINVAL if
+ * @po is null, -EEXIST if platform functions have already been
+ * registered, or 0 upon success.
  */
-void pwrdm_init(struct powerdomain **pwrdms, struct pwrdm_ops *custom_funcs)
+int pwrdm_register_platform_funcs(struct pwrdm_ops *po)
+{
+	if (!po)
+		return -EINVAL;
+
+	if (arch_pwrdm)
+		return -EEXIST;
+
+	arch_pwrdm = po;
+
+	return 0;
+}
+
+/**
+ * pwrdm_register_pwrdms - register SoC powerdomains
+ * @ps: pointer to an array of struct powerdomain to register
+ *
+ * Register the powerdomains available on a particular OMAP SoC.  Must
+ * be called after pwrdm_register_platform_funcs().  May be called
+ * multiple times.  Returns -EACCES if called before
+ * pwrdm_register_platform_funcs(); -EINVAL if the argument @ps is
+ * null; or 0 upon success.
+ */
+int pwrdm_register_pwrdms(struct powerdomain **ps)
 {
 	struct powerdomain **p = NULL;
-	struct powerdomain *temp_p;
 
-	if (!custom_funcs)
-		WARN(1, "powerdomain: No custom pwrdm functions registered\n");
-	else
-		arch_pwrdm = custom_funcs;
+	if (!arch_pwrdm)
+		return -EEXIST;
 
-	if (pwrdms) {
-		for (p = pwrdms; *p; p++)
-			_pwrdm_register(*p);
-	}
+	if (!ps)
+		return -EINVAL;
+
+	for (p = ps; *p; p++)
+		_pwrdm_register(*p);
+
+	return 0;
+}
+
+/**
+ * pwrdm_complete_init - set up the powerdomain layer
+ *
+ * Do whatever is necessary to initialize registered powerdomains and
+ * powerdomain code.  Currently, this programs the next power state
+ * for each powerdomain to ON.  This prevents powerdomains from
+ * unexpectedly losing context or entering high wakeup latency modes
+ * with non-power-management-enabled kernels.  Must be called after
+ * pwrdm_register_pwrdms().  Returns -EACCES if called before
+ * pwrdm_register_pwrdms(), or 0 upon success.
+ */
+int pwrdm_complete_init(void)
+{
+	struct powerdomain *temp_p;
+
+	if (list_empty(&pwrdm_list))
+		return -EACCES;
 
 	list_for_each_entry(temp_p, &pwrdm_list, node)
 		pwrdm_set_next_pwrst(temp_p, PWRDM_POWER_ON);
+
+	return 0;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index d23d979..489e1c5 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -162,7 +162,9 @@ struct pwrdm_ops {
 	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
 };
 
-void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_ops *custom_funcs);
+int pwrdm_register_platform_funcs(struct pwrdm_ops *custom_funcs);
+int pwrdm_register_pwrdms(struct powerdomain **pwrdm_list);
+int pwrdm_complete_init(void);
 
 struct powerdomain *pwrdm_lookup(const char *name);
 
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_data.c
index cc389fb..71c4fd7 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_data.c
@@ -119,5 +119,7 @@ static struct powerdomain *powerdomains_omap2xxx[] __initdata = {
 
 void __init omap2xxx_powerdomains_init(void)
 {
-	pwrdm_init(powerdomains_omap2xxx, &omap2_pwrdm_operations);
+	pwrdm_register_platform_funcs(&omap2_pwrdm_operations);
+	pwrdm_register_pwrdms(powerdomains_omap2xxx);
+	pwrdm_complete_init();
 }
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 469a920..9d355fc 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -283,5 +283,7 @@ static struct powerdomain *powerdomains_omap3xxx[] __initdata = {
 
 void __init omap3xxx_powerdomains_init(void)
 {
-	pwrdm_init(powerdomains_omap3xxx, &omap3_pwrdm_operations);
+	pwrdm_register_platform_funcs(&omap3_pwrdm_operations);
+	pwrdm_register_pwrdms(powerdomains_omap3xxx);
+	pwrdm_complete_init();
 }
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 247e794..67ac24b 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -352,5 +352,7 @@ static struct powerdomain *powerdomains_omap44xx[] __initdata = {
 
 void __init omap44xx_powerdomains_init(void)
 {
-	pwrdm_init(powerdomains_omap44xx, &omap4_pwrdm_operations);
+	pwrdm_register_platform_funcs(&omap4_pwrdm_operations);
+	pwrdm_register_pwrdms(powerdomains_omap44xx);
+	pwrdm_complete_init();
 }


