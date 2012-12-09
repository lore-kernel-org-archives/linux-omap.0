From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/10] ARM: OMAP2+: powerdomain/clockdomain: add a
 per-powerdomain spinlock
Date: Sat, 08 Dec 2012 18:23:41 -0700
Message-ID: <20121209012340.19716.62316.stgit@dusk.lan>
References: <20121209011755.19716.25244.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39005 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932302Ab2LIBYd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Dec 2012 20:24:33 -0500
In-Reply-To: <20121209011755.19716.25244.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <jean.pihet@newoldbits.com>

Add a per-powerdomain spinlock.  Use that instead of the clockdomain
spinlock.  Add pwrdm_lock()/pwrdm_unlock() functions to allow other
code to acquire or release the powerdomain spinlock without reaching
directly into the struct powerdomain.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>
---
 arch/arm/mach-omap2/clockdomain-powerdomain.h |   22 +++
 arch/arm/mach-omap2/clockdomain.c             |  161 +++++++++++++++++--------
 arch/arm/mach-omap2/clockdomain.h             |    6 +
 arch/arm/mach-omap2/powerdomain-clockdomain.h |   27 ++++
 arch/arm/mach-omap2/powerdomain.c             |   56 ++++++++-
 arch/arm/mach-omap2/powerdomain.h             |   11 +-
 6 files changed, 219 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain-powerdomain.h
 create mode 100644 arch/arm/mach-omap2/powerdomain-clockdomain.h

diff --git a/arch/arm/mach-omap2/clockdomain-powerdomain.h b/arch/arm/mach-omap2/clockdomain-powerdomain.h
new file mode 100644
index 0000000..8beee2d
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomain-powerdomain.h
@@ -0,0 +1,22 @@
+/*
+ * OMAP clockdomain framework functions for use only by the powerdomain code
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_POWERDOMAIN_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_POWERDOMAIN_H
+
+#include "clockdomain.h"
+
+extern void clkdm_allow_idle_nolock(struct clockdomain *clkdm);
+extern void clkdm_deny_idle_nolock(struct clockdomain *clkdm);
+extern int clkdm_wakeup_nolock(struct clockdomain *clkdm);
+extern int clkdm_sleep_nolock(struct clockdomain *clkdm);
+
+#endif
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 18f65fd..2142dab 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -30,6 +30,7 @@
 #include "soc.h"
 #include "clock.h"
 #include "clockdomain.h"
+#include "powerdomain-clockdomain.h"
 
 /* clkdm_list contains all registered struct clockdomains */
 static LIST_HEAD(clkdm_list);
@@ -91,8 +92,6 @@ static int _clkdm_register(struct clockdomain *clkdm)
 
 	pwrdm_add_clkdm(pwrdm, clkdm);
 
-	spin_lock_init(&clkdm->lock);
-
 	pr_debug("clockdomain: registered %s\n", clkdm->name);
 
 	return 0;
@@ -733,18 +732,17 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
 }
 
 /**
- * clkdm_sleep - force clockdomain sleep transition
+ * clkdm_sleep_nolock - force clockdomain sleep transition (lockless)
  * @clkdm: struct clockdomain *
  *
  * Instruct the CM to force a sleep transition on the specified
- * clockdomain @clkdm.  Returns -EINVAL if @clkdm is NULL or if
- * clockdomain does not support software-initiated sleep; 0 upon
- * success.
+ * clockdomain @clkdm.  Only for use by the powerdomain code.  Returns
+ * -EINVAL if @clkdm is NULL or if clockdomain does not support
+ * software-initiated sleep; 0 upon success.
  */
