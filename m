From: Romit Dasgupta <romit@ti.com>
Subject: [PATCH 6/10] OPP layer and additional cleanups
Date: Thu, 31 Dec 2009 18:59:22 +0530
Message-ID: <1262266162.20175.182.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47333 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211AbZLaN3a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Dec 2009 08:29:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, nm@ti.com, khilman@deeprootsystems.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Introduce a new types for
1. for identifying voltage rails.
2. generic voltage scaling routine and its registration function.

and the prototype for the registration function itself.

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 65a6e04..d36cd1d 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -12,6 +12,9 @@
 #define __ARCH_ARM_MACH_OMAP2_PM_H
 
 #include <plat/powerdomain.h>
+#ifdef CONFIG_ARCH_OMAP3
+#include <plat/opp.h>
+#endif
 
 extern u32 enable_off_mode;
 extern u32 sleep_while_idle;
@@ -23,6 +26,20 @@ extern void omap_sram_idle(void);
 extern int omap3_can_sleep(void);
 extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
+#ifdef CONFIG_ARCH_OMAP3
+extern unsigned long get_l3_target_freq(struct omap_opp *);
+enum volt_rail {
+	RAIL_NONE,
+	RAIL_VDD1,
+	RAIL_VDD2,
+};
+
+typedef int (*volt_scale_t) (enum volt_rail, struct omap_opp *,
+				struct omap_opp *);
+extern volt_scale_t voltage_scale;
+extern int pm_register_volt_scaling(volt_scale_t);
+#endif
+
 
 struct cpuidle_params {
 	u8  valid;


