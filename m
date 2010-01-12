From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/10] OMAP2/3 clkdm/pwrdm: move wkdep/sleepdep handling from
	pwrdm to clkdm
Date: Mon, 11 Jan 2010 18:05:34 -0700
Message-ID: <20100112010531.6275.88841.stgit@localhost.localdomain>
References: <20100112010258.6275.97999.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45278 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532Ab0ALBQV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 20:16:21 -0500
In-Reply-To: <20100112010258.6275.97999.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Move clockdomain wakeup dependency and sleep dependency data
structures from the powerdomain layer to the clockdomain layer, where
they belong.  These dependencies were originally placed in the
powerdomain layer due to unclear documentation; however, it is clear
now that these dependencies are between clockdomains.  For OMAP2/3,
this is not such a big problem, but for OMAP4 this needs to be fixed.

Thanks to Beno=C3=AEt Cousson <b-cousson@ti.com> for his advice on this
patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c             |  368 +++++++++++++++++=
+++----
 arch/arm/mach-omap2/clockdomains.h            |  378 +++++++++++++++++=
+++++++-
 arch/arm/mach-omap2/io.c                      |    2=20
 arch/arm/mach-omap2/omap_hwmod.c              |   10 -
 arch/arm/mach-omap2/pm34xx.c                  |   10 +
 arch/arm/mach-omap2/powerdomain.c             |  259 -----------------
 arch/arm/mach-omap2/powerdomains.h            |   88 +-----
 arch/arm/mach-omap2/powerdomains24xx.h        |   87 ------
 arch/arm/mach-omap2/powerdomains34xx.h        |  145 ----------
 arch/arm/mach-omap2/prcm.c                    |   12 +
 arch/arm/plat-omap/include/plat/clockdomain.h |   50 +++
 arch/arm/plat-omap/include/plat/powerdomain.h |   34 --
 arch/arm/plat-omap/include/plat/prcm.h        |    8 +
 13 files changed, 761 insertions(+), 690 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/cl=
ockdomain.c
index 8c9e78c..a70ba29 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -27,14 +27,14 @@
=20
 #include <linux/bitops.h>
=20
-#include <plat/clock.h>
-
 #include "prm.h"
 #include "prm-regbits-24xx.h"
 #include "cm.h"
=20
+#include <plat/clock.h>
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
+#include <plat/prcm.h>
=20
 /* clkdm_list contains all registered struct clockdomains */
 static LIST_HEAD(clkdm_list);
@@ -42,28 +42,75 @@ static LIST_HEAD(clkdm_list);
 /* clkdm_mutex protects clkdm_list add and del ops */
 static DEFINE_MUTEX(clkdm_mutex);
=20
-/* array of powerdomain deps to be added/removed when clkdm in hwsup m=
ode */
-static struct clkdm_pwrdm_autodep *autodeps;
+/* array of clockdomain deps to be added/removed when clkdm in hwsup m=
ode */
+static struct clkdm_autodep *autodeps;
=20
=20
 /* Private functions */
=20
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
+/* _clkdm_deps_lookup - look up the specified clockdomain in a clkdm l=
ist */
+static struct clkdm_dep *_clkdm_deps_lookup(struct clockdomain *clkdm,
+					    struct clkdm_dep *deps)
+{
+	struct clkdm_dep *cd;
+
+	if (!clkdm || !deps || !omap_chip_is(clkdm->omap_chip))
+		return ERR_PTR(-EINVAL);
+
+	for (cd =3D deps; cd->clkdm_name; cd++) {
+
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		if (!cd->clkdm && cd->clkdm_name)
+			cd->clkdm =3D _clkdm_lookup(cd->clkdm_name);
+
+		if (cd->clkdm =3D=3D clkdm)
+			break;
+
+	}
+
+	if (!cd->clkdm_name)
+		return ERR_PTR(-ENOENT);
+
+	return cd;
+}
+
 /*
- * _autodep_lookup - resolve autodep pwrdm names to pwrdm pointers; st=
ore
- * @autodep: struct clkdm_pwrdm_autodep * to resolve
+ * _autodep_lookup - resolve autodep clkdm names to clkdm pointers; st=
ore
+ * @autodep: struct clkdm_autodep * to resolve
  *
- * Resolve autodep powerdomain names to powerdomain pointers via
- * pwrdm_lookup() and store the pointers in the autodep structure.  An
- * "autodep" is a powerdomain sleep/wakeup dependency that is
+ * Resolve autodep clockdomain names to clockdomain pointers via
+ * clkdm_lookup() and store the pointers in the autodep structure.  An
+ * "autodep" is a clockdomain sleep/wakeup dependency that is
  * automatically added and removed whenever clocks in the associated
  * clockdomain are enabled or disabled (respectively) when the
  * clockdomain is in hardware-supervised mode.	Meant to be called
  * once at clockdomain layer initialization, since these should remain
  * fixed for a particular architecture.  No return value.
  */
-static void _autodep_lookup(struct clkdm_pwrdm_autodep *autodep)
+static void _autodep_lookup(struct clkdm_autodep *autodep)
 {
-	struct powerdomain *pwrdm;
+	struct clockdomain *clkdm;
=20
 	if (!autodep)
 		return;
@@ -71,13 +118,13 @@ static void _autodep_lookup(struct clkdm_pwrdm_aut=
odep *autodep)
 	if (!omap_chip_is(autodep->omap_chip))
 		return;
=20
-	pwrdm =3D pwrdm_lookup(autodep->pwrdm.name);
-	if (!pwrdm) {
-		pr_err("clockdomain: autodeps: powerdomain %s does not exist\n",
-			 autodep->pwrdm.name);
-		pwrdm =3D ERR_PTR(-ENOENT);
+	clkdm =3D clkdm_lookup(autodep->clkdm.name);
+	if (!clkdm) {
+		pr_err("clockdomain: autodeps: clockdomain %s does not exist\n",
+			 autodep->clkdm.name);
+		clkdm =3D ERR_PTR(-ENOENT);
 	}
-	autodep->pwrdm.ptr =3D pwrdm;
+	autodep->clkdm.ptr =3D clkdm;
 }
=20
 /*
@@ -90,21 +137,21 @@ static void _autodep_lookup(struct clkdm_pwrdm_aut=
odep *autodep)
  */
 static void _clkdm_add_autodeps(struct clockdomain *clkdm)
 {
-	struct clkdm_pwrdm_autodep *autodep;
+	struct clkdm_autodep *autodep;
=20
-	for (autodep =3D autodeps; autodep->pwrdm.ptr; autodep++) {
-		if (IS_ERR(autodep->pwrdm.ptr))
+	for (autodep =3D autodeps; autodep->clkdm.ptr; autodep++) {
+		if (IS_ERR(autodep->clkdm.ptr))
 			continue;
=20
 		if (!omap_chip_is(autodep->omap_chip))
 			continue;
=20
 		pr_debug("clockdomain: adding %s sleepdep/wkdep for "
-			 "pwrdm %s\n", autodep->pwrdm.ptr->name,
-			 clkdm->pwrdm.ptr->name);
+			 "clkdm %s\n", autodep->clkdm.ptr->name,
+			 clkdm->name);
=20
-		pwrdm_add_sleepdep(clkdm->pwrdm.ptr, autodep->pwrdm.ptr);
-		pwrdm_add_wkdep(clkdm->pwrdm.ptr, autodep->pwrdm.ptr);
+		clkdm_add_sleepdep(clkdm, autodep->clkdm.ptr);
+		clkdm_add_wkdep(clkdm, autodep->clkdm.ptr);
 	}
 }
=20
@@ -118,21 +165,21 @@ static void _clkdm_add_autodeps(struct clockdomai=
n *clkdm)
  */
 static void _clkdm_del_autodeps(struct clockdomain *clkdm)
 {
-	struct clkdm_pwrdm_autodep *autodep;
+	struct clkdm_autodep *autodep;
=20
-	for (autodep =3D autodeps; autodep->pwrdm.ptr; autodep++) {
-		if (IS_ERR(autodep->pwrdm.ptr))
+	for (autodep =3D autodeps; autodep->clkdm.ptr; autodep++) {
+		if (IS_ERR(autodep->clkdm.ptr))
 			continue;
=20
 		if (!omap_chip_is(autodep->omap_chip))
 			continue;
=20
 		pr_debug("clockdomain: removing %s sleepdep/wkdep for "
-			 "pwrdm %s\n", autodep->pwrdm.ptr->name,
-			 clkdm->pwrdm.ptr->name);
+			 "clkdm %s\n", autodep->clkdm.ptr->name,
+			 clkdm->name);
=20
-		pwrdm_del_sleepdep(clkdm->pwrdm.ptr, autodep->pwrdm.ptr);
-		pwrdm_del_wkdep(clkdm->pwrdm.ptr, autodep->pwrdm.ptr);
+		clkdm_del_sleepdep(clkdm, autodep->clkdm.ptr);
+		clkdm_del_wkdep(clkdm, autodep->clkdm.ptr);
 	}
 }
=20
@@ -171,25 +218,6 @@ static void _omap2_clkdm_set_hwsup(struct clockdom=
ain *clkdm, int enable)
=20
 }
