From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 4/7] omap: hwmod: convert to use common struct clk
Date: Tue, 13 Dec 2011 20:11:55 -0800
Message-ID: <1323835918-2371-5-git-send-email-mturquette@ti.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:38490 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756682Ab1LNEQK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:16:10 -0500
Received: by mail-gy0-f178.google.com with SMTP id g21so354749ghb.23
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 20:16:09 -0800 (PST)
In-Reply-To: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, rnayak@ti.com, jeremy.kerr@canonical.com, paul@pwsan.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@linaro.org, mturquette@ti.com, andrew@lunn.ch

hwmod functions implicitly deal with hardware clks and must be updated
to support the new common struct clk and accompanying functions.

Changes in this patch include adding clk_prepare/clk_unprepare to hwmod
as well as using struct clk_hw_omap instead of the old OMAP-specific
struct clk.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   54 ++++++++++++++++++++++++++++---------
 1 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 207a2ff..3e533c7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -465,13 +465,19 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
  */
 static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 {
+	struct clk_hw_omap *oclk;
+	struct clk_hw_omap *init_oclk;
+
 	if (!oh->_clk)
 		return -EINVAL;
 
-	if (oh->_clk->clkdm && oh->_clk->clkdm->flags & CLKDM_NO_AUTODEPS)
+	oclk = to_clk_hw_omap(oh->_clk);
+	init_oclk = to_clk_hw_omap(init_oh->_clk);
+
+	if (oclk->clkdm && oclk->clkdm->flags & CLKDM_NO_AUTODEPS)
 		return 0;
 
-	return clkdm_add_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
+	return clkdm_add_sleepdep(oclk->clkdm, init_oclk->clkdm);
 }
 
 /**
@@ -489,13 +495,19 @@ static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
  */
 static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 {
+	struct clk_hw_omap *oclk;
+	struct clk_hw_omap *init_oclk;
+
 	if (!oh->_clk)
 		return -EINVAL;
 
-	if (oh->_clk->clkdm && oh->_clk->clkdm->flags & CLKDM_NO_AUTODEPS)
+	oclk = to_clk_hw_omap(oh->_clk);
+	init_oclk = to_clk_hw_omap(init_oh->_clk);
+
+	if (oclk->clkdm && oclk->clkdm->flags & CLKDM_NO_AUTODEPS)
 		return 0;
 
-	return clkdm_del_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
+	return clkdm_del_sleepdep(oclk->clkdm, init_oclk->clkdm);
 }
 
 /**
@@ -509,10 +521,12 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 static int _init_main_clk(struct omap_hwmod *oh)
 {
 	int ret = 0;
+	struct clk_hw_omap *oclk;
 
 	if (!oh->main_clk)
 		return 0;
 
+	/* FIXME replace with common clk get_clk_by_name() */
 	oh->_clk = omap_clk_get_by_name(oh->main_clk);
 	if (!oh->_clk) {
 		pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
@@ -520,7 +534,9 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
 
-	if (!oh->_clk->clkdm)
+	oclk = to_clk_hw_omap(oh->_clk);
+
+	if (!oclk->clkdm)
 		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
 			   oh->main_clk, oh->_clk->name);
 
@@ -601,16 +617,20 @@ static int _enable_clocks(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
 
-	if (oh->_clk)
+	if (oh->_clk) {
+		clk_prepare(oh->_clk);
 		clk_enable(oh->_clk);
+	}
 
 	if (oh->slaves_cnt > 0) {
 		for (i = 0; i < oh->slaves_cnt; i++) {
 			struct omap_hwmod_ocp_if *os = oh->slaves[i];
 			struct clk *c = os->_clk;
 
-			if (c && (os->flags & OCPIF_SWSUP_IDLE))
+			if (c && (os->flags & OCPIF_SWSUP_IDLE)) {
+				clk_prepare(c);
 				clk_enable(c);
+			}
 		}
 	}
 
@@ -631,16 +651,20 @@ static int _disable_clocks(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
 
-	if (oh->_clk)
+	if (oh->_clk) {
 		clk_disable(oh->_clk);
+		clk_unprepare(oh->_clk);
+	}
 
 	if (oh->slaves_cnt > 0) {
 		for (i = 0; i < oh->slaves_cnt; i++) {
 			struct omap_hwmod_ocp_if *os = oh->slaves[i];
 			struct clk *c = os->_clk;
 
-			if (c && (os->flags & OCPIF_SWSUP_IDLE))
+			if (c && (os->flags & OCPIF_SWSUP_IDLE)) {
 				clk_disable(c);
+				clk_unprepare(c);
+			}
 		}
 	}
 
@@ -660,6 +684,7 @@ static void _enable_optional_clocks(struct omap_hwmod *oh)
 		if (oc->_clk) {
 			pr_debug("omap_hwmod: enable %s:%s\n", oc->role,
 				 oc->_clk->name);
+			clk_prepare(oc->_clk);
 			clk_enable(oc->_clk);
 		}
 }
@@ -676,6 +701,7 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
 			pr_debug("omap_hwmod: disable %s:%s\n", oc->role,
 				 oc->_clk->name);
 			clk_disable(oc->_clk);
+			clk_unprepare(oc->_clk);
 		}
 }
 
@@ -1697,6 +1723,7 @@ static int _setup(struct omap_hwmod *oh, void *data)
 				/* XXX omap_iclk_deny_idle(c); */
 			} else {
 				/* XXX omap_iclk_allow_idle(c); */
+				clk_prepare(c);
 				clk_enable(c);
 			}
 		}
@@ -1995,8 +2022,6 @@ int __init omap_hwmod_setup_one(const char *oh_name)
 	struct omap_hwmod *oh;
 	int r;
 
-	pr_debug("omap_hwmod: %s: %s\n", oh_name, __func__);
-
 	if (!mpu_oh) {
 		pr_err("omap_hwmod: %s: cannot setup_one: MPU initiator hwmod %s not yet registered\n",
 		       oh_name, MPU_INITIATOR_NAME);
@@ -2304,6 +2329,7 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 {
 	struct clk *c;
+	struct clk_hw_omap *oclk;
 
 	if (!oh)
 		return NULL;
@@ -2316,10 +2342,12 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 		c = oh->slaves[oh->_mpu_port_index]->_clk;
 	}
 
-	if (!c->clkdm)
+	oclk = to_clk_hw_omap(oh->_clk);
+
+	if (!oclk->clkdm)
 		return NULL;
 
-	return c->clkdm->pwrdm.ptr;
+	return oclk->clkdm->pwrdm.ptr;
 
 }
 
-- 
1.7.5.4

