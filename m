From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 17/23] OMAP3: PM: Fixed VDD2 control to work from both sysfs and SRF API
Date: Thu, 11 Dec 2008 17:52:36 +0200
Message-ID: <1229010762-3150-18-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-6-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-7-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-8-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-9-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-10-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-11-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-12-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-13-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-14-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-15-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-16-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-17-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34964 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201AbYLKP7O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:14 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBBFwj2o020861
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 17:59:06 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mBBFwchw011022
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 17:59:02 +0200
In-Reply-To: <1229010762-3150-17-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

SRF API for setting throughput requirement attempted to use throughput values
as parameter to set_opp() and sysfs was attempting to use OPP levels (1..3.)

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm.c                   |    5 +-
 arch/arm/mach-omap2/pm.h                   |    1 +
 arch/arm/mach-omap2/resource34xx.c         |   62 ++++++++++++++++++----------
 arch/arm/plat-omap/include/mach/omap34xx.h |    4 ++
 4 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 285f596..2dd1341 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -61,7 +61,6 @@ static struct kobj_attribute voltage_off_while_idle_attr =
 	__ATTR(voltage_off_while_idle, 0644, idle_show, idle_store);
 
 #ifdef CONFIG_OMAP_PM_SRF
-static struct device dummy_sysfs_dev;
 static ssize_t vdd_opp_show(struct kobject *, struct kobj_attribute *, char *);
 static ssize_t vdd_opp_store(struct kobject *k, struct kobj_attribute *,
 			  const char *buf, size_t n);
@@ -145,13 +144,13 @@ static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
 			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
 			return -EINVAL;
 		}
-		resource_request("vdd1_opp", &dummy_sysfs_dev, value);
+		set_opp_level(VDD1_OPP, value);
 	} else if (attr == &vdd2_opp_attr) {
 		if (value < 2 || value > 3) {
 			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
 			return -EINVAL;
 		}
-		resource_request("vdd2_opp", &dummy_sysfs_dev, value);
+		set_opp_level(VDD2_OPP, value);
 	} else {
 		return -EINVAL;
 	}
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index a209819..4c0052f 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -42,6 +42,7 @@ extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 #define omap3_pm_set_suspend_state(pwrdm,state) do {} while (0);
 #endif
 extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
+extern int set_opp_level(int res, u32 target_level);
 
 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 034318b..d2c4e1f 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -135,6 +135,8 @@ int set_pd_latency(struct shared_resource *resp, u32 latency)
 
 static struct clk *vdd1_clk;
 static struct clk *vdd2_clk;
+static struct shared_resource *vdd1_resp;
+static struct shared_resource *vdd2_resp;
 static struct device dummy_mpu_dev;
 static struct device dummy_dsp_dev;
 
@@ -154,19 +156,27 @@ void init_opp(struct shared_resource *resp)
 	if (strcmp(resp->name, "vdd1_opp") == 0) {
 		resp->curr_level = curr_vdd1_prcm_set->opp_id;
 		vdd1_clk = clk_get(NULL, "virt_vdd1_prcm_set");
+		vdd1_resp = resp;
 	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
 		resp->curr_level = curr_vdd2_prcm_set->opp_id;
 		vdd2_clk = clk_get(NULL, "virt_vdd2_prcm_set");
+		vdd2_resp = resp;
 	}
 	return;
 }
 
-int set_opp(struct shared_resource *resp, u32 target_level)
+int set_opp_level(int res, u32 target_level)
 {
-	unsigned long mpu_freq, mpu_old_freq, l3_freq, tput, t_opp;
-	int ind;
-	struct bus_throughput_db *tput_db;
+	unsigned long mpu_freq, mpu_old_freq, l3_freq, t_opp;
 	struct cpufreq_freqs freqs_notify;
+	struct shared_resource *resp;
+
+	if (res == VDD1_OPP)
+		resp = vdd1_resp;
+	else if (res == VDD2_OPP)
+		resp = vdd2_resp;
+	else
+		return 0;
 
 	if (resp->curr_level == target_level)
 		return 0;
@@ -174,7 +184,7 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 	if (!mpu_opps || !dsp_opps || !l3_opps)
 		return 0;
 
-	if (strcmp(resp->name, "vdd1_opp") == 0) {
+	if (res == VDD1_OPP) {
 		mpu_old_freq = get_freq(mpu_opps + MAX_VDD1_OPP,
 					curr_vdd1_prcm_set->opp_id);
 		mpu_freq = get_freq(mpu_opps + MAX_VDD1_OPP,
@@ -208,23 +218,7 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 		/* Send a post notification to CPUFreq */
 		cpufreq_notify_transition(&freqs_notify, CPUFREQ_POSTCHANGE);
 #endif
-	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
-		tput_db = resp->resource_data;
-		tput = target_level;
-		/* using the throughput db map to the appropriate L3 Freq */
-		for (ind = 1; ind < MAX_VDD2_OPP; ind++)
-			if (tput_db->throughput[ind] > tput)
-				target_level = ind;
-
-		/* Set the highest OPP possible */
-		if (ind == MAX_VDD2_OPP)
-			target_level = ind-1;
-
-		if (resp->curr_level == target_level)
-			return 0;
-
-		resp->curr_level = target_level;
-
+	} else {
 		l3_freq = get_freq(l3_opps + MAX_VDD2_OPP,
 					target_level);
 		t_opp = ID_VDD(PRCM_VDD2) |
@@ -249,6 +243,30 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 	return 0;
 }
 
+int set_opp(struct shared_resource *resp, u32 target_level)
+{
+	unsigned long tput;
+	int ind;
+	struct bus_throughput_db *tput_db;
+
+	if (resp == vdd1_resp) {
+		set_opp_level(VDD1_OPP, target_level);
+	} else if (resp == vdd2_resp) {
+		tput_db = resp->resource_data;
+		tput = target_level;
+		/* using the throughput db map to the appropriate L3 Freq */
+		for (ind = 1; ind < MAX_VDD2_OPP; ind++)
+			if (tput_db->throughput[ind] > tput)
+				target_level = ind;
+
+		/* Set the highest OPP possible */
+		if (ind == MAX_VDD2_OPP)
+			target_level = ind-1;
+		set_opp_level(VDD2_OPP, target_level);
+	}
+	return 0;
+}
+
 /**
  * validate_opp - Validates if valid VDD1 OPP's are passed as the
  * target_level.
diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index b64375e..6db9a6c 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -72,6 +72,10 @@
 #define OMAP34XX_DSP_IPI_BASE	(OMAP34XX_DSP_BASE + 0x1000000)
 #define OMAP34XX_DSP_MMU_BASE	(OMAP34XX_DSP_BASE + 0x2000000)
 
+/* VDD OPP identifiers */
+#define VDD1_OPP	0x1
+#define VDD2_OPP	0x2
+
 /* VDD1 OPPS */
 #define VDD1_OPP1	0x1
 #define VDD1_OPP2	0x2
-- 
1.5.4.3

