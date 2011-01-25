From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 2/5] OMAP: clockdomain: Arch specific funcs to handle deps
Date: Tue, 25 Jan 2011 17:21:45 +0530
Message-ID: <1295956308-23860-3-git-send-email-rnayak@ti.com>
References: <1295956308-23860-1-git-send-email-rnayak@ti.com>
 <1295956308-23860-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54970 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab1AYLwK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 06:52:10 -0500
In-Reply-To: <1295956308-23860-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

Define the following architecture specific funtions for omap2/3
.clkdm_add_wkdep
.clkdm_del_wkdep
.clkdm_read_wkdep
.clkdm_clear_all_wkdeps
.clkdm_add_sleepdep
.clkdm_del_sleepdep
.clkdm_read_sleepdep
.clkdm_clear_all_sleepdeps

Convert the platform-independent framework to call these functions.
With this also move the clkdm lookups for all wkdep_srcs and
sleepdep_srcs at clkdm_init.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile                     |    2 +
 arch/arm/mach-omap2/clockdomain.c                |  160 +++++++++++-----------
 arch/arm/mach-omap2/clockdomain.h                |    6 +-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c       |  126 +++++++++++++++++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    9 +-
 arch/arm/mach-omap2/io.c                         |    6 +-
 6 files changed, 225 insertions(+), 84 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1c0c2b0..6b2824d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -102,8 +102,10 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common) \
 
 # PRCM clockdomain control
 obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain.o \
+					   clockdomain2xxx_3xxx.o \
 					   clockdomains2xxx_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain.o \
+					   clockdomain2xxx_3xxx.o \
 					   clockdomains2xxx_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o \
 					   clockdomains44xx_data.o
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 3e40184..1c461ed 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -308,6 +308,7 @@ void clkdm_init(struct clockdomain **clkdms,
 	struct clockdomain **c = NULL;
 	struct clockdomain *clkdm;
 	struct clkdm_autodep *autodep = NULL;
+	struct clkdm_dep *cd;
 
 	if (!custom_funcs)
 		WARN(1, "No custom clkdm functions registered\n");
@@ -333,7 +334,18 @@ void clkdm_init(struct clockdomain **clkdms,
 		else if (clkdm->flags & CLKDM_CAN_DISABLE_AUTO)
 			omap2_clkdm_deny_idle(clkdm);
 
+		for (cd = clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
+			if (!omap_chip_is(cd->omap_chip))
+				continue;
+			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
+		}
 		clkdm_clear_all_wkdeps(clkdm);
+
+		for (cd = clkdm->sleepdep_srcs; cd && cd->clkdm_name; cd++) {
+			if (!omap_chip_is(cd->omap_chip))
+				continue;
+			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
+		}
 		clkdm_clear_all_sleepdeps(clkdm);
 	}
 }
