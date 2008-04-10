From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/5] Powerdomains: add base OMAP2/3 powerdomain code
Date: Thu, 10 Apr 2008 08:46:26 -0600
Message-ID: <20080410153343.932983978@pwsan.com>
References: <20080410144624.246788469@pwsan.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47225 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756259AbYDJRPP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2008 13:15:15 -0400
Content-Disposition: inline; filename=add_base_powerdomain_layer.patch
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds an interface to the powerdomain registers in the
PRM/CM modules on OMAP2/3.  This interface is intended to be used by 
PM code, e.g., pm.c; not by device drivers directly.

Each powerdomain will be defined in later patches as static
structures.  Also definable are dependencies between powerdomains,
used for adding and removing PM_WKDEP and CM_SLEEPDEP bits.  The
powerdomain structures are linked into a list at boot by
pwrdm_register(), similar to the OMAP clock code.

The patch adds a Kconfig option, CONFIG_OMAP_DEBUG_POWERDOMAIN, which 
when enabled will emit verbose debug messages via pr_debug().

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/Makefile            |    2 
 arch/arm/mach-omap2/io.c                |    3 
 arch/arm/mach-omap2/powerdomain.c       |  884 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig              |   12 
 include/asm-arm/arch-omap/powerdomain.h |  137 ++++
 5 files changed, 1037 insertions(+), 1 deletion(-)

Index: linux-omap/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/Makefile	2008-04-10 08:00:56.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/Makefile	2008-04-10 08:00:58.000000000 -0600
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := irq.o id.o io.o memory.o control.o prcm.o clock.o mux.o \
-		devices.o serial.o gpmc.o timer-gp.o
+		devices.o serial.o gpmc.o timer-gp.o powerdomain.o
 
 # Functions loaded to SRAM
 obj-$(CONFIG_ARCH_OMAP2)		+= sram24xx.o
Index: linux-omap/arch/arm/mach-omap2/io.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/io.c	2008-04-10 08:00:56.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/io.c	2008-04-10 08:00:58.000000000 -0600
@@ -27,6 +27,8 @@
 #include <asm/arch/mux.h>
 #include <asm/arch/omapfb.h>
 
+#include <asm/arch/powerdomain.h>
+
 extern void omap_sram_init(void);
 extern int omap2_clk_init(void);
 extern void omap2_check_revision(void);
