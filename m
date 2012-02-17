From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH/RFT 1/1] OMAP2+: cpufreq: scale voltage along with
 frequency
Date: Fri, 17 Feb 2012 07:35:55 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A931782571@DBDE01.ent.ti.com>
References: <1329420043-32656-1-git-send-email-khilman@ti.com>
 <1329420043-32656-2-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52554 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab2BQHgD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Feb 2012 02:36:03 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1H7Zxii008574
	for <linux-omap@vger.kernel.org>; Fri, 17 Feb 2012 01:36:00 -0600
In-Reply-To: <1329420043-32656-2-git-send-email-khilman@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kristo, Tero" <t-kristo@ti.com>

Hi Kevin,

On Fri, Feb 17, 2012 at 00:50:43, Hilman, Kevin wrote:
> +	/* scaling up?  scale voltage before frequency */
> +	if (mpu_reg && (freqs.new > freqs.old))
> +		regulator_set_voltage(mpu_reg, volt, volt);

Probably voltage ranges has to be specified, otherwise
if I understand correctly,  if exact voltage 'volt'
is a value that cannot be set by voltage regulator,
it may not work properly.

>  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
> -	freqs.new = omap_getspeed(policy->cpu);
>  
> +	/* scaling down?  scale voltage after frequency */
> +	if (mpu_reg && (freqs.new < freqs.old))
> +		regulator_set_voltage(mpu_reg, volt, volt);
> +
> +	freqs.new = omap_getspeed(policy->cpu);

It would be better to handle error cases too,
we have a patch for doing DVFS for AM335X as follows

Regards
Afzal


8<------------------------------------------------------

---
 drivers/cpufreq/omap-cpufreq.c |   97 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 5d04c57..a897a9e 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -25,6 +25,7 @@
 #include <linux/opp.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>

 #include <asm/system.h>
 #include <asm/smp_plat.h>
@@ -37,6 +38,8 @@

 #include <mach/hardware.h>

+#define DEFAULT_RESOLUTION 12500
+
 #ifdef CONFIG_SMP
 struct lpj_info {
        unsigned long   ref;
@@ -52,6 +55,7 @@ static atomic_t freq_table_users = ATOMIC_INIT(0);
 static struct clk *mpu_clk;
 static char *mpu_clk_name;
 static struct device *mpu_dev;
+static struct regulator *mpu_reg;

 static int omap_verify_speed(struct cpufreq_policy *policy)
 {
@@ -78,6 +82,8 @@ static int omap_target(struct cpufreq_policy *policy,
        unsigned int i;
        int ret = 0;
        struct cpufreq_freqs freqs;
+       struct opp *opp;
+       int volt_old = 0, volt_new = 0;

        if (!freq_table) {
                dev_err(mpu_dev, "%s: cpu%d: no freq table!\n", __func__,
@@ -105,16 +111,45 @@ static int omap_target(struct cpufreq_policy *policy,
        if (freqs.old == freqs.new && policy->cur == freqs.new)
                return ret;

+       opp = opp_find_freq_exact(mpu_dev, freqs.new * 1000, true);
+       if (IS_ERR(opp)) {
+               dev_err(mpu_dev, "%s: cpu%d: no opp match for freq %d\n",
+                       __func__, policy->cpu, target_freq);
+               return -EINVAL;
+       }
+
+       volt_new = opp_get_voltage(opp);
+       if (!volt_new) {
+               dev_err(mpu_dev, "%s: cpu%d: no opp voltage for freq %d\n",
+                       __func__, policy->cpu, target_freq);
+               return -EINVAL;
+       }
+
+       volt_old = regulator_get_voltage(mpu_reg);
+
+#ifdef CONFIG_CPU_FREQ_DEBUG
+       pr_info("cpufreq-omap: frequency transition: %u --> %u\n",
+                       freqs.old, freqs.new);
+       pr_info("cpufreq-omap: voltage transition: %d --> %d\n",
+                       volt_old, volt_new);
+#endif
+
+       if (freqs.new > freqs.old) {
+               ret = regulator_set_voltage(mpu_reg, volt_new,
+                       volt_new + DEFAULT_RESOLUTION - 1);
+               if (ret) {
+                       dev_err(mpu_dev, "%s: unable to set voltage to %d uV (for %u MHz)\n",
+                               __func__, volt_new, freqs.new/1000);
+                       return ret;
+               }
+       }
+
        /* notifiers */
        for_each_cpu(i, policy->cpus) {
                freqs.cpu = i;
                cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
        }

-#ifdef CONFIG_CPU_FREQ_DEBUG
-       pr_info("cpufreq-omap: transition: %u --> %u\n", freqs.old, freqs.new);
-#endif
-
        ret = clk_set_rate(mpu_clk, freqs.new * 1000);
        freqs.new = omap_getspeed(policy->cpu);

@@ -150,6 +185,38 @@ static int omap_target(struct cpufreq_policy *policy,
                cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
        }

+       if (freqs.new < freqs.old) {
+               ret = regulator_set_voltage(mpu_reg, volt_new,
+                       volt_new + DEFAULT_RESOLUTION - 1);
+               if (ret) {
+                       unsigned int temp;
+
+                       dev_err(mpu_dev, "%s: unable to set voltage to %d uV (for %u MHz)\n",
+                               __func__, volt_new, freqs.new/1000);
+
+                       if (clk_set_rate(mpu_clk, freqs.old * 1000)) {
+                               dev_err(mpu_dev,
+                                       "%s: failed restoring clock rate to %u MHz, clock rate is %u MHz",
+                                       __func__,
+                                       freqs.old/1000, freqs.new/1000);
+                               return ret;
+                       }
+
+                       temp = freqs.new;
+                       freqs.new = freqs.old;
+                       freqs.old = temp;
+
+                       for_each_cpu(i, policy->cpus) {
+                               freqs.cpu = i;
+                               cpufreq_notify_transition(&freqs,
+                                       CPUFREQ_PRECHANGE);
+                               cpufreq_notify_transition(&freqs,
+                                       CPUFREQ_POSTCHANGE);
+                       }
+                       return ret;
+               }
+       }
+
        return ret;
 }

@@ -167,11 +234,27 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
        if (IS_ERR(mpu_clk))
                return PTR_ERR(mpu_clk);

-       if (policy->cpu >= NR_CPUS) {
+       mpu_reg = regulator_get(NULL, "vdd_mpu");
+       if (IS_ERR(mpu_reg)) {
                result = -EINVAL;
                goto fail_ck;
        }

+       /* success of regulator_get doesn't gurantee presence of driver for
+          physical regulator and presence of physical regulator (this
+          situation arises if dummy regulator is enabled),so check voltage
+          to verify that physical regulator and it's driver is present
+        */
+       if (regulator_get_voltage(mpu_reg) < 0) {
+               result = -EINVAL;
+               goto fail_reg;
+       }
+
+       if (policy->cpu >= NR_CPUS) {
+               result = -EINVAL;
+               goto fail_reg;
+       }
+
        policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);

        if (atomic_inc_return(&freq_table_users) == 1)
@@ -180,7 +263,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
        if (result) {
                dev_err(mpu_dev, "%s: cpu%d: failed creating freq table[%d]\n",
                                __func__, policy->cpu, result);
-               goto fail_ck;
+               goto fail_reg;
        }

        result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
@@ -212,6 +295,8 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)

 fail_table:
        freq_table_free();
+fail_reg:
+       regulator_put(mpu_reg);
 fail_ck:
        clk_put(mpu_clk);
        return result;
--
1.7.1

