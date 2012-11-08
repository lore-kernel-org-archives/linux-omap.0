From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 02/26] ARM: OMAP: hwmod: Fix up hwmod based clkdm accesses
Date: Wed, 7 Nov 2012 17:12:37 -0800
Message-ID: <1352337181-29427-3-git-send-email-mturquette@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45943 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423Ab2KHBN3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 20:13:29 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Mike Turquette <mturquette@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

hwmod uses deferencing the clk pointer to acccess the clkdm.
With COMMON clk hwoever this will need to be deferenced through
the clk_hw_omap pointer, so do the necessary changes.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   70 ++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 37eeb45..1754d7e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -130,7 +130,11 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#ifdef CONFIG_COMMON_CLK
+#include <linux/clk-provider.h>
+#else
 #include <linux/clk.h>
+#endif
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/list.h>
@@ -617,6 +621,23 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 	return 0;
 }
 
+struct clockdomain *_get_clkdm(struct omap_hwmod *oh)
+{
+	struct clk_hw_omap *clk;
+
+	if (oh->clkdm) {
+		return oh->clkdm;
+	} else if (oh->_clk) {
+#ifdef CONFIG_COMMON_CLK
+		clk = to_clk_hw_omap(__clk_get_hw(oh->_clk));
+		return  clk->clkdm;
+#else
+		return oh->_clk->clkdm;
+#endif
+	}
+	return NULL;
+}
+
 /**
  * _add_initiator_dep: prevent @oh from smart-idling while @init_oh is active
  * @oh: struct omap_hwmod *
@@ -632,13 +653,18 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
  */
 static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 {
-	if (!oh->_clk)
+	struct clockdomain *clkdm, *init_clkdm;
+
+	clkdm = _get_clkdm(oh);
+	init_clkdm = _get_clkdm(init_oh);
+
+	if (!clkdm || !init_clkdm)
 		return -EINVAL;
 
-	if (oh->_clk->clkdm && oh->_clk->clkdm->flags & CLKDM_NO_AUTODEPS)
+	if (clkdm && clkdm->flags & CLKDM_NO_AUTODEPS)
 		return 0;
 
-	return clkdm_add_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
+	return clkdm_add_sleepdep(clkdm, init_clkdm);
 }
 
 /**
@@ -656,13 +682,18 @@ static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
  */
 static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 {
-	if (!oh->_clk)
+	struct clockdomain *clkdm, *init_clkdm;
+
+	clkdm = _get_clkdm(oh);
+	init_clkdm = _get_clkdm(init_oh);
+
+	if (!clkdm || !init_clkdm)
 		return -EINVAL;
 
-	if (oh->_clk->clkdm && oh->_clk->clkdm->flags & CLKDM_NO_AUTODEPS)
+	if (clkdm && clkdm->flags & CLKDM_NO_AUTODEPS)
 		return 0;
 
-	return clkdm_del_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
+	return clkdm_del_sleepdep(clkdm, init_clkdm);
 }
 
 /**
@@ -696,7 +727,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
 	 */
 	clk_prepare(oh->_clk);
 
-	if (!oh->_clk->clkdm)
+	if (!_get_clkdm(oh))
 		pr_debug("omap_hwmod: %s: missing clockdomain for %s.\n",
 			   oh->name, oh->main_clk);
 
@@ -1279,6 +1310,7 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	u8 idlemode, sf;
 	u32 v;
 	bool clkdm_act;
+	struct clockdomain *clkdm;
 
 	if (!oh->class->sysc)
 		return;
@@ -1286,11 +1318,9 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	v = oh->_sysc_cache;
 	sf = oh->class->sysc->sysc_flags;
 
+	clkdm = _get_clkdm(oh);
 	if (sf & SYSC_HAS_SIDLEMODE) {
-		clkdm_act = ((oh->clkdm &&
-			      oh->clkdm->flags & CLKDM_ACTIVE_WITH_MPU) ||
-			     (oh->_clk && oh->_clk->clkdm &&
-			      oh->_clk->clkdm->flags & CLKDM_ACTIVE_WITH_MPU));
+		clkdm_act = (clkdm && clkdm->flags & CLKDM_ACTIVE_WITH_MPU);
 		if (clkdm_act && !(oh->class->sysc->idlemodes &
 				   (SIDLE_SMART | SIDLE_SMART_WKUP)))
 			idlemode = HWMOD_IDLEMODE_FORCE;
@@ -3558,10 +3588,17 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 {
 	struct clk *c;
 	struct omap_hwmod_ocp_if *oi;
+	struct clockdomain *clkdm;
+#ifdef CONFIG_COMMON_CLK
+	struct clk_hw_omap *clk;
+#endif
 
 	if (!oh)
 		return NULL;
 
+	if (oh->clkdm)
+		return oh->clkdm->pwrdm.ptr;
+
 	if (oh->_clk) {
 		c = oh->_clk;
 	} else {
@@ -3571,11 +3608,16 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 		c = oi->_clk;
 	}
 
-	if (!c->clkdm)
+#ifdef CONFIG_COMMON_CLK
+	clk = to_clk_hw_omap(__clk_get_hw(c));
+	clkdm = clk->clkdm;
+#else
+	clkdm = c->clkdm;
+#endif
+	if (!clkdm)
 		return NULL;
 
-	return c->clkdm->pwrdm.ptr;
-
+	return clkdm->pwrdm.ptr;
 }
 
 /**
-- 
1.7.9.5

