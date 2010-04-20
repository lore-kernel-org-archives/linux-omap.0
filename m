From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-OPP][PATCH 1/2 v2] omap3: pm: cpufreq: BUG_ON cleanup
Date: Tue, 20 Apr 2010 14:49:53 -0500
Message-ID: <1271792994-31816-2-git-send-email-nm@ti.com>
References: <1271792994-31816-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54121 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755020Ab0DTTuO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 15:50:14 -0400
In-Reply-To: <1271792994-31816-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ambresh K <ambresh@ti.com>, Benoit Cousson <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Sanjeev Premi <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Thara Gopinath <thara@ti.com>

BUG_ON should not ideally contain a functional code.
Ref: http://marc.info/?l=linux-kernel&m=109391212925546&w=2

To do this, we change the return of omap3_pm_init_opp from
void to int and return back error value for caller to adequately
handle further decisions. to reduce code duplication, the
registration and error handling are done in loop now.

Cc: Ambresh K <ambresh@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Ref:
v1: https://patchwork.kernel.org/patch/86793/
v2 changes:
	removed BUG_ON entirely. instead have introduced int
	return value allowing for board files which call to
	handle the return results intelligently.

 arch/arm/mach-omap2/cpufreq34xx.c |   36 ++++++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/omap3-opp.h   |    5 +++--
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
index 189c42e..01cf98f 100644
--- a/arch/arm/mach-omap2/cpufreq34xx.c
+++ b/arch/arm/mach-omap2/cpufreq34xx.c
@@ -25,6 +25,7 @@
 
 #include <plat/opp.h>
 #include <plat/cpu.h>
+#include "omap3-opp.h"
 
 static struct omap_opp_def __initdata omap34xx_mpu_rate_table[] = {
 	/* OPP1 */
@@ -109,8 +110,9 @@ static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
 	OMAP_OPP_DEF(0, 0, 0)
 };
 
-void __init omap3_pm_init_opp_table(void)
+int __init omap3_pm_init_opp_table(void)
 {
+	int i, r;
 	struct omap_opp_def **omap3_opp_def_list;
 	struct omap_opp_def *omap34xx_opp_def_list[] = {
 		omap34xx_mpu_rate_table,
@@ -122,12 +124,38 @@ void __init omap3_pm_init_opp_table(void)
 		omap36xx_l3_rate_table,
 		omap36xx_dsp_rate_table
 	};
+	enum opp_t omap3_opps[] = {
+		OPP_MPU,
+		OPP_L3,
+		OPP_DSP
+	};
 
 	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
 				omap34xx_opp_def_list;
 
-	BUG_ON(opp_init_list(OPP_MPU, omap3_opp_def_list[0]));
-	BUG_ON(opp_init_list(OPP_L3, omap3_opp_def_list[1]));
-	BUG_ON(opp_init_list(OPP_DSP, omap3_opp_def_list[2]));
+	for (i = 0; i < ARRAY_SIZE(omap3_opps); i++) {
+		r = opp_init_list(omap3_opps[i], omap3_opp_def_list[i]);
+		if (r)
+			break;
+	}
+	if (!r)
+		return 0;
+
+	/* Cascading error handling - disable all enabled OPPs */
+	pr_err("%s: Failed to register %d OPP type\n", __func__,
+		omap3_opps[i]);
+	i--;
+	while (i != -1) {
+		struct omap_opp *opp;
+		unsigned long freq = 0;
+		while (!IS_ERR(opp = opp_find_freq_ceil(omap3_opps[i],
+							&freq))) {
+			opp_disable(opp);
+			freq++;
+		}
+		i--;
+	}
+
+	return r;
 }
 
diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
index 1ba85fc..3e88d8c 100644
--- a/arch/arm/mach-omap2/omap3-opp.h
+++ b/arch/arm/mach-omap2/omap3-opp.h
@@ -9,10 +9,11 @@
  * table after the basic initialization
  */
 #ifdef CONFIG_CPU_FREQ
-extern void omap3_pm_init_opp_table(void);
+extern int omap3_pm_init_opp_table(void);
 #else
-static inline void omap3_pm_init_opp_table(void)
+static inline int omap3_pm_init_opp_table(void)
 {
+	return 0;
 }
 #endif
 
-- 
1.6.3.3