@@ -430,26 +442,32 @@ struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm)
 int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 {
 	struct clkdm_dep *cd;
+	int ret = 0;
 
 	if (!clkdm1 || !clkdm2)
 		return -EINVAL;
 
 	cd = _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
-	if (IS_ERR(cd)) {
+	if (IS_ERR(cd))
+		ret = PTR_ERR(cd);
+
+	if (!arch_clkdm || !arch_clkdm->clkdm_add_wkdep)
+		ret = -EINVAL;
+
+	if (ret) {
 		pr_debug("clockdomain: hardware cannot set/clear wake up of "
 			 "%s when %s wakes up\n", clkdm1->name, clkdm2->name);
-		return PTR_ERR(cd);
+		return ret;
 	}
 
 	if (atomic_inc_return(&cd->wkdep_usecount) == 1) {
 		pr_debug("clockdomain: hardware will wake up %s when %s wakes "
 			 "up\n", clkdm1->name, clkdm2->name);
 
-		omap2_prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
-				     clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+		ret = arch_clkdm->clkdm_add_wkdep(clkdm1, clkdm2);
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -465,26 +483,32 @@ int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 {
 	struct clkdm_dep *cd;
+	int ret = 0;
 
 	if (!clkdm1 || !clkdm2)
 		return -EINVAL;
 
 	cd = _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
-	if (IS_ERR(cd)) {
+	if (IS_ERR(cd))
+		ret = PTR_ERR(cd);
+
+	if (!arch_clkdm || !arch_clkdm->clkdm_del_wkdep)
+		ret = -EINVAL;
+
+	if (ret) {
 		pr_debug("clockdomain: hardware cannot set/clear wake up of "
 			 "%s when %s wakes up\n", clkdm1->name, clkdm2->name);
-		return PTR_ERR(cd);
+		return ret;
 	}
 
 	if (atomic_dec_return(&cd->wkdep_usecount) == 0) {
 		pr_debug("clockdomain: hardware will no longer wake up %s "
 			 "after %s wakes up\n", clkdm1->name, clkdm2->name);
 
-		omap2_prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
-				       clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+		ret = arch_clkdm->clkdm_del_wkdep(clkdm1, clkdm2);
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -504,20 +528,26 @@ int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 {
 	struct clkdm_dep *cd;
+	int ret = 0;
 
 	if (!clkdm1 || !clkdm2)
 		return -EINVAL;
 
 	cd = _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
-	if (IS_ERR(cd)) {
+	if (IS_ERR(cd))
+		ret = PTR_ERR(cd);
+
+	if (!arch_clkdm || !arch_clkdm->clkdm_read_wkdep)
+		ret = -EINVAL;
+
+	if (ret) {
 		pr_debug("clockdomain: hardware cannot set/clear wake up of "
 			 "%s when %s wakes up\n", clkdm1->name, clkdm2->name);
-		return PTR_ERR(cd);
+		return ret;
 	}
 
 	/* XXX It's faster to return the atomic wkdep_usecount */
-	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP,
-				       (1 << clkdm2->dep_bit));
+	return arch_clkdm->clkdm_read_wkdep(clkdm1, clkdm2);
 }
 
 /**
@@ -532,27 +562,13 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
  */
 int clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
 {
-	struct clkdm_dep *cd;
-	u32 mask = 0;
-
 	if (!clkdm)
 		return -EINVAL;
 
-	for (cd = clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
-		if (!omap_chip_is(cd->omap_chip))
-			continue;
-
-		if (!cd->clkdm && cd->clkdm_name)
-			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
-
-		/* PRM accesses are slow, so minimize them */
-		mask |= 1 << cd->clkdm->dep_bit;
-		atomic_set(&cd->wkdep_usecount, 0);
-	}
-
-	omap2_prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs, PM_WKDEP);
+	if (!arch_clkdm || !arch_clkdm->clkdm_clear_all_wkdeps)
+		return -EINVAL;
 
-	return 0;
+	return arch_clkdm->clkdm_clear_all_wkdeps(clkdm);
 }
 
 /**
@@ -570,31 +586,33 @@ int clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
 int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 {
 	struct clkdm_dep *cd;
-
-	if (!cpu_is_omap34xx())
-		return -EINVAL;
+	int ret = 0;
 
 	if (!clkdm1 || !clkdm2)
 		return -EINVAL;
 
 	cd = _clkdm_deps_lookup(clkdm2, clkdm1->sleepdep_srcs);
-	if (IS_ERR(cd)) {
+	if (IS_ERR(cd))
+		ret = PTR_ERR(cd);
+
+	if (!arch_clkdm || !arch_clkdm->clkdm_add_sleepdep)
+		ret = -EINVAL;
+
+	if (ret) {
 		pr_debug("clockdomain: hardware cannot set/clear sleep "
 			 "dependency affecting %s from %s\n", clkdm1->name,
 			 clkdm2->name);
-		return PTR_ERR(cd);
+		return ret;
 	}
 
 	if (atomic_inc_return(&cd->sleepdep_usecount) == 1) {
 		pr_debug("clockdomain: will prevent %s from sleeping if %s "
 			 "is active\n", clkdm1->name, clkdm2->name);
 
-		omap2_cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
-				    clkdm1->pwrdm.ptr->prcm_offs,
-				    OMAP3430_CM_SLEEPDEP);
+		ret = arch_clkdm->clkdm_add_sleepdep(clkdm1, clkdm2);
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -612,19 +630,23 @@ int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 {
 	struct clkdm_dep *cd;
-
-	if (!cpu_is_omap34xx())
-		return -EINVAL;
+	int ret = 0;
 
 	if (!clkdm1 || !clkdm2)
 		return -EINVAL;
 
 	cd = _clkdm_deps_lookup(clkdm2, clkdm1->sleepdep_srcs);
-	if (IS_ERR(cd)) {
+	if (IS_ERR(cd))
+		ret = PTR_ERR(cd);
+
+	if (!arch_clkdm || !arch_clkdm->clkdm_del_sleepdep)
+		ret = -EINVAL;
+
+	if (ret) {
 		pr_debug("clockdomain: hardware cannot set/clear sleep "
 			 "dependency affecting %s from %s\n", clkdm1->name,
 			 clkdm2->name);
-		return PTR_ERR(cd);
+		return ret;
 	}
 
 	if (atomic_dec_return(&cd->sleepdep_usecount) == 0) {
@@ -632,12 +654,10 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 			 "sleeping if %s is active\n", clkdm1->name,
 			 clkdm2->name);
 
-		omap2_cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
-				      clkdm1->pwrdm.ptr->prcm_offs,
-				      OMAP3430_CM_SLEEPDEP);
+		ret = arch_clkdm->clkdm_del_sleepdep(clkdm1, clkdm2);
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -659,25 +679,27 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 {
 	struct clkdm_dep *cd;
-
-	if (!cpu_is_omap34xx())
-		return -EINVAL;
+	int ret = 0;
 
 	if (!clkdm1 || !clkdm2)
 		return -EINVAL;
 
 	cd = _clkdm_deps_lookup(clkdm2, clkdm1->sleepdep_srcs);
-	if (IS_ERR(cd)) {
+	if (IS_ERR(cd))
+		ret = PTR_ERR(cd);
+
+	if (!arch_clkdm || !arch_clkdm->clkdm_read_sleepdep)
+		ret = -EINVAL;
+
+	if (ret) {
 		pr_debug("clockdomain: hardware cannot set/clear sleep "
 			 "dependency affecting %s from %s\n", clkdm1->name,
 			 clkdm2->name);
-		return PTR_ERR(cd);
+		return ret;
 	}
 
 	/* XXX It's faster to return the atomic sleepdep_usecount */
-	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
-				       OMAP3430_CM_SLEEPDEP,
-				       (1 << clkdm2->dep_bit));
+	return arch_clkdm->clkdm_read_sleepdep(clkdm1, clkdm2);
 }
 
 /**
@@ -692,31 +714,13 @@ int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
  */
 int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
 {
-	struct clkdm_dep *cd;
-	u32 mask = 0;
-
-	if (!cpu_is_omap34xx())
-		return -EINVAL;
-
 	if (!clkdm)
 		return -EINVAL;
 
-	for (cd = clkdm->sleepdep_srcs; cd && cd->clkdm_name; cd++) {
-		if (!omap_chip_is(cd->omap_chip))
-			continue;
-
-		if (!cd->clkdm && cd->clkdm_name)
-			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
-
-		/* PRM accesses are slow, so minimize them */
-		mask |= 1 << cd->clkdm->dep_bit;
-		atomic_set(&cd->sleepdep_usecount, 0);
-	}
-
-	omap2_prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
-			       OMAP3430_CM_SLEEPDEP);
+	if (!arch_clkdm || !arch_clkdm->clkdm_clear_all_sleepdeps)
+		return -EINVAL;
 
-	return 0;
+	return arch_clkdm->clkdm_clear_all_sleepdeps(clkdm);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 71ad265..90b6d6a 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -176,7 +176,11 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm);
 int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
 int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
 
-extern void __init omap2_clockdomains_init(void);
+extern void __init omap2xxx_clockdomains_init(void);
+extern void __init omap3xxx_clockdomains_init(void);
 extern void __init omap44xx_clockdomains_init(void);
 
+extern struct clkdm_ops omap2_clkdm_operations;
+extern struct clkdm_ops omap3_clkdm_operations;
+
 #endif
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
new file mode 100644
index 0000000..58b0626
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -0,0 +1,126 @@
+/*
+ * OMAP2 and OMAP3 clockdomain control
+ *
+ * Copyright (C) 2008-2010 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ *
+ * Derived from mach-omap2/clockdomain.c written by Paul Walmsley
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/types.h>
+#include <plat/prcm.h>
+#include "prm.h"
+#include "prm2xxx_3xxx.h"
+#include "cm.h"
+#include "cm2xxx_3xxx.h"
+#include "cm-regbits-24xx.h"
+#include "cm-regbits-34xx.h"
+#include "clockdomain.h"
+
+static int omap2_clkdm_add_wkdep(struct clockdomain *clkdm1,
+						struct clockdomain *clkdm2)
+{
+	omap2_prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+				clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+	return 0;
+}
+
+static int omap2_clkdm_del_wkdep(struct clockdomain *clkdm1,
+						 struct clockdomain *clkdm2)
+{
+	omap2_prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+				clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+	return 0;
+}
+
+static int omap2_clkdm_read_wkdep(struct clockdomain *clkdm1,
+						 struct clockdomain *clkdm2)
+{
+	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
+				PM_WKDEP, (1 << clkdm2->dep_bit));
+}
+
+static int omap2_clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
+{
+	struct clkdm_dep *cd;
+	u32 mask = 0;
+
+	for (cd = clkdm->wkdep_srcs; cd && cd->clkdm; cd++) {
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		/* PRM accesses are slow, so minimize them */
+		mask |= 1 << cd->clkdm->dep_bit;
+		atomic_set(&cd->wkdep_usecount, 0);
+	}
+
+	omap2_prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
+				 PM_WKDEP);
+	return 0;
+}
+
+static int omap3_clkdm_add_sleepdep(struct clockdomain *clkdm1,
+						 struct clockdomain *clkdm2)
+{
+	omap2_cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+				clkdm1->pwrdm.ptr->prcm_offs,
+				OMAP3430_CM_SLEEPDEP);
+	return 0;
+}
+
+static int omap3_clkdm_del_sleepdep(struct clockdomain *clkdm1,
+						 struct clockdomain *clkdm2)
+{
+	omap2_cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+				clkdm1->pwrdm.ptr->prcm_offs,
+				OMAP3430_CM_SLEEPDEP);
+	return 0;
+}
+
+static int omap3_clkdm_read_sleepdep(struct clockdomain *clkdm1,
+						 struct clockdomain *clkdm2)
+{
+	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
+				OMAP3430_CM_SLEEPDEP, (1 << clkdm2->dep_bit));
+}
+
+static int omap3_clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
+{
+	struct clkdm_dep *cd;
+	u32 mask = 0;
+
+	for (cd = clkdm->sleepdep_srcs; cd && cd->clkdm; cd++) {
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		/* PRM accesses are slow, so minimize them */
+		mask |= 1 << cd->clkdm->dep_bit;
+		atomic_set(&cd->sleepdep_usecount, 0);
+	}
+	omap2_prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
+				OMAP3430_CM_SLEEPDEP);
+	return 0;
+}
+
+struct clkdm_ops omap2_clkdm_operations = {
+	.clkdm_add_wkdep	= omap2_clkdm_add_wkdep,
+	.clkdm_del_wkdep	= omap2_clkdm_del_wkdep,
+	.clkdm_read_wkdep	= omap2_clkdm_read_wkdep,
+	.clkdm_clear_all_wkdeps	= omap2_clkdm_clear_all_wkdeps,
+};
+
+struct clkdm_ops omap3_clkdm_operations = {
+	.clkdm_add_wkdep	= omap2_clkdm_add_wkdep,
+	.clkdm_del_wkdep	= omap2_clkdm_del_wkdep,
+	.clkdm_read_wkdep	= omap2_clkdm_read_wkdep,
+	.clkdm_clear_all_wkdeps	= omap2_clkdm_clear_all_wkdeps,
+	.clkdm_add_sleepdep	= omap3_clkdm_add_sleepdep,
+	.clkdm_del_sleepdep	= omap3_clkdm_del_sleepdep,
+	.clkdm_read_sleepdep	= omap3_clkdm_read_sleepdep,
+	.clkdm_clear_all_sleepdeps	= omap3_clkdm_clear_all_sleepdeps,
+};
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 8cab07a..f85de72 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -854,7 +854,12 @@ static struct clockdomain *clockdomains_omap2[] __initdata = {
 	NULL,
 };
 
