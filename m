From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] ARM: OMAP1: Move dpll1 rates selection from config to runtime
Date: Sun,  4 Dec 2011 13:17:01 +0100
Message-ID: <1323001021-7322-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <20111130222837.GR31337@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:58476 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab1LDMSW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Dec 2011 07:18:22 -0500
In-Reply-To: <20111130222837.GR31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

For still better multi-OMAP1 support, expand omap1_rate_table with flags
for different SoC types and match them while selecting clock rates. The
idea is stolen from current omap24xx clock rate selection algorithm.

Since clkdev platform flag definitions are reused here, those had to be
expanded with one extra entry for OMAP1710 subtype, as this is the only
SoC for which we allow selection of the highest, 216 MHz rate.

Once done, remove no longer needed clock rate configure time options.

Created against linux-omap/master tip as of Thu Dec 1,
commit f83c2a8cbb59981722d1ab610c79adfd034a2667.
Tested on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
Hi,
Here is a list of changes against the initial version, submitted as
patch 2a/5 v2 "ARM: OMAP1: select clock rate by CPU type" of the series
"ARM: OMAP1: Fix dpll1 reprogramming related issues":
* drop no longer needed .config options, as suggested by Tony (thanks!),
* follow selection conditions of those removed .config clock rate
  options more closely (I missed that before, ended up reinventing the
  wheel),
* add extra clkdev platform flag for OMAP1710 to be able to limit the
  216 MHz rate selection to this SoC subtype only,
* update commit summary and message.

I still wonder if it is sufficient to select a highest rate for a board
based on a SoC type only, not on the board type itself. For example, the
Amstrad Delta has been used to be running at 150 MHz since it was
introduced first, while from now on it will be running at 168 MHz.
I haven't noticed any visible issues so far, but who knows...
Any opinions?

Thanks,
Janusz


 arch/arm/configs/omap1_defconfig              |    1 -
 arch/arm/mach-omap1/Kconfig                   |   64 -------------------------
 arch/arm/mach-omap1/clock.c                   |    6 ++
 arch/arm/mach-omap1/clock.h                   |    3 +
 arch/arm/mach-omap1/clock_data.c              |    6 ++-
 arch/arm/mach-omap1/opp.h                     |    1 +
 arch/arm/mach-omap1/opp_data.c                |   63 +++++++++++-------------
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
 8 files changed, 45 insertions(+), 100 deletions(-)

diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 945a34f..dde2a1a 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -48,7 +48,6 @@ CONFIG_MACH_SX1=y
 CONFIG_MACH_NOKIA770=y
 CONFIG_MACH_AMS_DELTA=y
 CONFIG_MACH_OMAP_GENERIC=y
-CONFIG_OMAP_ARM_182MHZ=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_PCCARD=y
 CONFIG_OMAP_CF=y
diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 73f287d..4f8d66f 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -168,70 +168,6 @@ config MACH_OMAP_GENERIC
           custom OMAP boards. Say Y here if you have a custom
           board.
 
-comment "OMAP CPU Speed"
-	depends on ARCH_OMAP1
-
-config OMAP_ARM_216MHZ
-	bool "OMAP ARM 216 MHz CPU (1710 only)"
-        depends on ARCH_OMAP1 && ARCH_OMAP16XX
-        help
-          Enable 216 MHz clock for OMAP1710 CPU. If unsure, say N.
-
-config OMAP_ARM_195MHZ
-	bool "OMAP ARM 195 MHz CPU"
-	depends on ARCH_OMAP1 && (ARCH_OMAP730 || ARCH_OMAP850)
-	help
-          Enable 195MHz clock for OMAP CPU. If unsure, say N.
-
-config OMAP_ARM_192MHZ
-	bool "OMAP ARM 192 MHz CPU"
-	depends on ARCH_OMAP1 && ARCH_OMAP16XX
-	help
-          Enable 192MHz clock for OMAP CPU. If unsure, say N.
-
-config OMAP_ARM_182MHZ
-	bool "OMAP ARM 182 MHz CPU"
-	depends on ARCH_OMAP1 && (ARCH_OMAP730 || ARCH_OMAP850)
-	help
-          Enable 182MHz clock for OMAP CPU. If unsure, say N.
-
-config OMAP_ARM_168MHZ
-	bool "OMAP ARM 168 MHz CPU"
-	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_OMAP850)
-	help
-          Enable 168MHz clock for OMAP CPU. If unsure, say N.
-
-config OMAP_ARM_150MHZ
-	bool "OMAP ARM 150 MHz CPU"
-	depends on ARCH_OMAP1 && ARCH_OMAP15XX
-	help
-	  Enable 150MHz clock for OMAP CPU. If unsure, say N.
-
-config OMAP_ARM_120MHZ
-	bool "OMAP ARM 120 MHz CPU"
-	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_OMAP850)
-	help
-          Enable 120MHz clock for OMAP CPU. If unsure, say N.
-
-config OMAP_ARM_96MHZ
-	bool "OMAP ARM 96 MHz CPU"
-	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_OMAP850)
-	help
-          Enable 96MHz clock for OMAP CPU. If unsure, say N.
-
-config OMAP_ARM_60MHZ
-	bool "OMAP ARM 60 MHz CPU"
-	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_OMAP850)
-        default y
-	help
-          Enable 60MHz clock for OMAP CPU. If unsure, say Y.
-
-config OMAP_ARM_30MHZ
-	bool "OMAP ARM 30 MHz CPU"
-	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_OMAP850)
-	help
-          Enable 30MHz clock for OMAP CPU. If unsure, say N.
-
 endmenu
 
 endif
diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 84ef704..ff27dbd 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -197,6 +197,9 @@ int omap1_select_table_rate(struct clk *clk, unsigned long rate)
 	ref_rate = ck_ref_p->rate;
 
 	for (ptr = omap1_rate_table; ptr->rate; ptr++) {
+		if (!(ptr->flags & cpu_mask))
+			continue;
+
 		if (ptr->xtal != ref_rate)
 			continue;
 
@@ -290,6 +293,9 @@ long omap1_round_to_table_rate(struct clk *clk, unsigned long rate)
 	highest_rate = -EINVAL;
 
 	for (ptr = omap1_rate_table; ptr->rate; ptr++) {
+		if (!(ptr->flags & cpu_mask))
+			continue;
+
 		if (ptr->xtal != ref_rate)
 			continue;
 
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 16b1423..3d04f4f 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -111,4 +111,7 @@ extern const struct clkops clkops_dummy;
 extern const struct clkops clkops_uart_16xx;
 extern const struct clkops clkops_generic;
 
+/* used for passing SoC type to omap1_{select,round_to}_table_rate() */
+extern u32 cpu_mask;
+
 #endif
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 9ff90a7..ff2d524 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -778,12 +778,14 @@ static void __init omap1_show_rates(void)
 		arm_ck.rate / 1000000, (arm_ck.rate / 100000) % 10);
 }
 
