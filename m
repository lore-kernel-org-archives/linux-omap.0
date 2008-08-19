From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/10] ARM: OMAP2: Clockdomain: Add base OMAP2/3 clockdomain code
Date: Tue, 19 Aug 2008 11:39:56 +0300
Message-ID: <1219135201-10282-6-git-send-email-tony@atomide.com>
References: <20080818163429.GF16455@flint.arm.linux.org.uk>
 <1219135201-10282-1-git-send-email-tony@atomide.com>
 <1219135201-10282-2-git-send-email-tony@atomide.com>
 <1219135201-10282-3-git-send-email-tony@atomide.com>
 <1219135201-10282-4-git-send-email-tony@atomide.com>
 <1219135201-10282-5-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63521 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbYHSIkW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 04:40:22 -0400
In-Reply-To: <1219135201-10282-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

=46rom: Paul Walmsley <paul@pwsan.com>

This patch creates an interface to the clockdomain registers in the
PRM/CM modules on OMAP2/3.  This interface is intended to be used by
PM code, e.g., pm.c; not by device drivers directly.

The patch also adds clockdomain usecount tracking.  This is intended
to be called whenever the first clock in a clockdomain is enabled, or
when the last enabled clock in a clockdomain is disabled.  If the
clockdomain is in software-supervised mode, the code will force-wakeup
or force-sleep the clockdomain.  If the clockdomain is in
hardware-supervised mode, the first clock enable will add sleep and
wakeup dependencies on a user-selectable set of parent domains (usually
MPU & IVA2), and the disable will remove them.

Each clockdomain will be defined in later patches as static
structures.  The clockdomain structures are linked into a list at boot
by clkdm_register(), similar to the OMAP clock code.

The patch adds a Kconfig option, CONFIG_OMAP_DEBUG_CLOCKDOMAIN, which
when enabled will emit verbose debug messages via pr_debug().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index 1001d42..e7cf1b4 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,8 @@
=20
 # Common support
 obj-y :=3D irq.o id.o io.o memory.o control.o prcm.o clock.o mux.o \
-		devices.o serial.o gpmc.o timer-gp.o powerdomain.o
+		devices.o serial.o gpmc.o timer-gp.o powerdomain.o \
+		clockdomain.o
=20
 obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