@@ -188,6 +190,7 @@
 void __init omap2_init_common_hw(void)
 {
 	omap2_mux_init();
+	pwrdm_init(NULL);
 	omap2_clk_init();
 	omap2_init_memory();
 	gpmc_init();
Index: linux-omap/arch/arm/mach-omap2/powerdomain.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap/arch/arm/mach-omap2/powerdomain.c	2008-04-10 08:01:08.000000000 -0600
@@ -0,0 +1,884 @@
+/*
+ * OMAP powerdomain control
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifdef CONFIG_OMAP_DEBUG_POWERDOMAIN
+# define DEBUG
+#endif
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+
+#include <asm/atomic.h>
+
+#include "cm.h"
+#include "cm-regbits-34xx.h"
+#include "prm.h"
+#include "prm-regbits-34xx.h"
+
+#include <asm/arch/cpu.h>
+#include <asm/arch/powerdomain.h>
+
+/* pwrdm_list contains all registered struct powerdomains */
+static LIST_HEAD(pwrdm_list);
+
+/* pwrdm_mutex protects pwrdm_list add and del ops */
+static DEFINE_MUTEX(pwrdm_mutex);
+
+/* Private functions */
+
+static u32 __attribute__((unused)) prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+{
+	u32 v;
+
+	v = prm_read_mod_reg(domain, idx);
+	v &= mask;
+	v >>= __ffs(mask);
+
+	return v;
+}
+
+/* _pwrdm_deps_lookup - look up the specified powerdomain in a pwrdm list */
+static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
+					      const struct pwrdm_dep *deps)
+{
+	const struct pwrdm_dep *pd;
+
+	if (!pwrdm || !deps || !omap_chip_is(pwrdm->omap_chip))
+		return ERR_PTR(-EINVAL);
+
+	for (pd = deps; pd; pd++)
+		if (pd->pwrdm == pwrdm && omap_chip_is(pd->omap_chip))
+			break;
+
+	if (!pd)
+		return ERR_PTR(-ENOENT);
+
+	return pd->pwrdm;
+}
+
+
+/* Public functions */
+
+/**
+ * pwrdm_init - set up the powerdomain layer
+ *
+ *  * Loop through the list of powerdomains, registering all that are
+ * available on the current CPU. If pwrdm_list is supplied and not
+ * null, all of the referenced powerdomains will be registered.	 No
+ * return value.
+ */
+void pwrdm_init(struct powerdomain **pwrdm_list)
+{
+	struct powerdomain **p = NULL;
+
+	if (pwrdm_list)
+		for (p = pwrdm_list; *p; p++)
+			pwrdm_register(*p);
+}
+
+
+/**
+ * pwrdm_register - register a powerdomain
+ * @pwrdm: struct powerdomain * to register
+ *
+ * Adds a powerdomain to the internal powerdomain list.	 Returns
+ * -EINVAL if given a null pointer, -EEXIST if a powerdomain is
+ * already registered by the provided name, or 0 upon success.
+ */
+int pwrdm_register(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (!omap_chip_is(pwrdm->omap_chip))
+		return -EINVAL;
+
+	/* Verify that the powerdomain is not already registered */
+	if (pwrdm_lookup(pwrdm->name))
+		return -EEXIST;
+
+	mutex_lock(&pwrdm_mutex);
+	list_add(&pwrdm->node, &pwrdm_list);
+	mutex_unlock(&pwrdm_mutex);
+
+	pr_debug("powerdomain: registered %s\n", pwrdm->name);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwrdm_register);
+
+/**
+ * pwrdm_unregister - unregister a powerdomain
+ * @pwrdm: struct powerdomain * to unregister
+ *
+ * Removes a powerdomain from the internal powerdomain list.  Returns
+ * -EINVAL if pwrdm argument is NULL.
+ */
+int pwrdm_unregister(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	mutex_lock(&pwrdm_mutex);
+	list_del(&pwrdm->node);
+	mutex_unlock(&pwrdm_mutex);
+
+	pr_debug("powerdomain: unregistered %s\n", pwrdm->name);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwrdm_unregister);
+
+/**
+ * pwrdm_lookup - look up a powerdomain by name, return a pointer
+ * @name: name of powerdomain
+ *
+ * Find a registered powerdomain by its name.  Returns a pointer to the
+ * struct powerdomain if found, or NULL otherwise.
+ */
+struct powerdomain *pwrdm_lookup(const char *name)
+{
+	struct powerdomain *pwrdm, *temp_pwrdm;
+
+	if (!name)
+		return NULL;
+
+	pwrdm = NULL;
+
+	mutex_lock(&pwrdm_mutex);
+	list_for_each_entry(temp_pwrdm, &pwrdm_list, node) {
+		if (!strcmp(name, temp_pwrdm->name)) {
+			pwrdm = temp_pwrdm;
+			break;
+		}
+	}
+	mutex_unlock(&pwrdm_mutex);
+
+	return pwrdm;
+}
+EXPORT_SYMBOL(pwrdm_lookup);
+
+/**
+ * pwrdm_for_each - call function on each registered clockdomain
+ * @fn: callback function *
+ *
+ * Call the supplied function for each registered powerdomain.
+ * The callback function can return anything but 0 to bail
+ * out early from the iterator.	 The callback function is called with
+ * the pwrdm_mutex held, so no powerdomain structure manipulation
+ * functions should be called from the callback, although hardware
+ * powerdomain control functions are fine.  Returns the last return
+ * value of the callback function, which should be 0 for success or
+ * anything else to indicate failure; or -EINVAL if the function pointer
+ * is null.
+ */
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm))
+{
+	struct powerdomain *temp_pwrdm;
+	int ret = 0;
+
+	if (!fn)
+		return -EINVAL;
+
+	mutex_lock(&pwrdm_mutex);
+	list_for_each_entry(temp_pwrdm, &pwrdm_list, node) {
+		ret = (*fn)(temp_pwrdm);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&pwrdm_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(pwrdm_for_each);
+
+/**
+ * pwrdm_add_wkdep - add a wakeup dependency from pwrdm2 to pwrdm1
+ * @pwrdm1: wake this struct powerdomain * up (dependent)
+ * @pwrdm2: when this struct powerdomain * wakes up (source)
+ *
+ * When the powerdomain represented by pwrdm2 wakes up (due to an
+ * interrupt), wake up pwrdm1.	Implemented in hardware on the OMAP,
+ * this feature is designed to reduce wakeup latency of the dependent
+ * powerdomain.	 Returns -EINVAL if presented with invalid powerdomain
+ * pointers, -ENOENT if pwrdm2 cannot wake up pwrdm1 in hardware, or
+ * 0 upon success.
+ */
+int pwrdm_add_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
+{
+	struct powerdomain *p;
+
+	if (!pwrdm1)
+		return -EINVAL;
+
+	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->wkdep_srcs);
+	if (IS_ERR(p)) {
+		pr_debug("powerdomain: hardware cannot set/clear wake up of "
+			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
+		return IS_ERR(p);
+	}
+
+	pr_debug("powerdomain: hardware will wake up %s when %s wakes up\n",
+		 pwrdm1->name, pwrdm2->name);
+
+	prm_set_mod_reg_bits((1 << pwrdm2->dep_bit),
+			     pwrdm1->prcm_offs, PM_WKDEP);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwrdm_add_wkdep);
+
+/**
+ * pwrdm_del_wkdep - remove a wakeup dependency from pwrdm2 to pwrdm1
+ * @pwrdm1: wake this struct powerdomain * up (dependent)
+ * @pwrdm2: when this struct powerdomain * wakes up (source)
+ *
+ * Remove a wakeup dependency that causes pwrdm1 to wake up when pwrdm2
+ * wakes up.  Returns -EINVAL if presented with invalid powerdomain
+ * pointers, -ENOENT if pwrdm2 cannot wake up pwrdm1 in hardware, or
+ * 0 upon success.
+ */
+int pwrdm_del_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
+{
+	struct powerdomain *p;
+
+	if (!pwrdm1)
+		return -EINVAL;
+
+	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->wkdep_srcs);
+	if (IS_ERR(p)) {
+		pr_debug("powerdomain: hardware cannot set/clear wake up of "
+			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
+		return IS_ERR(p);
+	}
+
+	pr_debug("powerdomain: hardware will no longer wake up %s after %s "
+		 "wakes up\n", pwrdm1->name, pwrdm2->name);
+
+	prm_clear_mod_reg_bits((1 << pwrdm2->dep_bit),
+			       pwrdm1->prcm_offs, PM_WKDEP);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwrdm_del_wkdep);
+
+/**
+ * pwrdm_read_wkdep - read wakeup dependency state from pwrdm2 to pwrdm1
+ * @pwrdm1: wake this struct powerdomain * up (dependent)
+ * @pwrdm2: when this struct powerdomain * wakes up (source)
+ *
+ * Return 1 if a hardware wakeup dependency exists wherein pwrdm1 will be
+ * awoken when pwrdm2 wakes up; 0 if dependency is not set; -EINVAL
+ * if either powerdomain pointer is invalid; or -ENOENT if the hardware
+ * is incapable.
+ *
+ * REVISIT: Currently this function only represents software-controllable
+ * wakeup dependencies.	 Wakeup dependencies fixed in hardware are not
+ * yet handled here.
+ */
+int pwrdm_read_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
+{
+	struct powerdomain *p;
+
+	if (!pwrdm1)
+		return -EINVAL;
+
+	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->wkdep_srcs);
+	if (IS_ERR(p)) {
+		pr_debug("powerdomain: hardware cannot set/clear wake up of "
+			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
+		return IS_ERR(p);
+	}
+
+	return prm_read_mod_bits_shift(pwrdm1->prcm_offs, PM_WKDEP,
+					(1 << pwrdm2->dep_bit));
+}
+EXPORT_SYMBOL(pwrdm_read_wkdep);
+
+/**
+ * pwrdm_add_sleepdep - add a sleep dependency from pwrdm2 to pwrdm1
+ * @pwrdm1: prevent this struct powerdomain * from sleeping (dependent)
+ * @pwrdm2: when this struct powerdomain * is active (source)
+ *
+ * Prevent pwrdm1 from automatically going inactive (and then to
+ * retention or off) if pwrdm2 is still active.	 Returns -EINVAL if
+ * presented with invalid powerdomain pointers or called on a machine
+ * that does not support software-configurable hardware sleep dependencies,
+ * -ENOENT if the specified dependency cannot be set in hardware, or
+ * 0 upon success.
+ */
+int pwrdm_add_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
+{
+	struct powerdomain *p;
+
+	if (!pwrdm1)
+		return -EINVAL;
+
+	if (!cpu_is_omap34xx())
+		return -EINVAL;
+
+	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->sleepdep_srcs);
+	if (IS_ERR(p)) {
+		pr_debug("powerdomain: hardware cannot set/clear sleep "
+			 "dependency affecting %s from %s\n", pwrdm1->name,
+			 pwrdm2->name);
+		return IS_ERR(p);
+	}
+
+	pr_debug("powerdomain: will prevent %s from sleeping if %s is active\n",
+		 pwrdm1->name, pwrdm2->name);
+
+	cm_set_mod_reg_bits((1 << pwrdm2->dep_bit),
+			    pwrdm1->prcm_offs, OMAP3430_CM_SLEEPDEP);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwrdm_add_sleepdep);
+
+/**
+ * pwrdm_del_sleepdep - remove a sleep dependency from pwrdm2 to pwrdm1
+ * @pwrdm1: prevent this struct powerdomain * from sleeping (dependent)
+ * @pwrdm2: when this struct powerdomain * is active (source)
+ *
+ * Allow pwrdm1 to automatically go inactive (and then to retention or
+ * off), independent of the activity state of pwrdm2.  Returns -EINVAL
+ * if presented with invalid powerdomain pointers or called on a machine
+ * that does not support software-configurable hardware sleep dependencies,
+ * -ENOENT if the specified dependency cannot be cleared in hardware, or
+ * 0 upon success.
+ */
+int pwrdm_del_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
+{
+	struct powerdomain *p;
+
+	if (!pwrdm1)
+		return -EINVAL;
+
+	if (!cpu_is_omap34xx())
+		return -EINVAL;
+
+	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->sleepdep_srcs);
+	if (IS_ERR(p)) {
+		pr_debug("powerdomain: hardware cannot set/clear sleep "
+			 "dependency affecting %s from %s\n", pwrdm1->name,
+			 pwrdm2->name);
+		return IS_ERR(p);
+	}
+
+	pr_debug("powerdomain: will no longer prevent %s from sleeping if "
+		 "%s is active\n", pwrdm1->name, pwrdm2->name);
+
+	cm_clear_mod_reg_bits((1 << pwrdm2->dep_bit),
+			      pwrdm1->prcm_offs, OMAP3430_CM_SLEEPDEP);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwrdm_del_sleepdep);
+
+/**
+ * pwrdm_read_sleepdep - read sleep dependency state from pwrdm2 to pwrdm1
+ * @pwrdm1: prevent this struct powerdomain * from sleeping (dependent)
+ * @pwrdm2: when this struct powerdomain * is active (source)
+ *
+ * Return 1 if a hardware sleep dependency exists wherein pwrdm1 will
+ * not be allowed to automatically go inactive if pwrdm2 is active;
+ * 0 if pwrdm1's automatic power state inactivity transition is independent
+ * of pwrdm2's; -EINVAL if either powerdomain pointer is invalid or called
+ * on a machine that does not support software-configurable hardware sleep
+ * dependencies; or -ENOENT if the hardware is incapable.
+ *
+ * REVISIT: Currently this function only represents software-controllable
+ * sleep dependencies.	Sleep dependencies fixed in hardware are not
+ * yet handled here.
+ */
+int pwrdm_read_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
+{
+	struct powerdomain *p;
+
+	if (!pwrdm1)
+		return -EINVAL;
+
+	if (!cpu_is_omap34xx())
+		return -EINVAL;
+
+	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->sleepdep_srcs);
+	if (IS_ERR(p)) {
+		pr_debug("powerdomain: hardware cannot set/clear sleep "
+			 "dependency affecting %s from %s\n", pwrdm1->name,
+			 pwrdm2->name);
+		return IS_ERR(p);
+	}
+
+	return prm_read_mod_bits_shift(pwrdm1->prcm_offs, OMAP3430_CM_SLEEPDEP,
+					(1 << pwrdm2->dep_bit));
+}
+EXPORT_SYMBOL(pwrdm_read_sleepdep);
+
+
+/**
+ * pwrdm_set_next_pwrst - set next powerdomain power state
+ * @pwrdm: struct powerdomain * to set
+ * @pwrst: one of the PWRDM_POWER_* macros
+ *
+ * Set the powerdomain pwrdm's next power state to pwrst.  The powerdomain
+ * may not enter this state immediately if the preconditions for this state
+ * have not been satisfied.  Returns -EINVAL if the powerdomain pointer is
+ * null or if the power state is invalid for the powerdomin, or returns 0
+ * upon success.
+ */
+int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (!(pwrdm->pwrsts & (1 << pwrst)))
+		return -EINVAL;
+
+	pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
+		 pwrdm->name, pwrst);
+
+	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
+			     (pwrst << OMAP_POWERSTATE_SHIFT),
+			     pwrdm->prcm_offs, PM_PWSTCTRL);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwrdm_set_next_pwrst);
+
+/**
+ * pwrdm_read_next_pwrst - get next powerdomain power state
+ * @pwrdm: struct powerdomain * to get power state
+ *
+ * Return the powerdomain pwrdm's next power state.  Returns -EINVAL
+ * if the powerdomain pointer is null or returns the next power state
+ * upon success.
+ */
+int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTCTRL,
+					OMAP_POWERSTATE_MASK);
+}
+EXPORT_SYMBOL(pwrdm_read_next_pwrst);
+
+/**
+ * pwrdm_read_pwrst - get current powerdomain power state
+ * @pwrdm: struct powerdomain * to get power state
+ *
+ * Return the powerdomain pwrdm's current power state.	Returns -EINVAL
+ * if the powerdomain pointer is null or returns the current power state
+ * upon success.
+ */
+int pwrdm_read_pwrst(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTST,
+					OMAP_POWERSTATEST_MASK);
+}
+EXPORT_SYMBOL(pwrdm_read_pwrst);
+
+/**
+ * pwrdm_read_prev_pwrst - get previous powerdomain power state
+ * @pwrdm: struct powerdomain * to get previous power state
+ *
+ * Return the powerdomain pwrdm's previous power state.	 Returns -EINVAL
+ * if the powerdomain pointer is null or returns the previous power state
+ * upon success.
+ */
+int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
+					OMAP3430_LASTPOWERSTATEENTERED_MASK);
+}
+EXPORT_SYMBOL(pwrdm_read_prev_pwrst);
+
+/**
+ * pwrdm_set_logic_retst - set powerdomain logic power state upon retention
+ * @pwrdm: struct powerdomain * to set
+ * @pwrst: one of the PWRDM_POWER_* macros
+ *
+ * Set the next power state that the logic portion of the powerdomain
+ * pwrdm will enter when the powerdomain enters retention.  This will
+ * be either RETENTION or OFF, if supported.  Returns -EINVAL if the
+ * powerdomain pointer is null or the target power state is not not
+ * supported, or returns 0 upon success.
+ */
+int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (!(pwrdm->pwrsts_logic_ret & (1 << pwrst)))
+		return -EINVAL;
+
+	pr_debug("powerdomain: setting next logic powerstate for %s to %0x\n",
+		 pwrdm->name, pwrst);
+
+	/*
+	 * The register bit names below may not correspond to the
+	 * actual names of the bits in each powerdomain's register,
+	 * but the type of value returned is the same for each
+	 * powerdomain.
+	 */
+	prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE,
+			     (pwrst << __ffs(OMAP3430_LOGICL1CACHERETSTATE)),
+			     pwrdm->prcm_offs, PM_PWSTCTRL);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwrdm_set_logic_retst);
+
+/**
+ * pwrdm_set_mem_onst - set memory power state while powerdomain ON
+ * @pwrdm: struct powerdomain * to set
+ * @bank: memory bank number to set (0-3)
+ * @pwrst: one of the PWRDM_POWER_* macros
+ *
+ * Set the next power state that memory bank x of the powerdomain
+ * pwrdm will enter when the powerdomain enters the ON state.  Bank
+ * will be a number from 0 to 3, and represents different types of
+ * memory, depending on the powerdomain.  Returns -EINVAL if the
+ * powerdomain pointer is null or the target power state is not not
+ * supported for this memory bank, -EEXIST if the target memory bank
+ * does not exist or is not controllable, or returns 0 upon success.
+ */
+int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
+{
+	u32 m;
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (pwrdm->banks < (bank + 1))
+		return -EEXIST;
+
+	if (!(pwrdm->pwrsts_mem_on[bank] & (1 << pwrst)))
+		return -EINVAL;
+
+	pr_debug("powerdomain: setting next memory powerstate for domain %s "
+		 "bank %0x while pwrdm-ON to %0x\n", pwrdm->name, bank, pwrst);
+
+	/*
+	 * The register bit names below may not correspond to the
+	 * actual names of the bits in each powerdomain's register,
+	 * but the type of value returned is the same for each
+	 * powerdomain.
+	 */
+	switch (bank) {
+	case 0:
+		m = OMAP3430_SHAREDL1CACHEFLATONSTATE_MASK;
+		break;
+	case 1:
+		m = OMAP3430_L1FLATMEMONSTATE_MASK;
+		break;
+	case 2:
+		m = OMAP3430_SHAREDL2CACHEFLATONSTATE_MASK;
+		break;
+	case 3:
+		m = OMAP3430_L2FLATMEMONSTATE_MASK;
+		break;
+	default:
+		WARN_ON(1); /* should never happen */
+		return -EEXIST;
+	}
+
+	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)),
+			     pwrdm->prcm_offs, PM_PWSTCTRL);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwrdm_set_mem_onst);
+
+/**
+ * pwrdm_set_mem_retst - set memory power state while powerdomain in RET
+ * @pwrdm: struct powerdomain * to set
+ * @bank: memory bank number to set (0-3)
+ * @pwrst: one of the PWRDM_POWER_* macros
+ *
+ * Set the next power state that memory bank x of the powerdomain
+ * pwrdm will enter when the powerdomain enters the RETENTION state.
+ * Bank will be a number from 0 to 3, and represents different types
+ * of memory, depending on the powerdomain.  pwrst will be either
+ * RETENTION or OFF, if supported. Returns -EINVAL if the powerdomain
+ * pointer is null or the target power state is not not supported for
+ * this memory bank, -EEXIST if the target memory bank does not exist
+ * or is not controllable, or returns 0 upon success.
+ */
+int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
+{
+	u32 m;
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (pwrdm->banks < (bank + 1))
+		return -EEXIST;
+
+	if (!(pwrdm->pwrsts_mem_ret[bank] & (1 << pwrst)))
+		return -EINVAL;
+
+	pr_debug("powerdomain: setting next memory powerstate for domain %s "
+		 "bank %0x while pwrdm-RET to %0x\n", pwrdm->name, bank, pwrst);
+
+	/*
+	 * The register bit names below may not correspond to the
+	 * actual names of the bits in each powerdomain's register,
+	 * but the type of value returned is the same for each
+	 * powerdomain.
+	 */
+	switch (bank) {
+	case 0:
+		m = OMAP3430_SHAREDL1CACHEFLATRETSTATE;
+		break;
+	case 1:
+		m = OMAP3430_L1FLATMEMRETSTATE;
+		break;
+	case 2:
+		m = OMAP3430_SHAREDL2CACHEFLATRETSTATE;
+		break;
+	case 3:
+		m = OMAP3430_L2FLATMEMRETSTATE;
+		break;
+	default:
+		WARN_ON(1); /* should never happen */
+		return -EEXIST;
+	}
+
+	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
+			     PM_PWSTCTRL);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwrdm_set_mem_retst);
+
+/**
+ * pwrdm_read_logic_pwrst - get current powerdomain logic retention power state
+ * @pwrdm: struct powerdomain * to get current logic retention power state
+ *
+ * Return the current power state that the logic portion of
+ * powerdomain pwrdm will enter
+ * Returns -EINVAL if the powerdomain pointer is null or returns the
+ * current logic retention power state upon success.
+ */
+int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTST,
+					OMAP3430_LOGICSTATEST);
+}
+EXPORT_SYMBOL(pwrdm_read_logic_pwrst);
+
+/**
+ * pwrdm_read_prev_logic_pwrst - get previous powerdomain logic power state
+ * @pwrdm: struct powerdomain * to get previous logic power state
+ *
+ * Return the powerdomain pwrdm's logic power state.  Returns -EINVAL
+ * if the powerdomain pointer is null or returns the previous logic
+ * power state upon success.
+ */
+int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	/*
+	 * The register bit names below may not correspond to the
+	 * actual names of the bits in each powerdomain's register,
+	 * but the type of value returned is the same for each
+	 * powerdomain.
+	 */
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
+					OMAP3430_LASTLOGICSTATEENTERED);
+}
+EXPORT_SYMBOL(pwrdm_read_prev_logic_pwrst);
+
+/**
+ * pwrdm_read_mem_pwrst - get current memory bank power state
+ * @pwrdm: struct powerdomain * to get current memory bank power state
+ * @bank: memory bank number (0-3)
+ *
+ * Return the powerdomain pwrdm's current memory power state for bank
+ * x.  Returns -EINVAL if the powerdomain pointer is null, -EEXIST if
+ * the target memory bank does not exist or is not controllable, or
+ * returns the current memory power state upon success.
+ */
+int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
+{
+	u32 m;
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (pwrdm->banks < (bank + 1))
+		return -EEXIST;
+
+	/*
+	 * The register bit names below may not correspond to the
+	 * actual names of the bits in each powerdomain's register,
+	 * but the type of value returned is the same for each
+	 * powerdomain.
+	 */
+	switch (bank) {
+	case 0:
+		m = OMAP3430_SHAREDL1CACHEFLATSTATEST_MASK;
+		break;
+	case 1:
+		m = OMAP3430_L1FLATMEMSTATEST_MASK;
+		break;
+	case 2:
+		m = OMAP3430_SHAREDL2CACHEFLATSTATEST_MASK;
+		break;
+	case 3:
+		m = OMAP3430_L2FLATMEMSTATEST_MASK;
+		break;
+	default:
+		WARN_ON(1); /* should never happen */
+		return -EEXIST;
+	}
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTST, m);
+}
+EXPORT_SYMBOL(pwrdm_read_mem_pwrst);
+
+/**
+ * pwrdm_read_prev_mem_pwrst - get previous memory bank power state
+ * @pwrdm: struct powerdomain * to get previous memory bank power state
+ * @bank: memory bank number (0-3)
+ *
+ * Return the powerdomain pwrdm's previous memory power state for bank
+ * x.  Returns -EINVAL if the powerdomain pointer is null, -EEXIST if
+ * the target memory bank does not exist or is not controllable, or
+ * returns the previous memory power state upon success.
+ */
+int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
+{
+	u32 m;
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (pwrdm->banks < (bank + 1))
+		return -EEXIST;
+
+	/*
+	 * The register bit names below may not correspond to the actual
+	 * names of the bits in each powerdomain's register,
+	 * but the type of value returned is the same for each powerdomain.
+	 */
+	switch (bank) {
+	case 0:
+		m = OMAP3430_LASTMEM1STATEENTERED_MASK;
+		break;
+	case 1:
+		m = OMAP3430_LASTMEM2STATEENTERED_MASK;
+		break;
+	case 2:
+		m = OMAP3430_LASTSHAREDL2CACHEFLATSTATEENTERED_MASK;
+		break;
+	case 3:
+		m = OMAP3430_LASTL2FLATMEMSTATEENTERED_MASK;
+		break;
+	default:
+		WARN_ON(1); /* should never happen */
+		return -EEXIST;
+	}
+
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					OMAP3430_PM_PREPWSTST, m);
+}
+EXPORT_SYMBOL(pwrdm_read_prev_mem_pwrst);
+
+/**
+ * pwrdm_clear_all_prev_pwrst - clear previous powerstate register for a pwrdm
+ * @pwrdm: struct powerdomain * to clear
+ *
+ * Clear the powerdomain's previous power state register.  Clears the
+ * entire register, including logic and memory bank previous power states.
+ * Returns -EINVAL if the powerdomain pointer is null, or returns 0 upon
+ * success.
+ */
+int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	/*
+	 * XXX should get the powerdomain's current state here;
+	 * warn & fail if it is not ON.
+	 */
+
+	pr_debug("powerdomain: clearing previous power state reg for %s\n",
+		 pwrdm->name);
+
+	prm_write_mod_reg(0, pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwrdm_clear_all_prev_pwrst);
+
+/**
+ * pwrdm_wait_transition - wait for powerdomain power transition to finish
+ * @pwrdm: struct powerdomain * to wait for
+ *
+ * If the powerdomain pwrdm is in the process of a state transition,
+ * spin until it completes the power transition, or until an iteration
+ * bailout value is reached. Returns -EINVAL if the powerdomain
+ * pointer is null, -EAGAIN if the bailout value was reached, or
+ * returns 0 upon success.
+ */
+int pwrdm_wait_transition(struct powerdomain *pwrdm)
+{
+	u32 c = 0;
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	/*
+	 * REVISIT: pwrdm_wait_transition() may be better implemented
+	 * via a callback and a periodic timer check -- how long do we expect
+	 * powerdomain transitions to take?
+	 */
+
+	/* XXX Is this udelay() value meaningful? */
+	while ((prm_read_mod_reg(pwrdm->prcm_offs, PM_PWSTST) &
+		OMAP_INTRANSITION) &&
+	       (c++ < PWRDM_TRANSITION_BAILOUT))
+		udelay(1);
+
+	if (c >= PWRDM_TRANSITION_BAILOUT) {
+		printk(KERN_ERR "powerdomain: waited too long for "
+		       "powerdomain %s to complete transition\n", pwrdm->name);
+		return -EAGAIN;
+	}
+
+	pr_debug("powerdomain: completed transition in %d loops\n", c);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwrdm_wait_transition);
+
+
Index: linux-omap/arch/arm/plat-omap/Kconfig
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/Kconfig	2008-04-10 08:00:56.000000000 -0600
+++ linux-omap/arch/arm/plat-omap/Kconfig	2008-04-10 08:00:58.000000000 -0600
@@ -42,6 +42,18 @@
 	  confident in your SRAM code, disabling this will save
 	  about 600 bytes.
 