-void __init omap2_clockdomains_init(void)
+void __init omap2xxx_clockdomains_init(void)
 {
-	clkdm_init(clockdomains_omap2, clkdm_autodeps, NULL);
+	clkdm_init(clockdomains_omap2, clkdm_autodeps, &omap2_clkdm_operations);
+}
+
+void __init omap3xxx_clockdomains_init(void)
+{
+	clkdm_init(clockdomains_omap2, clkdm_autodeps, &omap3_clkdm_operations);
 }
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e66687b..e1c5e76 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -339,15 +339,15 @@ void __init omap2_init_common_infrastructure(void)
 
 	if (cpu_is_omap242x()) {
 		omap2xxx_powerdomains_init();
-		omap2_clockdomains_init();
+		omap2xxx_clockdomains_init();
 		omap2420_hwmod_init();
 	} else if (cpu_is_omap243x()) {
 		omap2xxx_powerdomains_init();
-		omap2_clockdomains_init();
+		omap2xxx_clockdomains_init();
 		omap2430_hwmod_init();
 	} else if (cpu_is_omap34xx()) {
 		omap3xxx_powerdomains_init();
-		omap2_clockdomains_init();
+		omap3xxx_clockdomains_init();
 		omap3xxx_hwmod_init();
 	} else if (cpu_is_omap44xx()) {
 		omap44xx_powerdomains_init();
-- 
1.7.0.4

