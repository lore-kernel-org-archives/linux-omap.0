From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v3 1/3] ARM: OMAP2+: L2 cache: get rid of init call
Date: Tue, 22 Apr 2014 13:58:01 +0530
Message-ID: <9e9e4a3cae0b383f35a04aa1c060d4f678471f4d.1398149526.git.nsekhar@ti.com>
References: <cover.1398149526.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40324 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754434AbaDVI2k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 04:28:40 -0400
In-Reply-To: <cover.1398149526.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>

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
index d88aff7..ff02973 100644
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
index f14f9ac..b28299b 100644
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
index df3f531..1230975 100644
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
@@ -226,7 +219,6 @@ static int __init omap_l2_cache_init(void)
 
 	return 0;
 }
-omap_early_initcall(omap_l2_cache_init);
 #endif
 
 void __iomem *omap4_get_sar_ram_base(void)
-- 
1.7.10.1

