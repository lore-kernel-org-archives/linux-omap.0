From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 25/26] ARM: OMAP2+: clock: remove unnecessary declarations
Date: Wed, 7 Nov 2012 17:13:00 -0800
Message-ID: <1352337181-29427-26-git-send-email-mturquette@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52145 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754701Ab2KHBNv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 20:13:51 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Mike Turquette <mturquette@ti.com>

At some point during the CM/PRM cleanup a few function declarations were
added back to clock.h which are unnecessary.  This patch removes them.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/clock.h |   27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index a3e9067..4a095b0 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -597,33 +597,6 @@ u32 omap2_get_dpll_rate(struct clk *clk);
 void omap2_init_dpll_parent(struct clk *clk);
 #endif
 
-int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
-
-
-#ifdef CONFIG_ARCH_OMAP2
-void omap2xxx_clk_prepare_for_reboot(void);
-#else
-static inline void omap2xxx_clk_prepare_for_reboot(void)
-{
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-void omap3_clk_prepare_for_reboot(void);
-#else
-static inline void omap3_clk_prepare_for_reboot(void)
-{
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-void omap4_clk_prepare_for_reboot(void);
-#else
-static inline void omap4_clk_prepare_for_reboot(void)
-{
-}
-#endif
-
 #ifdef CONFIG_COMMON_CLK
 int omap2_dflt_clk_enable(struct clk_hw *hw);
 void omap2_dflt_clk_disable(struct clk_hw *hw);
-- 
1.7.9.5