+config OMAP_DEBUG_POWERDOMAIN
+	bool "Emit debug messages from powerdomain layer"
+	depends on ARCH_OMAP2 || ARCH_OMAP3
+	default n
+	help
+	  Say Y here if you want to compile in powerdomain layer
+	  debugging messages for OMAP2/3.   These messages can
+	  provide more detail as to why some powerdomain calls
+	  may be failing, and will also emit a descriptive message
+	  for every powerdomain register write.  However, the
+	  extra detail costs some memory.
+
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
 	depends on ARCH_OMAP
Index: linux-omap/include/asm-arm/arch-omap/powerdomain.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap/include/asm-arm/arch-omap/powerdomain.h	2008-04-10 08:00:58.000000000 -0600
@@ -0,0 +1,137 @@
+/*
+ * OMAP2/3 powerdomain control
+ *
+ * Copyright (C) 2007-8 Texas Instruments, Inc.
+ * Copyright (C) 2007-8 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ASM_ARM_ARCH_OMAP_POWERDOMAIN
+#define ASM_ARM_ARCH_OMAP_POWERDOMAIN
+
+#include <linux/types.h>
+#include <linux/list.h>
+
+#include <asm/atomic.h>
+
+#include <asm/arch/cpu.h>
+
+
+/* Powerdomain basic power states */
+#define PWRDM_POWER_OFF		0x0
+#define PWRDM_POWER_RET		0x1
+#define PWRDM_POWER_INACTIVE	0x2
+#define PWRDM_POWER_ON		0x3
+
+/* Powerdomain allowable state bitfields */
+#define PWRSTS_OFF_ON		((1 << PWRDM_POWER_OFF) | \
+				 (1 << PWRDM_POWER_ON))
+
+#define PWRSTS_OFF_RET		((1 << PWRDM_POWER_OFF) | \
+				 (1 << PWRDM_POWER_RET))
+
+#define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | (1 << PWRDM_POWER_ON))
+
+
+/*
+ * Number of memory banks that are power-controllable.	On OMAP3430, the
+ * maximum is 4.
+ */
+#define PWRDM_MAX_MEM_BANKS	4
+
+/* XXX A completely arbitrary number. What is reasonable here? */
+#define PWRDM_TRANSITION_BAILOUT 100000
+
+struct powerdomain;
+
+/* Encodes dependencies between powerdomains - statically defined */
+struct pwrdm_dep {
+
+	struct powerdomain *pwrdm;
+
+	/* Flags to mark OMAP chip restrictions, etc. */
+	const omap_chip_t omap_chip;
+
+};
+
+struct powerdomain {
+
+	/* Powerdomain name */
+	const char *name;
+
+	/* the address offset from CM_BASE/PRM_BASE */
+	const s16 prcm_offs;
+
+	/* Used to represent the OMAP chip types containing this pwrdm */
+	const omap_chip_t omap_chip;
+
+	/* Bit shift of this powerdomain's PM_WKDEP/CM_SLEEPDEP bit */
+	const u8 dep_bit;
+
+	/* Powerdomains that can be told to wake this powerdomain up */
+	const struct pwrdm_dep *wkdep_srcs;
+
+	/* Powerdomains that can be told to keep this pwrdm from inactivity */
+	const struct pwrdm_dep *sleepdep_srcs;
+
+	/* Possible powerdomain power states */
+	const u8 pwrsts;
+
+	/* Possible logic power states when pwrdm in RETENTION */
+	const u8 pwrsts_logic_ret;
+
+	/* Number of software-controllable memory banks in this powerdomain */
+	const u8 banks;
+
+	/* Possible memory bank pwrstates when pwrdm in RETENTION */
+	const u8 pwrsts_mem_ret[PWRDM_MAX_MEM_BANKS];
+
+	/* Possible memory bank pwrstates when pwrdm is ON */
+	const u8 pwrsts_mem_on[PWRDM_MAX_MEM_BANKS];
+
+	/* List of clockdomains in this powerdomain */
+	struct list_head pwrdm_clkdms;
+
+	struct kobject *kobj;
+	struct list_head node;
+
+};
+
+
+void pwrdm_init(struct powerdomain **pwrdm_list);
+
+int pwrdm_register(struct powerdomain *pwrdm);
+int pwrdm_unregister(struct powerdomain *pwrdm);
+struct powerdomain *pwrdm_lookup(const char *name);
+
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm));
+
+int pwrdm_add_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
+int pwrdm_del_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
+int pwrdm_read_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
+int pwrdm_add_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
+int pwrdm_del_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
+int pwrdm_read_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
+
+int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
+int pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm);
+int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
+
+int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
+int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
+int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
+
+int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
+int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
+
+int pwrdm_wait_transition(struct powerdomain *pwrdm);
+
+#endif

-- 

