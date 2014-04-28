From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 84/97] ARM: l2c: omap2: avoid reading directly from the L2
 registers in platform code
Date: Mon, 28 Apr 2014 20:33:21 +0100
Message-ID: <E1WerIn-0001ZP-6I@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:55837 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932486AbaD1TdX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 15:33:23 -0400
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.ifradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Avoid reading directly from the L2 registers in platform code.  The L2
code will have already saved the register values itself into the
l2x0_saved_regs structure, so platform code should just move these
values to where they're required.

This is safe because the L2x0 will have been initialised by an early
initcall, whereas the OMAP4 PM code is initialised late.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index ba43f49fbb59..61cb77f8cf12 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -187,19 +187,15 @@ static void l2x0_pwrst_prepare(unsigned int cpu_id, unsigned int save_state)
  * in every restore MPUSS OFF path.
  */
 #ifdef CONFIG_CACHE_L2X0
-static void save_l2x0_context(void)
+static void __init save_l2x0_context(void)
 {
-	u32 val;
-	void __iomem *l2x0_base = omap4_get_l2cache_base();
-	if (l2x0_base) {
-		val = __raw_readl(l2x0_base + L2X0_AUX_CTRL);
-		__raw_writel(val, sar_base + L2X0_AUXCTRL_OFFSET);
-		val = __raw_readl(l2x0_base + L310_PREFETCH_CTRL);
-		__raw_writel(val, sar_base + L2X0_PREFETCH_CTRL_OFFSET);
-	}
+	__raw_writel(l2x0_saved_regs.aux_ctrl,
+		     sar_base + L2X0_AUXCTRL_OFFSET);
+	__raw_writel(l2x0_saved_regs.prefetch_ctrl,
+		     sar_base + L2X0_PREFETCH_CTRL_OFFSET);
 }
 #else
-static void save_l2x0_context(void)
+static void __init save_l2x0_context(void)
 {}
 #endif
 
-- 
1.8.3.1

