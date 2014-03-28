From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 42/75] ARM: l2c: omap2: implement new write_sec method
Date: Fri, 28 Mar 2014 15:18:01 +0000
Message-ID: <E1WTYXh-0007Fh-BP@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41424 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751573AbaC1PSE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 11:18:04 -0400
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

With the write_sec method, we no longer need to override the default
L2C disable method, and we no longer need the L2C set_debug method.
Both of these can be handled via the write_sec method.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap4-common.c | 42 +++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 9f8d506f511d..7abc1eb15bf9 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -166,17 +166,33 @@ void __iomem *omap4_get_l2cache_base(void)
 	return l2cache_base;
 }
 
-static void omap4_l2x0_disable(void)
+static void omap4_l2c310_write_sec(unsigned long val, unsigned reg)
 {
-	outer_flush_all();
-	/* Disable PL310 L2 Cache controller */
-	omap_smc1(0x102, 0x0);
-}
+	unsigned smc_op;
 
-static void omap4_l2x0_set_debug(unsigned long val)
-{
-	/* Program PL310 L2 Cache controller debug register */
-	omap_smc1(0x100, val);
+	switch (reg) {
+	case L2X0_CTRL:
+		smc_op = OMAP4_MON_L2X0_CTRL_INDEX;
+		break;
+
+	case L2X0_AUX_CTRL:
+		smc_op = OMAP4_MON_L2X0_AUXCTRL_INDEX;
+		break;
+
+	case L2X0_DEBUG_CTRL:
+		smc_op = OMAP4_MON_L2X0_DBG_CTRL_INDEX;
+		break;
+
+	case L310_PREFETCH_CTRL:
+		smc_op = OMAP4_MON_L2X0_PREFETCH_INDEX;
+		break;
+
+	default:
+		WARN_ONCE(1, "OMAP L2C310: ignoring write to reg 0x%x\n", reg);
+		return;
+	}
+
+	omap_smc1(smc_op, val);
 }
 
 static int __init omap_l2_cache_init(void)
@@ -211,18 +227,12 @@ static int __init omap_l2_cache_init(void)
 	/* Enable PL310 L2 Cache controller */
 	omap_smc1(0x102, 0x1);
 
+	outer_cache.write_sec = omap4_l2c310_write_sec;
 	if (of_have_populated_dt())
 		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
 	else
 		l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
 
-	/*
-	 * Override default outer_cache.disable with a OMAP4
-	 * specific one
-	*/
-	outer_cache.disable = omap4_l2x0_disable;
-	outer_cache.set_debug = omap4_l2x0_set_debug;
-
 	return 0;
 }
 omap_early_initcall(omap_l2_cache_init);
-- 
1.8.3.1

