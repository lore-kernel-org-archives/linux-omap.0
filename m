From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 06/10] cpufreq: OMAP: deny initialization if no mpudev
Date: Thu, 22 Sep 2011 14:07:24 -0700
Message-ID: <1316725648-26710-7-git-send-email-khilman@ti.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:33050 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754024Ab1IVVHv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 17:07:51 -0400
In-Reply-To: <1316725648-26710-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Nishanth Menon <nm@ti.com>

if we do not have mpu_dev we normally fail in cpu_init. It is better
to fail driver registration if the devices are not available.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 07e835d..fe943b3 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -49,6 +49,7 @@ static struct lpj_info global_lpj_ref;
 static struct cpufreq_frequency_table *freq_table;
 static struct clk *mpu_clk;
 static char *mpu_clk_name;
+static struct device *mpu_dev;
 
 static int omap_verify_speed(struct cpufreq_policy *policy)
 {
@@ -151,7 +152,6 @@ static int omap_target(struct cpufreq_policy *policy,
 static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
-	struct device *mpu_dev;
 
 	mpu_clk = clk_get(NULL, mpu_clk_name);
 	if (IS_ERR(mpu_clk))
@@ -161,12 +161,6 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
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
@@ -238,6 +232,13 @@ static int __init omap_cpufreq_init(void)
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
1.7.6

