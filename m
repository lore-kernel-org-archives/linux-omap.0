From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/10] OMAP clockdomains: add usecounting for wakeup and sleep
	dependencies
Date: Tue, 05 Jan 2010 15:54:58 -0700
Message-ID: <20100105225453.16474.92006.stgit@localhost.localdomain>
References: <20100105225217.16474.44114.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49855 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622Ab0AEW6X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 17:58:23 -0500
In-Reply-To: <20100105225217.16474.44114.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add usecounting for wakeup and sleep dependencies.  In the current
situation, if several functions add dependencies on the same clockdomains,
when the first dependency removal function is called, the dependency will
be incorrectly removed from the hardware.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c             |  150 ++++++++++++++++++++++---
 arch/arm/plat-omap/include/plat/clockdomain.h |    6 +
 2 files changed, 135 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 2af9996..d039df7 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -113,7 +113,6 @@ static struct clkdm_dep *_clkdm_deps_lookup(struct clockdomain *clkdm,
 		return ERR_PTR(-EINVAL);
 
 	for (cd = deps; cd->clkdm_name; cd++) {
-
 		if (!omap_chip_is(cd->omap_chip))
 			continue;
 
@@ -122,7 +121,6 @@ static struct clkdm_dep *_clkdm_deps_lookup(struct clockdomain *clkdm,
 
 		if (cd->clkdm == clkdm)
 			break;
-
 	}
 
 	if (!cd->clkdm_name)
@@ -254,6 +252,96 @@ static void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
 
 }
 
+/**
+ * _init_wkdep_usecount - initialize wkdep usecounts to match hardware
+ * @clkdm: clockdomain to initialize wkdep usecounts
+ *
+ * Initialize the wakeup dependency usecount variables for clockdomain @clkdm.
+ * If a wakeup dependency is present in the hardware, the usecount will be
+ * set to 1; otherwise, it will be set to 0.  Software should clear all
+ * software wakeup dependencies prior to calling this function if it wishes
+ * to ensure that all usecounts start at 0.  No return value.
+ */
+static void _init_wkdep_usecount(struct clockdomain *clkdm)
+{
+	u32 v;
+	struct clkdm_dep *cd;
+
+	if (!clkdm->wkdep_srcs)
+		return;
+
+	for (cd = clkdm->wkdep_srcs; cd->clkdm_name; cd++) {
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		if (!cd->clkdm && cd->clkdm_name)
+			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
+
+		if (!cd->clkdm) {
+			WARN(!cd->clkdm, "clockdomain: %s: wkdep clkdm %s not "
+			     "found\n", clkdm->name, cd->clkdm_name);
+			continue;
+		}
+
+		v = prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
+					    PM_WKDEP,
+					    (1 << cd->clkdm->dep_bit));
+
+		if (v)
+			pr_debug("clockdomain: %s: wakeup dependency already "
+				 "set to wake up when %s wakes\n",
+				 clkdm->name, cd->clkdm->name);
+
+		atomic_set(&cd->wkdep_usecount, (v) ? 1 : 0);
+	}
+}
+
+/**
+ * _init_sleepdep_usecount - initialize sleepdep usecounts to match hardware
+ * @clkdm: clockdomain to initialize sleepdep usecounts
+ *
+ * Initialize the sleep dependency usecount variables for clockdomain @clkdm.
+ * If a sleep dependency is present in the hardware, the usecount will be
+ * set to 1; otherwise, it will be set to 0.  Software should clear all
+ * software sleep dependencies prior to calling this function if it wishes
+ * to ensure that all usecounts start at 0.  No return value.
+ */
+static void _init_sleepdep_usecount(struct clockdomain *clkdm)
+{
+	u32 v;
+	struct clkdm_dep *cd;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	if (!clkdm->sleepdep_srcs)
+		return;
+
+	for (cd = clkdm->sleepdep_srcs; cd->clkdm_name; cd++) {
+		if (!omap_chip_is(cd->omap_chip))
+			continue;
+
+		if (!cd->clkdm && cd->clkdm_name)
+			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
+
+		if (!cd->clkdm) {
+			WARN(!cd->clkdm, "clockdomain: %s: sleepdep clkdm %s "
+			     "not found\n", clkdm->name, cd->clkdm_name);
+			continue;
+		}
+
+		v = prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
+					    OMAP3430_CM_SLEEPDEP,
+					    (1 << cd->clkdm->dep_bit));
+
+		if (v)
+			pr_debug("clockdomain: %s: sleep dependency already "
+				 "set to prevent from idling until %s "
+				 "idles\n", clkdm->name, cd->clkdm->name);
+
+		atomic_set(&cd->sleepdep_usecount, (v) ? 1 : 0);
+	}
+};
 
 /* Public functions */
 
