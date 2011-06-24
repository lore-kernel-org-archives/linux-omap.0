From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 6/7] OMAP2+: clockdomain: Add 2 APIs to control clockdomain from hwmod framework
Date: Fri, 24 Jun 2011 14:06:32 +0200
Message-ID: <1308917193-16912-7-git-send-email-b-cousson@ti.com>
References: <1308917193-16912-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54280 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753573Ab1FXMIn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 08:08:43 -0400
In-Reply-To: <1308917193-16912-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Duplicate the existing API for clockdomain enable from clock to enable
a clock domain from hwmod framework.
This will be needed when the hwmod framework will move from the current
clock centric approach to the module based approach.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |  150 +++++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/clockdomain.h |    3 +
 2 files changed, 124 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 2ab3686..7add49e 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -817,7 +817,48 @@ int clkdm_is_idle(struct clockdomain *clkdm)
 }
 
 
-/* Clockdomain-to-clock framework interface code */
+/* Clockdomain-to-clock/hwmod framework interface code */
+
+static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
+{
+	if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_enable)
+		return -EINVAL;
+
+	/*
+	 * For arch's with no autodeps, clkcm_clk_enable
+	 * should be called for every clock instance or hwmod that is
+	 * enabled, so the clkdm can be force woken up.
+	 */
+	if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps)
+		return 0;
+
+	arch_clkdm->clkdm_clk_enable(clkdm);
+	pwrdm_wait_transition(clkdm->pwrdm.ptr);
+	pwrdm_clkdm_state_switch(clkdm);
+
+	return 0;
+}
+
+static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
+{
+	if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
+		return -EINVAL;
+
+#ifdef DEBUG
+	if (atomic_read(&clkdm->usecount) == 0) {
+		WARN_ON(1); /* underflow */
+		return -ERANGE;
+	}
+#endif
+
+	if (atomic_dec_return(&clkdm->usecount) > 0)
+		return 0;
+
+	arch_clkdm->clkdm_clk_disable(clkdm);
+	pwrdm_clkdm_state_switch(clkdm);
+
+	return 0;
+}
 
 /**
  * clkdm_clk_enable - add an enabled downstream clock to this clkdm
@@ -835,30 +876,23 @@ int clkdm_is_idle(struct clockdomain *clkdm)
  */
 int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 {
+	int ret = 0;
+
 	/*
 	 * XXX Rewrite this code to maintain a list of enabled
 	 * downstream clocks for debugging purposes?
 	 */
 
-	if (!clkdm || !clk)
+	if (!clk)
 		return -EINVAL;
 
-	if (!arch_clkdm || !arch_clkdm->clkdm_clk_enable)
-		return -EINVAL;
-
-	if (atomic_inc_return(&clkdm->usecount) > 1)
-		return 0;
+	ret = _clkdm_clk_hwmod_enable(clkdm);
 
 	/* Clockdomain now has one enabled downstream clock */
-
 	pr_debug("clockdomain: clkdm %s: clk %s now enabled\n", clkdm->name,
 		 clk->name);
 
-	arch_clkdm->clkdm_clk_enable(clkdm);
-	pwrdm_wait_transition(clkdm->pwrdm.ptr);
-	pwrdm_clkdm_state_switch(clkdm);
-
-	return 0;
+	return ret;
 }
 
 /**
@@ -877,35 +911,93 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
  */
 int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 {
+	int ret = 0;
+
 	/*
 	 * XXX Rewrite this code to maintain a list of enabled
 	 * downstream clocks for debugging purposes?
 	 */
 
-	if (!clkdm || !clk)
+	if (!clk)
 		return -EINVAL;
 
-	if (!arch_clkdm || !arch_clkdm->clkdm_clk_disable)
+	ret = _clkdm_clk_hwmod_disable(clkdm);
+
+	/* All downstream clocks of this clockdomain are now disabled */
+	pr_debug("clockdomain: clkdm %s: clk %s now disabled\n", clkdm->name,
+		 clk->name);
+
+	return ret;
+}
+
+/**
+ * clkdm_hwmod_enable - add an enabled downstream hwmod to this clkdm
+ * @clkdm: struct clockdomain *
+ * @oh: struct omap_hwmod * of the enabled downstream hwmod
+ *
+ * Increment the usecount of the clockdomain @clkdm and ensure that it
+ * is awake before @oh is enabled. Intended to be called by
+ * module_enable() code.
+ * If the clockdomain is in software-supervised idle mode, force the
+ * clockdomain to wake.  If the clockdomain is in hardware-supervised idle
+ * mode, add clkdm-pwrdm autodependencies, to ensure that devices in the
+ * clockdomain can be read from/written to by on-chip processors.
+ * Returns -EINVAL if passed null pointers;
+ * returns 0 upon success or if the clockdomain is in hwsup idle mode.
+ */
+int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh)
+{
+	int ret = 0;
+
+	/*
+	 * XXX Rewrite this code to maintain a list of enabled
+	 * downstream hwmods for debugging purposes?
+	 */
+
+	if (!oh)
 		return -EINVAL;
 
-#ifdef DEBUG
-	if (atomic_read(&clkdm->usecount) == 0) {
-		WARN_ON(1); /* underflow */
-		return -ERANGE;
-	}
-#endif
+	ret = _clkdm_clk_hwmod_enable(clkdm);
 
-	if (atomic_dec_return(&clkdm->usecount) > 0)
-		return 0;
+	/* Clockdomain now has one enabled downstream hwmod */
+	pr_debug("clockdomain: clkdm %s: oh %s now enabled\n", clkdm->name,
+		 oh->name);
 
-	/* All downstream clocks of this clockdomain are now disabled */
+	return ret;
+}
 