-int clkdm_sleep(struct clockdomain *clkdm)
+int clkdm_sleep_nolock(struct clockdomain *clkdm)
 {
 	int ret;
-	unsigned long flags;
 
 	if (!clkdm)
 		return -EINVAL;
@@ -760,27 +758,45 @@ int clkdm_sleep(struct clockdomain *clkdm)
 
 	pr_debug("clockdomain: forcing sleep on %s\n", clkdm->name);
 
-	spin_lock_irqsave(&clkdm->lock, flags);
 	clkdm->_flags &= ~_CLKDM_FLAG_HWSUP_ENABLED;
 	ret = arch_clkdm->clkdm_sleep(clkdm);
-	ret |= pwrdm_state_switch(clkdm->pwrdm.ptr);
-	spin_unlock_irqrestore(&clkdm->lock, flags);
+	ret |= pwrdm_state_switch_nolock(clkdm->pwrdm.ptr);
+
 	return ret;
 }
 
 /**
- * clkdm_wakeup - force clockdomain wakeup transition
+ * clkdm_sleep - force clockdomain sleep transition
  * @clkdm: struct clockdomain *
  *
- * Instruct the CM to force a wakeup transition on the specified
- * clockdomain @clkdm.  Returns -EINVAL if @clkdm is NULL or if the
- * clockdomain does not support software-controlled wakeup; 0 upon
+ * Instruct the CM to force a sleep transition on the specified
+ * clockdomain @clkdm.  Returns -EINVAL if @clkdm is NULL or if
+ * clockdomain does not support software-initiated sleep; 0 upon
  * success.
  */
-int clkdm_wakeup(struct clockdomain *clkdm)
+int clkdm_sleep(struct clockdomain *clkdm)
+{
+	int ret;
+
+	pwrdm_lock(clkdm->pwrdm.ptr);
+	ret = clkdm_sleep_nolock(clkdm);
+	pwrdm_unlock(clkdm->pwrdm.ptr);
+
+	return ret;
+}
+
+/**
+ * clkdm_wakeup_nolock - force clockdomain wakeup transition (lockless)
+ * @clkdm: struct clockdomain *
+ *
+ * Instruct the CM to force a wakeup transition on the specified
+ * clockdomain @clkdm.  Only for use by the powerdomain code.  Returns
+ * -EINVAL if @clkdm is NULL or if the clockdomain does not support
+ * software-controlled wakeup; 0 upon success.
+ */
+int clkdm_wakeup_nolock(struct clockdomain *clkdm)
 {
 	int ret;
-	unsigned long flags;
 
 	if (!clkdm)
 		return -EINVAL;
@@ -796,28 +812,46 @@ int clkdm_wakeup(struct clockdomain *clkdm)
 
 	pr_debug("clockdomain: forcing wakeup on %s\n", clkdm->name);
 
-	spin_lock_irqsave(&clkdm->lock, flags);
 	clkdm->_flags &= ~_CLKDM_FLAG_HWSUP_ENABLED;
 	ret = arch_clkdm->clkdm_wakeup(clkdm);
-	ret |= pwrdm_state_switch(clkdm->pwrdm.ptr);
-	spin_unlock_irqrestore(&clkdm->lock, flags);
+	ret |= pwrdm_state_switch_nolock(clkdm->pwrdm.ptr);
+
 	return ret;
 }
 
 /**
- * clkdm_allow_idle - enable hwsup idle transitions for clkdm
+ * clkdm_wakeup - force clockdomain wakeup transition
  * @clkdm: struct clockdomain *
  *
- * Allow the hardware to automatically switch the clockdomain @clkdm into
- * active or idle states, as needed by downstream clocks.  If the
+ * Instruct the CM to force a wakeup transition on the specified
+ * clockdomain @clkdm.  Returns -EINVAL if @clkdm is NULL or if the
+ * clockdomain does not support software-controlled wakeup; 0 upon
+ * success.
+ */
+int clkdm_wakeup(struct clockdomain *clkdm)
+{
+	int ret;
+
+	pwrdm_lock(clkdm->pwrdm.ptr);
+	ret = clkdm_wakeup_nolock(clkdm);
+	pwrdm_unlock(clkdm->pwrdm.ptr);
+
+	return ret;
+}
+
+/**
+ * clkdm_allow_idle_nolock - enable hwsup idle transitions for clkdm
+ * @clkdm: struct clockdomain *
+ *
+ * Allow the hardware to automatically switch the clockdomain @clkdm
+ * into active or idle states, as needed by downstream clocks.  If the
  * clockdomain has any downstream clocks enabled in the clock
  * framework, wkdep/sleepdep autodependencies are added; this is so
- * device drivers can read and write to the device.  No return value.
+ * device drivers can read and write to the device.  Only for use by
+ * the powerdomain code.  No return value.
  */
