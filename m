From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/5] OMAP: clockdomain: Arch specific funcs to handle deps
Date: Wed,  5 Jan 2011 19:52:42 +0530
Message-ID: <1294237365-10893-3-git-send-email-rnayak@ti.com>
References: <1294237365-10893-1-git-send-email-rnayak@ti.com>
 <1294237365-10893-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60747 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab1AEOW5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 09:22:57 -0500
In-Reply-To: <1294237365-10893-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

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
---
 arch/arm/mach-omap2/Makefile                     |    2 +
 arch/arm/mach-omap2/clockdomain.c                |   80 ++++++---------
 arch/arm/mach-omap2/clockdomain.h                |    2 +
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c       |  113 ++++++++++++++++++++++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    2 +-
 5 files changed, 150 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4ab82f6..d28db0a 100644
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
index 3e40184..c32480c 100644
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
@@ -445,8 +457,8 @@ int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		pr_debug("clockdomain: hardware will wake up %s when %s wakes "
 			 "up\n", clkdm1->name, clkdm2->name);
 
-		omap2_prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
-				     clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+		if (arch_clkdm && arch_clkdm->clkdm_add_wkdep)
+			arch_clkdm->clkdm_add_wkdep(clkdm1, clkdm2);
 	}
 
 	return 0;
@@ -480,8 +492,8 @@ int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		pr_debug("clockdomain: hardware will no longer wake up %s "
 			 "after %s wakes up\n", clkdm1->name, clkdm2->name);
 
-		omap2_prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
-				       clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+		if (arch_clkdm && arch_clkdm->clkdm_del_wkdep)
+			arch_clkdm->clkdm_del_wkdep(clkdm1, clkdm2);
 	}
 
 	return 0;
@@ -516,8 +528,10 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 	}
 
 	/* XXX It's faster to return the atomic wkdep_usecount */
-	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP,
-				       (1 << clkdm2->dep_bit));
+	if (arch_clkdm && arch_clkdm->clkdm_read_wkdep)
+		return arch_clkdm->clkdm_read_wkdep(clkdm1, clkdm2);
+
+	return -EINVAL;
 }
 
 /**
@@ -532,25 +546,11 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
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
+	if (arch_clkdm && arch_clkdm->clkdm_clear_all_wkdeps)
+		arch_clkdm->clkdm_clear_all_wkdeps(clkdm);
 
 	return 0;
 }
@@ -589,9 +589,8 @@ int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		pr_debug("clockdomain: will prevent %s from sleeping if %s "
 			 "is active\n", clkdm1->name, clkdm2->name);
 
-		omap2_cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
-				    clkdm1->pwrdm.ptr->prcm_offs,
-				    OMAP3430_CM_SLEEPDEP);
+		if (arch_clkdm && arch_clkdm->clkdm_add_sleepdep)
+			arch_clkdm->clkdm_add_sleepdep(clkdm1, clkdm2);
 	}
 
 	return 0;
@@ -632,9 +631,8 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 			 "sleeping if %s is active\n", clkdm1->name,
 			 clkdm2->name);
 
-		omap2_cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
-				      clkdm1->pwrdm.ptr->prcm_offs,
-				      OMAP3430_CM_SLEEPDEP);
+		if (arch_clkdm && arch_clkdm->clkdm_del_sleepdep)
+			arch_clkdm->clkdm_del_sleepdep(clkdm1, clkdm2);
 	}
 
 	return 0;
@@ -675,9 +673,10 @@ int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 	}
 
 	/* XXX It's faster to return the atomic sleepdep_usecount */
