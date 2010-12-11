From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 05/11] OMAP2+: clockdomains: split the clkdm hwsup
 enable/disable function
Date: Fri, 10 Dec 2010 18:36:00 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012101832200.13430@utopia.booyaka.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain> <20101208061838.30541.36426.stgit@twilight.localdomain> <871v5rg8px.fsf@deeprootsystems.com> <alpine.DEB.2.00.1012081659520.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42640 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab0LKBgB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 20:36:01 -0500
In-Reply-To: <alpine.DEB.2.00.1012081659520.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 8 Dec 2010, Paul Walmsley wrote:

> On Wed, 8 Dec 2010, Kevin Hilman wrote:
> 
> > Paul Walmsley <paul@pwsan.com> writes:
> >
> > > - * _omap2_clkdm_set_hwsup - set the hwsup idle transition bit
> > > +/**
> > > + * _enable_hwsup - set the hwsup idle transition bit
> > > + * @clkdm: struct clockdomain *
> > > + *
> > > + * XXX fix doco
> > 
> > hmm, 'doco' must be a new lingo I haven't learned yet.
> 
> Thanks, will fix these.

Here's the revised patch.


- Paul


>From 017fc0cc53bedbbaf65e7cded483b2c753f1cc0e Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 8 Dec 2010 17:09:02 -0700
Subject: [PATCH] OMAP2+: clockdomains: split the clkdm hwsup enable/disable function

Split _omap2_clkdm_set_hwsup() into _disable_hwsup() and _enable_hwsup().

While here, also document that the autodeps are deprecated and that they
should be removed at the earliest opportunity.

The documentation has been fixed for _{enable,disable}_hwsup(), thanks
to Kevin Hilman <khilman@deeprootsystems.com> for pointing out that those
functions still had placeholder documentation in an earlier patch revision.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clockdomain.c |   75 +++++++++++++++++++++++++++----------
 1 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index da74f71..8e3276b 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -140,6 +140,9 @@ static struct clkdm_dep *_clkdm_deps_lookup(struct clockdomain *clkdm,
  * clockdomain is in hardware-supervised mode.	Meant to be called
  * once at clockdomain layer initialization, since these should remain
  * fixed for a particular architecture.  No return value.
+ *
+ * XXX autodeps are deprecated and should be removed at the earliest
+ * opportunity
  */
 static void _autodep_lookup(struct clkdm_autodep *autodep)
 {
@@ -167,6 +170,9 @@ static void _autodep_lookup(struct clkdm_autodep *autodep)
  * Add the "autodep" sleep & wakeup dependencies to clockdomain 'clkdm'
  * in hardware-supervised mode.  Meant to be called from clock framework
  * when a clock inside clockdomain 'clkdm' is enabled.	No return value.
+ *
+ * XXX autodeps are deprecated and should be removed at the earliest
+ * opportunity
  */
 static void _clkdm_add_autodeps(struct clockdomain *clkdm)
 {
@@ -198,6 +204,9 @@ static void _clkdm_add_autodeps(struct clockdomain *clkdm)
  * Remove the "autodep" sleep & wakeup dependencies from clockdomain 'clkdm'
  * in hardware-supervised mode.  Meant to be called from clock framework
  * when a clock inside clockdomain 'clkdm' is disabled.  No return value.
+ *
+ * XXX autodeps are deprecated and should be removed at the earliest
+ * opportunity
  */
 static void _clkdm_del_autodeps(struct clockdomain *clkdm)
 {
@@ -222,28 +231,54 @@ static void _clkdm_del_autodeps(struct clockdomain *clkdm)
 	}
 }
 
-/*
- * _omap2_clkdm_set_hwsup - set the hwsup idle transition bit
+/**
+ * _enable_hwsup - place a clockdomain into hardware-supervised idle
  * @clkdm: struct clockdomain *
- * @enable: int 0 to disable, 1 to enable
  *
- * Internal helper for actually switching the bit that controls hwsup
- * idle transitions for clkdm.
+ * Place the clockdomain into hardware-supervised idle mode.  No return
+ * value.
+ *
+ * XXX Should this return an error if the clockdomain does not support
+ * hardware-supervised idle mode?
+ */
+static void _enable_hwsup(struct clockdomain *clkdm)
+{
+	u32 bits, v;
+
+	if (cpu_is_omap24xx())
+		bits = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
+	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
+		bits = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
+	else
+		BUG();
+
+	bits = bits << __ffs(clkdm->clktrctrl_mask);
+
+	v = __raw_readl(clkdm->clkstctrl_reg);
+	v &= ~(clkdm->clktrctrl_mask);
+	v |= bits;
+	__raw_writel(v, clkdm->clkstctrl_reg);
+
+}
+
+/**
+ * _disable_hwsup - place a clockdomain into software-supervised idle
+ * @clkdm: struct clockdomain *
+ *
+ * Place the clockdomain @clkdm into software-supervised idle mode.
+ * No return value.
+ *
+ * XXX Should this return an error if the clockdomain does not support
+ * software-supervised idle mode?
  */
-static void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
+static void _disable_hwsup(struct clockdomain *clkdm)
 {
 	u32 bits, v;
 
 	if (cpu_is_omap24xx()) {
-		if (enable)
-			bits = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
-		else
-			bits = OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
+		bits = OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
 	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		if (enable)
-			bits = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
-		else
-			bits = OMAP34XX_CLKSTCTRL_DISABLE_AUTO;
+		bits = OMAP34XX_CLKSTCTRL_DISABLE_AUTO;
 	} else {
 		BUG();
 	}
@@ -828,7 +863,7 @@ void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
 			_clkdm_add_autodeps(clkdm);
 	}
 
-	_omap2_clkdm_set_hwsup(clkdm, 1);
+	_enable_hwsup(clkdm);
 
 	pwrdm_clkdm_state_switch(clkdm);
 }
@@ -856,7 +891,7 @@ void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
 	pr_debug("clockdomain: disabling automatic idle transitions for %s\n",
 		 clkdm->name);
 
-	_omap2_clkdm_set_hwsup(clkdm, 0);
+	_disable_hwsup(clkdm);
 
 	/*
 	 * XXX This should be removed once TI adds wakeup/sleep
@@ -916,9 +951,9 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	if ((cpu_is_omap34xx() && v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ||
 	    (cpu_is_omap24xx() && v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO)) {
 		/* Disable HW transitions when we are changing deps */
-		_omap2_clkdm_set_hwsup(clkdm, 0);
+		_disable_hwsup(clkdm);
 		_clkdm_add_autodeps(clkdm);
-		_omap2_clkdm_set_hwsup(clkdm, 1);
+		_enable_hwsup(clkdm);
 	} else {
 		omap2_clkdm_wakeup(clkdm);
 	}
@@ -978,9 +1013,9 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	if ((cpu_is_omap34xx() && v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ||
 	    (cpu_is_omap24xx() && v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO)) {
 		/* Disable HW transitions when we are changing deps */
-		_omap2_clkdm_set_hwsup(clkdm, 0);
+		_disable_hwsup(clkdm);
 		_clkdm_del_autodeps(clkdm);
-		_omap2_clkdm_set_hwsup(clkdm, 1);
+		_enable_hwsup(clkdm);
 	} else {
 		omap2_clkdm_sleep(clkdm);
 	}
-- 
1.7.2.3

