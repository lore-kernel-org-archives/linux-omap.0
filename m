From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 10/17] OMAP3: PM: Disabling Smartreflex across both frequency and voltage scaling during DVFS.
Date: Thu, 18 Mar 2010 14:45:48 +0530
Message-ID: <1268903755-4151-11-git-send-email-thara@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
 <1268903755-4151-2-git-send-email-thara@ti.com>
 <1268903755-4151-3-git-send-email-thara@ti.com>
 <1268903755-4151-4-git-send-email-thara@ti.com>
 <1268903755-4151-5-git-send-email-thara@ti.com>
 <1268903755-4151-6-git-send-email-thara@ti.com>
 <1268903755-4151-7-git-send-email-thara@ti.com>
 <1268903755-4151-8-git-send-email-thara@ti.com>
 <1268903755-4151-9-git-send-email-thara@ti.com>
 <1268903755-4151-10-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50249 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076Ab0CRJQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 05:16:09 -0400
In-Reply-To: <1268903755-4151-10-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch disables smartreflex across both frequency and voltage
scaling instead of just across voltage scaling as before.
This is the hardware recommended practice.
This bug was first reported and solved on Nokia N900
code base by Nishanth Menon and Paul Walmsley.

This patch also does some changes in SRF to adapt to the new smartreflex
and voltage driver.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |   27 ++++++++++-----------------
 arch/arm/mach-omap2/resource34xx.h |    1 -
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index c6cce8b..fc1b775 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -28,6 +28,7 @@
 #include <plat/opp_twl_tps.h>
 
 #include "smartreflex.h"
+#include "voltage.h"
 #include "resource34xx.h"
 #include "pm.h"
 #include "cm.h"
@@ -331,12 +332,6 @@ static int program_opp(int res, enum opp_t opp_type, int target_level,
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
@@ -348,15 +343,15 @@ static int program_opp(int res, enum opp_t opp_type, int target_level,
 	else
 		raise = 0;
 
+	omap_smartreflex_disable(res);
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
@@ -364,21 +359,19 @@ static int program_opp(int res, enum opp_t opp_type, int target_level,
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
+			omap_voltage_scale(res, uvdc_target, uvdc_current);
 		}
-#endif
 	}
 
+	omap_smartreflex_enable(res);
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

