From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 05/13] OMAP2+: hwmod: Replace clkdm access from main_clk using hwmod attribute
Date: Fri, 1 Jul 2011 23:09:10 +0200
Message-ID: <1309554558-19819-6-git-send-email-b-cousson@ti.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58888 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756361Ab1GAVJk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 17:09:40 -0400
In-Reply-To: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Since the clkdm is now part of the omap_hwmod structure, there is no need
to retrieve it from the main_clock or interface clock.
The code can be simplified a little bit with a direct access.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   34 ++++++++--------------------------
 1 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index b54e1e6..fdf6547 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -463,13 +463,13 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
  */
 static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 {
-	if (!oh->_clk)
+	if (!oh->clkdm)
 		return -EINVAL;
 
-	if (oh->_clk->clkdm && oh->_clk->clkdm->flags & CLKDM_NO_AUTODEPS)
+	if (oh->clkdm->flags & CLKDM_NO_AUTODEPS)
 		return 0;
 
-	return clkdm_add_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
+	return clkdm_add_sleepdep(oh->clkdm, init_oh->clkdm);
 }
 
 /**
@@ -487,13 +487,13 @@ static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
  */
 static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 {
-	if (!oh->_clk)
+	if (!oh->clkdm)
 		return -EINVAL;
 
-	if (oh->_clk->clkdm && oh->_clk->clkdm->flags & CLKDM_NO_AUTODEPS)
+	if (oh->clkdm->flags & CLKDM_NO_AUTODEPS)
 		return 0;
 
-	return clkdm_del_sleepdep(oh->_clk->clkdm, init_oh->_clk->clkdm);
+	return clkdm_del_sleepdep(oh->clkdm, init_oh->clkdm);
 }
 
 /**
@@ -518,10 +518,6 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
 
-	if (!oh->_clk->clkdm)
-		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
-			   oh->main_clk, oh->_clk->name);
-
 	return ret;
 }
 
@@ -2108,24 +2104,10 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
  */
 struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 {
-	struct clk *c;
-
-	if (!oh)
+	if (!oh || !oh->clkdm)
 		return NULL;
 
-	if (oh->_clk) {
-		c = oh->_clk;
-	} else {
-		if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
-			return NULL;
-		c = oh->slaves[oh->_mpu_port_index]->_clk;
-	}
-
-	if (!c->clkdm)
-		return NULL;
-
-	return c->clkdm->pwrdm.ptr;
-
+	return oh->clkdm->pwrdm.ptr;
 }
 
 /**
-- 
1.7.0.4

