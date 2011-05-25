From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH V3 1/8] OMAP2+: cpufreq: move clk name decision to init
Date: Wed, 25 May 2011 16:38:46 -0700
Message-ID: <1306366733-8439-2-git-send-email-nm@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56295 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756741Ab1EYXjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:39:03 -0400
Received: by gwj16 with SMTP id 16so118920gwj.23
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:39:02 -0700 (PDT)
In-Reply-To: <1306366733-8439-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Clk name does'nt need to dynamically detected during clk init.
move them off to driver initialization, if we dont have a clk name,
there is no point in registering the driver anyways. The actual clk
get and put is left at cpu_init and exit functions.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index d53ce23..a57b322 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -42,6 +42,7 @@
 
 static struct cpufreq_frequency_table *freq_table;
 static struct clk *mpu_clk;
+static char *mpu_clk_name;
 
 static int omap_verify_speed(struct cpufreq_policy *policy)
 {
@@ -157,13 +158,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	struct device *mpu_dev;
 	static cpumask_var_t cpumask;
 
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
 
@@ -238,6 +233,17 @@ static struct cpufreq_driver omap_driver = {
 
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
1.7.1

