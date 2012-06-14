From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 23/29] ARM: omap: hwmod: Cleanup !CONFIG_COMMON_CLK parts
Date: Thu, 14 Jun 2012 18:17:12 +0530
Message-ID: <1339678038-23082-24-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34644 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755958Ab2FNMs2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:48:28 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Clean all #ifdef's added as part of fixing the clkdm
accesses from hwmod.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 014280b..024a248 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -130,11 +130,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/io.h>
-#ifdef CONFIG_COMMON_CLK
 #include <linux/clk-provider.h>
-#else
-#include <linux/clk.h>
-#endif
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/list.h>
@@ -550,12 +546,8 @@ struct clockdomain *_get_clkdm(struct omap_hwmod *oh)
 	if (oh->clkdm) {
 		return oh->clkdm;
 	} else if (oh->_clk) {
-#ifdef CONFIG_COMMON_CLK
 		clk = to_clk_hw_omap(__clk_get_hw(oh->_clk));
 		return  clk->clkdm;
-#else
-		return oh->_clk->clkdm;
-#endif
 	}
 	return NULL;
 }
@@ -3014,9 +3006,7 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 	struct clk *c;
 	struct omap_hwmod_ocp_if *oi;
 	struct clockdomain *clkdm;
-#ifdef CONFIG_COMMON_CLK
 	struct clk_hw_omap *clk;
-#endif
 
 	if (!oh)
 		return NULL;
@@ -3033,12 +3023,8 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 		c = oi->_clk;
 	}
 
-#ifdef CONFIG_COMMON_CLK
 	clk = to_clk_hw_omap(__clk_get_hw(c));
 	clkdm = clk->clkdm;
-#else
-	clkdm = c->clkdm;
-#endif
 	if (!clkdm)
 		return NULL;
 
-- 
1.7.1

