From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 06/10] OMAP: hwmod: Remove IS_ERR check with omap_clk_get_by_name return value
Date: Fri,  7 May 2010 17:44:11 +0200
Message-ID: <1273247055-15165-7-git-send-email-b-cousson@ti.com>
References: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35496 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756687Ab0EGPo1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 May 2010 11:44:27 -0400
In-Reply-To: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

The previous clock API was returning a standard linux error code in
case of failure. This is not the case anymore with the new
omap_clk_get_by_name API. A NULL value means that the clock node
does not exist.
Replace all the IS_ERR check by a !clk check.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index a280ccc..a62920b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -411,9 +411,9 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		return 0;
 
 	c = omap_clk_get_by_name(oh->main_clk);
-	WARN(IS_ERR(c), "omap_hwmod: %s: cannot clk_get main_clk %s\n",
+	WARN(!c, "omap_hwmod: %s: cannot clk_get main_clk %s\n",
 	     oh->name, oh->main_clk);
-	if (IS_ERR(c))
+	if (!c)
 		ret = -EINVAL;
 	oh->_clk = c;
 
@@ -446,9 +446,9 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 			continue;
 
 		c = omap_clk_get_by_name(os->clk);
-		WARN(IS_ERR(c), "omap_hwmod: %s: cannot clk_get "
-		     "interface_clk %s\n", oh->name, os->clk);
-		if (IS_ERR(c))
+		WARN(!c, "omap_hwmod: %s: cannot clk_get interface_clk %s\n",
+		     oh->name, os->clk);
+		if (!c)
 			ret = -EINVAL;
 		os->_clk = c;
 	}
@@ -472,9 +472,9 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++) {
 		c = omap_clk_get_by_name(oc->clk);
-		WARN(IS_ERR(c), "omap_hwmod: %s: cannot clk_get opt_clk "
-		     "%s\n", oh->name, oc->clk);
-		if (IS_ERR(c))
+		WARN(!c, "omap_hwmod: %s: cannot clk_get opt_clk %s\n",
+		     oh->name, oc->clk);
+		if (!c)
 			ret = -EINVAL;
 		oc->_clk = c;
 	}
@@ -495,7 +495,7 @@ static int _enable_clocks(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
 
-	if (oh->_clk && !IS_ERR(oh->_clk))
+	if (oh->_clk)
 		clk_enable(oh->_clk);
 
 	if (oh->slaves_cnt > 0) {
@@ -503,7 +503,7 @@ static int _enable_clocks(struct omap_hwmod *oh)
 			struct omap_hwmod_ocp_if *os = oh->slaves[i];
 			struct clk *c = os->_clk;
 
-			if (c && !IS_ERR(c) && (os->flags & OCPIF_SWSUP_IDLE))
+			if (c && (os->flags & OCPIF_SWSUP_IDLE))
 				clk_enable(c);
 		}
 	}
@@ -525,7 +525,7 @@ static int _disable_clocks(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
 
-	if (oh->_clk && !IS_ERR(oh->_clk))
+	if (oh->_clk)
 		clk_disable(oh->_clk);
 
 	if (oh->slaves_cnt > 0) {
@@ -533,7 +533,7 @@ static int _disable_clocks(struct omap_hwmod *oh)
 			struct omap_hwmod_ocp_if *os = oh->slaves[i];
 			struct clk *c = os->_clk;
 
-			if (c && !IS_ERR(c) && (os->flags & OCPIF_SWSUP_IDLE))
+			if (c && (os->flags & OCPIF_SWSUP_IDLE))
 				clk_disable(c);
 		}
 	}
@@ -1013,7 +1013,7 @@ static int _setup(struct omap_hwmod *oh)
 			struct omap_hwmod_ocp_if *os = oh->slaves[i];
 			struct clk *c = os->_clk;
 
-			if (!c || IS_ERR(c))
+			if (!c)
 				continue;
 
 			if (os->flags & OCPIF_SWSUP_IDLE) {
-- 
1.6.1.3