=20
-static struct clockdomain *_clkdm_lookup(const char *name)
-{
-	struct clockdomain *clkdm, *temp_clkdm;
-
-	if (!name)
-		return NULL;
-
-	clkdm =3D NULL;
-
-	list_for_each_entry(temp_clkdm, &clkdm_list, node) {
-		if (!strcmp(name, temp_clkdm->name)) {
-			clkdm =3D temp_clkdm;
-			break;
-		}
-	}
-
-	return clkdm;
-}
-
=20
 /* Public functions */
=20
@@ -200,26 +228,24 @@ static struct clockdomain *_clkdm_lookup(const ch=
ar *name)
  *
  * Set up internal state.  If a pointer to an array of clockdomains
  * was supplied, loop through the list of clockdomains, register all
- * that are available on the current platform.	Similarly, if a
- * pointer to an array of clockdomain-powerdomain autodependencies was
- * provided, register those.  No return value.
+ * that are available on the current platform. Similarly, if a pointer
+ * to an array of clockdomain autodependencies was provided, register
+ * those.  No return value.
  */
 void clkdm_init(struct clockdomain **clkdms,
-		struct clkdm_pwrdm_autodep *init_autodeps)
+		struct clkdm_autodep *init_autodeps)
 {
 	struct clockdomain **c =3D NULL;
-	struct clkdm_pwrdm_autodep *autodep =3D NULL;
+	struct clkdm_autodep *autodep =3D NULL;
=20
 	if (clkdms)
 		for (c =3D clkdms; *c; c++)
 			clkdm_register(*c);
=20
-	if (!cpu_is_omap44xx()) {
-		autodeps =3D init_autodeps;
-		if (autodeps)
-			for (autodep =3D autodeps; autodep->pwrdm.ptr; autodep++)
-				_autodep_lookup(autodep);
-	}
+	autodeps =3D init_autodeps;
+	if (autodeps)
+		for (autodep =3D autodeps; autodep->clkdm.ptr; autodep++)
+			_autodep_lookup(autodep);
 }
=20
 /**
@@ -374,6 +400,226 @@ struct powerdomain *clkdm_get_pwrdm(struct clockd=
omain *clkdm)
 /* Hardware clockdomain control */
=20
 /**
+ * clkdm_add_wkdep - add a wakeup dependency from clkdm2 to clkdm1
+ * @clkdm1: wake this struct clockdomain * up (dependent)
+ * @clkdm2: when this struct clockdomain * wakes up (source)
+ *
+ * When the clockdomain represented by @clkdm2 wakes up, wake up
+ * @clkdm1. Implemented in hardware on the OMAP, this feature is
+ * designed to reduce wakeup latency of the dependent clockdomain @clk=
dm1.
+ * Returns -EINVAL if presented with invalid clockdomain pointers,
+ * -ENOENT if @clkdm2 cannot wake up clkdm1 in hardware, or 0 upon
+ * success.
+ */
+int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *cl=
kdm2)
+{
+	struct clkdm_dep *cd;
+
+	if (!clkdm1 || !clkdm2)
+		return -EINVAL;
+
+	cd =3D _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
+	if (IS_ERR(cd)) {
+		pr_debug("clockdomain: hardware cannot set/clear wake up of "
+			 "%s when %s wakes up\n", clkdm1->name, clkdm2->name);
+		return PTR_ERR(cd);
+	}
+
+	pr_debug("clockdomain: hardware will wake up %s when %s wakes up\n",
+		 clkdm1->name, clkdm2->name);
+
+	prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+			     clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+
+	return 0;
+}
+
+/**
+ * clkdm_del_wkdep - remove a wakeup dependency from clkdm2 to clkdm1
+ * @clkdm1: wake this struct clockdomain * up (dependent)
+ * @clkdm2: when this struct clockdomain * wakes up (source)
+ *
+ * Remove a wakeup dependency causing @clkdm1 to wake up when @clkdm2
+ * wakes up.  Returns -EINVAL if presented with invalid clockdomain
+ * pointers, -ENOENT if @clkdm2 cannot wake up clkdm1 in hardware, or
+ * 0 upon success.
+ */
+int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *cl=
kdm2)
+{
+	struct clkdm_dep *cd;
+
+	if (!clkdm1 || !clkdm2)
+		return -EINVAL;
+
+	cd =3D _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
+	if (IS_ERR(cd)) {
+		pr_debug("clockdomain: hardware cannot set/clear wake up of "
+			 "%s when %s wakes up\n", clkdm1->name, clkdm2->name);
+		return PTR_ERR(cd);
+	}
+
+	pr_debug("clockdomain: hardware will no longer wake up %s after %s "
+		 "wakes up\n", clkdm1->name, clkdm2->name);
+
+	prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+			       clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+
+	return 0;
+}
+
+/**
+ * clkdm_read_wkdep - read wakeup dependency state from clkdm2 to clkd=
m1
+ * @clkdm1: wake this struct clockdomain * up (dependent)
+ * @clkdm2: when this struct clockdomain * wakes up (source)
+ *
+ * Return 1 if a hardware wakeup dependency exists wherein @clkdm1 wil=
l be
+ * awoken when @clkdm2 wakes up; 0 if dependency is not set; -EINVAL
+ * if either clockdomain pointer is invalid; or -ENOENT if the hardwar=
e
+ * is incapable.
+ *
+ * REVISIT: Currently this function only represents software-controlla=
ble
+ * wakeup dependencies.  Wakeup dependencies fixed in hardware are not
+ * yet handled here.
+ */
+int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *c=
lkdm2)
+{
+	struct clkdm_dep *cd;
+
+	if (!clkdm1 || !clkdm2)
+		return -EINVAL;
+
+	cd =3D _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
+	if (IS_ERR(cd)) {
+		pr_debug("clockdomain: hardware cannot set/clear wake up of "
+			 "%s when %s wakes up\n", clkdm1->name, clkdm2->name);
+		return PTR_ERR(cd);
+	}
+
+	return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP=
,
+				       (1 << clkdm2->dep_bit));
+}
+
+/**
+ * clkdm_add_sleepdep - add a sleep dependency from clkdm2 to clkdm1
+ * @clkdm1: prevent this struct clockdomain * from sleeping (dependent=
)
+ * @clkdm2: when this struct clockdomain * is active (source)
+ *
+ * Prevent @clkdm1 from automatically going inactive (and then to
+ * retention or off) if @clkdm2 is active.  Returns -EINVAL if
+ * presented with invalid clockdomain pointers or called on a machine
+ * that does not support software-configurable hardware sleep
+ * dependencies, -ENOENT if the specified dependency cannot be set in
+ * hardware, or 0 upon success.
+ */
+int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain =
*clkdm2)
+{
+	struct clkdm_dep *cd;
+
+	if (!cpu_is_omap34xx())
+		return -EINVAL;
+
+	if (!clkdm1 || !clkdm2)
+		return -EINVAL;
+
+	cd =3D _clkdm_deps_lookup(clkdm2, clkdm1->sleepdep_srcs);
+	if (IS_ERR(cd)) {
+		pr_debug("clockdomain: hardware cannot set/clear sleep "
+			 "dependency affecting %s from %s\n", clkdm1->name,
+			 clkdm2->name);
+		return PTR_ERR(cd);
+	}
+
+	pr_debug("clockdomain: will prevent %s from sleeping if %s is active\=
n",
+		 clkdm1->name, clkdm2->name);
+
+	cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+			    clkdm1->pwrdm.ptr->prcm_offs,
+			    OMAP3430_CM_SLEEPDEP);
+
+	return 0;
+}
+
+/**
+ * clkdm_del_sleepdep - remove a sleep dependency from clkdm2 to clkdm=
1
+ * @clkdm1: prevent this struct clockdomain * from sleeping (dependent=
)
+ * @clkdm2: when this struct clockdomain * is active (source)
+ *
+ * Allow @clkdm1 to automatically go inactive (and then to retention o=
r
+ * off), independent of the activity state of @clkdm2.  Returns -EINVA=
L
+ * if presented with invalid clockdomain pointers or called on a machi=
ne
+ * that does not support software-configurable hardware sleep dependen=
cies,
+ * -ENOENT if the specified dependency cannot be cleared in hardware, =
or
+ * 0 upon success.
+ */
+int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain =
*clkdm2)
+{
+	struct clkdm_dep *cd;
+
+	if (!cpu_is_omap34xx())
+		return -EINVAL;
+
+	if (!clkdm1 || !clkdm2)
+		return -EINVAL;
+
+	cd =3D _clkdm_deps_lookup(clkdm2, clkdm1->sleepdep_srcs);
+	if (IS_ERR(cd)) {
+		pr_debug("clockdomain: hardware cannot set/clear sleep "
+			 "dependency affecting %s from %s\n", clkdm1->name,
+			 clkdm2->name);
+		return PTR_ERR(cd);
+	}
+
+	pr_debug("clockdomain: will no longer prevent %s from sleeping if "
+		 "%s is active\n", clkdm1->name, clkdm2->name);
+
+	cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+			      clkdm1->pwrdm.ptr->prcm_offs,
+			      OMAP3430_CM_SLEEPDEP);
+
+	return 0;
+}
+
+/**
+ * clkdm_read_sleepdep - read sleep dependency state from clkdm2 to cl=
kdm1
+ * @clkdm1: prevent this struct clockdomain * from sleeping (dependent=
)
+ * @clkdm2: when this struct clockdomain * is active (source)
+ *
+ * Return 1 if a hardware sleep dependency exists wherein @clkdm1 will
+ * not be allowed to automatically go inactive if @clkdm2 is active;
+ * 0 if @clkdm1's automatic power state inactivity transition is indep=
endent
+ * of @clkdm2's; -EINVAL if either clockdomain pointer is invalid or c=
alled
+ * on a machine that does not support software-configurable hardware s=
leep
+ * dependencies; or -ENOENT if the hardware is incapable.
+ *
+ * REVISIT: Currently this function only represents software-controlla=
ble
+ * sleep dependencies.	Sleep dependencies fixed in hardware are not
+ * yet handled here.
+ */
+int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain=
 *clkdm2)
