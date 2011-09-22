From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 05/10] cpufreq: OMAP: move clk name decision to init
Date: Thu, 22 Sep 2011 14:07:23 -0700
Message-ID: <1316725648-26710-6-git-send-email-khilman@ti.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:54477 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753919Ab1IVVHr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 17:07:47 -0400
In-Reply-To: <1316725648-26710-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Nishanth Menon <nm@ti.com>

Clk name does'nt need to dynamically detected during clk init.
move them off to driver initialization, if we dont have a clk name,
there is no point in registering the driver anyways. The actual clk
get and put is left at cpu_init and exit functions.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 724d36c..07e835d 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -48,6 +48,7 @@ static struct lpj_info global_lpj_ref;
 
 static struct cpufreq_frequency_table *freq_table;
 static struct clk *mpu_clk;
+static char *mpu_clk_name;
 
 static int omap_verify_speed(struct cpufreq_policy *policy)
 {
@@ -152,13 +153,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	int result = 0;
 	struct device *mpu_dev;
 
-	if (cpu_is_omap24xx())
-		mpu_clk = clk_get(NULL, "virt_prcm_set");
-	else if (cpu_is_omap34xx())
-		mpu_clk = clk_get(NULL, "dpll1_ck");
-	else if (cpu_is_omap44xx())
-		mpu_clk = clk_get(NULL, "dpll_mpu_ck");
-
+	mpu_clk = clk_get(NULL, mpu_clk_name);
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
 
@@ -232,6 +227,17 @@ static struct cpufreq_driver omap_driver = {
 
 static int __init omap_cpufreq_init(void)
 {
+	if (cpu_is_omap24xx())
+		mpu_clk_name = "virt_prcm_set";
+	else if (cpu_is_omap34xx())
+		mpu_clk_name = "dpll1_ck";
+	else if (cpu_is_omap44xx())
+		mpu_clk_name = "dpll_mpu_ck";
+
+	if (!mpu_clk_name) {
+		pr_err("%s: unsupported Silicon?\n", __func__);
+		return -EINVAL;
+	}
 	return cpufreq_register_driver(&omap_driver);
 }
 
-- 
1.7.6

