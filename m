From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH] OMAP: Fix race condition with autodeps
Date: Wed, 16 Sep 2009 13:53:06 +0300
Message-ID: <1253098386-30263-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:25184 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbZIPLPG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Sep 2009 07:15:06 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, ville.syrjala@nokia.com, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

There is a possible race condition in clockdomain
code handling hw supported idle transitions.

When multiple autodeps dependencies are being added
or removed, a transition of still remaining dependent
powerdomain can result in false readings of the
state counter. This is especially fatal for off mode
state counter, as it could result in a driver not
noticing a context loss.

Fixed by disabling hw supported state transitions
when autodeps are being changed.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/clockdomain.c |   74 ++++++++++++++++++++++---------------
 1 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 4ef7b4f..1a8c386 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -137,6 +137,36 @@ static void _clkdm_del_autodeps(struct clockdomain *clkdm)
 	}
 }
 
+/*
+ * _omap2_clkdm_set_hwsup - set high the hwsup idle transition bit
+ * @clkdm: struct clockdomain *
+ * @enable: int 0 to disable, 1 to enable
+ *
+ * Internal helper for actually switching the bit that controls hwsup
+ * idle transitions for clkdm.
+ */
+void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
+{
+	u32 v;
+
+	if (cpu_is_omap24xx()) {
+		if (enable)
+			v = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
+		else
+			v = OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
+	} else if (cpu_is_omap34xx()) {
+		if (enable)
+			v = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
+		else
+			v = OMAP34XX_CLKSTCTRL_DISABLE_AUTO;
+	} else {
+		BUG();
+	}
+
+	cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask,
+			    v << __ffs(clkdm->clktrctrl_mask),
+			    clkdm->pwrdm.ptr->prcm_offs, CM_CLKSTCTRL);
+}
 
 static struct clockdomain *_clkdm_lookup(const char *name)
 {
@@ -456,8 +486,6 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
  */
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
 {
-	u32 v;
-
 	if (!clkdm)
 		return;
 
@@ -473,18 +501,7 @@ void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
 	if (atomic_read(&clkdm->usecount) > 0)
 		_clkdm_add_autodeps(clkdm);
 
-	if (cpu_is_omap24xx())
-		v = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
-	else if (cpu_is_omap34xx())
-		v = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
-	else
-		BUG();
-
-
-	cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask,
-			    v << __ffs(clkdm->clktrctrl_mask),
-			    clkdm->pwrdm.ptr->prcm_offs,
-			    CM_CLKSTCTRL);
+	_omap2_clkdm_set_hwsup(clkdm, 1);
 
 	pwrdm_clkdm_state_switch(clkdm);
 }
@@ -500,8 +517,6 @@ void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
  */
 void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
 {
-	u32 v;
-
 	if (!clkdm)
 		return;
 
@@ -514,16 +529,7 @@ void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
 	pr_debug("clockdomain: disabling automatic idle transitions for %s\n",
 		 clkdm->name);
 
-	if (cpu_is_omap24xx())
-		v = OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
-	else if (cpu_is_omap34xx())
-		v = OMAP34XX_CLKSTCTRL_DISABLE_AUTO;
-	else
-		BUG();
-
-	cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask,
-			    v << __ffs(clkdm->clktrctrl_mask),
-			    clkdm->pwrdm.ptr->prcm_offs, CM_CLKSTCTRL);
+	_omap2_clkdm_set_hwsup(clkdm, 0);
 
 	if (atomic_read(&clkdm->usecount) > 0)
 		_clkdm_del_autodeps(clkdm);
@@ -569,10 +575,14 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	v = omap2_clkdm_clktrctrl_read(clkdm);
 
 	if ((cpu_is_omap34xx() && v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ||
-	    (cpu_is_omap24xx() && v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO))
+	    (cpu_is_omap24xx() && v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO)) {
+		/* Disable HW transitions when we are changing deps */
+		_omap2_clkdm_set_hwsup(clkdm, 0);
 		_clkdm_add_autodeps(clkdm);
-	else
+		_omap2_clkdm_set_hwsup(clkdm, 1);
+	} else {
 		omap2_clkdm_wakeup(clkdm);
+	}
 
 	pwrdm_wait_transition(clkdm->pwrdm.ptr);
 	pwrdm_clkdm_state_switch(clkdm);
@@ -623,10 +633,14 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	v = omap2_clkdm_clktrctrl_read(clkdm);
 
 	if ((cpu_is_omap34xx() && v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ||
-	    (cpu_is_omap24xx() && v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO))
+	    (cpu_is_omap24xx() && v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO)) {
+		/* Disable HW transitions when we are changing deps */
+		_omap2_clkdm_set_hwsup(clkdm, 0);
 		_clkdm_del_autodeps(clkdm);
-	else
+		_omap2_clkdm_set_hwsup(clkdm, 1);
+	} else {
 		omap2_clkdm_sleep(clkdm);
+	}
 
 	pwrdm_clkdm_state_switch(clkdm);
 
-- 
1.5.4.3

