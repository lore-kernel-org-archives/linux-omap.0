From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 17/26] ARM: OMAP: hwmod: Cleanup !CONFIG_COMMON_CLK parts
Date: Wed, 7 Nov 2012 17:12:52 -0800
Message-ID: <1352337181-29427-18-git-send-email-mturquette@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53082 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754290Ab2KHBNm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 20:13:42 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Mike Turquette <mturquette@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Clean all #ifdef's added as part of fixing the clkdm
accesses from hwmod.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 22a41f6..25052d6 100644
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
@@ -623,17 +619,13 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 
 struct clockdomain *_get_clkdm(struct omap_hwmod *oh)
 {
+	struct clk_hw_omap *clk;
+
 	if (oh->clkdm) {
 		return oh->clkdm;
 	} else if (oh->_clk) {
-#ifdef CONFIG_COMMON_CLK
-		struct clk_hw_omap *clk;
-
 		clk = to_clk_hw_omap(__clk_get_hw(oh->_clk));
 		return  clk->clkdm;
-#else
-		return oh->_clk->clkdm;
-#endif
 	}
 	return NULL;
 }
@@ -3590,9 +3582,7 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 	struct clk *c;
 	struct omap_hwmod_ocp_if *oi;
 	struct clockdomain *clkdm;
-#ifdef CONFIG_COMMON_CLK
 	struct clk_hw_omap *clk;
-#endif
 
 	if (!oh)
 		return NULL;
@@ -3609,12 +3599,8 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
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
1.7.9.5

