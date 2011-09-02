From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/4] OMAP: clockdomain: split clkdm_init()
Date: Thu, 01 Sep 2011 20:19:13 -0600
Message-ID: <20110902021911.8185.89304.stgit@dusk>
References: <20110902021321.8185.63172.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47537 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933071Ab1IBCbo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 22:31:44 -0400
In-Reply-To: <20110902021321.8185.63172.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

In preparation for OMAP_CHIP() removal, split clkdm_init() into four
functions.  This allows some of them to be called multiple times: for
example, clkdm_register_clkdms() can be called once to register
clockdomains that are common to a group of SoCs, and once to register
clockdomains that are specific to a single SoC.

The appropriate order to call these functions - which is enforced
by the code - is:

1. clkdm_register_platform_funcs()
2. clkdm_register_clkdms() (can be called multiple times)
3. clkdm_register_autodeps() (optional; deprecated)
4. clkdm_complete_init()

Convert the OMAP2, 3, and 4 clockdomain init code to use these new
functions.

While here, improve documentation, and increase CodingStyle
conformance by shortening some local variable names.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c                |  130 +++++++++++++++++-----
 arch/arm/mach-omap2/clockdomain.h                |    7 +
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |   13 ++
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    5 +
 4 files changed, 121 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 8f08906..b73a1dc 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -257,43 +257,113 @@ static void _resolve_clkdm_deps(struct clockdomain *clkdm,
 /* Public functions */
 
 /**
- * clkdm_init - set up the clockdomain layer
- * @clkdms: optional pointer to an array of clockdomains to register
- * @init_autodeps: optional pointer to an array of autodeps to register
- * @custom_funcs: func pointers for arch specific implementations
- *
- * Set up internal state.  If a pointer to an array of clockdomains
- * @clkdms was supplied, loop through the list of clockdomains,
- * register all that are available on the current platform. Similarly,
- * if a pointer to an array of clockdomain autodependencies
- * @init_autodeps was provided, register those.  No return value.
+ * clkdm_register_platform_funcs - register clockdomain implementation fns
+ * @co: func pointers for arch specific implementations
+ *
+ * Register the list of function pointers used to implement the
+ * clockdomain functions on different OMAP SoCs.  Should be called
+ * before any other clkdm_register*() function.  Returns -EINVAL if
+ * @co is null, -EEXIST if platform functions have already been
+ * registered, or 0 upon success.
+ */
+int clkdm_register_platform_funcs(struct clkdm_ops *co)
+{
+	if (!co)
+		return -EINVAL;
+
+	if (arch_clkdm)
+		return -EEXIST;
+
+	arch_clkdm = co;
+
+	return 0;
+};
+
+/**
+ * clkdm_register_clkdms - register SoC clockdomains
+ * @cs: pointer to an array of struct clockdomain to register
+ *
+ * Register the clockdomains available on a particular OMAP SoC.  Must
+ * be called after clkdm_register_platform_funcs().  May be called
+ * multiple times.  Returns -EACCES if called before
+ * clkdm_register_platform_funcs(); -EINVAL if the argument @cs is
+ * null; or 0 upon success.
  */
-void clkdm_init(struct clockdomain **clkdms,
-		struct clkdm_autodep *init_autodeps,
-		struct clkdm_ops *custom_funcs)
+int clkdm_register_clkdms(struct clockdomain **cs)
 {
 	struct clockdomain **c = NULL;
-	struct clockdomain *clkdm;
-	struct clkdm_autodep *autodep = NULL;
 
-	if (!custom_funcs)
-		WARN(1, "No custom clkdm functions registered\n");
-	else
-		arch_clkdm = custom_funcs;
+	if (!arch_clkdm)
+		return -EACCES;
+
+	if (!cs)
+		return -EINVAL;
+
+	for (c = cs; *c; c++)
+		_clkdm_register(*c);
 
-	if (clkdms)
-		for (c = clkdms; *c; c++)
-			_clkdm_register(*c);
+	return 0;
+}
+
+/**
+ * clkdm_register_autodeps - register autodeps (if required)
+ * @ia: pointer to a static array of struct clkdm_autodep to register
+ *
+ * Register clockdomain "automatic dependencies."  These are
+ * clockdomain wakeup and sleep dependencies that are automatically
+ * added whenever the first clock inside a clockdomain is enabled, and
+ * removed whenever the last clock inside a clockdomain is disabled.
+ * These are currently only used on OMAP3 devices, and are deprecated,
+ * since they waste energy.  However, until the OMAP2/3 IP block
+ * enable/disable sequence can be converted to match the OMAP4
+ * sequence, they are needed.
+ *
+ * Must be called only after all of the SoC clockdomains are
+ * registered, since the function will resolve autodep clockdomain
+ * names into clockdomain pointers.
+ *
+ * The struct clkdm_autodep @ia array must be static, as this function
+ * does not copy the array elements.
+ *
+ * Returns -EACCES if called before any clockdomains have been
+ * registered, -EINVAL if called with a null @ia argument, -EEXIST if
+ * autodeps have already been registered, or 0 upon success.
+ */
+int clkdm_register_autodeps(struct clkdm_autodep *ia)
+{
+	struct clkdm_autodep *a = NULL;
+
+	if (list_empty(&clkdm_list))
+		return -EACCES;
+
+	if (!ia)
+		return -EINVAL;
 
-	autodeps = init_autodeps;
 	if (autodeps)
-		for (autodep = autodeps; autodep->clkdm.ptr; autodep++)
-			_autodep_lookup(autodep);
+		return -EEXIST;
+
+	autodeps = ia;
+	for (a = autodeps; a->clkdm.ptr; a++)
+		_autodep_lookup(a);
+
+	return 0;
+}
+
+/**
+ * clkdm_complete_init - set up the clockdomain layer
+ *
+ * Put all clockdomains into software-supervised mode; PM code should
+ * later enable hardware-supervised mode as appropriate.  Must be
+ * called after clkdm_register_clkdms().  Returns -EACCES if called
+ * before clkdm_register_clkdms(), or 0 upon success.
+ */
+int clkdm_complete_init(void)
+{
+	struct clockdomain *clkdm;
+
+	if (list_empty(&clkdm_list))
+		return -EACCES;
 
-	/*
-	 * Put all clockdomains into software-supervised mode; PM code
-	 * should later enable hardware-supervised mode as appropriate
-	 */
 	list_for_each_entry(clkdm, &clkdm_list, node) {
 		if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
 			clkdm_wakeup(clkdm);
@@ -306,6 +376,8 @@ void clkdm_init(struct clockdomain **clkdms,
 		_resolve_clkdm_deps(clkdm, clkdm->sleepdep_srcs);
 		clkdm_clear_all_sleepdeps(clkdm);
 	}
+
+	return 0;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 1e50c88..0d879ff 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -166,8 +166,11 @@ struct clkdm_ops {
 	int	(*clkdm_clk_disable)(struct clockdomain *clkdm);
 };
 
-void clkdm_init(struct clockdomain **clkdms, struct clkdm_autodep *autodeps,
-			struct clkdm_ops *custom_funcs);
+int clkdm_register_platform_funcs(struct clkdm_ops *co);
+int clkdm_register_autodeps(struct clkdm_autodep *ia);
+int clkdm_register_clkdms(struct clockdomain **c);
+int clkdm_complete_init(void);
+
 struct clockdomain *clkdm_lookup(const char *name);
 
 int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 13bde95..148a3e8 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -857,12 +857,21 @@ static struct clockdomain *clockdomains_omap2[] __initdata = {
 	NULL,
 };
 
+static void __init omap2_3_clockdomains_init(void)
+{
+	clkdm_register_clkdms(clockdomains_omap2);
+	clkdm_register_autodeps(clkdm_autodeps);
+	clkdm_complete_init();
+}
+
 void __init omap2xxx_clockdomains_init(void)
 {
-	clkdm_init(clockdomains_omap2, clkdm_autodeps, &omap2_clkdm_operations);
+	clkdm_register_platform_funcs(&omap2_clkdm_operations);
+	omap2_3_clockdomains_init();
 }
 
 void __init omap3xxx_clockdomains_init(void)
 {
-	clkdm_init(clockdomains_omap2, clkdm_autodeps, &omap3_clkdm_operations);
+	clkdm_register_platform_funcs(&omap3_clkdm_operations);
+	omap2_3_clockdomains_init();
 }
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index dccc651..c75411a 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -685,7 +685,10 @@ static struct clockdomain *clockdomains_omap44xx[] __initdata = {
 	NULL
 };
 
+
 void __init omap44xx_clockdomains_init(void)
 {
-	clkdm_init(clockdomains_omap44xx, NULL, &omap4_clkdm_operations);
+	clkdm_register_platform_funcs(&omap4_clkdm_operations);
+	clkdm_register_clkdms(clockdomains_omap44xx);
+	clkdm_complete_init();
 }