-	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
-				       OMAP3430_CM_SLEEPDEP,
-				       (1 << clkdm2->dep_bit));
+	if (arch_clkdm && arch_clkdm->clkdm_read_sleepdep)
+		return arch_clkdm->clkdm_read_sleepdep(clkdm1, clkdm2);
+
+	return -EINVAL;
 }
 
 /**
@@ -692,29 +691,14 @@ int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
  */
 int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
 {
-	struct clkdm_dep *cd;
-	u32 mask = 0;
-
 	if (!cpu_is_omap34xx())
 		return -EINVAL;
 
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
+	if (arch_clkdm && arch_clkdm->clkdm_clear_all_sleepdeps)
+		arch_clkdm->clkdm_clear_all_sleepdeps(clkdm);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 346efa2..a9cda27 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -181,4 +181,6 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
 extern void __init omap2_clockdomains_init(void);
 extern void __init omap44xx_clockdomains_init(void);
 
+extern struct clkdm_ops omap2_clkdm_operations;
+
 #endif
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
new file mode 100644
index 0000000..a7303bd
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -0,0 +1,113 @@
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
+static void omap2_clkdm_add_wkdep(struct clockdomain *clkdm1,
+						struct clockdomain *clkdm2)
+{
+	omap2_prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+				clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+}
+
+static void omap2_clkdm_del_wkdep(struct clockdomain *clkdm1,
+						 struct clockdomain *clkdm2)
+{
+	omap2_prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+				clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+}
+
+static int omap2_clkdm_read_wkdep(struct clockdomain *clkdm1,
+						 struct clockdomain *clkdm2)
+{
+	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
+				PM_WKDEP, (1 << clkdm2->dep_bit));
+}
+
+static void omap2_clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
+{
+	struct clkdm_dep *cd;
+	u32 mask = 0;
+
+	for (cd = clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
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
+}
+
+static void omap2_clkdm_add_sleepdep(struct clockdomain *clkdm1,
+						 struct clockdomain *clkdm2)
+{
+	omap2_cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+				clkdm1->pwrdm.ptr->prcm_offs,
+				OMAP3430_CM_SLEEPDEP);
+}
+
+static void omap2_clkdm_del_sleepdep(struct clockdomain *clkdm1,
+						 struct clockdomain *clkdm2)
+{
+	omap2_cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+				clkdm1->pwrdm.ptr->prcm_offs,
+				OMAP3430_CM_SLEEPDEP);
+}
+
+static int omap2_clkdm_read_sleepdep(struct clockdomain *clkdm1,
+						 struct clockdomain *clkdm2)
+{
+	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
+				OMAP3430_CM_SLEEPDEP, (1 << clkdm2->dep_bit));
+}
+
+static void omap2_clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
+{
+	struct clkdm_dep *cd;
+	u32 mask = 0;
+
+	for (cd = clkdm->sleepdep_srcs; cd && cd->clkdm_name; cd++) {
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		/* PRM accesses are slow, so minimize them */
+		mask |= 1 << cd->clkdm->dep_bit;
+		atomic_set(&cd->sleepdep_usecount, 0);
+	}
+	omap2_prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
+				OMAP3430_CM_SLEEPDEP);
+}
+
+struct clkdm_ops omap2_clkdm_operations = {
+	.clkdm_add_wkdep	= omap2_clkdm_add_wkdep,
+	.clkdm_del_wkdep	= omap2_clkdm_del_wkdep,
+	.clkdm_read_wkdep	= omap2_clkdm_read_wkdep,
+	.clkdm_clear_all_wkdeps	= omap2_clkdm_clear_all_wkdeps,
+	.clkdm_add_sleepdep	= omap2_clkdm_add_sleepdep,
+	.clkdm_del_sleepdep	= omap2_clkdm_del_sleepdep,
+	.clkdm_read_sleepdep	= omap2_clkdm_read_sleepdep,
+	.clkdm_clear_all_sleepdeps	= omap2_clkdm_clear_all_sleepdeps,
+};
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 8cab07a..ba0bbbd 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -856,5 +856,5 @@ static struct clockdomain *clockdomains_omap2[] __initdata = {
 
 void __init omap2_clockdomains_init(void)
 {
-	clkdm_init(clockdomains_omap2, clkdm_autodeps, NULL);
+	clkdm_init(clockdomains_omap2, clkdm_autodeps, &omap2_clkdm_operations);
 }
-- 
1.7.0.4