=20
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/cl=
ockdomain.c
new file mode 100644
index 0000000..f867d8f
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -0,0 +1,603 @@
+/*
+ * OMAP2/3 clockdomain framework functions
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Written by Paul Walmsley and Jouni H=C3=B6gander
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifdef CONFIG_OMAP_DEBUG_CLOCKDOMAIN
+#  define DEBUG
+#endif
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/limits.h>
+
+#include <linux/io.h>
+
+#include <linux/bitops.h>
+
+#include <mach/clock.h>
+
+#include "prm.h"
+#include "prm-regbits-24xx.h"
+#include "cm.h"
+
+#include <mach/powerdomain.h>
+#include <mach/clockdomain.h>
+
+/* clkdm_list contains all registered struct clockdomains */
+static LIST_HEAD(clkdm_list);
+
+/* clkdm_mutex protects clkdm_list add and del ops */
+static DEFINE_MUTEX(clkdm_mutex);
+
+/* array of powerdomain deps to be added/removed when clkdm in hwsup m=
ode */
+static struct clkdm_pwrdm_autodep *autodeps;
+
+
+/* Private functions */
+
+/*
+ * _autodep_lookup - resolve autodep pwrdm names to pwrdm pointers; st=
ore
+ * @autodep: struct clkdm_pwrdm_autodep * to resolve
+ *
+ * Resolve autodep powerdomain names to powerdomain pointers via
+ * pwrdm_lookup() and store the pointers in the autodep structure.  An
+ * "autodep" is a powerdomain sleep/wakeup dependency that is
+ * automatically added and removed whenever clocks in the associated
+ * clockdomain are enabled or disabled (respectively) when the
+ * clockdomain is in hardware-supervised mode.	Meant to be called
+ * once at clockdomain layer initialization, since these should remain
+ * fixed for a particular architecture.  No return value.
+ */
+static void _autodep_lookup(struct clkdm_pwrdm_autodep *autodep)
+{
+	struct powerdomain *pwrdm;
+
+	if (!autodep)
+		return;
+
+	if (!omap_chip_is(autodep->omap_chip))
+		return;
+
+	pwrdm =3D pwrdm_lookup(autodep->pwrdm_name);
+	if (!pwrdm) {
+		pr_debug("clockdomain: _autodep_lookup: powerdomain %s "
+			 "does not exist\n", autodep->pwrdm_name);
+		WARN_ON(1);
+		return;
+	}
+	autodep->pwrdm =3D pwrdm;
+
+	return;
+}
+
+/*
+ * _clkdm_add_autodeps - add auto sleepdeps/wkdeps to clkdm upon clock=
 enable
+ * @clkdm: struct clockdomain *
+ *
+ * Add the "autodep" sleep & wakeup dependencies to clockdomain 'clkdm=
'
+ * in hardware-supervised mode.  Meant to be called from clock framewo=
rk
+ * when a clock inside clockdomain 'clkdm' is enabled.	No return value=
=2E
+ */
+static void _clkdm_add_autodeps(struct clockdomain *clkdm)
+{
+	struct clkdm_pwrdm_autodep *autodep;
+
+	for (autodep =3D autodeps; autodep->pwrdm_name; autodep++) {
+		if (!autodep->pwrdm)
+			continue;
+
+		pr_debug("clockdomain: adding %s sleepdep/wkdep for "
+			 "pwrdm %s\n", autodep->pwrdm_name,
+			 clkdm->pwrdm->name);
+
+		pwrdm_add_sleepdep(clkdm->pwrdm, autodep->pwrdm);
+		pwrdm_add_wkdep(clkdm->pwrdm, autodep->pwrdm);
+	}
+}
+
+/*
+ * _clkdm_add_autodeps - remove auto sleepdeps/wkdeps from clkdm
+ * @clkdm: struct clockdomain *
+ *
+ * Remove the "autodep" sleep & wakeup dependencies from clockdomain '=
clkdm'
+ * in hardware-supervised mode.  Meant to be called from clock framewo=
rk
+ * when a clock inside clockdomain 'clkdm' is disabled.  No return val=
ue.
+ */
+static void _clkdm_del_autodeps(struct clockdomain *clkdm)
+{
+	struct clkdm_pwrdm_autodep *autodep;
+
+	for (autodep =3D autodeps; autodep->pwrdm_name; autodep++) {
+		if (!autodep->pwrdm)
+			continue;
+
+		pr_debug("clockdomain: removing %s sleepdep/wkdep for "
+			 "pwrdm %s\n", autodep->pwrdm_name,
+			 clkdm->pwrdm->name);
+
+		pwrdm_del_sleepdep(clkdm->pwrdm, autodep->pwrdm);
+		pwrdm_del_wkdep(clkdm->pwrdm, autodep->pwrdm);
+	}
+}
+
+
+static struct clockdomain *_clkdm_lookup(const char *name)
+{
+	struct clockdomain *clkdm, *temp_clkdm;
+
+	if (!name)
+		return NULL;
+
+	clkdm =3D NULL;
+
+	list_for_each_entry(temp_clkdm, &clkdm_list, node) {
+		if (!strcmp(name, temp_clkdm->name)) {
+			clkdm =3D temp_clkdm;
+			break;
+		}
+	}
+
+	return clkdm;
+}
+
+
+/* Public functions */
+
+/**
+ * clkdm_init - set up the clockdomain layer
+ * @clkdms: optional pointer to an array of clockdomains to register
+ * @init_autodeps: optional pointer to an array of autodeps to registe=
r
+ *
+ * Set up internal state.  If a pointer to an array of clockdomains
+ * was supplied, loop through the list of clockdomains, register all
+ * that are available on the current platform.	Similarly, if a
+ * pointer to an array of clockdomain-powerdomain autodependencies was
+ * provided, register those.  No return value.
+ */
+void clkdm_init(struct clockdomain **clkdms,
+		struct clkdm_pwrdm_autodep *init_autodeps)
+{
+	struct clockdomain **c =3D NULL;
+	struct clkdm_pwrdm_autodep *autodep =3D NULL;
+
+	if (clkdms)
+		for (c =3D clkdms; *c; c++)
+			clkdm_register(*c);
+
+	autodeps =3D init_autodeps;
+	if (autodeps)
+		for (autodep =3D autodeps; autodep->pwrdm_name; autodep++)
+			_autodep_lookup(autodep);
+}
+
+/**
+ * clkdm_register - register a clockdomain
+ * @clkdm: struct clockdomain * to register
+ *
+ * Adds a clockdomain to the internal clockdomain list.
+ * Returns -EINVAL if given a null pointer, -EEXIST if a clockdomain i=
s
+ * already registered by the provided name, or 0 upon success.
+ */
+int clkdm_register(struct clockdomain *clkdm)
+{
+	int ret =3D -EINVAL;
+	struct powerdomain *pwrdm;
+
+	if (!clkdm || !clkdm->name)
+		return -EINVAL;
+
+	if (!omap_chip_is(clkdm->omap_chip))
+		return -EINVAL;
+
+	pwrdm =3D pwrdm_lookup(clkdm->pwrdm_name);
+	if (!pwrdm) {
+		pr_debug("clockdomain: clkdm_register %s: powerdomain %s "
+			 "does not exist\n", clkdm->name, clkdm->pwrdm_name);
+		return -EINVAL;
+	}
+	clkdm->pwrdm =3D pwrdm;
+
+	mutex_lock(&clkdm_mutex);
+	/* Verify that the clockdomain is not already registered */
+	if (_clkdm_lookup(clkdm->name)) {
+		ret =3D -EEXIST;
+		goto cr_unlock;
+	};
+
+	list_add(&clkdm->node, &clkdm_list);
+
+	pr_debug("clockdomain: registered %s\n", clkdm->name);
+	ret =3D 0;
+
+cr_unlock:
+	mutex_unlock(&clkdm_mutex);
+
+	return ret;
+}
+
+/**
+ * clkdm_unregister - unregister a clockdomain
+ * @clkdm: struct clockdomain * to unregister
+ *
+ * Removes a clockdomain from the internal clockdomain list.  Returns
+ * -EINVAL if clkdm argument is NULL.
+ */
+int clkdm_unregister(struct clockdomain *clkdm)
+{
+	if (!clkdm)
+		return -EINVAL;
+
+	mutex_lock(&clkdm_mutex);
+	list_del(&clkdm->node);
+	mutex_unlock(&clkdm_mutex);
+
+	pr_debug("clockdomain: unregistered %s\n", clkdm->name);
+
+	return 0;
+}
+
+/**
+ * clkdm_lookup - look up a clockdomain by name, return a pointer
+ * @name: name of clockdomain
+ *
+ * Find a registered clockdomain by its name.  Returns a pointer to th=
e
+ * struct clockdomain if found, or NULL otherwise.
+ */
+struct clockdomain *clkdm_lookup(const char *name)
+{
+	struct clockdomain *clkdm, *temp_clkdm;
+
+	if (!name)
+		return NULL;
+
+	clkdm =3D NULL;
+
+	mutex_lock(&clkdm_mutex);
+	list_for_each_entry(temp_clkdm, &clkdm_list, node) {
+		if (!strcmp(name, temp_clkdm->name)) {
+			clkdm =3D temp_clkdm;
+			break;
+		}
+	}
+	mutex_unlock(&clkdm_mutex);
+
+	return clkdm;
+}
+
+/**
+ * clkdm_for_each - call function on each registered clockdomain
+ * @fn: callback function *
+ *
+ * Call the supplied function for each registered clockdomain.
+ * The callback function can return anything but 0 to bail
+ * out early from the iterator.  The callback function is called with
+ * the clkdm_mutex held, so no clockdomain structure manipulation
+ * functions should be called from the callback, although hardware
+ * clockdomain control functions are fine.  Returns the last return
+ * value of the callback function, which should be 0 for success or
+ * anything else to indicate failure; or -EINVAL if the function point=
er
+ * is null.
+ */
+int clkdm_for_each(int (*fn)(struct clockdomain *clkdm))
+{
+	struct clockdomain *clkdm;
+	int ret =3D 0;
+
+	if (!fn)
+		return -EINVAL;
+
+	mutex_lock(&clkdm_mutex);
+	list_for_each_entry(clkdm, &clkdm_list, node) {
+		ret =3D (*fn)(clkdm);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&clkdm_mutex);
+
+	return ret;
+}
+
+
+/* Hardware clockdomain control */
+
+/**
+ * omap2_clkdm_clktrctrl_read - read the clkdm's current state transit=
ion mode
+ * @clk: struct clk * of a clockdomain
+ *
+ * Return the clockdomain's current state transition mode from the
+ * corresponding domain CM_CLKSTCTRL register.	Returns -EINVAL if clk
+ * is NULL or the current mode upon success.
+ */
+static int omap2_clkdm_clktrctrl_read(struct clockdomain *clkdm)
+{
+	u32 v;
+
+	if (!clkdm)
+		return -EINVAL;
+
+	v =3D cm_read_mod_reg(clkdm->pwrdm->prcm_offs, CM_CLKSTCTRL);
+	v &=3D clkdm->clktrctrl_mask;
+	v >>=3D __ffs(clkdm->clktrctrl_mask);
+
+	return v;
+}
+
+/**
+ * omap2_clkdm_sleep - force clockdomain sleep transition
+ * @clkdm: struct clockdomain *
+ *
+ * Instruct the CM to force a sleep transition on the specified
+ * clockdomain 'clkdm'.  Returns -EINVAL if clk is NULL or if
+ * clockdomain does not support software-initiated sleep; 0 upon
+ * success.
+ */
+int omap2_clkdm_sleep(struct clockdomain *clkdm)
+{
+	if (!clkdm)
+		return -EINVAL;
+
+	if (!(clkdm->flags & CLKDM_CAN_FORCE_SLEEP)) {
+		pr_debug("clockdomain: %s does not support forcing "
+			 "sleep via software\n", clkdm->name);
+		return -EINVAL;
+	}
+
+	pr_debug("clockdomain: forcing sleep on %s\n", clkdm->name);
+
+	if (cpu_is_omap24xx()) {
+
+		cm_set_mod_reg_bits(OMAP24XX_FORCESTATE,
+				    clkdm->pwrdm->prcm_offs, PM_PWSTCTRL);
+
+	} else if (cpu_is_omap34xx()) {
+
+		u32 v =3D (OMAP34XX_CLKSTCTRL_FORCE_SLEEP <<
+			 __ffs(clkdm->clktrctrl_mask));
+
+		cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask, v,
+				    clkdm->pwrdm->prcm_offs, CM_CLKSTCTRL);
+
+	} else {
+		BUG();
+	};
+
+	return 0;
+}
+
+/**
+ * omap2_clkdm_wakeup - force clockdomain wakeup transition
+ * @clkdm: struct clockdomain *
+ *
+ * Instruct the CM to force a wakeup transition on the specified
+ * clockdomain 'clkdm'.  Returns -EINVAL if clkdm is NULL or if the
+ * clockdomain does not support software-controlled wakeup; 0 upon
+ * success.
+ */
+int omap2_clkdm_wakeup(struct clockdomain *clkdm)
+{
+	if (!clkdm)
+		return -EINVAL;
+
+	if (!(clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)) {
+		pr_debug("clockdomain: %s does not support forcing "
+			 "wakeup via software\n", clkdm->name);
+		return -EINVAL;
+	}
+
+	pr_debug("clockdomain: forcing wakeup on %s\n", clkdm->name);
+
+	if (cpu_is_omap24xx()) {
+
+		cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE,
+				      clkdm->pwrdm->prcm_offs, PM_PWSTCTRL);
+
+	} else if (cpu_is_omap34xx()) {
+
+		u32 v =3D (OMAP34XX_CLKSTCTRL_FORCE_WAKEUP <<
+			 __ffs(clkdm->clktrctrl_mask));
+
+		cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask, v,
+				    clkdm->pwrdm->prcm_offs, CM_CLKSTCTRL);
+
+	} else {
+		BUG();
+	};
+
+	return 0;
+}
+
+/**
+ * omap2_clkdm_allow_idle - enable hwsup idle transitions for clkdm
+ * @clkdm: struct clockdomain *
+ *
+ * Allow the hardware to automatically switch the clockdomain into
+ * active or idle states, as needed by downstream clocks.  If the
+ * clockdomain has any downstream clocks enabled in the clock
+ * framework, wkdep/sleepdep autodependencies are added; this is so
+ * device drivers can read and write to the device.  No return value.
+ */
+void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
+{
+	u32 v;
+
+	if (!clkdm)
+		return;
+
+	if (!(clkdm->flags & CLKDM_CAN_ENABLE_AUTO)) {
+		pr_debug("clock: automatic idle transitions cannot be enabled "
+			 "on clockdomain %s\n", clkdm->name);
+		return;
+	}
+
+	pr_debug("clockdomain: enabling automatic idle transitions for %s\n",
+		 clkdm->name);
+
+	if (atomic_read(&clkdm->usecount) > 0)
+		_clkdm_add_autodeps(clkdm);
+
+	if (cpu_is_omap24xx())
+		v =3D OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
+	else if (cpu_is_omap34xx())
+		v =3D OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
+	else
+		BUG();
+
+
+	cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask,
+			    v << __ffs(clkdm->clktrctrl_mask),
+			    clkdm->pwrdm->prcm_offs,
+			    CM_CLKSTCTRL);
+}
+
+/**
+ * omap2_clkdm_deny_idle - disable hwsup idle transitions for clkdm
+ * @clkdm: struct clockdomain *
+ *
+ * Prevent the hardware from automatically switching the clockdomain
+ * into inactive or idle states.  If the clockdomain has downstream
+ * clocks enabled in the clock framework, wkdep/sleepdep
+ * autodependencies are removed.  No return value.
+ */
+void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
+{
+	u32 v;
+
+	if (!clkdm)
+		return;
+
+	if (!(clkdm->flags & CLKDM_CAN_DISABLE_AUTO)) {
+		pr_debug("clockdomain: automatic idle transitions cannot be "
+			 "disabled on %s\n", clkdm->name);
+		return;
+	}
+
+	pr_debug("clockdomain: disabling automatic idle transitions for %s\n"=
,
+		 clkdm->name);
+
+	if (cpu_is_omap24xx())
+		v =3D OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
+	else if (cpu_is_omap34xx())
+		v =3D OMAP34XX_CLKSTCTRL_DISABLE_AUTO;
+	else
+		BUG();
+
+	cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask,
+			    v << __ffs(clkdm->clktrctrl_mask),
+			    clkdm->pwrdm->prcm_offs, CM_CLKSTCTRL);
+
+	if (atomic_read(&clkdm->usecount) > 0)
+		_clkdm_del_autodeps(clkdm);
+}
+
+
+/* Clockdomain-to-clock framework interface code */
+
+/**
+ * omap2_clkdm_clk_enable - add an enabled downstream clock to this cl=
kdm
+ * @clkdm: struct clockdomain *
+ * @clk: struct clk * of the enabled downstream clock
+ *
+ * Increment the usecount of this clockdomain 'clkdm' and ensure that
+ * it is awake.  Intended to be called by clk_enable() code.  If the
+ * clockdomain is in software-supervised idle mode, force the
+ * clockdomain to wake.  If the clockdomain is in hardware-supervised
+ * idle mode, add clkdm-pwrdm autodependencies, to ensure that devices
+ * in the clockdomain can be read from/written to by on-chip processor=
s.
+ * Returns -EINVAL if passed null pointers; returns 0 upon success or
+ * if the clockdomain is in hwsup idle mode.
+ */
+int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
+{
+	int v;
+
+	/*
+	 * XXX Rewrite this code to maintain a list of enabled
+	 * downstream clocks for debugging purposes?
+	 */
+
+	if (!clkdm || !clk)
+		return -EINVAL;
+
+	if (atomic_inc_return(&clkdm->usecount) > 1)
+		return 0;
+
+	/* Clockdomain now has one enabled downstream clock */
+
+	pr_debug("clockdomain: clkdm %s: clk %s now enabled\n", clkdm->name,
+		 clk->name);
+
+	v =3D omap2_clkdm_clktrctrl_read(clkdm);
+
+	if ((cpu_is_omap34xx() && v =3D=3D OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ||
+	    (cpu_is_omap24xx() && v =3D=3D OMAP24XX_CLKSTCTRL_ENABLE_AUTO))
+		_clkdm_add_autodeps(clkdm);
+	else
+		omap2_clkdm_wakeup(clkdm);
+
+	return 0;
+}
+
+/**
+ * omap2_clkdm_clk_disable - remove an enabled downstream clock from t=
his clkdm
+ * @clkdm: struct clockdomain *
+ * @clk: struct clk * of the disabled downstream clock
+ *
+ * Decrement the usecount of this clockdomain 'clkdm'. Intended to be
+ * called by clk_disable() code.  If the usecount goes to 0, put the
+ * clockdomain to sleep (software-supervised mode) or remove the
+ * clkdm-pwrdm autodependencies (hardware-supervised mode).  Returns
+ * -EINVAL if passed null pointers; -ERANGE if the clkdm usecount
+ * underflows and debugging is enabled; or returns 0 upon success or
+ * if the clockdomain is in hwsup idle mode.
+ */
+int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk=
)
+{
+	int v;
+
+	/*
+	 * XXX Rewrite this code to maintain a list of enabled
+	 * downstream clocks for debugging purposes?
+	 */
+
+	if (!clkdm || !clk)
+		return -EINVAL;
+
+#ifdef DEBUG
+	if (atomic_read(&clkdm->usecount) =3D=3D 0) {
+		WARN_ON(1); /* underflow */
+		return -ERANGE;
+	}
+#endif
+
+	if (atomic_dec_return(&clkdm->usecount) > 0)
+		return 0;
+
+	/* All downstream clocks of this clockdomain are now disabled */
+
+	pr_debug("clockdomain: clkdm %s: clk %s now disabled\n", clkdm->name,
+		 clk->name);
+
+	v =3D omap2_clkdm_clktrctrl_read(clkdm);
+
+	if ((cpu_is_omap34xx() && v =3D=3D OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ||
+	    (cpu_is_omap24xx() && v =3D=3D OMAP24XX_CLKSTCTRL_ENABLE_AUTO))
+		_clkdm_del_autodeps(clkdm);
+	else
+		omap2_clkdm_sleep(clkdm);
+
+	return 0;
+}
+
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index e815fa3..ef62bf2 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -41,6 +41,18 @@ config OMAP_DEBUG_POWERDOMAIN
 	  for every powerdomain register write.  However, the
 	  extra detail costs some memory.
=20
+config OMAP_DEBUG_CLOCKDOMAIN
+	bool "Emit debug messages from clockdomain layer"
+	depends on ARCH_OMAP2 || ARCH_OMAP3
+	default n
+	help
+	  Say Y here if you want to compile in clockdomain layer
+	  debugging messages for OMAP2/3.   These messages can
+	  provide more detail as to why some clockdomain calls
+	  may be failing, and will also emit a descriptive message
+	  for every clockdomain register write.  However, the
+	  extra detail costs some memory.
+
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
 	depends on ARCH_OMAP
diff --git a/arch/arm/plat-omap/include/mach/clockdomain.h b/arch/arm/p=
lat-omap/include/mach/clockdomain.h
new file mode 100644
index 0000000..1f51f01
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/clockdomain.h
@@ -0,0 +1,106 @@
+/*
+ * linux/include/asm-arm/arch-omap/clockdomain.h
+ *
+ * OMAP2/3 clockdomain framework functions
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARM_ARCH_OMAP_CLOCKDOMAIN_H
+#define __ASM_ARM_ARCH_OMAP_CLOCKDOMAIN_H
+
+#include <mach/powerdomain.h>
+#include <mach/clock.h>
+#include <mach/cpu.h>
+
+/* Clockdomain capability flags */
+#define CLKDM_CAN_FORCE_SLEEP			(1 << 0)
+#define CLKDM_CAN_FORCE_WAKEUP			(1 << 1)
+#define CLKDM_CAN_ENABLE_AUTO			(1 << 2)
+#define CLKDM_CAN_DISABLE_AUTO			(1 << 3)
+
+#define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AU=
TO)
+#define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKE=
UP)
+#define CLKDM_CAN_HWSUP_SWSUP	(CLKDM_CAN_SWSUP | CLKDM_CAN_HWSUP)
+
+/* OMAP24XX CM_CLKSTCTRL_*.AUTOSTATE_* register bit values */
+#define OMAP24XX_CLKSTCTRL_DISABLE_AUTO		0x0
+#define OMAP24XX_CLKSTCTRL_ENABLE_AUTO		0x1
+
+/* OMAP3XXX CM_CLKSTCTRL_*.CLKTRCTRL_* register bit values */
+#define OMAP34XX_CLKSTCTRL_DISABLE_AUTO		0x0
+#define OMAP34XX_CLKSTCTRL_FORCE_SLEEP		0x1
+#define OMAP34XX_CLKSTCTRL_FORCE_WAKEUP		0x2
+#define OMAP34XX_CLKSTCTRL_ENABLE_AUTO		0x3
+
+/*
+ * struct clkdm_pwrdm_autodep - a powerdomain that should have wkdeps
+ * and sleepdeps added when a powerdomain should stay active in hwsup =
mode;
+ * and conversely, removed when the powerdomain should be allowed to g=
o
+ * inactive in hwsup mode.
+ */
+struct clkdm_pwrdm_autodep {
+
+	/* Name of the powerdomain to add a wkdep/sleepdep on */
+	const char *pwrdm_name;
+
+	/* Powerdomain pointer (looked up at clkdm_init() time) */
+	struct powerdomain *pwrdm;
+
+	/* OMAP chip types that this clockdomain dep is valid on */
+	const struct omap_chip_id omap_chip;
+
+};
+
+struct clockdomain {
+
+	/* Clockdomain name */
+	const char *name;
+
+	/* Powerdomain enclosing this clockdomain */
+	const char *pwrdm_name;
+
+	/* CLKTRCTRL/AUTOSTATE field mask in CM_CLKSTCTRL reg */
+	const u16 clktrctrl_mask;
+
+	/* Clockdomain capability flags */
+	const u8 flags;
+
+	/* OMAP chip types that this clockdomain is valid on */
+	const struct omap_chip_id omap_chip;
+
+	/* Usecount tracking */
+	atomic_t usecount;
+
+	/* Powerdomain pointer assigned at clkdm_register() */
+	struct powerdomain *pwrdm;
+
+	struct list_head node;
+
+};
+
+void clkdm_init(struct clockdomain **clkdms, struct clkdm_pwrdm_autode=
p *autodeps);
+int clkdm_register(struct clockdomain *clkdm);
+int clkdm_unregister(struct clockdomain *clkdm);
+struct clockdomain *clkdm_lookup(const char *name);
+
+int clkdm_for_each(int (*fn)(struct clockdomain *clkdm));
+struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
+
+void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
+void omap2_clkdm_deny_idle(struct clockdomain *clkdm);
+
+int omap2_clkdm_wakeup(struct clockdomain *clkdm);
+int omap2_clkdm_sleep(struct clockdomain *clkdm);
+
+int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)=
;
+int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk=
);
+
+#endif
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
