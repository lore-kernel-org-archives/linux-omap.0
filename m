From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv13 35/40] ARM: OMAP2+: io: use new clock init API
Date: Thu, 9 Jan 2014 16:00:46 +0200
Message-ID: <1389276051-1326-36-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

clk_init is now separated to a common function which gets called for all
SoC:s, which initializes the DT clocks and calls the SoC specific clock init.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/common.h |    2 +-
 arch/arm/mach-omap2/io.c     |   32 +++++++++++++++++++++++---------
 arch/arm/mach-omap2/timer.c  |    6 ++----
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index e30ef67..5ccf36d 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -305,7 +305,7 @@ struct omap_hwmod;
 extern int omap_dss_reset(struct omap_hwmod *);
 
 /* SoC specific clock initializer */
-extern int (*omap_clk_init)(void);
+int omap_clk_init(void);
 
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3d9b3fc..8517a62 100644
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
+static int (*omap_clk_soc_init)(void);
 
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
 
 void __init am33xx_init_late(void)
@@ -635,7 +635,7 @@ void __init omap4430_init_early(void)
 	omap44xx_clockdomains_init();
 	omap44xx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_init = omap4xxx_clk_init;
+	omap_clk_soc_init = omap4xxx_clk_init;
 }
 
 void __init omap4430_init_late(void)
@@ -666,7 +666,7 @@ void __init omap5_init_early(void)
 	omap54xx_clockdomains_init();
 	omap54xx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap_clk_init = omap5xxx_dt_clk_init;
+	omap_clk_soc_init = omap5xxx_dt_clk_init;
 }
 
 void __init omap5_init_late(void)
@@ -711,3 +711,17 @@ void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
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
index 3ca81e0..60e5fc9 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -570,8 +570,7 @@ static inline void __init realtime_counter_init(void)
 			       clksrc_nr, clksrc_src, clksrc_prop)	\
 void __init omap##name##_gptimer_timer_init(void)			\
 {									\
-	if (omap_clk_init)						\
-		omap_clk_init();					\
+	omap_clk_init();					\
 	omap_dmtimer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
 	omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src,		\
@@ -582,8 +581,7 @@ void __init omap##name##_gptimer_timer_init(void)			\
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
