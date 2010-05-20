From: Nishanth Menon <nm@ti.com>
Subject: [PM][PATCH] omap3: cpufreq: allow default opp table init
Date: Wed, 19 May 2010 20:14:53 -0500
Message-ID: <1274318093-29010-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51673 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791Ab0ETBO6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 21:14:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Cliff Brake <cliff.brake@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>

For board files which choose to override the defaults, the existing
mechanism will work, for boards that would like to work with defaults,
allow init_common_hw to call init_opp_table to initialize if not
already initialized. this will allow all omap boards which have opp
tables predefined for a silicon to use the same.

Originally reported for overo: 
http://marc.info/?t=127265269400004&r=1&w=2

Signed-off-by: Nishanth Menon <nm@ti.com>
Reported-by: Peter Tseng <tsenpet09@gmail.com>
Cc: Cliff Brake <cliff.brake@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
NOTE: This makes rest of the current board omap3_pm_init_opp_table
calls redundant, but also allows for custom boards to go ahead and
customize their own custom OPPs in parallel.

 arch/arm/mach-omap2/cpufreq34xx.c |   11 +++++++++++
 arch/arm/mach-omap2/io.c          |    4 ++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
index 8747dd6..b9d75cf 100644
--- a/arch/arm/mach-omap2/cpufreq34xx.c
+++ b/arch/arm/mach-omap2/cpufreq34xx.c
@@ -110,6 +110,9 @@ static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
 	OMAP_OPP_DEF(0, 0, 0)
 };
 
+/* Temp variable to allow multiple calls */
+static u8 __initdata omap3_table_init;
+
 int __init omap3_pm_init_opp_table(void)
 {
 	int i, r;
@@ -130,6 +133,14 @@ int __init omap3_pm_init_opp_table(void)
 		OPP_DSP
 	};
 
+	/*
+	 * Allow multiple calls, but initialize only if not already initalized
+	 * even if the previous call failed, coz, no reason we'd succeed again
+	 */
+	if (omap3_table_init)
+		return 0;
+	omap3_table_init = 1;
+
 	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
 				omap34xx_opp_def_list;
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 984bdbf..203c7e8 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -47,6 +47,7 @@
 #include "clockdomains.h"
 #include <plat/omap_hwmod.h>
 
+#include "omap3-opp.h"
 /*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
@@ -307,6 +308,9 @@ static int __init _omap2_init_reprogram_sdrc(void)
 void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 				 struct omap_sdrc_params *sdrc_cs1)
 {
+	/* initialize the opp table if board file has not done so */
+	omap3_pm_init_opp_table();
+
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_autodeps);
 	if (cpu_is_omap242x())
-- 
1.6.3.3

