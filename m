From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/12] ARM: OMAP2+: powerdomain/PM: only program supported
 power states
Date: Sun, 09 Dec 2012 10:53:35 -0700
Message-ID: <20121209175332.6933.98995.stgit@dusk.lan>
References: <20121209174545.6933.59371.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39997 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934329Ab2LIRyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 12:54:47 -0500
In-Reply-To: <20121209174545.6933.59371.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Previously the PM code attempted to program power states that the
underlying powerdomain didn't support.  Change this to only program
power states that are supported by the hardware.

In the future, the PM code should be changed further to program
explicit lists of powerdomain power states that are valid for each
chip (and supported by the underlying software).  Also the powerdomain
code should return errors when PM code tries to program an unsupported
power state, rather than simply ignoring the requrest.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c      |   34 +++++++++++++++++
 arch/arm/mach-omap2/pm44xx.c      |    9 ++++-
 arch/arm/mach-omap2/powerdomain.c |   74 ++++++-------------------------------
 3 files changed, 52 insertions(+), 65 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8aac26e..c4d4154 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -395,7 +395,14 @@ restore:
 	/* Restore next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		prev_fpwrst = pwrdm_read_prev_fpwrst(pwrst->pwrdm);
-		if (prev_fpwrst > pwrst->next_fpwrst) {
+		/*
+		 * The SGX powerdomain will report its previous state as
+		 * INACTIVE when it's been programmed to ON.  This seems to
+		 * be the only OMAP3 powerdomain that does this.
+		 */
+		if (prev_fpwrst == PWRDM_FUNC_PWRST_INACTIVE)
+			prev_fpwrst = PWRDM_FUNC_PWRST_ON;
+		if (prev_fpwrst != pwrst->next_fpwrst) {
 			pr_info("Powerdomain %s didn't enter target state %s - entered state %s instead\n",
 				pwrst->pwrdm->name,
 				pwrdm_convert_fpwrst_to_name(pwrst->next_fpwrst),
@@ -575,6 +582,10 @@ void omap3_pm_off_mode_enable(int enable)
 
 	fpwrst = (enable) ? PWRDM_FUNC_PWRST_OFF : PWRDM_FUNC_PWRST_CSWR;
 
+	/*
+	 * XXX This should be replaced by explicit lists of
+	 * powerdomains with specific powerstates to set
+	 */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583) &&
 		    pwrst->pwrdm == core_pwrdm &&
@@ -584,6 +595,12 @@ void omap3_pm_off_mode_enable(int enable)
 				__func__);
 		} else {
 			pwrst->next_fpwrst = fpwrst;
+			if (!pwrdm_supports_fpwrst(pwrst->pwrdm,
+						   pwrst->next_fpwrst))
+				pwrst->next_fpwrst = PWRDM_FUNC_PWRST_CSWR;
+			if (!pwrdm_supports_fpwrst(pwrst->pwrdm,
+						   pwrst->next_fpwrst))
+				pwrst->next_fpwrst = PWRDM_FUNC_PWRST_ON;
 		}
 		WARN_ON(pwrdm_set_fpwrst(pwrst->pwrdm, pwrst->next_fpwrst));
 	}
@@ -603,9 +620,17 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, u8 fpwrst)
 {
 	struct power_state *pwrst;
 
+	/*
+	 * XXX This should be replaced by per-powerdomain suspend
+	 * power state files
+	 */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		if (pwrst->pwrdm == pwrdm) {
 			pwrst->next_fpwrst = fpwrst;
+			if (!pwrdm_supports_fpwrst(pwrdm, pwrst->next_fpwrst))
+				pwrst->next_fpwrst = PWRDM_FUNC_PWRST_CSWR;
+			if (!pwrdm_supports_fpwrst(pwrdm, pwrst->next_fpwrst))
+				pwrst->next_fpwrst = PWRDM_FUNC_PWRST_ON;
 			return 0;
 		}
 	}
@@ -623,7 +648,14 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
+
+	/*
+	 * XXX This should be replaced by explicit lists of
+	 * powerdomains with specific powerstates to set
+	 */
 	pwrst->next_fpwrst = PWRDM_FUNC_PWRST_CSWR;
+	if (!pwrdm_supports_fpwrst(pwrdm, pwrst->next_fpwrst))
+		pwrst->next_fpwrst = PWRDM_FUNC_PWRST_ON;
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 595f84e..5db9a91 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -67,8 +67,7 @@ static int omap4_pm_suspend(void)
 	/* Restore next powerdomain state */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		prev_fpwrst = pwrdm_read_prev_fpwrst(pwrst->pwrdm);