+{
+	struct clkdm_dep *cd;
+
+	if (!cpu_is_omap34xx())
+		return -EINVAL;
+
+	if (!clkdm1 || !clkdm2)
+		return -EINVAL;
+
+	cd =3D _clkdm_deps_lookup(clkdm2, clkdm1->sleepdep_srcs);
+	if (IS_ERR(cd)) {
+		pr_debug("clockdomain: hardware cannot set/clear sleep "
+			 "dependency affecting %s from %s\n", clkdm1->name,
+			 clkdm2->name);
+		return PTR_ERR(cd);
+	}
+
+	return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
+				       OMAP3430_CM_SLEEPDEP,
+				       (1 << clkdm2->dep_bit));
+}
+
+
+/**
  * omap2_clkdm_clktrctrl_read - read the clkdm's current state transit=
ion mode
  * @clk: struct clk * of a clockdomain
  *
diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/c=
lockdomains.h
index 6dc5ddc..ff216f2 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -2,9 +2,28 @@
  * OMAP2/3 clockdomains
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2008-2009 Nokia Corporation
  *
- * Written by Paul Walmsley
+ * Written by Paul Walmsley and Jouni H=C3=B6gander
+ *
+ * This file contains clockdomains and clockdomain wakeup/sleep
+ * dependencies for the OMAP2/3 chips.  Some notes:
+ *
+ * A useful validation rule for struct clockdomain: Any clockdomain
+ * referenced by a wkdep_srcs or sleepdep_srcs array must have a
+ * dep_bit assigned.  So wkdep_srcs/sleepdep_srcs are really just
+ * software-controllable dependencies.  Non-software-controllable
+ * dependencies do exist, but they are not encoded below (yet).
+ *
+ * 24xx does not support programmable sleep dependencies (SLEEPDEP)
+ *
+ * The overly-specific dep_bit names are due to a bit name collision
+ * with CM_FCLKEN_{DSP,IVA2}.  The DSP/IVA2 PM_WKDEP and CM_SLEEPDEP s=
hift
+ * value are the same for all powerdomains: 2
+ *
+ * XXX should dep_bit be a mask, so we can test to see if it is 0 as a
+ * sanity check?
+ * XXX encode hardware fixed wakeup dependencies -- esp. for 3430 CORE
  */
