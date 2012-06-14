From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 11/29] ARM: omap: hwmod: Fix up hwmod based clkdm accesses
Date: Thu, 14 Jun 2012 18:17:00 +0530
Message-ID: <1339678038-23082-12-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53438 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755534Ab2FNMrx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:47:53 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

hwmod uses deferencing the clk pointer to acccess the clkdm.
With COMMON clk hwoever this will need to be deferenced through
the clk_hw_omap pointer, so do the necessary changes.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   63 ++++++++++++++++++++++++++++++++------
 1 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2ebcacf..014280b 100644
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
@@ -539,6 +543,23 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
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
@@ -554,13 +575,18 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
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
@@ -578,13 +604,18 @@ static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
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
@@ -609,7 +640,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
 
-	if (!oh->_clk->clkdm)
+	if (!_get_clkdm(oh))
 		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
 			   oh->name, oh->main_clk);
 
@@ -2982,10 +3013,17 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
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
@@ -2995,11 +3033,16 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
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
1.7.1

