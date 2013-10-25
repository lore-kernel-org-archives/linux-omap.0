From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 39/43] ARM: OMAP2+: io: use new clock init API
Date: Fri, 25 Oct 2013 18:57:33 +0300
Message-ID: <1382716658-6964-40-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53500 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754140Ab3JYQBD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 12:01:03 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

clk_init is now separated to a common function which gets called for all
SoC:s, which initializes the DT clocks and calls the SoC specific clock init.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/common.h |    2 +-
 arch/arm/mach-omap2/io.c     |   32 +++++++++++++++++++++++---------
 arch/arm/mach-omap2/timer.c  |    6 ++----
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 4a5684b..513d17a 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -299,7 +299,7 @@ struct omap_hwmod;
 extern int omap_dss_reset(struct omap_hwmod *);
 
 /* SoC specific clock initializer */
-extern int (*omap_clk_init)(void);
+int omap_clk_init(void);
 
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e360ddf..2f90f38 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -55,10 +55,10 @@
 #include "prm44xx.h"
 
 /*
- * omap_clk_init: points to a function that does the SoC-specific
+ * omap_clk_soc_init: points to a function that does the SoC-specific
  * clock initializations
  */
-int (*omap_clk_init)(void);
+int (*omap_clk_soc_init)(void);
 
 /*
  * The machine specific code may provide the extra mapping besides the
@@ -419,7 +419,7 @@ void __init omap2420_init_early(void)
 	omap242x_clockdomains_init();
 	omap2420_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_init = omap2420_clk_init;
+	omap_clk_soc_init = omap2420_clk_init;
 }
 
 void __init omap2420_init_late(void)
@@ -448,7 +448,7 @@ void __init omap2430_init_early(void)
 	omap243x_clockdomains_init();
 	omap2430_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_init = omap2430_clk_init;
+	omap_clk_soc_init = omap2430_clk_init;
 }
 
 void __init omap2430_init_late(void)
@@ -482,7 +482,7 @@ void __init omap3_init_early(void)
 	omap3xxx_clockdomains_init();
 	omap3xxx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_init = omap3xxx_clk_init;
+	omap_clk_soc_init = omap3xxx_clk_init;
 }
 
 void __init omap3430_init_early(void)
@@ -520,7 +520,7 @@ void __init ti81xx_init_early(void)
 	omap3xxx_clockdomains_init();
 	omap3xxx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_init = omap3xxx_clk_init;
+	omap_clk_soc_init = omap3xxx_clk_init;
 }
 
 void __init omap3_init_late(void)
@@ -581,7 +581,7 @@ void __init am33xx_init_early(void)
 	am33xx_clockdomains_init();
 	am33xx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_init = am33xx_clk_init;
+	omap_clk_soc_init = am33xx_clk_init;
 }
 #endif
 
@@ -619,7 +619,7 @@ void __init omap4430_init_early(void)
 	omap44xx_clockdomains_init();
 	omap44xx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_init = omap4xxx_clk_init;
+	omap_clk_soc_init = omap4xxx_clk_init;
 }
 
 void __init omap4430_init_late(void)
@@ -650,7 +650,7 @@ void __init omap5_init_early(void)
 	omap54xx_clockdomains_init();
 	omap54xx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_init = omap5xxx_dt_clk_init;
+	omap_clk_soc_init = omap5xxx_dt_clk_init;
 }
 #endif
 
@@ -685,3 +685,17 @@ void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 		_omap2_init_reprogram_sdrc();
 	}
 }
+
+int __init omap_clk_init(void)
+{
+	int ret = 0;
+
+	if (!omap_clk_soc_init)
+		return 0;
+
+	ret = of_prcm_init();
+	if (!ret)
+		ret = omap_clk_soc_init();
+
+	return ret;
+}
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 87a42de..9812709 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -558,8 +558,7 @@ static inline void __init realtime_counter_init(void)
 			       clksrc_nr, clksrc_src, clksrc_prop)	\
 void __init omap##name##_gptimer_timer_init(void)			\
 {									\
-	if (omap_clk_init)						\
-		omap_clk_init();					\
+	omap_clk_init();					\
 	omap_dmtimer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
 	omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src,		\
@@ -570,8 +569,7 @@ void __init omap##name##_gptimer_timer_init(void)			\
 				clksrc_nr, clksrc_src, clksrc_prop)	\
 void __init omap##name##_sync32k_timer_init(void)		\
 {									\
-	if (omap_clk_init)						\
-		omap_clk_init();					\
+	omap_clk_init();					\
 	omap_dmtimer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
 	/* Enable the use of clocksource="gp_timer" kernel parameter */	\
-- 
1.7.9.5

