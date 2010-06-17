From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 09/12] OMAP3: CPUfreq: update to device-based OPP API
Date: Wed, 16 Jun 2010 17:17:10 -0700
Message-ID: <1276733833-18510-10-git-send-email-khilman@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:61763 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758535Ab0FQARg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:17:36 -0400
Received: by mail-px0-f174.google.com with SMTP id 8so4194812pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:17:36 -0700 (PDT)
In-Reply-To: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

Update usage of OPP API to use new device-based API.  This requires
getting the 'struct device' for the MPU and using that with the OPP
API.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/cpu-omap.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 0674405..b086795 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -89,6 +89,7 @@ static int omap_target(struct cpufreq_policy *policy,
 #endif
 #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 	unsigned long freq;
+	struct device *mpu_dev = omap_get_mpu_device();
 #endif
 	int ret = 0;
 
@@ -115,7 +116,7 @@ static int omap_target(struct cpufreq_policy *policy,
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 	freq = target_freq * 1000;
-	if (opp_find_freq_ceil(OPP_MPU, &freq))
+	if (opp_find_freq_ceil(mpu_dev, &freq))
 		omap_pm_cpu_set_freq(freq);
 #endif
 	return ret;
@@ -134,10 +135,13 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cur = policy->min = policy->max = omap_getspeed(0);
 
-	if (!cpu_is_omap34xx())
+	if (!cpu_is_omap34xx()) {
 		clk_init_cpufreq_table(&freq_table);
-	else
-		opp_init_cpufreq_table(OPP_MPU, &freq_table);
+	} else {
+		struct device *mpu_dev = omap_get_mpu_device();
+
+		opp_init_cpufreq_table(mpu_dev, &freq_table);
+	}
 
 	if (freq_table) {
 		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
-- 
1.7.0.2

