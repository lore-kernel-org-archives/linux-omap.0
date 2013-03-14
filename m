From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 8/8] cpufreq: omap: remove omap-cpufreq
Date: Thu, 14 Mar 2013 15:58:15 -0500
Message-ID: <1363294695-658-9-git-send-email-nm@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38029 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676Ab3CNU7O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Mar 2013 16:59:14 -0400
In-Reply-To: <1363294695-658-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

We can now use cpufreq-cpu0 driver using DT entries.
remove the redundant omap-cpufreq driver from the tree.
Remove MAINTAINERS file entry for the same as well.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 MAINTAINERS                    |    1 -
 drivers/cpufreq/Kconfig.arm    |    6 -
 drivers/cpufreq/Makefile       |    1 -
 drivers/cpufreq/omap-cpufreq.c |  291 --------------------------------=
--------
 4 files changed, 299 deletions(-)
 delete mode 100644 drivers/cpufreq/omap-cpufreq.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9561658..d9c11bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5654,7 +5654,6 @@ M:	Kevin Hilman <khilman@ti.com>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	arch/arm/*omap*/*pm*
-F:	drivers/cpufreq/omap-cpufreq.c
=20
 OMAP POWERDOMAIN/CLOCKDOMAIN SOC ADAPTATION LAYER SUPPORT
 M:	Rajendra Nayak <rnayak@ti.com>
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 030ddf6..1cb810a 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -2,12 +2,6 @@
 # ARM CPU Frequency scaling drivers
 #