-void clkdm_allow_idle(struct clockdomain *clkdm)
+void clkdm_allow_idle_nolock(struct clockdomain *clkdm)
 {
-	unsigned long flags;
-
 	if (!clkdm)
 		return;
 
@@ -833,11 +867,26 @@ void clkdm_allow_idle(struct clockdomain *clkdm)
 	pr_debug("clockdomain: enabling automatic idle transitions for %s\n",
 		 clkdm->name);
 
-	spin_lock_irqsave(&clkdm->lock, flags);
 	clkdm->_flags |= _CLKDM_FLAG_HWSUP_ENABLED;
 	arch_clkdm->clkdm_allow_idle(clkdm);
-	pwrdm_state_switch(clkdm->pwrdm.ptr);
-	spin_unlock_irqrestore(&clkdm->lock, flags);
+	pwrdm_state_switch_nolock(clkdm->pwrdm.ptr);
+}
+
+/**
+ * clkdm_allow_idle - enable hwsup idle transitions for clkdm
+ * @clkdm: struct clockdomain *
+ *
+ * Allow the hardware to automatically switch the clockdomain @clkdm into
+ * active or idle states, as needed by downstream clocks.  If the
+ * clockdomain has any downstream clocks enabled in the clock
+ * framework, wkdep/sleepdep autodependencies are added; this is so
+ * device drivers can read and write to the device.  No return value.
+ */
+void clkdm_allow_idle(struct clockdomain *clkdm)
+{
+	pwrdm_lock(clkdm->pwrdm.ptr);
+	clkdm_allow_idle_nolock(clkdm);
+	pwrdm_unlock(clkdm->pwrdm.ptr);
 }
 
 /**
@@ -847,12 +896,11 @@ void clkdm_allow_idle(struct clockdomain *clkdm)
  * Prevent the hardware from automatically switching the clockdomain
  * @clkdm into inactive or idle states.  If the clockdomain has
  * downstream clocks enabled in the clock framework, wkdep/sleepdep
- * autodependencies are removed.  No return value.
+ * autodependencies are removed.  Only for use by the powerdomain
+ * code.  No return value.
  */
