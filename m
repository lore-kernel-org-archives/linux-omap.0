From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH V3 2/8] OMAP2+: cpufreq: deny initialization if no mpudev
Date: Wed, 25 May 2011 16:38:47 -0700
Message-ID: <1306366733-8439-3-git-send-email-nm@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:41858 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754904Ab1EYXjH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:39:07 -0400
Received: by ywe9 with SMTP id 9so101364ywe.19
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:39:06 -0700 (PDT)
In-Reply-To: <1306366733-8439-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

if we do not have mpu_dev we normally fail in cpu_init. It is better
to fail driver registration if the devices are not available.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index a57b322..2d4e9d7 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -43,6 +43,7 @@
 static struct cpufreq_frequency_table *freq_table;
 static struct clk *mpu_clk;
 static char *mpu_clk_name;
+static struct device *mpu_dev;
 
 static int omap_verify_speed(struct cpufreq_policy *policy)
 {
@@ -155,7 +156,6 @@ skip_lpj:
 static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
-	struct device *mpu_dev;
 	static cpumask_var_t cpumask;
 
 	mpu_clk = clk_get(NULL, mpu_clk_name);
@@ -166,12 +166,6 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 		return -EINVAL;
 
 	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
-	mpu_dev = omap2_get_mpuss_device();
-
-	if (!mpu_dev) {
-		pr_warning("%s: unable to get the mpu device\n", __func__);
-		return -EINVAL;
-	}
 	opp_init_cpufreq_table(mpu_dev, &freq_table);
 
 	if (freq_table) {
@@ -244,6 +238,13 @@ static int __init omap_cpufreq_init(void)
 		pr_err("%s: unsupported Silicon?\n", __func__);
 		return -EINVAL;
 	}
+
+	mpu_dev = omap2_get_mpuss_device();
+	if (!mpu_dev) {
+		pr_warning("%s: unable to get the mpu device\n", __func__);
+		return -EINVAL;
+	}
+
 	return cpufreq_register_driver(&omap_driver);
 }
 
-- 
1.7.1

