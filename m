From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 88/97] ARM: l2c: omap2+: get rid of init call
Date: Mon, 28 Apr 2014 20:33:41 +0100
Message-ID: <E1WerJ7-0001Zg-L6@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:55852 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933103AbaD1Tdn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 15:33:43 -0400
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.ifradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>
To: linux-arm-kernel@lists.ifradead.org

Get rid of init call to initialize L2 cache.  Instead use the init_early
machine hook. This helps in using the initialization routine across
SoCs without the need of ugly cpu_is_*() checks.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/common.h       |  1 +
 arch/arm/mach-omap2/io.c           |  1 +
 arch/arm/mach-omap2/omap4-common.c | 10 +---------
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index d88aff7baff8..ff029737c8f0 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -91,6 +91,7 @@ extern void omap3_sync32k_timer_init(void);
 extern void omap3_secure_sync32k_timer_init(void);
 extern void omap3_gptimer_timer_init(void);
 extern void omap4_local_timer_init(void);
+int omap_l2_cache_init(void);
 extern void omap5_realtime_timer_init(void);
 
 void omap2420_init_early(void);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index f14f9ac2dca1..b28299b5afd5 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -640,6 +640,7 @@ void __init omap4430_init_early(void)
 	omap44xx_clockdomains_init();
 	omap44xx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap_l2_cache_init();
 	omap_clk_soc_init = omap4xxx_dt_clk_init;
 }
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 6927d5b120fe..c41ff8b638e1 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -196,17 +196,10 @@ static void omap4_l2c310_write_sec(unsigned long val, unsigned reg)
 	omap_smc1(smc_op, val);
 }
 
-static int __init omap_l2_cache_init(void)
+int __init omap_l2_cache_init(void)
 {
 	u32 aux_ctrl;
 
-	/*
-	 * To avoid code running on other OMAPs in
-	 * multi-omap builds
-	 */
-	if (!cpu_is_omap44xx())
-		return -ENODEV;
-
 	/* Static mapping, never released */
 	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
 	if (WARN_ON(!l2cache_base))
@@ -225,7 +218,6 @@ static int __init omap_l2_cache_init(void)
 
 	return 0;
 }
-omap_early_initcall(omap_l2_cache_init);
 #endif
 
 void __iomem *omap4_get_sar_ram_base(void)
-- 
1.8.3.1