@@ -272,6 +360,7 @@ void clkdm_init(struct clockdomain **clkdms,
 		struct clkdm_autodep *init_autodeps)
 {
 	struct clockdomain **c = NULL;
+	struct clockdomain *clkdm;
 	struct clkdm_autodep *autodep = NULL;
 
 	if (clkdms)
@@ -282,6 +371,15 @@ void clkdm_init(struct clockdomain **clkdms,
 	if (autodeps)
 		for (autodep = autodeps; autodep->clkdm.ptr; autodep++)
 			_autodep_lookup(autodep);
+
+	/*
+	 * Ensure that the *dep_usecount registers reflect the current
+	 * state of the PRCM.
+	 */
+	list_for_each_entry(clkdm, &clkdm_list, node) {
+		_init_wkdep_usecount(clkdm);
+		_init_sleepdep_usecount(clkdm);
+	}
 }
 
 /**
@@ -387,11 +485,13 @@ int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		return PTR_ERR(cd);
 	}
 
-	pr_debug("clockdomain: hardware will wake up %s when %s wakes up\n",
-		 clkdm1->name, clkdm2->name);
+	if (atomic_inc_return(&cd->wkdep_usecount) == 1) {
+		pr_debug("clockdomain: hardware will wake up %s when %s wakes "
+			 "up\n", clkdm1->name, clkdm2->name);
 
-	prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
-			     clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+		prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+				     clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+	}
 
 	return 0;
 }
@@ -420,11 +520,13 @@ int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		return PTR_ERR(cd);
 	}
 
-	pr_debug("clockdomain: hardware will no longer wake up %s after %s "
-		 "wakes up\n", clkdm1->name, clkdm2->name);
+	if (atomic_dec_return(&cd->wkdep_usecount) == 0) {
+		pr_debug("clockdomain: hardware will no longer wake up %s "
+			 "after %s wakes up\n", clkdm1->name, clkdm2->name);
 
-	prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
-			       clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+		prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+				       clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
+	}
 
 	return 0;
 }
@@ -457,6 +559,7 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		return PTR_ERR(cd);
 	}
 
+	/* XXX It's faster to return the atomic wkdep_usecount */
 	return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP,
 				       (1 << clkdm2->dep_bit));
 }
@@ -491,12 +594,14 @@ int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		return PTR_ERR(cd);
 	}
 
-	pr_debug("clockdomain: will prevent %s from sleeping if %s is active\n",
-		 clkdm1->name, clkdm2->name);
+	if (atomic_inc_return(&cd->sleepdep_usecount) == 1) {
+		pr_debug("clockdomain: will prevent %s from sleeping if %s "
+			 "is active\n", clkdm1->name, clkdm2->name);
 
-	cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
-			    clkdm1->pwrdm.ptr->prcm_offs,
-			    OMAP3430_CM_SLEEPDEP);
+		cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+				    clkdm1->pwrdm.ptr->prcm_offs,
+				    OMAP3430_CM_SLEEPDEP);
+	}
 
 	return 0;
 }
@@ -531,12 +636,15 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		return PTR_ERR(cd);
 	}
 
-	pr_debug("clockdomain: will no longer prevent %s from sleeping if "
-		 "%s is active\n", clkdm1->name, clkdm2->name);
+	if (atomic_dec_return(&cd->sleepdep_usecount) == 0) {
+		pr_debug("clockdomain: will no longer prevent %s from "
+			 "sleeping if %s is active\n", clkdm1->name,
+			 clkdm2->name);
 
-	cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
-			      clkdm1->pwrdm.ptr->prcm_offs,
-			      OMAP3430_CM_SLEEPDEP);
+		cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+				      clkdm1->pwrdm.ptr->prcm_offs,
+				      OMAP3430_CM_SLEEPDEP);
+	}
 
 	return 0;
 }
@@ -575,12 +683,12 @@ int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		return PTR_ERR(cd);
 	}
 
+	/* XXX It's faster to return the atomic sleepdep_usecount */
 	return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
 				       OMAP3430_CM_SLEEPDEP,
 				       (1 << clkdm2->dep_bit));
 }
 
-
 /**
  * omap2_clkdm_clktrctrl_read - read the clkdm's current state transition mode
  * @clk: struct clk * of a clockdomain
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
index 2286971..192cc95 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -70,6 +70,12 @@ struct clkdm_dep {
 	/* Clockdomain pointer - resolved by the clockdomain code */
 	struct clockdomain *clkdm;
 
+	/* Number of wakeup dependencies causing this clkdm to wake  */
+	atomic_t wkdep_usecount;
+
+	/* Number of sleep dependencies that could prevent clkdm from idle */
+	atomic_t sleepdep_usecount;
+
 	/* Flags to mark OMAP chip restrictions, etc. */
 	const struct omap_chip_id omap_chip;
 


