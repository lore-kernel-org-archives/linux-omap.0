From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 2/4] OMAP3: PM: Disabling Smartreflex across both frequency and voltage scaling during DVFS.
Date: Sat, 29 May 2010 22:16:52 +0530
Message-ID: <1275151614-16634-3-git-send-email-thara@ti.com>
References: <1275151614-16634-1-git-send-email-thara@ti.com>
 <1275151614-16634-2-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38090 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753988Ab0E2QrD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 May 2010 12:47:03 -0400
In-Reply-To: <1275151614-16634-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch disables smartreflex across both frequency and voltage
scaling instead of just across voltage scaling as before.
This is the hardware recommended practice.
This bug was first reported and solved on Nokia N900
code base by Nishanth Menon and Paul Walmsley.

This patch also does some changes in SRF to adapt to the new smartreflex
and voltage driver.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |   29 +++++++++++------------------
 arch/arm/mach-omap2/resource34xx.h |    1 -
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 2bc5694..886657a 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -26,8 +26,9 @@
 #include <plat/clockdomain.h>
 #include <plat/omap34xx.h>
 #include <plat/opp_twl_tps.h>
+#include <plat/smartreflex.h>
 
-#include "smartreflex.h"
+#include "voltage.h"
 #include "resource34xx.h"
 #include "pm.h"
 #include "cm.h"
@@ -353,12 +354,6 @@ static int program_opp(int res, enum opp_t opp_type, int target_level,
 {
 	int i, ret = 0, raise;
 	unsigned long freq;
-#ifdef CONFIG_OMAP_SMARTREFLEX
-	unsigned long t_opp, c_opp;
-
-	t_opp = ID_VDD(res) | ID_OPP_NO(target_level);
-	c_opp = ID_VDD(res) | ID_OPP_NO(current_level);
-#endif
 
 	/* See if have a freq associated, if not, invalid opp */
 	ret = opp_to_freq(&freq, opp_type, target_level);
@@ -370,15 +365,15 @@ static int program_opp(int res, enum opp_t opp_type, int target_level,
 	else
 		raise = 0;
 
+	omap_smartreflex_disable(res - 1);
+
 	for (i = 0; i < 2; i++) {
-		if (i == raise)
+		if (i == raise) {
 			ret = program_opp_freq(res, target_level,
 					current_level);
-#ifdef CONFIG_OMAP_SMARTREFLEX
-		else {
-			u8 vc, vt;
+		} else {
 			struct omap_opp *oppx;
-			unsigned long uvdc;
+			unsigned long uvdc_current, uvdc_target;
 
 			/*
 			 * transitioning from good to good OPP
@@ -386,21 +381,19 @@ static int program_opp(int res, enum opp_t opp_type, int target_level,
 			 */
 			oppx = opp_find_freq_exact(opp_type, freq, true);
 			BUG_ON(IS_ERR(oppx));
-			uvdc = opp_get_voltage(oppx);
-			vt = omap_twl_uv_to_vsel(uvdc);
+			uvdc_target = opp_get_voltage(oppx);
 
 			BUG_ON(opp_to_freq(&freq, opp_type, current_level));
 			oppx = opp_find_freq_exact(opp_type, freq, true);
 			BUG_ON(IS_ERR(oppx));
-			uvdc = opp_get_voltage(oppx);
-			vc = omap_twl_uv_to_vsel(uvdc);
+			uvdc_current = opp_get_voltage(oppx);
 
 			/* ok to scale.. */
-			sr_voltagescale_vcbypass(t_opp, c_opp, vt, vc);
+			omap_voltage_scale(res - 1, uvdc_target);
 		}
-#endif
 	}
 
+	omap_smartreflex_enable(res - 1);
 	return ret;
 }
 
diff --git a/arch/arm/mach-omap2/resource34xx.h b/arch/arm/mach-omap2/resource34xx.h
index 0b4e76e..b56d2df 100644
--- a/arch/arm/mach-omap2/resource34xx.h
+++ b/arch/arm/mach-omap2/resource34xx.h
@@ -30,7 +30,6 @@
 #include <plat/opp.h>
 #include <plat/omap34xx.h>
 
-extern int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
 extern void lock_scratchpad_sem(void);
 extern void unlock_scratchpad_sem(void);
 
-- 
1.7.0.rc1.33.g07cf0f

