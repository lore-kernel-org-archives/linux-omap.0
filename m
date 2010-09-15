From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 08/10] OMAP clockdomain: initialize clockdomain registers when the clockdomain layer starts
Date: Wed, 15 Sep 2010 16:55:44 -0700
Message-ID: <1284594946-28963-9-git-send-email-khilman@deeprootsystems.com>
References: <1284594946-28963-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35690 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472Ab0IOX4F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 19:56:05 -0400
Received: by mail-gy0-f174.google.com with SMTP id 8so224515gyd.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Sep 2010 16:56:05 -0700 (PDT)
In-Reply-To: <1284594946-28963-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

When the clockdomain layer initializes, place all clockdomains into
software-supervised mode, and clear all wakeup and sleep dependencies
immediately, rather than waiting for the PM code to do this later.
This fixes a major bug where critical sleep dependencies added by the
hwmod code are cleared during late PM init.

As a side benefit, the _init_{wk,sleep}dep_usecount() functions are no
longer needed, so remove them.

Kevin Hilman <khilman@deeprootsystems.com> did all the really hard work on
this, identifying the problem and finding the bug.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clockdomain.c |  110 +++++--------------------------------
 arch/arm/mach-omap2/pm34xx.c      |    3 -
 2 files changed, 15 insertions(+), 98 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 5d80cb8..6fb61b1 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -258,97 +258,6 @@ static void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
 
 }
 
-/**
- * _init_wkdep_usecount - initialize wkdep usecounts to match hardware
- * @clkdm: clockdomain to initialize wkdep usecounts
- *
- * Initialize the wakeup dependency usecount variables for clockdomain @clkdm.
- * If a wakeup dependency is present in the hardware, the usecount will be
- * set to 1; otherwise, it will be set to 0.  Software should clear all
- * software wakeup dependencies prior to calling this function if it wishes
- * to ensure that all usecounts start at 0.  No return value.
- */
-static void _init_wkdep_usecount(struct clockdomain *clkdm)
-{
-	u32 v;
-	struct clkdm_dep *cd;
-
-	if (!clkdm->wkdep_srcs)
-		return;
-
-	for (cd = clkdm->wkdep_srcs; cd->clkdm_name; cd++) {
-		if (!omap_chip_is(cd->omap_chip))
-			continue;
-
-		if (!cd->clkdm && cd->clkdm_name)
-			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
-
-		if (!cd->clkdm) {
-			WARN(!cd->clkdm, "clockdomain: %s: wkdep clkdm %s not "
-			     "found\n", clkdm->name, cd->clkdm_name);
-			continue;
-		}
-
-		v = prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
-					    PM_WKDEP,
-					    (1 << cd->clkdm->dep_bit));
-
-		if (v)
-			pr_debug("clockdomain: %s: wakeup dependency already "
-				 "set to wake up when %s wakes\n",
-				 clkdm->name, cd->clkdm->name);
-
-		atomic_set(&cd->wkdep_usecount, (v) ? 1 : 0);
-	}
-}
-
-/**
- * _init_sleepdep_usecount - initialize sleepdep usecounts to match hardware
- * @clkdm: clockdomain to initialize sleepdep usecounts
- *
- * Initialize the sleep dependency usecount variables for clockdomain @clkdm.
- * If a sleep dependency is present in the hardware, the usecount will be
- * set to 1; otherwise, it will be set to 0.  Software should clear all
- * software sleep dependencies prior to calling this function if it wishes
- * to ensure that all usecounts start at 0.  No return value.
- */
-static void _init_sleepdep_usecount(struct clockdomain *clkdm)
-{
-	u32 v;
-	struct clkdm_dep *cd;
-
-	if (!cpu_is_omap34xx())
-		return;
-
-	if (!clkdm->sleepdep_srcs)
-		return;
-
-	for (cd = clkdm->sleepdep_srcs; cd->clkdm_name; cd++) {
-		if (!omap_chip_is(cd->omap_chip))
-			continue;
-
-		if (!cd->clkdm && cd->clkdm_name)
-			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
-
-		if (!cd->clkdm) {
-			WARN(!cd->clkdm, "clockdomain: %s: sleepdep clkdm %s "
-			     "not found\n", clkdm->name, cd->clkdm_name);
-			continue;
-		}
-
-		v = prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
-					    OMAP3430_CM_SLEEPDEP,
-					    (1 << cd->clkdm->dep_bit));
-
-		if (v)
-			pr_debug("clockdomain: %s: sleep dependency already "
-				 "set to prevent from idling until %s "
-				 "idles\n", clkdm->name, cd->clkdm->name);
-
-		atomic_set(&cd->sleepdep_usecount, (v) ? 1 : 0);
-	}
-};
-
 /* Public functions */
 
 /**
@@ -379,12 +288,17 @@ void clkdm_init(struct clockdomain **clkdms,
 			_autodep_lookup(autodep);
 
 	/*
-	 * Ensure that the *dep_usecount registers reflect the current
-	 * state of the PRCM.
+	 * Put all clockdomains into software-supervised mode; PM code
+	 * should later enable hardware-supervised mode as appropriate
 	 */
 	list_for_each_entry(clkdm, &clkdm_list, node) {
-		_init_wkdep_usecount(clkdm);
-		_init_sleepdep_usecount(clkdm);
+		if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
+			omap2_clkdm_wakeup(clkdm);
+		else if (clkdm->flags & CLKDM_CAN_DISABLE_AUTO)
+			omap2_clkdm_deny_idle(clkdm);
+
+		clkdm_clear_all_wkdeps(clkdm);
+		clkdm_clear_all_sleepdeps(clkdm);
 	}
 }
 
@@ -592,6 +506,9 @@ int clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
 		if (!omap_chip_is(cd->omap_chip))
 			continue;
 
+		if (!cd->clkdm && cd->clkdm_name)
+			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
+
 		/* PRM accesses are slow, so minimize them */
 		mask |= 1 << cd->clkdm->dep_bit;
 		atomic_set(&cd->wkdep_usecount, 0);
@@ -752,6 +669,9 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
 		if (!omap_chip_is(cd->omap_chip))
 			continue;
 
+		if (!cd->clkdm && cd->clkdm_name)
+			cd->clkdm = _clkdm_lookup(cd->clkdm_name);
+
 		/* PRM accesses are slow, so minimize them */
 		mask |= 1 << cd->clkdm->dep_bit;
 		atomic_set(&cd->sleepdep_usecount, 0);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index f5f1dbd..d2b940c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -949,9 +949,6 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
  */
 static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
-	clkdm_clear_all_wkdeps(clkdm);
-	clkdm_clear_all_sleepdeps(clkdm);
-
 	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
 		omap2_clkdm_allow_idle(clkdm);
 	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
-- 
1.7.2.1