-void clkdm_deny_idle(struct clockdomain *clkdm)
+void clkdm_deny_idle_nolock(struct clockdomain *clkdm)
 {
-	unsigned long flags;
-
 	if (!clkdm)
 		return;
 
@@ -868,11 +916,25 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
 	pr_debug("clockdomain: disabling automatic idle transitions for %s\n",
 		 clkdm->name);
 
-	spin_lock_irqsave(&clkdm->lock, flags);
 	clkdm->_flags &= ~_CLKDM_FLAG_HWSUP_ENABLED;
 	arch_clkdm->clkdm_deny_idle(clkdm);
-	pwrdm_state_switch(clkdm->pwrdm.ptr);
-	spin_unlock_irqrestore(&clkdm->lock, flags);
+	pwrdm_state_switch_nolock(clkdm->pwrdm.ptr);
+}
+
+/**
+ * clkdm_deny_idle - disable hwsup idle transitions for clkdm
+ * @clkdm: struct clockdomain *
+ *
+ * Prevent the hardware from automatically switching the clockdomain
+ * @clkdm into inactive or idle states.  If the clockdomain has
+ * downstream clocks enabled in the clock framework, wkdep/sleepdep
+ * autodependencies are removed.  No return value.
+ */
+void clkdm_deny_idle(struct clockdomain *clkdm)
+{
+	pwrdm_lock(clkdm->pwrdm.ptr);
+	clkdm_deny_idle_nolock(clkdm);
+	pwrdm_unlock(clkdm->pwrdm.ptr);
 }
 
 /**
@@ -889,14 +951,11 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
 bool clkdm_in_hwsup(struct clockdomain *clkdm)
 {
 	bool ret;
-	unsigned long flags;
 
 	if (!clkdm)
 		return false;
 
-	spin_lock_irqsave(&clkdm->lock, flags);
 	ret = (clkdm->_flags & _CLKDM_FLAG_HWSUP_ENABLED) ? true : false;
-	spin_unlock_irqrestore(&clkdm->lock, flags);
 
 	return ret;
 }
@@ -922,12 +981,10 @@ bool clkdm_missing_idle_reporting(struct clockdomain *clkdm)
 
 static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 {
-	unsigned long flags;
-
 	if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_enable)
 		return -EINVAL;
 
-	spin_lock_irqsave(&clkdm->lock, flags);
+	pwrdm_lock(clkdm->pwrdm.ptr);
 
 	/*
 	 * For arch's with no autodeps, clkcm_clk_enable
@@ -935,13 +992,13 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 	 * enabled, so the clkdm can be force woken up.
 	 */
 	if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps) {
-		spin_unlock_irqrestore(&clkdm->lock, flags);
+		pwrdm_unlock(clkdm->pwrdm.ptr);
 		return 0;
 	}
 
 	arch_clkdm->clkdm_clk_enable(clkdm);
-	pwrdm_state_switch(clkdm->pwrdm.ptr);
-	spin_unlock_irqrestore(&clkdm->lock, flags);
+	pwrdm_state_switch_nolock(clkdm->pwrdm.ptr);
+	pwrdm_unlock(clkdm->pwrdm.ptr);
 
 	pr_debug("clockdomain: %s: enabled\n", clkdm->name);
 