-		/* XXX test below should be != */
-		if (prev_fpwrst > pwrst->next_fpwrst) {
+		if (prev_fpwrst != pwrst->next_fpwrst) {
 			pr_info("Powerdomain (%s) didn't enter target state %s - entered state %s instead\n",
 				pwrst->pwrdm->name,
 				pwrdm_convert_fpwrst_to_name(pwrst->next_fpwrst),
@@ -113,7 +112,13 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 		return -ENOMEM;
 
 	pwrst->pwrdm = pwrdm;
+	/*
+	 * XXX This should be replaced by explicit lists of
+	 * powerdomains with specific powerstates to set
+	 */
 	pwrst->next_fpwrst = PWRDM_FUNC_PWRST_CSWR;
+	if (!pwrdm_supports_fpwrst(pwrdm, pwrst->next_fpwrst))
+		pwrst->next_fpwrst = PWRDM_FUNC_PWRST_ON;
 	list_add(&pwrst->node, &pwrst_list);
 
 	return WARN_ON(pwrdm_set_fpwrst(pwrst->pwrdm, pwrst->next_fpwrst));
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 6ba79df..fdeabbf 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -185,61 +185,9 @@ static bool _pwrdm_logic_retst_can_change(struct powerdomain *pwrdm)
 }
 
 /**
- * _match_pwrst: determine the closest supported power state
- * @pwrsts: list of allowed states, defined as a bitmask
- * @pwrst: initial state to be used as a starting point
- * @min: minimum (i.e. lowest consumption) allowed state
- * @max: maximum (i.e. highest consumption) allowed state
- *
  * Search down then up for a valid state from a list of allowed
  * states.  Used by states conversion functions (_pwrdm_fpwrst_to_*)
  * to look for allowed power and logic states for a powerdomain.
- * Returns the matching allowed state.  XXX Deprecated.  The software
- * should not try to program unsupported powerstates.
- */
-static int _match_pwrst(u32 pwrsts, int pwrst, int min, int max)
-{
-	int found = 1, new_pwrst = pwrst;
-
-	/*
-	 * If the power domain does not allow any state programmation
-	 * return the max state which is always allowed
-	 */
-	if (!pwrsts)
-		return max;
-
-	/*
-	 * Search lower: if the requested state is not supported
-	 * try the lower states, stopping at the minimum allowed
-	 * state
-	 */
-	while (!(pwrsts & (1 << new_pwrst))) {
-		if (new_pwrst <= min) {
-			found = 0;
-			break;
-		}
-		new_pwrst--;
-	}
-
-	/*
-	 * Search higher: if no lower state found fallback to the higher
-	 * states, stopping at the maximum allowed state
-	 */
-	if (!found) {
-		new_pwrst = pwrst;
-		while (!(pwrsts & (1 << new_pwrst))) {
-			if (new_pwrst >= max) {
-				new_pwrst = max;
-				break;
-			}
-			new_pwrst++;
-		}
-	}
-
-	return new_pwrst;
-}
-
-/**
  * _pwrdm_fpwrst_to_pwrst - Convert functional (i.e. logical) to
  * internal (i.e. registers) values for the power domains states.
  * @pwrdm: struct powerdomain * to convert the values for
@@ -285,13 +233,6 @@ static int _pwrdm_fpwrst_to_pwrst(struct powerdomain *pwrdm, u8 fpwrst,
 		return -EINVAL;
 	}
 
-	/* XXX deprecated */
-	*pwrdm_pwrst = _match_pwrst(pwrdm->pwrsts, *pwrdm_pwrst,
-				    PWRDM_POWER_OFF, PWRDM_POWER_ON);
-
-	*logic_retst = _match_pwrst(pwrdm->pwrsts_logic_ret, *logic_retst,
-				    PWRDM_POWER_OFF, PWRDM_POWER_RET);
-
 	pr_debug("powerdomain %s: convert fpwrst %0x to pwrst %0x\n",
 		 pwrdm->name, fpwrst, *pwrdm_pwrst);
 
@@ -361,6 +302,10 @@ static int _set_logic_retst_and_pwrdm_pwrst(struct powerdomain *pwrdm,
 {
 	int ret;
 
+	/*
+	 * XXX Should return an error, but this means that our PM code
+	 * will need to be much more careful about what it programs
+	 */
 	if (!_pwrdm_pwrst_is_controllable(pwrdm))
 		return 0;
 
@@ -1319,6 +1264,10 @@ int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm, u8 fpwrst)
 	if (!pwrdm || IS_ERR(pwrdm))
 		return -EINVAL;
 
+	/*
+	 * XXX Should return an error, but this means that our PM code
+	 * will need to be much more careful about what it programs
+	 */
 	if (!_pwrdm_pwrst_is_controllable(pwrdm))
 		return 0;
 
@@ -1399,6 +1348,10 @@ int pwrdm_set_fpwrst(struct powerdomain *pwrdm, enum pwrdm_func_state fpwrst)
 	    !arch_pwrdm->pwrdm_read_pwrst)
 		return -EINVAL;
 
+	/*
+	 * XXX Should return an error, but this means that our PM code
+	 * will need to be much more careful about what it programs
+	 */
 	if (!_pwrdm_pwrst_is_controllable(pwrdm))
 		return 0;
 
@@ -1516,9 +1469,6 @@ bool pwrdm_supports_fpwrst(struct powerdomain *pwrdm, u8 fpwrst)
 	if (ret)
 		return false;
 
-	pr_debug("%s: pwrdm %s: set fpwrst %0x\n", __func__, pwrdm->name,
-		 fpwrst);
-
 	if (pwrdm->pwrsts_logic_ret && pwrst == PWRDM_POWER_RET &&
 	    !(pwrdm->pwrsts_logic_ret & (1 << logic)))
 		return false;


