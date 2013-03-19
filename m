From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: OMAP: clocks: Delay clk inits atleast until slab is initialized
Date: Tue, 19 Mar 2013 16:08:45 +0530
Message-ID: <1363689525-14584-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49532 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab3CSKjY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 06:39:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, phaber@broadcom.com, mturquette@linaro.org, santosh.shilimkar@ti.com, Rajendra Nayak <rnayak@ti.com>

clk inits on OMAP happen quite early, even before slab is available.
The dependency comes from the fact that the timer init code starts to
use clocks and hwmod and we need clocks to be initialized by then.

There are various problems doing clk inits this early, one is,
not being able to do dynamic clk registrations and hence the
dependency on clk-private.h. The other is, inability to debug
early kernel crashes without enabling DEBUG_LL and earlyprintk.

Doing early clk init also exposed another instance of a kernel
panic due to a BUG() when CONFIG_DEBUG_SLAB is enabled.
More details on the issue reported can be found here,
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg85932.html

With all these issues around clk inits happening way too early, it
makes sense to atleast move them to a point where dynamic memory
allocations are possible. So move them to a point just before the
timer code starts using clocks and hwmod.

This should atleast pave way for clk inits on OMAP moving to dynamic
clock registrations instead of using the static macros defined in
clk-private.h.

The issue with kernel panic while CONFIG_DEBUG_SLAB is enabled
was reported by Piotr Haber and Tony Lindgren and this patch
fixes the reported issue as well.

Reported-by: Piotr Haber <phaber@broadcom.com>
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
applies on 3.9-rc3 and tested on omap4 pandaES, omap3 beagle XM,
and am335x bone.

 arch/arm/mach-omap2/common.h |    3 +++
 arch/arm/mach-omap2/io.c     |   18 ++++++++++++------
 arch/arm/mach-omap2/timer.c  |    4 ++++
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 40f4a03..d6ba13e 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -293,5 +293,8 @@ extern void omap_reserve(void);
 struct omap_hwmod;
 extern int omap_dss_reset(struct omap_hwmod *);
 
+/* SoC specific clock initializer */
+extern int (*omap_clk_init)(void);
+
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2c3fdd6..5c445ca 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -55,6 +55,12 @@
 #include "prm44xx.h"
 
 /*
+ * omap_clk_init: points to a function that does the SoC-specific
+ * clock initializations
+ */
+int (*omap_clk_init)(void);
+
+/*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
  */
@@ -397,7 +403,7 @@ void __init omap2420_init_early(void)
 	omap242x_clockdomains_init();
 	omap2420_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap2420_clk_init();
+	omap_clk_init = omap2420_clk_init;
 }
 
 void __init omap2420_init_late(void)
@@ -427,7 +433,7 @@ void __init omap2430_init_early(void)
 	omap243x_clockdomains_init();
 	omap2430_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap2430_clk_init();
+	omap_clk_init = omap2430_clk_init;
 }
 
 void __init omap2430_init_late(void)
@@ -462,7 +468,7 @@ void __init omap3_init_early(void)
 	omap3xxx_clockdomains_init();
 	omap3xxx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap3xxx_clk_init();
+	omap_clk_init = omap3xxx_clk_init;
 }
 
 void __init omap3430_init_early(void)
@@ -500,7 +506,7 @@ void __init ti81xx_init_early(void)
 	omap3xxx_clockdomains_init();
 	omap3xxx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap3xxx_clk_init();
+	omap_clk_init = omap3xxx_clk_init;
 }
 
 void __init omap3_init_late(void)
@@ -568,7 +574,7 @@ void __init am33xx_init_early(void)
 	am33xx_clockdomains_init();
 	am33xx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	am33xx_clk_init();
+	omap_clk_init = am33xx_clk_init;
 }
 #endif
 
@@ -593,7 +599,7 @@ void __init omap4430_init_early(void)
 	omap44xx_clockdomains_init();
 	omap44xx_hwmod_init();
 	omap_hwmod_init_postsetup();
-	omap4xxx_clk_init();
+	omap_clk_init = omap4xxx_clk_init;
 }
 
 void __init omap4430_init_late(void)
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2bdd4cf..f62b509 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -547,6 +547,8 @@ static inline void __init realtime_counter_init(void)
 			       clksrc_nr, clksrc_src)			\
 void __init omap##name##_gptimer_timer_init(void)			\
 {									\
+	if (omap_clk_init)						\
+		omap_clk_init();					\
 	omap_dmtimer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
 	omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src);	\
@@ -556,6 +558,8 @@ void __init omap##name##_gptimer_timer_init(void)			\
 				clksrc_nr, clksrc_src)			\
 void __init omap##name##_sync32k_timer_init(void)		\
 {									\
+	if (omap_clk_init)						\
+		omap_clk_init();					\
 	omap_dmtimer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
 	/* Enable the use of clocksource="gp_timer" kernel parameter */	\
-- 
1.7.9.5