=20
 /*
@@ -21,6 +40,287 @@
 #include "prm.h"
=20
 /*
+ * Clockdomain dependencies for wkdeps/sleepdeps
+ *
+ * XXX Hardware dependencies (e.g., dependencies that cannot be
+ * changed in software) are not included here yet, but should be.
+ */
+
+/* OMAP2/3-common wakeup dependencies */
+
+/*
+ * 2420/2430 PM_WKDEP_GFX: CORE, MPU, WKUP
+ * 3430ES1 PM_WKDEP_GFX: adds IVA2, removes CORE
+ * 3430ES2 PM_WKDEP_SGX: adds IVA2, removes CORE
+ */
+static struct clkdm_dep gfx_sgx_wkdeps[] =3D {
+	{
+		.clkdm_name =3D "core_l3_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name =3D "core_l4_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name =3D "iva2_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "mpu_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
+					    CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "wkup_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
+					    CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+
+/* 24XX-specific possible dependencies */
+
+#ifdef CONFIG_ARCH_OMAP24XX
+
+/* Wakeup dependency source arrays */
+
+/*
+ * 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP
+ * 2420/2430 PM_WKDEP_MDM: same as DSP
+ */
+static struct clkdm_dep dsp_mdm_24xx_wkdeps[] =3D {
+	{
+		.clkdm_name =3D "core_l3_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name =3D "core_l4_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name =3D "mpu_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name =3D "wkup_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{ NULL },
+};
+
+/*
+ * 2420 PM_WKDEP_MPU: CORE, DSP, WKUP
+ * 2430 adds MDM
+ */
+static struct clkdm_dep mpu_24xx_wkdeps[] =3D {
+	{
+		.clkdm_name =3D "core_l3_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name =3D "core_l4_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name =3D "dsp_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name =3D "wkup_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name =3D "mdm_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+	},
+	{ NULL },
+};
+
+/*
+ * 2420 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP
+ * 2430 adds MDM
+ */
+static struct clkdm_dep core_24xx_wkdeps[] =3D {
+	{
+		.clkdm_name =3D "dsp_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name =3D "gfx_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name =3D "mpu_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name =3D "wkup_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name =3D "mdm_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+	},
+	{ NULL },
+};
+
+#endif
+
+/* 34XX-specific possible dependencies */
+
+#ifdef CONFIG_ARCH_OMAP34XX
+
+/*
+ * 3430: PM_WKDEP_{PER,USBHOST}: CORE, IVA2, MPU, WKUP
+ * (USBHOST is ES2 only)
+ */
+static struct clkdm_dep per_usbhost_wkdeps[] =3D {
+	{
+		.clkdm_name =3D "core_l3_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "core_l4_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "iva2_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "mpu_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "wkup_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/*
+ * 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER
+ */
+static struct clkdm_dep mpu_34xx_wkdeps[] =3D {
+	{
+		.clkdm_name =3D "core_l3_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "core_l4_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "iva2_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "dss_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "per_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/*
+ * 3430 PM_WKDEP_IVA2: CORE, MPU, WKUP, DSS, PER
+ */
+static struct clkdm_dep iva2_wkdeps[] =3D {
+	{
+		.clkdm_name =3D "core_l3_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "core_l4_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "mpu_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "wkup_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "dss_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "per_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+
+/* 3430 PM_WKDEP_{CAM,DSS}: IVA2, MPU, WKUP */
+static struct clkdm_dep cam_dss_wkdeps[] =3D {
+	{
+		.clkdm_name =3D "iva2_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "mpu_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "wkup_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/* 3430: PM_WKDEP_NEON: MPU */
+static struct clkdm_dep neon_wkdeps[] =3D {
+	{
+		.clkdm_name =3D "mpu_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+
+/* Sleep dependency source arrays for 34xx-specific clkdms - 34XX only=
 */
+
+/*
+ * 3430: CM_SLEEPDEP_{DSS,PER}: MPU, IVA
+ * 3430ES2: CM_SLEEPDEP_USBHOST: MPU, IVA
+ */
+static struct clkdm_dep dss_per_usbhost_sleepdeps[] =3D {
+	{
+		.clkdm_name =3D "mpu_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name =3D "iva2_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/*
+ * 3430: CM_SLEEPDEP_CAM: MPU
+ * 3430ES1: CM_SLEEPDEP_GFX: MPU
+ * 3430ES2: CM_SLEEPDEP_SGX: MPU
+ */
+static struct clkdm_dep cam_gfx_sleepdeps[] =3D {
+	{
+		.clkdm_name =3D "mpu_clkdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+#endif /* CONFIG_ARCH_OMAP34XX */
+
+
+/*
  * OMAP2/3-common clockdomains
  *
  * Even though the 2420 has a single PRCM module from the
@@ -35,6 +335,7 @@
 static struct clockdomain wkup_clkdm =3D {
 	.name		=3D "wkup_clkdm",
 	.pwrdm		=3D { .name =3D "wkup_pwrdm" },
+	.dep_bit	=3D OMAP_EN_WKUP_SHIFT,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 };
=20
@@ -63,6 +364,7 @@ static struct clockdomain mpu_2420_clkdm =3D {
 	.pwrdm		=3D { .name =3D "mpu_pwrdm" },
 	.flags		=3D CLKDM_CAN_HWSUP,
 	.clkstctrl_reg  =3D OMAP2420_CM_REGADDR(MPU_MOD, OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	=3D mpu_24xx_wkdeps,
 	.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_MPU_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -73,6 +375,8 @@ static struct clockdomain iva1_2420_clkdm =3D {
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg  =3D OMAP2420_CM_REGADDR(OMAP24XX_DSP_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.dep_bit	=3D OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
+	.wkdep_srcs	=3D dsp_mdm_24xx_wkdeps,
 	.clktrctrl_mask =3D OMAP2420_AUTOSTATE_IVA_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -92,6 +396,7 @@ static struct clockdomain gfx_2420_clkdm =3D {
 	.pwrdm		=3D { .name =3D "gfx_pwrdm" },
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg  =3D OMAP2420_CM_REGADDR(GFX_MOD, OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	=3D gfx_sgx_wkdeps,
 	.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_GFX_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -101,6 +406,7 @@ static struct clockdomain core_l3_2420_clkdm =3D {
 	.pwrdm		=3D { .name =3D "core_pwrdm" },
 	.flags		=3D CLKDM_CAN_HWSUP,
 	.clkstctrl_reg  =3D OMAP2420_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL)=
,
+	.wkdep_srcs	=3D core_24xx_wkdeps,
 	.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_L3_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -110,6 +416,7 @@ static struct clockdomain core_l4_2420_clkdm =3D {
 	.pwrdm		=3D { .name =3D "core_pwrdm" },
 	.flags		=3D CLKDM_CAN_HWSUP,
 	.clkstctrl_reg  =3D OMAP2420_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL)=
,
+	.wkdep_srcs	=3D core_24xx_wkdeps,
 	.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_L4_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -138,16 +445,20 @@ static struct clockdomain mpu_2430_clkdm =3D {
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg  =3D OMAP2430_CM_REGADDR(MPU_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	=3D mpu_24xx_wkdeps,
 	.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_MPU_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
=20
+/* Another case of bit name collisions between several registers: EN_M=
DM */
 static struct clockdomain mdm_clkdm =3D {
 	.name		=3D "mdm_clkdm",
 	.pwrdm		=3D { .name =3D "mdm_pwrdm" },
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg  =3D OMAP2430_CM_REGADDR(OMAP2430_MDM_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.dep_bit	=3D OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
+	.wkdep_srcs	=3D dsp_mdm_24xx_wkdeps,
 	.clktrctrl_mask =3D OMAP2430_AUTOSTATE_MDM_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
@@ -158,6 +469,8 @@ static struct clockdomain dsp_2430_clkdm =3D {
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg  =3D OMAP2430_CM_REGADDR(OMAP24XX_DSP_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.dep_bit	=3D OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
+	.wkdep_srcs	=3D dsp_mdm_24xx_wkdeps,
 	.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_DSP_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
@@ -167,24 +480,39 @@ static struct clockdomain gfx_2430_clkdm =3D {
 	.pwrdm		=3D { .name =3D "gfx_pwrdm" },
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg  =3D OMAP2430_CM_REGADDR(GFX_MOD, OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	=3D gfx_sgx_wkdeps,
 	.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_GFX_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
=20
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
+ * could cause trouble
+ */
 static struct clockdomain core_l3_2430_clkdm =3D {
 	.name		=3D "core_l3_clkdm",
 	.pwrdm		=3D { .name =3D "core_pwrdm" },
 	.flags		=3D CLKDM_CAN_HWSUP,
 	.clkstctrl_reg  =3D OMAP2430_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL)=
,
+	.dep_bit	=3D OMAP24XX_EN_CORE_SHIFT,
+	.wkdep_srcs	=3D core_24xx_wkdeps,
 	.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_L3_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
=20
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_24xx_clkdm and core_l4_24xx_clkdm
+ * could cause trouble
+ */
 static struct clockdomain core_l4_2430_clkdm =3D {
 	.name		=3D "core_l4_clkdm",
 	.pwrdm		=3D { .name =3D "core_pwrdm" },
 	.flags		=3D CLKDM_CAN_HWSUP,
 	.clkstctrl_reg  =3D OMAP2430_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL)=
,
+	.dep_bit	=3D OMAP24XX_EN_CORE_SHIFT,
+	.wkdep_srcs	=3D core_24xx_wkdeps,
 	.clktrctrl_mask =3D OMAP24XX_AUTOSTATE_L4_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
@@ -212,6 +540,8 @@ static struct clockdomain mpu_34xx_clkdm =3D {
 	.pwrdm		=3D { .name =3D "mpu_pwrdm" },
 	.flags		=3D CLKDM_CAN_HWSUP | CLKDM_CAN_FORCE_WAKEUP,
 	.clkstctrl_reg	=3D OMAP34XX_CM_REGADDR(MPU_MOD, OMAP2_CM_CLKSTCTRL),
+	.dep_bit	=3D OMAP3430_EN_MPU_SHIFT,
+	.wkdep_srcs	=3D mpu_34xx_wkdeps,
 	.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_MPU_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -222,6 +552,7 @@ static struct clockdomain neon_clkdm =3D {
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	=3D OMAP34XX_CM_REGADDR(OMAP3430_NEON_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	=3D neon_wkdeps,
 	.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_NEON_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -232,6 +563,8 @@ static struct clockdomain iva2_clkdm =3D {
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	=3D OMAP34XX_CM_REGADDR(OMAP3430_IVA2_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.dep_bit	=3D OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
+	.wkdep_srcs	=3D iva2_wkdeps,
 	.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_IVA2_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -241,6 +574,8 @@ static struct clockdomain gfx_3430es1_clkdm =3D {
 	.pwrdm		=3D { .name =3D "gfx_pwrdm" },
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	=3D OMAP34XX_CM_REGADDR(GFX_MOD, OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	=3D gfx_sgx_wkdeps,
+	.sleepdep_srcs	=3D cam_gfx_sleepdeps,
 	.clktrctrl_mask =3D OMAP3430ES1_CLKTRCTRL_GFX_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
 };
@@ -251,6 +586,8 @@ static struct clockdomain sgx_clkdm =3D {
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	=3D OMAP34XX_CM_REGADDR(OMAP3430ES2_SGX_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	=3D gfx_sgx_wkdeps,
+	.sleepdep_srcs	=3D cam_gfx_sleepdeps,
 	.clktrctrl_mask =3D OMAP3430ES2_CLKTRCTRL_SGX_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
@@ -271,30 +608,46 @@ static struct clockdomain d2d_clkdm =3D {
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_34xx_clkdm and core_l4_34xx_clkdm
+ * could cause trouble
+ */
 static struct clockdomain core_l3_34xx_clkdm =3D {
 	.name		=3D "core_l3_clkdm",
 	.pwrdm		=3D { .name =3D "core_pwrdm" },
 	.flags		=3D CLKDM_CAN_HWSUP,
 	.clkstctrl_reg	=3D OMAP34XX_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
+	.dep_bit	=3D OMAP3430_EN_CORE_SHIFT,
 	.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_L3_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
+/*
+ * XXX add usecounting for clkdm dependencies, otherwise the presence
+ * of a single dep bit for core_l3_34xx_clkdm and core_l4_34xx_clkdm
+ * could cause trouble
+ */
 static struct clockdomain core_l4_34xx_clkdm =3D {
 	.name		=3D "core_l4_clkdm",
 	.pwrdm		=3D { .name =3D "core_pwrdm" },
 	.flags		=3D CLKDM_CAN_HWSUP,
 	.clkstctrl_reg	=3D OMAP34XX_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
+	.dep_bit	=3D OMAP3430_EN_CORE_SHIFT,
 	.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_L4_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
+/* Another case of bit name collisions between several registers: EN_D=
SS */
 static struct clockdomain dss_34xx_clkdm =3D {
 	.name		=3D "dss_clkdm",
 	.pwrdm		=3D { .name =3D "dss_pwrdm" },
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	=3D OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.dep_bit	=3D OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
+	.wkdep_srcs	=3D cam_dss_wkdeps,
+	.sleepdep_srcs	=3D dss_per_usbhost_sleepdeps,
 	.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_DSS_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -305,6 +658,8 @@ static struct clockdomain cam_clkdm =3D {
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	=3D OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	=3D cam_dss_wkdeps,
+	.sleepdep_srcs	=3D cam_gfx_sleepdeps,
 	.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_CAM_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -315,6 +670,8 @@ static struct clockdomain usbhost_clkdm =3D {
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	=3D OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.wkdep_srcs	=3D per_usbhost_wkdeps,
+	.sleepdep_srcs	=3D dss_per_usbhost_sleepdeps,
 	.clktrctrl_mask =3D OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
@@ -325,6 +682,9 @@ static struct clockdomain per_clkdm =3D {
 	.flags		=3D CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	=3D OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD,
 						 OMAP2_CM_CLKSTCTRL),
+	.dep_bit	=3D OMAP3430_EN_PER_SHIFT,
+	.wkdep_srcs	=3D per_usbhost_wkdeps,
+	.sleepdep_srcs	=3D dss_per_usbhost_sleepdeps,
 	.clktrctrl_mask =3D OMAP3430_CLKTRCTRL_PER_MASK,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -378,25 +738,21 @@ static struct clockdomain dpll5_clkdm =3D {
 #include "clockdomains44xx.h"
=20
 /*
- * Clockdomain-powerdomain hwsup dependencies (34XX only)
+ * Clockdomain hwsup dependencies (34XX only)
  */
=20
-static struct clkdm_pwrdm_autodep clkdm_pwrdm_autodeps[] =3D {
-
-#ifdef CONFIG_ARCH_OMAP34XX
+static struct clkdm_autodep clkdm_autodeps[] =3D {
 	{
-		.pwrdm	   =3D { .name =3D "mpu_pwrdm" },
+		.clkdm	   =3D { .name =3D "mpu_clkdm" },
 		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 	},
 	{
-		.pwrdm	   =3D { .name =3D "iva2_pwrdm" },
+		.clkdm	   =3D { .name =3D "iva2_clkdm" },
 		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 	},
 	{
-		.pwrdm	   =3D { .name =3D NULL },
+		.clkdm	   =3D { .name =3D NULL },
 	}
-#endif
-
 };
=20
 /*
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 51d7453..8c58699 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -313,7 +313,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_p=
arams *sdrc_cs0,
 		hwmods =3D omap34xx_hwmods;
=20
 	pwrdm_init(powerdomains_omap);
-	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
+	clkdm_init(clockdomains_omap, clkdm_autodeps);
 #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is rea=
dy */
 	/* The OPP tables have to be registered before a clk init */
 	omap_hwmod_init(hwmods);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index d8c8545..88d91de 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -298,15 +298,14 @@ static int _disable_wakeup(struct omap_hwmod *oh)
  * be accessed by the IVA, there should be a sleepdep between the IVA
  * initiator and the module).  Only applies to modules in smart-idle
  * mode.  Returns -EINVAL upon error or passes along
- * pwrdm_add_sleepdep() value upon success.
+ * clkdm_add_sleepdep() value upon success.
  */
 static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod=
 *init_oh)
 {
 	if (!oh->_clk)
 		return -EINVAL;
=20
-	return pwrdm_add_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
-				  init_oh->_clk->clkdm->pwrdm.ptr);
+	return clkdm_add_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
 }
=20
 /**
@@ -319,15 +318,14 @@ static int _add_initiator_dep(struct omap_hwmod *=
oh, struct omap_hwmod *init_oh)
  * be accessed by the IVA, there should be no sleepdep between the IVA
  * initiator and the module).  Only applies to modules in smart-idle
  * mode.  Returns -EINVAL upon error or passes along
- * pwrdm_add_sleepdep() value upon success.
+ * clkdm_del_sleepdep() value upon success.
  */
 static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod=
 *init_oh)
 {
 	if (!oh->_clk)
 		return -EINVAL;
=20
-	return pwrdm_del_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
-				  init_oh->_clk->clkdm->pwrdm.ptr);
+	return clkdm_del_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
 }
=20
 /**
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index 3189acc..ab110b4 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1013,6 +1013,7 @@ void omap_push_sram_idle(void)
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
+	struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core_clkdm;
 	int ret;
=20
 	if (!cpu_is_omap34xx())
@@ -1052,6 +1053,11 @@ static int __init omap3_pm_init(void)
 	core_pwrdm =3D pwrdm_lookup("core_pwrdm");
 	cam_pwrdm =3D pwrdm_lookup("cam_pwrdm");
=20
+	neon_clkdm =3D clkdm_lookup("neon_clkdm");
+	mpu_clkdm =3D clkdm_lookup("mpu_clkdm");
+	per_clkdm =3D clkdm_lookup("per_clkdm");
+	core_clkdm =3D clkdm_lookup("core_clkdm");
+
 	omap_push_sram_idle();
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
@@ -1060,14 +1066,14 @@ static int __init omap3_pm_init(void)
 	pm_idle =3D omap3_pm_idle;
 	omap3_idle_init();
=20
-	pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
+	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
 	/*
 	 * REVISIT: This wkdep is only necessary when GPIO2-6 are enabled for
 	 * IO-pad wakeup.  Otherwise it will unnecessarily waste power
 	 * waking up PER with every CORE wakeup - see
 	 * http://marc.info/?l=3Dlinux-omap&m=3D121852150710062&w=3D2
 	*/
-	pwrdm_add_wkdep(per_pwrdm, core_pwrdm);
+	clkdm_add_wkdep(per_clkdm, core_clkdm);
=20
 	if (omap_type() !=3D OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =3D
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/po=
werdomain.c
index c0de050..e8e8d88 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -2,7 +2,7 @@
  * OMAP powerdomain control
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2008 Nokia Corporation
+ * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  *
@@ -36,6 +36,7 @@
 #include <plat/cpu.h>
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
+#include <plat/prcm.h>
=20
 #include "pm.h"
=20
@@ -88,17 +89,6 @@ static DEFINE_RWLOCK(pwrdm_rwlock);
=20
 /* Private functions */
=20
-static u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
-{
-	u32 v;
-
-	v =3D prm_read_mod_reg(domain, idx);
-	v &=3D mask;
-	v >>=3D __ffs(mask);
-
-	return v;
-}
-
 static struct powerdomain *_pwrdm_lookup(const char *name)
 {
 	struct powerdomain *pwrdm, *temp_pwrdm;
@@ -115,34 +105,6 @@ static struct powerdomain *_pwrdm_lookup(const cha=
r *name)
 	return pwrdm;
 }
=20
-/* _pwrdm_deps_lookup - look up the specified powerdomain in a pwrdm l=
ist */
-static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrd=
m,
-					      struct pwrdm_dep *deps)
-{
-	struct pwrdm_dep *pd;
-
-	if (!pwrdm || !deps || !omap_chip_is(pwrdm->omap_chip))
-		return ERR_PTR(-EINVAL);
-
-	for (pd =3D deps; pd->pwrdm_name; pd++) {
-
-		if (!omap_chip_is(pd->omap_chip))
-			continue;
-
-		if (!pd->pwrdm && pd->pwrdm_name)
-			pd->pwrdm =3D pwrdm_lookup(pd->pwrdm_name);
-
-		if (pd->pwrdm =3D=3D pwrdm)
-			break;
-
-	}
-
-	if (!pd->pwrdm_name)
-		return ERR_PTR(-ENOENT);
-
-	return pd->pwrdm;
-}
-
 static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 {
=20
@@ -502,223 +464,6 @@ int pwrdm_for_each_clkdm(struct powerdomain *pwrd=
m,
 	return ret;
 }
=20
-
-/**
- * pwrdm_add_wkdep - add a wakeup dependency from pwrdm2 to pwrdm1
- * @pwrdm1: wake this struct powerdomain * up (dependent)
- * @pwrdm2: when this struct powerdomain * wakes up (source)
- *
- * When the powerdomain represented by pwrdm2 wakes up (due to an
- * interrupt), wake up pwrdm1.	Implemented in hardware on the OMAP,
- * this feature is designed to reduce wakeup latency of the dependent
- * powerdomain.  Returns -EINVAL if presented with invalid powerdomain
- * pointers, -ENOENT if pwrdm2 cannot wake up pwrdm1 in hardware, or
- * 0 upon success.
- */
-int pwrdm_add_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pw=
rdm2)
-{
-	struct powerdomain *p;
-
-	if (!pwrdm1)
-		return -EINVAL;
-
-	p =3D _pwrdm_deps_lookup(pwrdm2, pwrdm1->wkdep_srcs);
-	if (IS_ERR(p)) {
-		pr_debug("powerdomain: hardware cannot set/clear wake up of "
-			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
-		return PTR_ERR(p);
-	}
-
-	pr_debug("powerdomain: hardware will wake up %s when %s wakes up\n",
-		 pwrdm1->name, pwrdm2->name);
-
-	prm_set_mod_reg_bits((1 << pwrdm2->dep_bit),
-			     pwrdm1->prcm_offs, PM_WKDEP);
-
-	return 0;
-}
-
-/**
- * pwrdm_del_wkdep - remove a wakeup dependency from pwrdm2 to pwrdm1
- * @pwrdm1: wake this struct powerdomain * up (dependent)
- * @pwrdm2: when this struct powerdomain * wakes up (source)
- *
- * Remove a wakeup dependency that causes pwrdm1 to wake up when pwrdm=
2
- * wakes up.  Returns -EINVAL if presented with invalid powerdomain
- * pointers, -ENOENT if pwrdm2 cannot wake up pwrdm1 in hardware, or
- * 0 upon success.
- */
-int pwrdm_del_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pw=
rdm2)
-{
-	struct powerdomain *p;
-
-	if (!pwrdm1)
-		return -EINVAL;
-
-	p =3D _pwrdm_deps_lookup(pwrdm2, pwrdm1->wkdep_srcs);
-	if (IS_ERR(p)) {
-		pr_debug("powerdomain: hardware cannot set/clear wake up of "
-			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
-		return PTR_ERR(p);
-	}
-
-	pr_debug("powerdomain: hardware will no longer wake up %s after %s "
-		 "wakes up\n", pwrdm1->name, pwrdm2->name);
-
-	prm_clear_mod_reg_bits((1 << pwrdm2->dep_bit),
-			       pwrdm1->prcm_offs, PM_WKDEP);
-
-	return 0;
-}
-
-/**
- * pwrdm_read_wkdep - read wakeup dependency state from pwrdm2 to pwrd=
m1
- * @pwrdm1: wake this struct powerdomain * up (dependent)
- * @pwrdm2: when this struct powerdomain * wakes up (source)
- *
- * Return 1 if a hardware wakeup dependency exists wherein pwrdm1 will=
 be
- * awoken when pwrdm2 wakes up; 0 if dependency is not set; -EINVAL
- * if either powerdomain pointer is invalid; or -ENOENT if the hardwar=
e
- * is incapable.
- *
- * REVISIT: Currently this function only represents software-controlla=
ble
- * wakeup dependencies.  Wakeup dependencies fixed in hardware are not
- * yet handled here.
- */
-int pwrdm_read_wkdep(struct powerdomain *pwrdm1, struct powerdomain *p=
wrdm2)
-{
-	struct powerdomain *p;
-
-	if (!pwrdm1)
-		return -EINVAL;
-
-	p =3D _pwrdm_deps_lookup(pwrdm2, pwrdm1->wkdep_srcs);
-	if (IS_ERR(p)) {
-		pr_debug("powerdomain: hardware cannot set/clear wake up of "
-			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
-		return PTR_ERR(p);
-	}
-
-	return prm_read_mod_bits_shift(pwrdm1->prcm_offs, PM_WKDEP,
-					(1 << pwrdm2->dep_bit));
-}
-
-/**
- * pwrdm_add_sleepdep - add a sleep dependency from pwrdm2 to pwrdm1
- * @pwrdm1: prevent this struct powerdomain * from sleeping (dependent=
)
- * @pwrdm2: when this struct powerdomain * is active (source)
- *
- * Prevent pwrdm1 from automatically going inactive (and then to
- * retention or off) if pwrdm2 is still active.	 Returns -EINVAL if
- * presented with invalid powerdomain pointers or called on a machine
- * that does not support software-configurable hardware sleep dependen=
cies,
- * -ENOENT if the specified dependency cannot be set in hardware, or
- * 0 upon success.
- */
-int pwrdm_add_sleepdep(struct powerdomain *pwrdm1, struct powerdomain =
*pwrdm2)
-{
-	struct powerdomain *p;
-
-	if (!cpu_is_omap34xx())
-		return -EINVAL;
-
-	if (!pwrdm1)
-		return -EINVAL;
-
-	p =3D _pwrdm_deps_lookup(pwrdm2, pwrdm1->sleepdep_srcs);
-	if (IS_ERR(p)) {
-		pr_debug("powerdomain: hardware cannot set/clear sleep "
-			 "dependency affecting %s from %s\n", pwrdm1->name,
-			 pwrdm2->name);
-		return PTR_ERR(p);
-	}
-
-	pr_debug("powerdomain: will prevent %s from sleeping if %s is active\=
n",
-		 pwrdm1->name, pwrdm2->name);
-
-	cm_set_mod_reg_bits((1 << pwrdm2->dep_bit),
-			    pwrdm1->prcm_offs, OMAP3430_CM_SLEEPDEP);
-
-	return 0;
-}
-
-/**
- * pwrdm_del_sleepdep - remove a sleep dependency from pwrdm2 to pwrdm=
1
- * @pwrdm1: prevent this struct powerdomain * from sleeping (dependent=
)
- * @pwrdm2: when this struct powerdomain * is active (source)
- *
- * Allow pwrdm1 to automatically go inactive (and then to retention or
- * off), independent of the activity state of pwrdm2.  Returns -EINVAL
- * if presented with invalid powerdomain pointers or called on a machi=
ne
- * that does not support software-configurable hardware sleep dependen=
cies,
- * -ENOENT if the specified dependency cannot be cleared in hardware, =
or
- * 0 upon success.
- */
-int pwrdm_del_sleepdep(struct powerdomain *pwrdm1, struct powerdomain =
*pwrdm2)
-{
-	struct powerdomain *p;
-
-	if (!cpu_is_omap34xx())
-		return -EINVAL;
-
-	if (!pwrdm1)
-		return -EINVAL;
-
-	p =3D _pwrdm_deps_lookup(pwrdm2, pwrdm1->sleepdep_srcs);
-	if (IS_ERR(p)) {
-		pr_debug("powerdomain: hardware cannot set/clear sleep "
-			 "dependency affecting %s from %s\n", pwrdm1->name,
-			 pwrdm2->name);
-		return PTR_ERR(p);
-	}
-
-	pr_debug("powerdomain: will no longer prevent %s from sleeping if "
-		 "%s is active\n", pwrdm1->name, pwrdm2->name);
-
-	cm_clear_mod_reg_bits((1 << pwrdm2->dep_bit),
-			      pwrdm1->prcm_offs, OMAP3430_CM_SLEEPDEP);
-
-	return 0;
-}
-
-/**
- * pwrdm_read_sleepdep - read sleep dependency state from pwrdm2 to pw=
rdm1
- * @pwrdm1: prevent this struct powerdomain * from sleeping (dependent=
)
- * @pwrdm2: when this struct powerdomain * is active (source)
- *
- * Return 1 if a hardware sleep dependency exists wherein pwrdm1 will
- * not be allowed to automatically go inactive if pwrdm2 is active;
- * 0 if pwrdm1's automatic power state inactivity transition is indepe=
ndent
- * of pwrdm2's; -EINVAL if either powerdomain pointer is invalid or ca=
lled
- * on a machine that does not support software-configurable hardware s=
leep
- * dependencies; or -ENOENT if the hardware is incapable.
- *
- * REVISIT: Currently this function only represents software-controlla=
ble
- * sleep dependencies.	Sleep dependencies fixed in hardware are not
- * yet handled here.
- */
-int pwrdm_read_sleepdep(struct powerdomain *pwrdm1, struct powerdomain=
 *pwrdm2)
-{
-	struct powerdomain *p;
-
-	if (!cpu_is_omap34xx())
-		return -EINVAL;
-
-	if (!pwrdm1)
-		return -EINVAL;
-
-	p =3D _pwrdm_deps_lookup(pwrdm2, pwrdm1->sleepdep_srcs);
-	if (IS_ERR(p)) {
-		pr_debug("powerdomain: hardware cannot set/clear sleep "
-			 "dependency affecting %s from %s\n", pwrdm1->name,
-			 pwrdm2->name);
-		return PTR_ERR(p);
-	}
-
-	return prm_read_mod_bits_shift(pwrdm1->prcm_offs, OMAP3430_CM_SLEEPDE=
P,
-					(1 << pwrdm2->dep_bit));
-}
-
 /**
  * pwrdm_get_mem_bank_count - get number of memory banks in this power=
domain
  * @pwrdm: struct powerdomain *
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/p=
owerdomains.h
index d646c99..faa8fc9 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -1,8 +1,8 @@
 /*
  * OMAP2/3 common powerdomain definitions
  *
- * Copyright (C) 2007-8 Texas Instruments, Inc.
- * Copyright (C) 2007-8 Nokia Corporation
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  * Debugging and integration fixes by Jouni H=C3=B6gander
@@ -25,19 +25,8 @@
  * This file contains all of the powerdomains that have some element
  * of software control for the OMAP24xx and OMAP34XX chips.
  *
- * A few notes:
- *
  * This is not an exhaustive listing of powerdomains on the chips; onl=
y
  * powerdomains that can be controlled in software.
- *
- * A useful validation rule for struct powerdomain:
- * Any powerdomain referenced by a wkdep_srcs or sleepdep_srcs array
- * must have a dep_bit assigned.  So wkdep_srcs/sleepdep_srcs are real=
ly
- * just software-controllable dependencies.  Non-software-controllable
- * dependencies do exist, but they are not encoded below (yet).
- *
- * 24xx does not support programmable sleep dependencies (SLEEPDEP)
- *
  */
=20
 /*
@@ -47,26 +36,17 @@
  *
  * On the 2420, this is a 'C55 DSP called, simply, the DSP.  Its
  * powerdomain is called the "DSP power domain."  On the 2430, the
- * on-board DSP is a 'C64 DSP, now called the IVA2 or IVA2.1.  Its
- * powerdomain is still called the "DSP power domain."	On the 3430,
- * the DSP is a 'C64 DSP like the 2430, also known as the IVA2; but
- * its powerdomain is now called the "IVA2 power domain."
+ * on-board DSP is a 'C64 DSP, now called (along with its hardware
+ * accelerators) the IVA2 or IVA2.1.  Its powerdomain is still called
+ * the "DSP power domain." On the 3430, the DSP is a 'C64 DSP like the
+ * 2430, also known as the IVA2; but its powerdomain is now called the
+ * "IVA2 power domain."
  *
  * The 2420 also has something called the IVA, which is a separate ARM
  * core, and has nothing to do with the DSP/IVA2.
  *
  * Ideally the DSP/IVA2 could just be the same powerdomain, but the PR=
CM
  * address offset is different between the C55 and C64 DSPs.
- *
- * The overly-specific dep_bit names are due to a bit name collision
- * with CM_FCLKEN_{DSP,IVA2}.  The DSP/IVA2 PM_WKDEP and CM_SLEEPDEP s=
hift
- * value are the same for all powerdomains: 2
- */
-
-/*
- * XXX should dep_bit be a mask, so we can test to see if it is 0 as a
- * sanity check?
- * XXX encode hardware fixed wakeup dependencies -- esp. for 3430 CORE
  */
=20
 #include <plat/powerdomain.h>
@@ -74,60 +54,11 @@
 #include "prcm-common.h"
 #include "prm.h"
 #include "cm.h"
-
-/* OMAP2/3-common powerdomains and wakeup dependencies */
-
-#ifndef CONFIG_ARCH_OMAP4
-/*
- * 2420/2430 PM_WKDEP_GFX: CORE, MPU, WKUP
- * 3430ES1 PM_WKDEP_GFX: adds IVA2, removes CORE
- * 3430ES2 PM_WKDEP_SGX: adds IVA2, removes CORE
- */
-static struct pwrdm_dep gfx_sgx_wkdeps[] =3D {
-	{
-		.pwrdm_name =3D "core_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name =3D "iva2_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "mpu_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-					    CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "wkup_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-					    CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/*
- * 3430: CM_SLEEPDEP_CAM: MPU
- * 3430ES1: CM_SLEEPDEP_GFX: MPU
- * 3430ES2: CM_SLEEPDEP_SGX: MPU
- */
-static struct pwrdm_dep cam_gfx_sleepdeps[] =3D {
-	{
-		.pwrdm_name =3D "mpu_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-#endif
-
-
 #include "powerdomains24xx.h"
 #include "powerdomains34xx.h"
 #include "powerdomains44xx.h"
=20
-
-/*
- * OMAP2/3 common powerdomains
- */
+/* OMAP2/3-common powerdomains */
=20
 #if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
=20
@@ -140,8 +71,6 @@ static struct powerdomain gfx_omap2_pwrdm =3D {
 	.prcm_offs	  =3D GFX_MOD,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
 					   CHIP_IS_OMAP3430ES1),
-	.wkdep_srcs	  =3D gfx_sgx_wkdeps,
-	.sleepdep_srcs	  =3D cam_gfx_sleepdeps,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
 	.banks		  =3D 1,
@@ -157,7 +86,6 @@ static struct powerdomain wkup_omap2_pwrdm =3D {
 	.name		=3D "wkup_pwrdm",
 	.prcm_offs	=3D WKUP_MOD,
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
-	.dep_bit	=3D OMAP_EN_WKUP_SHIFT,
 };
=20
 #endif
diff --git a/arch/arm/mach-omap2/powerdomains24xx.h b/arch/arm/mach-oma=
p2/powerdomains24xx.h
index bd249a4..652a01b 100644
--- a/arch/arm/mach-omap2/powerdomains24xx.h
+++ b/arch/arm/mach-omap2/powerdomains24xx.h
@@ -2,7 +2,7 @@
  * OMAP24XX powerdomain definitions
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2008 Nokia Corporation
+ * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  * Debugging and integration fixes by Jouni H=C3=B6gander
@@ -32,90 +32,12 @@
=20
 #ifdef CONFIG_ARCH_OMAP24XX
=20
-
-/* Wakeup dependency source arrays */
-
-/*
- * 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP
- * 2430 PM_WKDEP_MDM: same as above
- */
-static struct pwrdm_dep dsp_mdm_24xx_wkdeps[] =3D {
-	{
-		.pwrdm_name =3D "core_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name =3D "mpu_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name =3D "wkup_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{ NULL },
-};
-
-/*
- * 2420 PM_WKDEP_MPU: CORE, DSP, WKUP
- * 2430 adds MDM
- */
-static struct pwrdm_dep mpu_24xx_wkdeps[] =3D {
-	{
-		.pwrdm_name =3D "core_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name =3D "dsp_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name =3D "wkup_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name =3D "mdm_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
-	},
-	{ NULL },
-};
-
-/*
- * 2420 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP
- * 2430 adds MDM
- */
-static struct pwrdm_dep core_24xx_wkdeps[] =3D {
-	{
-		.pwrdm_name =3D "dsp_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name =3D "gfx_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name =3D "mpu_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name =3D "wkup_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
-	},
-	{
-		.pwrdm_name =3D "mdm_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
-	},
-	{ NULL },
-};
-
-
 /* Powerdomains */
=20
 static struct powerdomain dsp_pwrdm =3D {
 	.name		  =3D "dsp_pwrdm",
 	.prcm_offs	  =3D OMAP24XX_DSP_MOD,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
-	.dep_bit	  =3D OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
-	.wkdep_srcs	  =3D dsp_mdm_24xx_wkdeps,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
 	.banks		  =3D 1,
@@ -131,8 +53,6 @@ static struct powerdomain mpu_24xx_pwrdm =3D {
 	.name		  =3D "mpu_pwrdm",
 	.prcm_offs	  =3D MPU_MOD,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
-	.dep_bit	  =3D OMAP24XX_EN_MPU_SHIFT,
-	.wkdep_srcs	  =3D mpu_24xx_wkdeps,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 1,
@@ -148,9 +68,7 @@ static struct powerdomain core_24xx_pwrdm =3D {
 	.name		  =3D "core_pwrdm",
 	.prcm_offs	  =3D CORE_MOD,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
-	.wkdep_srcs	  =3D core_24xx_wkdeps,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
-	.dep_bit	  =3D OMAP24XX_EN_CORE_SHIFT,
 	.banks		  =3D 3,
 	.pwrsts_mem_ret	  =3D {
 		[0] =3D PWRSTS_OFF_RET,	 /* MEM1RETSTATE */
@@ -176,13 +94,10 @@ static struct powerdomain core_24xx_pwrdm =3D {
=20
 /* XXX 2430 KILLDOMAINWKUP bit?  No current users apparently */
=20
-/* Another case of bit name collisions between several registers: EN_M=
DM */
 static struct powerdomain mdm_pwrdm =3D {
 	.name		  =3D "mdm_pwrdm",
 	.prcm_offs	  =3D OMAP2430_MDM_MOD,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-	.dep_bit	  =3D OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
-	.wkdep_srcs	  =3D dsp_mdm_24xx_wkdeps,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
 	.banks		  =3D 1,
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-oma=
p2/powerdomains34xx.h
index 588f7e0..28228ef 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -2,7 +2,7 @@
  * OMAP34XX powerdomain definitions
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2008 Nokia Corporation
+ * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  * Debugging and integration fixes by Jouni H=C3=B6gander
@@ -35,127 +35,6 @@
 #ifdef CONFIG_ARCH_OMAP34XX
=20
 /*
- * 3430: PM_WKDEP_{PER,USBHOST}: CORE, IVA2, MPU, WKUP
- * (USBHOST is ES2 only)
- */
-static struct pwrdm_dep per_usbhost_wkdeps[] =3D {
-	{
-		.pwrdm_name =3D "core_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "iva2_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "mpu_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "wkup_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/*
- * 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER
- */
-static struct pwrdm_dep mpu_34xx_wkdeps[] =3D {
-	{
-		.pwrdm_name =3D "core_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "iva2_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "dss_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "per_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/*
- * 3430 PM_WKDEP_IVA2: CORE, MPU, WKUP, DSS, PER
- */
-static struct pwrdm_dep iva2_wkdeps[] =3D {
-	{
-		.pwrdm_name =3D "core_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "mpu_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "wkup_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "dss_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "per_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-
-/* 3430 PM_WKDEP_{CAM,DSS}: IVA2, MPU, WKUP */
-static struct pwrdm_dep cam_dss_wkdeps[] =3D {
-	{
-		.pwrdm_name =3D "iva2_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "mpu_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "wkup_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-/* 3430: PM_WKDEP_NEON: MPU */
-static struct pwrdm_dep neon_wkdeps[] =3D {
-	{
-		.pwrdm_name =3D "mpu_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-
-/* Sleep dependency source arrays for 34xx-specific pwrdms - 34XX only=
 */
-
-/*
- * 3430: CM_SLEEPDEP_{DSS,PER}: MPU, IVA
- * 3430ES2: CM_SLEEPDEP_USBHOST: MPU, IVA
- */
-static struct pwrdm_dep dss_per_usbhost_sleepdeps[] =3D {
-	{
-		.pwrdm_name =3D "mpu_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{
-		.pwrdm_name =3D "iva2_pwrdm",
-		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
-	},
-	{ NULL },
-};
-
-
-/*
  * Powerdomains
  */
=20
@@ -163,8 +42,6 @@ static struct powerdomain iva2_pwrdm =3D {
 	.name		  =3D "iva2_pwrdm",
 	.prcm_offs	  =3D OMAP3430_IVA2_MOD,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-	.dep_bit	  =3D OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
-	.wkdep_srcs	  =3D iva2_wkdeps,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 4,
@@ -186,8 +63,6 @@ static struct powerdomain mpu_34xx_pwrdm =3D {
 	.name		  =3D "mpu_pwrdm",
 	.prcm_offs	  =3D MPU_MOD,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-	.dep_bit	  =3D OMAP3430_EN_MPU_SHIFT,
-	.wkdep_srcs	  =3D mpu_34xx_wkdeps,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.flags		  =3D PWRDM_HAS_MPU_QUIRK,
@@ -200,7 +75,6 @@ static struct powerdomain mpu_34xx_pwrdm =3D {
 	},
 };
=20
-/* No wkdeps or sleepdeps for 34xx core apparently */
 static struct powerdomain core_34xx_pre_es3_1_pwrdm =3D {
 	.name		  =3D "core_pwrdm",
 	.prcm_offs	  =3D CORE_MOD,
@@ -208,7 +82,6 @@ static struct powerdomain core_34xx_pre_es3_1_pwrdm =
=3D {
 					   CHIP_IS_OMAP3430ES2 |
 					   CHIP_IS_OMAP3430ES3_0),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
-	.dep_bit	  =3D OMAP3430_EN_CORE_SHIFT,
 	.banks		  =3D 2,
 	.pwrsts_mem_ret	  =3D {
 		[0] =3D PWRSTS_OFF_RET,	 /* MEM1RETSTATE */
@@ -220,13 +93,11 @@ static struct powerdomain core_34xx_pre_es3_1_pwrd=
m =3D {
 	},
 };
=20
-/* No wkdeps or sleepdeps for 34xx core apparently */
 static struct powerdomain core_34xx_es3_1_pwrdm =3D {
 	.name		  =3D "core_pwrdm",
 	.prcm_offs	  =3D CORE_MOD,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
-	.dep_bit	  =3D OMAP3430_EN_CORE_SHIFT,
 	.flags		  =3D PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
 	.banks		  =3D 2,
 	.pwrsts_mem_ret	  =3D {
@@ -239,14 +110,10 @@ static struct powerdomain core_34xx_es3_1_pwrdm =3D=
 {
 	},
 };
=20
-/* Another case of bit name collisions between several registers: EN_D=
SS */
 static struct powerdomain dss_pwrdm =3D {
 	.name		  =3D "dss_pwrdm",
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.prcm_offs	  =3D OMAP3430_DSS_MOD,
-	.dep_bit	  =3D OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
-	.wkdep_srcs	  =3D cam_dss_wkdeps,
-	.sleepdep_srcs	  =3D dss_per_usbhost_sleepdeps,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
 	.banks		  =3D 1,
@@ -267,8 +134,6 @@ static struct powerdomain sgx_pwrdm =3D {
 	.name		  =3D "sgx_pwrdm",
 	.prcm_offs	  =3D OMAP3430ES2_SGX_MOD,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
-	.wkdep_srcs	  =3D gfx_sgx_wkdeps,
-	.sleepdep_srcs	  =3D cam_gfx_sleepdeps,
 	/* XXX This is accurate for 3430 SGX, but what about GFX? */
 	.pwrsts		  =3D PWRSTS_OFF_ON,
 	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
@@ -285,8 +150,6 @@ static struct powerdomain cam_pwrdm =3D {
 	.name		  =3D "cam_pwrdm",
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.prcm_offs	  =3D OMAP3430_CAM_MOD,
-	.wkdep_srcs	  =3D cam_dss_wkdeps,
-	.sleepdep_srcs	  =3D cam_gfx_sleepdeps,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
 	.banks		  =3D 1,
@@ -302,9 +165,6 @@ static struct powerdomain per_pwrdm =3D {
 	.name		  =3D "per_pwrdm",
 	.prcm_offs	  =3D OMAP3430_PER_MOD,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-	.dep_bit	  =3D OMAP3430_EN_PER_SHIFT,
-	.wkdep_srcs	  =3D per_usbhost_wkdeps,
-	.sleepdep_srcs	  =3D dss_per_usbhost_sleepdeps,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 1,
@@ -326,7 +186,6 @@ static struct powerdomain neon_pwrdm =3D {
 	.name		  =3D "neon_pwrdm",
 	.prcm_offs	  =3D OMAP3430_NEON_MOD,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-	.wkdep_srcs	  =3D neon_wkdeps,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
 };
@@ -335,8 +194,6 @@ static struct powerdomain usbhost_pwrdm =3D {
 	.name		  =3D "usbhost_pwrdm",
 	.prcm_offs	  =3D OMAP3430ES2_USBHOST_MOD,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
-	.wkdep_srcs	  =3D per_usbhost_wkdeps,
-	.sleepdep_srcs	  =3D dss_per_usbhost_sleepdeps,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
 	/*
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index cc621e2..63330d2 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -202,6 +202,18 @@ u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 m=
odule, s16 idx)
 	return v;
 }
=20
+/* Read a PRM register, AND it, and shift the result down to bit 0 */
+u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+{
+	u32 v;
+
+	v =3D prm_read_mod_reg(domain, idx);
+	v &=3D mask;
+	v >>=3D __ffs(mask);
+
+	return v;
+}
+
 /* Read a register in a CM module */
 u32 cm_read_mod_reg(s16 module, u16 idx)
 {
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/p=
lat-omap/include/plat/clockdomain.h
index 4806e2c..f77ca72 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -4,7 +4,7 @@
  * OMAP2/3 clockdomain framework functions
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2008-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  *
@@ -41,26 +41,40 @@
 #define OMAP34XX_CLKSTCTRL_ENABLE_AUTO		0x3
=20
 /*
- * struct clkdm_pwrdm_autodep - a powerdomain that should have wkdeps
- * and sleepdeps added when a powerdomain should stay active in hwsup =
mode;
- * and conversely, removed when the powerdomain should be allowed to g=
o
+ * struct clkdm_autodep - a clockdomain that should have wkdeps
+ * and sleepdeps added when a clockdomain should stay active in hwsup =
mode;
+ * and conversely, removed when the clockdomain should be allowed to g=
o
  * inactive in hwsup mode.
  */
-struct clkdm_pwrdm_autodep {
+struct clkdm_autodep {
=20
 	union {
-		/* Name of the powerdomain to add a wkdep/sleepdep on */
+		/* Name of the clockdomain to add a wkdep/sleepdep on */
 		const char *name;
=20
-		/* Powerdomain pointer (looked up at clkdm_init() time) */
-		struct powerdomain *ptr;
-	} pwrdm;
+		/* Clockdomain pointer (looked up at clkdm_init() time) */
+		struct clockdomain *ptr;
+	} clkdm;
=20
 	/* OMAP chip types that this clockdomain dep is valid on */
 	const struct omap_chip_id omap_chip;
=20
 };
=20
+/* Encodes dependencies between clockdomains - statically defined */
+struct clkdm_dep {
+
+	/* Clockdomain name */
+	const char *clkdm_name;
+
+	/* Clockdomain pointer - resolved by the clockdomain code */
+	struct clockdomain *clkdm;
+
+	/* Flags to mark OMAP chip restrictions, etc. */
+	const struct omap_chip_id omap_chip;
+
+};
+
 struct clockdomain {
=20
 	/* Clockdomain name */
@@ -83,6 +97,15 @@ struct clockdomain {
 	/* Clockdomain capability flags */
 	const u8 flags;
=20
+	/* Bit shift of this clockdomain's PM_WKDEP/CM_SLEEPDEP bit */
+	const u8 dep_bit;
+
+	/* Clockdomains that can be told to wake this powerdomain up */
+	struct clkdm_dep *wkdep_srcs;
+
+	/* Clockdomains that can be told to keep this clkdm from inactivity *=
/
+	struct clkdm_dep *sleepdep_srcs;
+
 	/* OMAP chip types that this clockdomain is valid on */
 	const struct omap_chip_id omap_chip;
=20
@@ -93,7 +116,7 @@ struct clockdomain {
=20
 };
=20
-void clkdm_init(struct clockdomain **clkdms, struct clkdm_pwrdm_autode=
p *autodeps);
+void clkdm_init(struct clockdomain **clkdms, struct clkdm_autodep *aut=
odeps);
 int clkdm_register(struct clockdomain *clkdm);
 int clkdm_unregister(struct clockdomain *clkdm);
 struct clockdomain *clkdm_lookup(const char *name);
@@ -102,6 +125,13 @@ int clkdm_for_each(int (*fn)(struct clockdomain *c=
lkdm, void *user),
 			void *user);
 struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
=20
+int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *cl=
kdm2);
+int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *cl=
kdm2);
+int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *c=
lkdm2);
+int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain =
*clkdm2);
+int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain =
*clkdm2);
+int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain=
 *clkdm2);
+
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
 void omap2_clkdm_deny_idle(struct clockdomain *clkdm);
=20
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/p=
lat-omap/include/plat/powerdomain.h
index bac378e..dd5f79d 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -1,8 +1,8 @@
 /*
  * OMAP2/3 powerdomain control
  *
- * Copyright (C) 2007-8 Texas Instruments, Inc.
- * Copyright (C) 2007-8 Nokia Corporation
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
  *
@@ -68,20 +68,6 @@
 struct clockdomain;
 struct powerdomain;
=20
-/* Encodes dependencies between powerdomains - statically defined */
-struct pwrdm_dep {
-
-	/* Powerdomain name */
-	const char *pwrdm_name;
-
-	/* Powerdomain pointer - resolved by the powerdomain code */
-	struct powerdomain *pwrdm;
-
-	/* Flags to mark OMAP chip restrictions, etc. */
-	const struct omap_chip_id omap_chip;
-
-};
-
 struct powerdomain {
=20
 	/* Powerdomain name */
@@ -93,15 +79,6 @@ struct powerdomain {
 	/* Used to represent the OMAP chip types containing this pwrdm */
 	const struct omap_chip_id omap_chip;
=20
-	/* Powerdomains that can be told to wake this powerdomain up */
-	struct pwrdm_dep *wkdep_srcs;
-
-	/* Powerdomains that can be told to keep this pwrdm from inactivity *=
/
-	struct pwrdm_dep *sleepdep_srcs;
-
-	/* Bit shift of this powerdomain's PM_WKDEP/CM_SLEEPDEP bit */
-	const u8 dep_bit;
-
 	/* Possible powerdomain power states */
 	const u8 pwrsts;
=20
@@ -152,13 +129,6 @@ int pwrdm_for_each_clkdm(struct powerdomain *pwrdm=
,
 			 int (*fn)(struct powerdomain *pwrdm,
 				   struct clockdomain *clkdm));
=20
-int pwrdm_add_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pw=
rdm2);
-int pwrdm_del_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pw=
rdm2);
-int pwrdm_read_wkdep(struct powerdomain *pwrdm1, struct powerdomain *p=
wrdm2);
-int pwrdm_add_sleepdep(struct powerdomain *pwrdm1, struct powerdomain =
*pwrdm2);
-int pwrdm_del_sleepdep(struct powerdomain *pwrdm1, struct powerdomain =
*pwrdm2);
-int pwrdm_read_sleepdep(struct powerdomain *pwrdm1, struct powerdomain=
 *pwrdm2);
-
 int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
=20
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-oma=
p/include/plat/prcm.h
index e63e94e..66938a9 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -33,6 +33,14 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask=
, const char *name);
 void omap3_prcm_save_context(void);
 void omap3_prcm_restore_context(void);
=20
+u32 prm_read_mod_reg(s16 module, u16 idx);
+void prm_write_mod_reg(u32 val, s16 module, u16 idx);
+u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
+u32 cm_read_mod_reg(s16 module, u16 idx);
+void cm_write_mod_reg(u32 val, s16 module, u16 idx);
+u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+
 #endif
=20
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
