From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 2/3] ARM: OMAP2+: L2 cache: get rid of init call
Date: Fri, 4 Apr 2014 15:40:28 +0530
Message-ID: <65332aad267b6dd81330215b0f4e2a7be12431d5.1396605300.git.nsekhar@ti.com>
References: <cover.1396605300.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49543 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbaDDKLE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2014 06:11:04 -0400
In-Reply-To: <cover.1396605300.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>

Get rid of init call to initialize L2 cache.
Instead use the init_early machine hook. This
helps in using the initialization routine across
SoCs without the need of ugly cpu_is_*() checks.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/common.h       |    1 +
 arch/arm/mach-omap2/io.c           |    1 +
 arch/arm/mach-omap2/omap4-common.c |   10 +---------
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index d88aff7..c64d5f5 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -91,6 +91,7 @@ extern void omap3_sync32k_timer_init(void);
 extern void omap3_secure_sync32k_timer_init(void);
 extern void omap3_gptimer_timer_init(void);
 extern void omap4_local_timer_init(void);
+int omap4_l2_cache_init(void);
 extern void omap5_realtime_timer_init(void);
 
 void omap2420_init_early(void);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index f14f9ac..81bc89c 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -640,6 +640,7 @@ void __init omap4430_init_early(void)
 	omap44xx_clockdomains_init();
 	omap44xx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap4_l2_cache_init();
 	omap_clk_soc_init = omap4xxx_dt_clk_init;
 }
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 0a2e4f0..f8b8dac 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -198,13 +198,6 @@ static void omap4_l2c310_write_sec(unsigned long val, unsigned reg)
 
 static int __init omap_l2_cache_init(u32 aux_ctrl, u32 aux_flags)
 {
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
@@ -219,7 +212,7 @@ static int __init omap_l2_cache_init(u32 aux_ctrl, u32 aux_flags)
 	return 0;
 }
 
-static int __init omap4_l2_cache_init(void)
+int __init omap4_l2_cache_init(void)
 {
 	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
 	u32 aux_ctrl = L310_AUX_CTRL_CACHE_REPLACE_RR |
@@ -231,7 +224,6 @@ static int __init omap4_l2_cache_init(void)
 
 	return omap_l2_cache_init(aux_ctrl, 0xc19fffff);
 }
-omap_early_initcall(omap4_l2_cache_init);
 #endif
 
 void __iomem *omap4_get_sar_ram_base(void)
-- 
1.7.10.1

