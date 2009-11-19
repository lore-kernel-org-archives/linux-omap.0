From: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Subject: [PATCH 1/3] omap3: pm: removes hardcoded VDD1/2 OPP values and make
 threshold generic
Date: Thu, 19 Nov 2009 16:54:27 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940254330A63@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59233 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbZKSLZA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 06:25:00 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From e5e225fc19410178ad378acc74183a1bf1f0251a Mon Sep 17 00:00:00 2001
From: Vijay Kumar <vijaykumar.gn@ti.com>
Date: Thu, 19 Nov 2009 14:39:59 +0530
Subject: [PATCH 1/3] omap3: pm: Adding facility to support OPP dynamically
 introduce  new accessor api's for
 1. Correcting VDD2 DVFS OPP threshold
 2. Removing hardcoded VDD1 OPP values and make threshold generic


Signed-off-by: Vijay Kumar <vijaykumar.gn@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c            |    2 +-
 arch/arm/mach-omap2/pm.c                   |    5 ++-
 arch/arm/mach-omap2/pm34xx.c               |   39 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/resource34xx.c         |    3 +-
 arch/arm/plat-omap/include/plat/omap-pm.h  |   27 +++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap34xx.h |   11 +++++---
 6 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index da5bc1f..9cfc7a0 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -1042,7 +1042,7 @@ static unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 #if defined(CONFIG_ARCH_OMAP3)
 
 #ifdef CONFIG_CPU_FREQ
-static struct cpufreq_frequency_table freq_table[MAX_VDD1_OPP+1];
+static struct cpufreq_frequency_table freq_table[MAX_VDD1_OPPS+1];
 
 void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index b324315..ba018f8 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -14,6 +14,7 @@
 
 #include <plat/resource.h>
 #include <plat/omap34xx.h>
+#include <plat/omap-pm.h>
 
 #include "pm.h"
 
@@ -92,13 +93,13 @@ static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
 	}
 
 	if (attr == &vdd1_opp_attr) {
-		if (value < 1 || value > 5) {
+		if (value < MIN_VDD1_OPP || value > MAX_VDD1_OPP) {
 			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
 			return -EINVAL;
 		}
 		resource_set_opp_level(VDD1_OPP, value, flags);
 	} else if (attr == &vdd2_opp_attr) {
-		if (value < 2 || value > 3) {
+		if (value < MIN_VDD2_OPP || value > 3) {
 			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
 			return -EINVAL;
 		}
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c328164..1ed7f53 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1059,6 +1059,45 @@ void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
 	prm_setup.vdd1_off = setup_vc->vdd1_off;
 }
 
+int omap3_get_max_vdd1_opp(void)
+{
+	if (cpu_is_omap3630())
+		return VDD1_OPP4;
+	else /* Place holder for other 34xx (3430/3440) */
+		return VDD1_OPP5;
+}
+EXPORT_SYMBOL(omap3_get_max_vdd1_opp);
+
+int omap3_get_min_vdd1_opp(void)
+{
+	if (cpu_is_omap3630())
+		return VDD1_OPP1;
+	else /* Place holder for other 34xx (3430/3440) */
+		return VDD1_OPP1;
+}
+EXPORT_SYMBOL(omap3_get_min_vdd1_opp);
+
+int omap3_get_max_vdd2_opp(void)
+{
+	if (cpu_is_omap3630())
+		return VDD2_OPP3;
+	else /* Place holder for other 34xx (3430/3440) */
+		return VDD2_OPP3;
+
+}
+EXPORT_SYMBOL(omap3_get_max_vdd2_opp);
+
+int omap3_get_min_vdd2_opp(void)
+{
+	if (cpu_is_omap3630())
+		return VDD2_OPP2;
+	else /* Place holder for other 34xx (3430/3440) */
+		return VDD2_OPP1;
+
+}
+EXPORT_SYMBOL(omap3_get_min_vdd2_opp);
+
+
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 04be4d2..cc85601 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -382,7 +382,8 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 		 * throughput in KiB/s for 100 Mhz = 100 * 1000 * 4.
 		 */
 		if (target_level >= 3)
-			resource_request("vdd2_opp", &vdd2_dev, 400000);
+			resource_request("vdd2_opp", &vdd2_dev,
+				(4 * (l3_opps + MAX_VDD2_OPP)->rate / 1000));
 
 	} else if (resp == vdd2_resp) {
 		tput = target_level;
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index 583e540..b089ccc 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -322,5 +322,32 @@ unsigned long omap_pm_cpu_get_freq(void);
  */
 int omap_pm_get_dev_context_loss_count(struct device *dev);
 
+/**
+ * omap3_get_max_opp - report Max OPP entries available for supplied VDD1 resource
+ *
+ * Returns the Max OPP entries available for supplied VDD resource.
+ */
+int omap3_get_max_vdd1_opp(void);
+
+/**
+ * omap3_get_min_opp - report Min OPP entries available for supplied VDD1 resource
+ *
+ * Returns the Min OPP entries available for supplied VDD resource.
+ */
+int omap3_get_min_vdd1_opp(void);
+
+/**
+ * omap3_get_max_opp - report Max OPP entries available for supplied VDD2 resource
+ *
+ * Returns the Max OPP entries available for supplied VDD resource.
+ */
+int omap3_get_max_vdd2_opp(void);
+
+/**
+ * omap3_get_min_opp - report Min OPP entries available for supplied VDD2 resource
+ *
+ * Returns the Min OPP entries available for supplied VDD resource.
+ */
+int omap3_get_min_vdd2_opp(void);
 
 #endif
diff --git a/arch/arm/plat-omap/include/plat/omap34xx.h b/arch/arm/plat-omap/include/plat/omap34xx.h
index 6b849e5..a4a7bd9 100644
--- a/arch/arm/plat-omap/include/plat/omap34xx.h
+++ b/arch/arm/plat-omap/include/plat/omap34xx.h
@@ -98,10 +98,13 @@
 #define VDD2_OPP2	0x2
 #define VDD2_OPP3	0x3
 
-#define MIN_VDD1_OPP	VDD1_OPP1
-#define MAX_VDD1_OPP	VDD1_OPP5
-#define MIN_VDD2_OPP	VDD2_OPP1
-#define MAX_VDD2_OPP	VDD2_OPP3
+#define MIN_VDD1_OPP	omap3_get_min_vdd1_opp()
+#define MAX_VDD1_OPP	omap3_get_max_vdd1_opp()
+#define MIN_VDD2_OPP	omap3_get_min_vdd2_opp()
+#define MAX_VDD2_OPP	omap3_get_max_vdd2_opp()
+
+/* Max OPP's Available among chips that comes under OMAP34xx configuration */
+#define MAX_VDD1_OPPS	VDD1_OPP5
 
 #endif /* __ASM_ARCH_OMAP34XX_H */
 
-- 
1.5.4.3
 


========================
Thanks and Regards
Vijay