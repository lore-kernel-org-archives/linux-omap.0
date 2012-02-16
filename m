From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFT 1/1] OMAP2+: cpufreq: scale voltage along with frequency
Date: Thu, 16 Feb 2012 11:20:43 -0800
Message-ID: <1329420043-32656-2-git-send-email-khilman@ti.com>
References: <1329420043-32656-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:52141 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755219Ab2BPTUJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 14:20:09 -0500
Received: by mail-pz0-f51.google.com with SMTP id y9so2080864dad.10
        for <linux-omap@vger.kernel.org>; Thu, 16 Feb 2012 11:20:08 -0800 (PST)
In-Reply-To: <1329420043-32656-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>

Use the regulator framework to get the voltage regulator associated
with the MPU voltage domain and use it to scale voltage along with
frequency.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/voltage.c  |    2 ++
 drivers/cpufreq/omap-cpufreq.c |   29 ++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 8a36342..140c032 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -89,6 +89,8 @@ int voltdm_scale(struct voltagedomain *voltdm,
 	ret = voltdm->scale(voltdm, target_volt);
 	if (!ret)
 		voltdm->nominal_volt = target_volt;
+	printk("KJH: %s: %d\n", __func__, target_volt);
+	dump_stack();
 
 	return ret;
 }
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 5d04c57..e4f4841 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -25,6 +25,7 @@
 #include <linux/opp.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 
 #include <asm/system.h>
 #include <asm/smp_plat.h>
@@ -52,6 +53,7 @@ static atomic_t freq_table_users = ATOMIC_INIT(0);
 static struct clk *mpu_clk;
 static char *mpu_clk_name;
 static struct device *mpu_dev;
+static struct regulator *mpu_reg;
 
 static int omap_verify_speed(struct cpufreq_policy *policy)
 {
@@ -78,6 +80,8 @@ static int omap_target(struct cpufreq_policy *policy,
 	unsigned int i;
 	int ret = 0;
 	struct cpufreq_freqs freqs;
+	struct opp *opp;
+	unsigned long freq, volt;
 
 	if (!freq_table) {
 		dev_err(mpu_dev, "%s: cpu%d: no freq table!\n", __func__,
@@ -115,9 +119,26 @@ static int omap_target(struct cpufreq_policy *policy,
 	pr_info("cpufreq-omap: transition: %u --> %u\n", freqs.old, freqs.new);
 #endif
 
+	freq = freqs.new * 1000;
+	opp = opp_find_freq_ceil(mpu_dev, &freq);
+	if (IS_ERR(opp)) {
+		printk(KERN_ERR "%s: unable to find MPU OPP for %d\n",
+		       __func__, freqs.new);
+		return -EINVAL;
+	}
+	volt = opp_get_voltage(opp);
+
+	/* scaling up?  scale voltage before frequency */
+	if (mpu_reg && (freqs.new > freqs.old))
+		regulator_set_voltage(mpu_reg, volt, volt);
+
 	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
-	freqs.new = omap_getspeed(policy->cpu);
 
+	/* scaling down?  scale voltage after frequency */
+	if (mpu_reg && (freqs.new < freqs.old))
+		regulator_set_voltage(mpu_reg, volt, volt);
+
+	freqs.new = omap_getspeed(policy->cpu);
 #ifdef CONFIG_SMP
 	/*
 	 * Note that loops_per_jiffy is not updated on SMP systems in
@@ -260,6 +281,12 @@ static int __init omap_cpufreq_init(void)
 		return -EINVAL;
 	}
 
+	mpu_reg = regulator_get(mpu_dev, "vcc");
+	if (IS_ERR(mpu_reg)) {
+		pr_warning("%s: unable to get MPU regulator\n", __func__);
+		mpu_reg = NULL;
+	}
+
 	return cpufreq_register_driver(&omap_driver);
 }
 
-- 
1.7.9