=20
-config ARM_OMAP2PLUS_CPUFREQ
-	bool "TI OMAP2+"
-	depends on ARCH_OMAP2PLUS
-	default ARCH_OMAP2PLUS
-	select CPU_FREQ_TABLE
-
 config ARM_S3C2416_CPUFREQ
 	bool "S3C2416 CPU Frequency scaling support"
 	depends on CPU_S3C2416
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 863fd18..d52076c 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -53,7 +53,6 @@ obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+=3D exynos4210-=
cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+=3D exynos4x12-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+=3D exynos5250-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+=3D kirkwood-cpufreq.o
-obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+=3D omap-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+=3D spear-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+=3D highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+=3D imx6q-cpufreq.o
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpuf=
req.c
deleted file mode 100644
index 9128c07..0000000
--- a/drivers/cpufreq/omap-cpufreq.c
+++ /dev/null
@@ -1,291 +0,0 @@
-/*
- *  CPU frequency scaling for OMAP using OPP information
- *
- *  Copyright (C) 2005 Nokia Corporation
- *  Written by Tony Lindgren <tony@atomide.com>
- *
- *  Based on cpu-sa1110.c, Copyright (C) 2001 Russell King
- *
- * Copyright (C) 2007-2011 Texas Instruments, Inc.
- * - OMAP3/4 support by Rajendra Nayak, Santosh Shilimkar
- *
- * This program is free software; you can redistribute it and/or modif=
y
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/cpufreq.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/opp.h>
-#include <linux/cpu.h>
-#include <linux/module.h>
-#include <linux/regulator/consumer.h>
-
-#include <asm/smp_plat.h>
-#include <asm/cpu.h>
-
-/* OPP tolerance in percentage */
-#define	OPP_TOLERANCE	4
-
-static struct cpufreq_frequency_table *freq_table;
-static atomic_t freq_table_users =3D ATOMIC_INIT(0);
-static struct clk *mpu_clk;
-static struct device *mpu_dev;
-static struct regulator *mpu_reg;
-
-static int omap_verify_speed(struct cpufreq_policy *policy)
-{
-	if (!freq_table)
-		return -EINVAL;
-	return cpufreq_frequency_table_verify(policy, freq_table);
-}
-
-static unsigned int omap_getspeed(unsigned int cpu)
-{
-	unsigned long rate;
-
-	if (cpu >=3D NR_CPUS)
-		return 0;
-
-	rate =3D clk_get_rate(mpu_clk) / 1000;
-	return rate;
-}
-
-static int omap_target(struct cpufreq_policy *policy,
-		       unsigned int target_freq,
-		       unsigned int relation)
-{
-	unsigned int i;
-	int r, ret =3D 0;
-	struct cpufreq_freqs freqs;
-	struct opp *opp;
-	unsigned long freq, volt =3D 0, volt_old =3D 0, tol =3D 0;
-
-	if (!freq_table) {
-		dev_err(mpu_dev, "%s: cpu%d: no freq table!\n", __func__,
-				policy->cpu);
-		return -EINVAL;
-	}
-
-	ret =3D cpufreq_frequency_table_target(policy, freq_table, target_fre=
q,
-			relation, &i);
-	if (ret) {
-		dev_dbg(mpu_dev, "%s: cpu%d: no freq match for %d(ret=3D%d)\n",
-			__func__, policy->cpu, target_freq, ret);
-		return ret;
-	}
-	freqs.new =3D freq_table[i].frequency;
-	if (!freqs.new) {
-		dev_err(mpu_dev, "%s: cpu%d: no match for freq %d\n", __func__,
-			policy->cpu, target_freq);
-		return -EINVAL;
-	}
-
-	freqs.old =3D omap_getspeed(policy->cpu);
-	freqs.cpu =3D policy->cpu;
-
-	if (freqs.old =3D=3D freqs.new && policy->cur =3D=3D freqs.new)
-		return ret;
-
-	/* notifiers */
-	for_each_cpu(i, policy->cpus) {
-		freqs.cpu =3D i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	}
-
-	freq =3D freqs.new * 1000;
-	ret =3D clk_round_rate(mpu_clk, freq);
-	if (IS_ERR_VALUE(ret)) {
-		dev_warn(mpu_dev,
-			 "CPUfreq: Cannot find matching frequency for %lu\n",
-			 freq);
-		return ret;
-	}
-	freq =3D ret;
-
-	if (mpu_reg) {
-		rcu_read_lock();
-		opp =3D opp_find_freq_ceil(mpu_dev, &freq);
-		if (IS_ERR(opp)) {
-			rcu_read_unlock();
-			dev_err(mpu_dev, "%s: unable to find MPU OPP for %d\n",
-				__func__, freqs.new);
-			return -EINVAL;
-		}
-		volt =3D opp_get_voltage(opp);
-		rcu_read_unlock();
-		tol =3D volt * OPP_TOLERANCE / 100;
-		volt_old =3D regulator_get_voltage(mpu_reg);
-	}
-
-	dev_dbg(mpu_dev, "cpufreq-omap: %u MHz, %ld mV --> %u MHz, %ld mV\n",=
=20
-		freqs.old / 1000, volt_old ? volt_old / 1000 : -1,
-		freqs.new / 1000, volt ? volt / 1000 : -1);
-
-	/* scaling up?  scale voltage before frequency */
-	if (mpu_reg && (freqs.new > freqs.old)) {
-		r =3D regulator_set_voltage(mpu_reg, volt - tol, volt + tol);
-		if (r < 0) {
-			dev_warn(mpu_dev, "%s: unable to scale voltage up.\n",
-				 __func__);
-			freqs.new =3D freqs.old;
-			goto done;
-		}
-	}
-
-	ret =3D clk_set_rate(mpu_clk, freqs.new * 1000);
-
-	/* scaling down?  scale voltage after frequency */
-	if (mpu_reg && (freqs.new < freqs.old)) {
-		r =3D regulator_set_voltage(mpu_reg, volt - tol, volt + tol);
-		if (r < 0) {
-			dev_warn(mpu_dev, "%s: unable to scale voltage down.\n",
-				 __func__);
-			ret =3D clk_set_rate(mpu_clk, freqs.old * 1000);
-			freqs.new =3D freqs.old;
-			goto done;
-		}
-	}
-
-	freqs.new =3D omap_getspeed(policy->cpu);
-
-done:
-	/* notifiers */
-	for_each_cpu(i, policy->cpus) {
-		freqs.cpu =3D i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	}
-
-	return ret;
-}
-
-static inline void freq_table_free(void)
-{
-	if (atomic_dec_and_test(&freq_table_users))
-		opp_free_cpufreq_table(mpu_dev, &freq_table);
-}
-
-static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
-{
-	int result =3D 0;
-
-	mpu_clk =3D clk_get(NULL, "cpufreq_ck");
-	if (IS_ERR(mpu_clk))
-		return PTR_ERR(mpu_clk);
-
-	if (policy->cpu >=3D NR_CPUS) {
-		result =3D -EINVAL;
-		goto fail_ck;
-	}
-
-	policy->cur =3D policy->min =3D policy->max =3D omap_getspeed(policy-=
>cpu);
-
-	if (!freq_table)
-		result =3D opp_init_cpufreq_table(mpu_dev, &freq_table);
-
-	if (result) {
-		dev_err(mpu_dev, "%s: cpu%d: failed creating freq table[%d]\n",
-				__func__, policy->cpu, result);
-		goto fail_ck;
-	}
-
-	atomic_inc_return(&freq_table_users);
-
-	result =3D cpufreq_frequency_table_cpuinfo(policy, freq_table);
-	if (result)
-		goto fail_table;
-
-	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
-
-	policy->min =3D policy->cpuinfo.min_freq;
-	policy->max =3D policy->cpuinfo.max_freq;
-	policy->cur =3D omap_getspeed(policy->cpu);
-
-	/*
-	 * On OMAP SMP configuartion, both processors share the voltage
-	 * and clock. So both CPUs needs to be scaled together and hence
-	 * needs software co-ordination. Use cpufreq affected_cpus
-	 * interface to handle this scenario. Additional is_smp() check
-	 * is to keep SMP_ON_UP build working.
-	 */
-	if (is_smp())
-		cpumask_setall(policy->cpus);
-
-	/* FIXME: what's the actual transition time? */
-	policy->cpuinfo.transition_latency =3D 300 * 1000;
-
-	return 0;
-
-fail_table:
-	freq_table_free();
-fail_ck:
-	clk_put(mpu_clk);
-	return result;
-}
-
-static int omap_cpu_exit(struct cpufreq_policy *policy)
-{
-	freq_table_free();
-	clk_put(mpu_clk);
-	return 0;
-}
-
-static struct freq_attr *omap_cpufreq_attr[] =3D {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
-static struct cpufreq_driver omap_driver =3D {
-	.flags		=3D CPUFREQ_STICKY,
-	.verify		=3D omap_verify_speed,
-	.target		=3D omap_target,
-	.get		=3D omap_getspeed,
-	.init		=3D omap_cpu_init,
-	.exit		=3D omap_cpu_exit,
-	.name		=3D "omap",
-	.attr		=3D omap_cpufreq_attr,
-};
-
-static int __init omap_cpufreq_init(void)
-{
-	mpu_dev =3D get_cpu_device(0);
-	if (!mpu_dev) {
-		pr_warning("%s: unable to get the mpu device\n", __func__);
-		return -EINVAL;
-	}
-
-	mpu_reg =3D regulator_get(mpu_dev, "vcc");
-	if (IS_ERR(mpu_reg)) {
-		pr_warning("%s: unable to get MPU regulator\n", __func__);
-		mpu_reg =3D NULL;
-	} else {
-		/*=20
-		 * Ensure physical regulator is present.
-		 * (e.g. could be dummy regulator.)
-		 */
-		if (regulator_get_voltage(mpu_reg) < 0) {
-			pr_warn("%s: physical regulator not present for MPU\n",
-				__func__);
-			regulator_put(mpu_reg);
-			mpu_reg =3D NULL;
-		}
-	}
-
-	return cpufreq_register_driver(&omap_driver);
-}
-
-static void __exit omap_cpufreq_exit(void)
-{
-	cpufreq_unregister_driver(&omap_driver);
-}
-
-MODULE_DESCRIPTION("cpufreq driver for OMAP SoCs");
-MODULE_LICENSE("GPL");
-module_init(omap_cpufreq_init);
-module_exit(omap_cpufreq_exit);
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