-	pr_debug("clockdomain: clkdm %s: clk %s now disabled\n", clkdm->name,
-		 clk->name);
+/**
+ * clkdm_hwmod_disable - remove an enabled downstream hwmod from this clkdm
+ * @clkdm: struct clockdomain *
+ * @oh: struct omap_hwmod * of the disabled downstream hwmod
+ *
+ * Decrement the usecount of this clockdomain @clkdm when @oh is
+ * disabled. Intended to be called by module_disable() code.
+ * If the clockdomain usecount goes to 0, put the clockdomain to sleep
+ * (software-supervised mode) or remove the clkdm autodependencies
+ * (hardware-supervised mode).
+ * Returns -EINVAL if passed null pointers; -ERANGE if the @clkdm usecount
+ * underflows and debugging is enabled; or returns 0 upon success or if the
+ * clockdomain is in hwsup idle mode.
+ */
+int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
+{
+	int ret = 0;
 
-	arch_clkdm->clkdm_clk_disable(clkdm);
-	pwrdm_clkdm_state_switch(clkdm);
+	/*
+	 * XXX Rewrite this code to maintain a list of enabled
+	 * downstream hwmods for debugging purposes?
+	 */
 
-	return 0;
+	if (!oh)
+		return -EINVAL;
+
+	ret = _clkdm_clk_hwmod_disable(clkdm);
+
+	/* All downstream hwmods of this clockdomain are now disabled */
+	pr_debug("clockdomain: clkdm %s: oh %s now disabled\n", clkdm->name,
+		 oh->name);
+
+	return ret;
 }
 
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 085ed82..77244b3 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -20,6 +20,7 @@
 
 #include "powerdomain.h"
 #include <plat/clock.h>
+#include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
 
 /*
@@ -186,6 +187,8 @@ int clkdm_sleep(struct clockdomain *clkdm);
 
 int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
 int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
+int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh);
+int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh);
 
 extern void __init omap2xxx_clockdomains_init(void);
 extern void __init omap3xxx_clockdomains_init(void);
-- 
1.7.0.4

