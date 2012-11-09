From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 00/26] Move OMAP2+ over to common clk framework
Date: Fri, 9 Nov 2012 23:47:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211092346320.20703@utopia.booyaka.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com> <alpine.DEB.2.00.1211092058540.20703@utopia.booyaka.com> <20121109221813.17381.31431@nucleus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60809 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab2KIXrl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 18:47:41 -0500
In-Reply-To: <20121109221813.17381.31431@nucleus>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Fri, 9 Nov 2012, Mike Turquette wrote:

> I just did some more testing on your branch and everything looks great.
> The only thing that caught my eye was using the clk-private.h header in
> the top-most patch.  The following patch will help me sleep better at
> night:
> 
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index ba4d14c..3848735 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -22,7 +22,7 @@
>  #include <linux/clk.h>
>  #include <linux/limits.h>
>  #include <linux/err.h>
> -#include <linux/clk-private.h>
> +#include <linux/clk-provider.h>
>  
>  #include <linux/io.h>

Just folded this one in, the updated patch follows.

> Tested on 3530 ES3.0 Beagleboard, boot + suspend/resume.

Great!


- Paul

From: Mike Turquette <mturquette@ti.com>
Date: Fri, 9 Nov 2012 11:28:42 -0700
Subject: [PATCH] ARM: OMAP2+: clockdomain: bypass clockdomain handling when
 disabling unused clks

The OMAP port to the common clk framework[1] resulted in spurious WARNs
while disable unused clocks.  This is due to _clkdm_clk_hwmod_disable
catching clkdm->usecount's with a value of zero.  Even less desirable it
would not allow the clkdm_clk_disable function pointer to get called due
to an early return of -ERANGE.

This patch adds a check for such a corner case by skipping the WARN and
early return in the event that clkdm->usecount and clk->enable_usecount
are both zero.  Presumably this could only happen during the check for
unused clocks at boot-time.

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/88824

Signed-off-by: Mike Turquette <mturquette@ti.com>
[paul@pwsan.com: split the hwmod and clock disable cases; modified the
 code to skip the clockdomain handling during the disable-unused-clocks phase;
 added COMMON_CLK ifdef; removed include of clk-private.h at Mike's request]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c |   91 ++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 64e5046..4424f3d 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/limits.h>
 #include <linux/err.h>
+#include <linux/clk-provider.h>
 
 #include <linux/io.h>
 
@@ -947,35 +948,6 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 	return 0;
 }
 
-static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
-{
-	unsigned long flags;
-
-	if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
-		return -EINVAL;
-
-	spin_lock_irqsave(&clkdm->lock, flags);
-
-	if (atomic_read(&clkdm->usecount) == 0) {
-		spin_unlock_irqrestore(&clkdm->lock, flags);
-		WARN_ON(1); /* underflow */
-		return -ERANGE;
-	}
-
-	if (atomic_dec_return(&clkdm->usecount) > 0) {
-		spin_unlock_irqrestore(&clkdm->lock, flags);
-		return 0;
-	}
-
-	arch_clkdm->clkdm_clk_disable(clkdm);
-	pwrdm_state_switch(clkdm->pwrdm.ptr);
-	spin_unlock_irqrestore(&clkdm->lock, flags);
-
-	pr_debug("clockdomain: %s: disabled\n", clkdm->name);
-
-	return 0;
-}
-
 /**
  * clkdm_clk_enable - add an enabled downstream clock to this clkdm
  * @clkdm: struct clockdomain *
@@ -1018,15 +990,39 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
  */
 int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 {
-	/*
-	 * XXX Rewrite this code to maintain a list of enabled
-	 * downstream clocks for debugging purposes?
-	 */
+	unsigned long flags;
 
-	if (!clk)
+	if (!clkdm || !clk || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
 		return -EINVAL;
 
-	return _clkdm_clk_hwmod_disable(clkdm);
+	spin_lock_irqsave(&clkdm->lock, flags);
+
+#ifdef CONFIG_COMMON_CLK
+	/* corner case: disabling unused clocks */
+	if (__clk_get_enable_count(clk) == 0)
+		goto ccd_exit;
+#endif
+
+	if (atomic_read(&clkdm->usecount) == 0) {
+		spin_unlock_irqrestore(&clkdm->lock, flags);
+		WARN_ON(1); /* underflow */
+		return -ERANGE;
+	}
+
+	if (atomic_dec_return(&clkdm->usecount) > 0) {
+		spin_unlock_irqrestore(&clkdm->lock, flags);
+		return 0;
+	}
+
+	arch_clkdm->clkdm_clk_disable(clkdm);
+	pwrdm_state_switch(clkdm->pwrdm.ptr);
+
+	pr_debug("clockdomain: %s: disabled\n", clkdm->name);
+
+ccd_exit:
+	spin_unlock_irqrestore(&clkdm->lock, flags);
+
+	return 0;
 }
 
 /**
@@ -1077,6 +1073,8 @@ int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh)
  */
 int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
 {
+	unsigned long flags;
+
 	/* The clkdm attribute does not exist yet prior OMAP4 */
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		return 0;
@@ -1086,9 +1084,28 @@ int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
 	 * downstream hwmods for debugging purposes?
 	 */
 
-	if (!oh)
+	if (!clkdm || !oh || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
 		return -EINVAL;
 
-	return _clkdm_clk_hwmod_disable(clkdm);
+	spin_lock_irqsave(&clkdm->lock, flags);
+
+	if (atomic_read(&clkdm->usecount) == 0) {
+		spin_unlock_irqrestore(&clkdm->lock, flags);
+		WARN_ON(1); /* underflow */
+		return -ERANGE;
+	}
+
+	if (atomic_dec_return(&clkdm->usecount) > 0) {
+		spin_unlock_irqrestore(&clkdm->lock, flags);
+		return 0;
+	}
+
+	arch_clkdm->clkdm_clk_disable(clkdm);
+	pwrdm_state_switch(clkdm->pwrdm.ptr);
+	spin_unlock_irqrestore(&clkdm->lock, flags);
+
+	pr_debug("clockdomain: %s: disabled\n", clkdm->name);
+
+	return 0;
 }
 
-- 
1.7.10.4