+u32 cpu_mask;
+
 int __init omap1_clk_init(void)
 {
 	struct omap_clk *c;
 	const struct omap_clock_config *info;
 	int crystal_type = 0; /* Default 12 MHz */
-	u32 reg, cpu_mask;
+	u32 reg;
 
 #ifdef CONFIG_DEBUG_LL
 	/*
@@ -808,6 +810,8 @@ int __init omap1_clk_init(void)
 		clk_preinit(c->lk.clk);
 
 	cpu_mask = 0;
+	if (cpu_is_omap1710())
+		cpu_mask |= CK_1710;
 	if (cpu_is_omap16xx())
 		cpu_mask |= CK_16XX;
 	if (cpu_is_omap1510())
diff --git a/arch/arm/mach-omap1/opp.h b/arch/arm/mach-omap1/opp.h
index 07074d7..79a6838 100644
--- a/arch/arm/mach-omap1/opp.h
+++ b/arch/arm/mach-omap1/opp.h
@@ -21,6 +21,7 @@ struct mpu_rate {
 	unsigned long		pll_rate;
 	__u16			ckctl_val;
 	__u16			dpllctl_val;
+	u32			flags;
 };
 
 extern struct mpu_rate omap1_rate_table[];
diff --git a/arch/arm/mach-omap1/opp_data.c b/arch/arm/mach-omap1/opp_data.c
index 75a5465..47094c4 100644
--- a/arch/arm/mach-omap1/opp_data.c
+++ b/arch/arm/mach-omap1/opp_data.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <plat/clkdev_omap.h>
 #include "opp.h"
 
 /*-------------------------------------------------------------------------
@@ -20,40 +21,34 @@ struct mpu_rate omap1_rate_table[] = {
 	 * NOTE: Comment order here is different from bits in CKCTL value:
 	 * armdiv, dspdiv, dspmmu, tcdiv, perdiv, lcddiv
 	 */
-#if defined(CONFIG_OMAP_ARM_216MHZ)
-	{ 216000000, 12000000, 216000000, 0x050d, 0x2910 }, /* 1/1/2/2/2/8 */
-#endif
-#if defined(CONFIG_OMAP_ARM_195MHZ)
-	{ 195000000, 13000000, 195000000, 0x050e, 0x2790 }, /* 1/1/2/2/4/8 */
-#endif
-#if defined(CONFIG_OMAP_ARM_192MHZ)
-	{ 192000000, 19200000, 192000000, 0x050f, 0x2510 }, /* 1/1/2/2/8/8 */
-	{ 192000000, 12000000, 192000000, 0x050f, 0x2810 }, /* 1/1/2/2/8/8 */
-	{  96000000, 12000000, 192000000, 0x055f, 0x2810 }, /* 2/2/2/2/8/8 */
-	{  48000000, 12000000, 192000000, 0x0baf, 0x2810 }, /* 4/4/4/8/8/8 */
-	{  24000000, 12000000, 192000000, 0x0fff, 0x2810 }, /* 8/8/8/8/8/8 */
-#endif
-#if defined(CONFIG_OMAP_ARM_182MHZ)
-	{ 182000000, 13000000, 182000000, 0x050e, 0x2710 }, /* 1/1/2/2/4/8 */
-#endif
-#if defined(CONFIG_OMAP_ARM_168MHZ)
-	{ 168000000, 12000000, 168000000, 0x010f, 0x2710 }, /* 1/1/1/2/8/8 */
-#endif
-#if defined(CONFIG_OMAP_ARM_150MHZ)
-	{ 150000000, 12000000, 150000000, 0x010a, 0x2cb0 }, /* 1/1/1/2/4/4 */
-#endif
-#if defined(CONFIG_OMAP_ARM_120MHZ)
-	{ 120000000, 12000000, 120000000, 0x010a, 0x2510 }, /* 1/1/1/2/4/4 */
-#endif
-#if defined(CONFIG_OMAP_ARM_96MHZ)
-	{  96000000, 12000000,  96000000, 0x0005, 0x2410 }, /* 1/1/1/1/2/2 */
-#endif
-#if defined(CONFIG_OMAP_ARM_60MHZ)
-	{  60000000, 12000000,  60000000, 0x0005, 0x2290 }, /* 1/1/1/1/2/2 */
-#endif
-#if defined(CONFIG_OMAP_ARM_30MHZ)
-	{  30000000, 12000000,  60000000, 0x0555, 0x2290 }, /* 2/2/2/2/2/2 */
-#endif
+	{ 216000000, 12000000, 216000000, 0x050d, 0x2910, /* 1/1/2/2/2/8 */
+			CK_1710 },
+	{ 195000000, 13000000, 195000000, 0x050e, 0x2790, /* 1/1/2/2/4/8 */
+			CK_7XX },
+	{ 192000000, 19200000, 192000000, 0x050f, 0x2510, /* 1/1/2/2/8/8 */
+			CK_16XX },
+	{ 192000000, 12000000, 192000000, 0x050f, 0x2810, /* 1/1/2/2/8/8 */
+			CK_16XX },
+	{  96000000, 12000000, 192000000, 0x055f, 0x2810, /* 2/2/2/2/8/8 */
+			CK_16XX },
+	{  48000000, 12000000, 192000000, 0x0baf, 0x2810, /* 4/4/4/8/8/8 */
+			CK_16XX },
+	{  24000000, 12000000, 192000000, 0x0fff, 0x2810, /* 8/8/8/8/8/8 */
+			CK_16XX },
+	{ 182000000, 13000000, 182000000, 0x050e, 0x2710, /* 1/1/2/2/4/8 */
+			CK_7XX },
+	{ 168000000, 12000000, 168000000, 0x010f, 0x2710, /* 1/1/1/2/8/8 */
+			CK_16XX|CK_1510|CK_7XX },
+	{ 150000000, 12000000, 150000000, 0x010a, 0x2cb0, /* 1/1/1/2/4/4 */
+			CK_1510 },
+	{ 120000000, 12000000, 120000000, 0x010a, 0x2510, /* 1/1/1/2/4/4 */
+			CK_16XX|CK_1510|CK_310|CK_7XX },
+	{  96000000, 12000000,  96000000, 0x0005, 0x2410, /* 1/1/1/1/2/2 */
+			CK_16XX|CK_1510|CK_310|CK_7XX },
+	{  60000000, 12000000,  60000000, 0x0005, 0x2290, /* 1/1/1/1/2/2 */
+			CK_16XX|CK_1510|CK_310|CK_7XX },
+	{  30000000, 12000000,  60000000, 0x0555, 0x2290, /* 2/2/2/2/2/2 */
+			CK_16XX|CK_1510|CK_310|CK_7XX },
 	{ 0, 0, 0, 0, 0 },
 };
 
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index 6d84c0c..7b9a934 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -41,6 +41,7 @@ struct omap_clk {
 #define CK_TI816X	(1 << 12)
 #define CK_446X		(1 << 13)
 #define CK_AM33XX	(1 << 14)	/* AM33xx specific clocks */
+#define CK_1710		(1 << 15)	/* 1710 extra for rate selection */
 
 
 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
-- 
1.7.3.4