@@ -950,27 +1007,25 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 
 static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
 {
-	unsigned long flags;
-
 	if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
 		return -EINVAL;
 
-	spin_lock_irqsave(&clkdm->lock, flags);
+	pwrdm_lock(clkdm->pwrdm.ptr);
 
 	if (atomic_read(&clkdm->usecount) == 0) {
-		spin_unlock_irqrestore(&clkdm->lock, flags);
+		pwrdm_unlock(clkdm->pwrdm.ptr);
 		WARN_ON(1); /* underflow */
 		return -ERANGE;
 	}
 
 	if (atomic_dec_return(&clkdm->usecount) > 0) {
-		spin_unlock_irqrestore(&clkdm->lock, flags);
+		pwrdm_unlock(clkdm->pwrdm.ptr);
 		return 0;
 	}
 
 	arch_clkdm->clkdm_clk_disable(clkdm);
-	pwrdm_state_switch(clkdm->pwrdm.ptr);
-	spin_unlock_irqrestore(&clkdm->lock, flags);
+	pwrdm_state_switch_nolock(clkdm->pwrdm.ptr);
+	pwrdm_unlock(clkdm->pwrdm.ptr);
 
 	pr_debug("clockdomain: %s: disabled\n", clkdm->name);
 
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index bc42446..e7f1b4b 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -15,7 +15,6 @@
 #define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_H
 
 #include <linux/init.h>
-#include <linux/spinlock.h>
 
 #include "powerdomain.h"
 #include "clock.h"
@@ -139,7 +138,6 @@ struct clockdomain {
 	struct clkdm_dep *sleepdep_srcs;
 	atomic_t usecount;
 	struct list_head node;
-	spinlock_t lock;
 };
 
 /**
@@ -196,12 +194,16 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
 
+void clkdm_allow_idle_nolock(struct clockdomain *clkdm);
 void clkdm_allow_idle(struct clockdomain *clkdm);
+void clkdm_deny_idle_nolock(struct clockdomain *clkdm);
 void clkdm_deny_idle(struct clockdomain *clkdm);
 bool clkdm_in_hwsup(struct clockdomain *clkdm);
 bool clkdm_missing_idle_reporting(struct clockdomain *clkdm);
 
+int clkdm_wakeup_nolock(struct clockdomain *clkdm);
 int clkdm_wakeup(struct clockdomain *clkdm);
+int clkdm_sleep_nolock(struct clockdomain *clkdm);
 int clkdm_sleep(struct clockdomain *clkdm);
 
 int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
diff --git a/arch/arm/mach-omap2/powerdomain-clockdomain.h b/arch/arm/mach-omap2/powerdomain-clockdomain.h
new file mode 100644
index 0000000..e404eec
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomain-clockdomain.h
@@ -0,0 +1,27 @@
+/*
+ * OMAP powerdomain functions only for use by the OMAP clockdomain code
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * The point of this file is to try to prevent other code outside of
+ * clockdomain.c from calling the functions listed herein.  Yes, this
+ * means you.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_CLOCKDOMAIN_H
+#define __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_CLOCKDOMAIN_H
+
+#include <linux/types.h>
+
+#include "powerdomain.h"
+
+extern void pwrdm_lock(struct powerdomain *pwrdm);
+extern void pwrdm_unlock(struct powerdomain *pwrdm);
+extern int pwrdm_state_switch_nolock(struct powerdomain *pwrdm);
+
+#endif
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 05f00660..2a5f15b 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -19,6 +19,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/spinlock.h>
 #include <trace/events/power.h>
 
 #include "cm2xxx_3xxx.h"
@@ -31,6 +32,7 @@
 
 #include "powerdomain.h"
 #include "clockdomain.h"
+#include "clockdomain-powerdomain.h"
 
 #include "soc.h"
 #include "pm.h"
@@ -101,6 +103,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	pwrdm->voltdm.ptr = voltdm;
 	INIT_LIST_HEAD(&pwrdm->voltdm_node);
 	voltdm_add_pwrdm(voltdm, pwrdm);
+	spin_lock_init(&pwrdm->_lock);
 
 	list_add(&pwrdm->node, &pwrdm_list);
 
@@ -276,6 +279,30 @@ int pwrdm_complete_init(void)
 }
 
 /**
+ * pwrdm_lock - acquire a Linux spinlock on a powerdomain
+ * @pwrdm: struct powerdomain * to lock
+ *
+ * Acquire the powerdomain spinlock on @pwrdm.  No return value.
+ */
+void pwrdm_lock(struct powerdomain *pwrdm)
+	__acquires(&pwrdm->_lock)
+{
+	spin_lock_irqsave(&pwrdm->_lock, pwrdm->_lock_flags);
+}
+
+/**
+ * pwrdm_unlock - release a Linux spinlock on a powerdomain
+ * @pwrdm: struct powerdomain * to unlock
+ *
+ * Release the powerdomain spinlock on @pwrdm.  No return value.
+ */
+void pwrdm_unlock(struct powerdomain *pwrdm)
+	__releases(&pwrdm->_lock)
+{
+	spin_unlock_irqrestore(&pwrdm->_lock, pwrdm->_lock_flags);
+}
+
+/**
  * pwrdm_lookup - look up a powerdomain by name, return a pointer
  * @name: name of powerdomain
  *
@@ -921,7 +948,7 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
 	return (pwrdm && pwrdm->flags & PWRDM_HAS_HDWR_SAR) ? 1 : 0;
 }
 
-int pwrdm_state_switch(struct powerdomain *pwrdm)
+int pwrdm_state_switch_nolock(struct powerdomain *pwrdm)
 {
 	int ret;
 
@@ -935,6 +962,17 @@ int pwrdm_state_switch(struct powerdomain *pwrdm)
 	return ret;
 }
 
+int __deprecated pwrdm_state_switch(struct powerdomain *pwrdm)
+{
+	int ret;
+
+	pwrdm_lock(pwrdm);
+	ret = pwrdm_state_switch_nolock(pwrdm);
+	pwrdm_unlock(pwrdm);
+
+	return ret;
+}
+
 int pwrdm_pre_transition(struct powerdomain *pwrdm)
 {
 	if (pwrdm)
@@ -973,7 +1011,7 @@ static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,
 			sleep_switch = LOWPOWERSTATE_SWITCH;
 		} else {
 			*hwsup = clkdm_in_hwsup(pwrdm->pwrdm_clkdms[0]);
-			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
+			clkdm_wakeup_nolock(pwrdm->pwrdm_clkdms[0]);
 			sleep_switch = FORCEWAKEUP_SWITCH;
 		}
 	} else {
@@ -989,15 +1027,15 @@ static void _pwrdm_restore_clkdm_state(struct powerdomain *pwrdm,
 	switch (sleep_switch) {
 	case FORCEWAKEUP_SWITCH:
 		if (hwsup)
-			clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+			clkdm_allow_idle_nolock(pwrdm->pwrdm_clkdms[0]);
 		else
-			clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
+			clkdm_sleep_nolock(pwrdm->pwrdm_clkdms[0]);
 		break;
 	case LOWPOWERSTATE_SWITCH:
 		if (pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE &&
 		    arch_pwrdm->pwrdm_set_lowpwrstchange)
 			arch_pwrdm->pwrdm_set_lowpwrstchange(pwrdm);
-		pwrdm_state_switch(pwrdm);
+		pwrdm_state_switch_nolock(pwrdm);
 		break;
 	}
 }
@@ -1021,9 +1059,13 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
 		pwrst--;
 	}
 
+	pwrdm_lock(pwrdm);
+
 	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
-	if (next_pwrst == pwrst)
+	if (next_pwrst == pwrst) {
+		pwrdm_unlock(pwrdm);
 		return ret;
+	}
 
 	sleep_switch = _pwrdm_save_clkdm_state_and_activate(pwrdm, pwrst,
 							    &hwsup);
@@ -1035,6 +1077,8 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
 
 	_pwrdm_restore_clkdm_state(pwrdm, sleep_switch, hwsup);
 
+	pwrdm_unlock(pwrdm);
+
 	return ret;
 }
 
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 1edb3b7..83b4892 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -19,8 +19,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
-
-#include <linux/atomic.h>
+#include <linux/spinlock.h>
 
 #include "voltage.h"
 
@@ -103,6 +102,8 @@ struct powerdomain;
  * @state_counter:
  * @timer:
  * @state_timer:
+ * @_lock: spinlock used to serialize powerdomain and some clockdomain ops
+ * @_lock_flags: stored flags when @_lock is taken
  *
  * @prcm_partition possible values are defined in mach-omap2/prcm44xx.h.
  */
@@ -127,7 +128,8 @@ struct powerdomain {
 	unsigned state_counter[PWRDM_MAX_PWRSTS];
 	unsigned ret_logic_off_counter;
 	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
-
+	spinlock_t _lock;
+	unsigned long _lock_flags;
 	const u8 pwrstctrl_offs;
 	const u8 pwrstst_offs;
 	const u32 logicretstate_mask;
@@ -225,6 +227,7 @@ int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm);
 int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
 bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
 
+int pwrdm_state_switch_nolock(struct powerdomain *pwrdm);
 int pwrdm_state_switch(struct powerdomain *pwrdm);
 int pwrdm_pre_transition(struct powerdomain *pwrdm);
 int pwrdm_post_transition(struct powerdomain *pwrdm);
@@ -252,5 +255,7 @@ extern u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank);
 extern struct powerdomain wkup_omap2_pwrdm;
 extern struct powerdomain gfx_omap2_pwrdm;
 
+extern void pwrdm_lock(struct powerdomain *pwrdm);
+extern void pwrdm_unlock(struct powerdomain *pwrdm);
 
 #endif


