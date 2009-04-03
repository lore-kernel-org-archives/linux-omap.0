From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 01/02] OMAP3 clock: Remove virt_vdd1/2_prcm_set
Date: Fri, 3 Apr 2009 21:50:16 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB102C28@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57348 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935622AbZDCQU2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 12:20:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n33GKJ6X025301
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 11:20:25 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n33GKI3U016490
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 21:50:19 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Rajendra Nayak <rnayak@ti.com>

This patch removes the virtual node implementation from clock f/w.
The resource framework which would use these nodes for DVFS
is been updated with most functionality internally, which was earlier
handled by virtual clock nodes.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.c    |  189 --------------------------------
 arch/arm/mach-omap2/clock34xx.h    |   26 ----
 arch/arm/mach-omap2/resource34xx.c |  214 +++++++++++++++++++++++++------------
 arch/arm/mach-omap2/resource34xx.h |    4
 4 files changed, 145 insertions(+), 288 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/clock34xx.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/clock34xx.c
+++ linux-omap-pm/arch/arm/mach-omap2/clock34xx.c
@@ -48,32 +48,6 @@

 #define MAX_DPLL_WAIT_TRIES            1000000

-struct omap_opp *curr_vdd1_prcm_set;
-struct omap_opp *curr_vdd2_prcm_set;
-static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
-
-#ifndef CONFIG_CPU_FREQ
-static unsigned long compute_lpj(unsigned long ref, u_int div, u_int mult)
-{
-       unsigned long new_jiffy_l, new_jiffy_h;
-
-       /*
-        * Recalculate loops_per_jiffy.  We do it this way to
-        * avoid math overflow on 32-bit machines.  Maybe we
-        * should make this architecture dependent?  If you have
-        * a better way of doing this, please replace!
-        *
-        *    new = old * mult / div
-        */
-       new_jiffy_h = ref / div;
-       new_jiffy_l = (ref % div) / 100;
-       new_jiffy_h *= mult;
-       new_jiffy_l = new_jiffy_l * mult / div;
-
-       return new_jiffy_h + new_jiffy_l * 100;
-}
-#endif
-
 #define MIN_SDRC_DLL_LOCK_FREQ         83000000

 #define CYCLES_PER_MHZ                 1000000
@@ -786,9 +760,6 @@ int __init omap2_clk_init(void)
        struct clk **clkp;
        /* u32 clkrate; */
        u32 cpu_clkflg;
-       unsigned long mpu_speed, core_speed;
-       struct omap_opp *prcm_vdd;
-

        /* REVISIT: Ultimately this will be used for multiboot */
 #if 0
@@ -846,32 +817,6 @@ int __init omap2_clk_init(void)

        recalculate_root_clocks();

-       dpll1_clk = clk_get(NULL, "dpll1_ck");
-       dpll2_clk = clk_get(NULL, "dpll2_ck");
-       dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
-
-       mpu_speed = dpll1_clk->rate;
-       if (mpu_opps) {
-               prcm_vdd = mpu_opps + MAX_VDD1_OPP;
-               for (; prcm_vdd->rate; prcm_vdd--) {
-                       if (prcm_vdd->rate <= mpu_speed) {
-                               curr_vdd1_prcm_set = prcm_vdd;
-                               break;
-                       }
-               }
-       }
-
-       core_speed = dpll3_clk->rate;
-       if (l3_opps) {
-               prcm_vdd = l3_opps + MAX_VDD2_OPP;
-               for (; prcm_vdd->rate; prcm_vdd--) {
-                       if (prcm_vdd->rate <= core_speed) {
-                               curr_vdd2_prcm_set = prcm_vdd;
-                               break;
-                       }
-               }
-       }
-
        printk(KERN_INFO "Clocking rate (Crystal/DPLL/ARM core): "
               "%ld.%01ld/%ld/%ld MHz\n",
               (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
@@ -885,138 +830,4 @@ int __init omap2_clk_init(void)

        return 0;
 }
-
-unsigned long get_freq(struct omap_opp *opp_freq_table,
-                     unsigned short opp)
-{
-       struct omap_opp *prcm_config;
-       prcm_config = opp_freq_table;
-
-       for (; prcm_config->opp_id; prcm_config--)
-               if (prcm_config->opp_id == opp)
-                       return prcm_config->rate;
-       return 0;
-}
-
-unsigned short get_opp(struct omap_opp *opp_freq_table,
-                    unsigned long freq)
-{
-       struct omap_opp *prcm_config;
-       prcm_config = opp_freq_table;
-
-       if (prcm_config->rate <= freq)
-               return prcm_config->opp_id; /* Return the Highest OPP */
-       for (; prcm_config->rate; prcm_config--)
-               if (prcm_config->rate < freq)
-                       return (prcm_config+1)->opp_id;
-               else if (prcm_config->rate == freq)
-                       return prcm_config->opp_id;
-       /* Return the least OPP */
-       return (prcm_config+1)->opp_id;
-}
-
-static void omap3_table_recalc(struct clk *clk)
-{
-       if ((clk != &virt_vdd1_prcm_set) && (clk != &virt_vdd2_prcm_set))
-               return;
-
-       if ((curr_vdd1_prcm_set) && (clk == &virt_vdd1_prcm_set))
-               clk->rate = curr_vdd1_prcm_set->rate;
-       else if ((curr_vdd2_prcm_set) && (clk == &virt_vdd2_prcm_set))
-               clk->rate = curr_vdd2_prcm_set->rate;
-       pr_debug("CLK RATE:%lu\n", clk->rate);
-}
-
-static long omap3_round_to_table_rate(struct clk *clk, unsigned long rate)
-{
-       struct omap_opp *ptr;
-       long highest_rate;
-
-       if ((clk != &virt_vdd1_prcm_set) && (clk != &virt_vdd2_prcm_set))
-               return -EINVAL;
-
-       if (!mpu_opps || !dsp_opps || !l3_opps)
-               return -EINVAL;
-
-       highest_rate = -EINVAL;
-
-       if (clk == &virt_vdd1_prcm_set)
-               ptr = mpu_opps + MAX_VDD1_OPP;
-       else
-               ptr = dsp_opps + MAX_VDD2_OPP;
-
-       for (; ptr->rate; ptr--) {
-               highest_rate = ptr->rate;
-               pr_debug("Highest speed : %lu, rate: %lu\n", highest_rate,
-                                                               rate);
-               if (ptr->rate <= rate)
-                       break;
-       }
-       return highest_rate;
-}
-
-static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
-{
-       struct omap_opp *prcm_vdd = NULL;
-       unsigned long found_speed = 0, curr_mpu_speed;
-       int index = 0;
-       int l3_div;
-       int ret;
-
-       if ((clk != &virt_vdd1_prcm_set) && (clk != &virt_vdd2_prcm_set))
-               return -EINVAL;
-
-       if (!mpu_opps || !dsp_opps || !l3_opps)
-               return -EINVAL;
-
-       if (clk == &virt_vdd1_prcm_set) {
-               prcm_vdd = mpu_opps + MAX_VDD1_OPP;
-               index = MAX_VDD1_OPP;
-       } else if (clk == &virt_vdd2_prcm_set) {
-               prcm_vdd = l3_opps + MAX_VDD2_OPP;
-               index = MAX_VDD2_OPP;
-       }
-
-       for (; prcm_vdd && prcm_vdd->rate; prcm_vdd--, index--) {
-               if (prcm_vdd->rate <= rate) {
-                       found_speed = prcm_vdd->rate;
-                       pr_debug("Found speed = %lu\n", found_speed);
-                       break;
-               }
-       }
-
-       if (!found_speed) {
-               printk(KERN_INFO "Could not set table rate to %luMHz\n",
-                      rate / 1000000);
-               return -EINVAL;
-       }
-
-
-       if (clk == &virt_vdd1_prcm_set) {
-               curr_mpu_speed = curr_vdd1_prcm_set->rate;
-               clk->rate = prcm_vdd->rate;
-               clk_set_rate(dpll1_clk, prcm_vdd->rate);
-               clk_set_rate(dpll2_clk, dsp_opps[index].rate);
-               curr_vdd1_prcm_set = prcm_vdd;
-#ifndef CONFIG_CPU_FREQ
-               /*Update loops_per_jiffy if processor speed is being changed*/
-               loops_per_jiffy = compute_lpj(loops_per_jiffy,
-                                       curr_mpu_speed/1000, found_speed/1000);
-#endif
-       } else {
-               l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
-                       OMAP3430_CLKSEL_L3_MASK;
-               ret = clk_set_rate(dpll3_clk, prcm_vdd->rate * l3_div);
-               if (ret)
-                       return ret;
-               curr_vdd2_prcm_set = prcm_vdd;
-       }
-
-#ifdef CONFIG_PM
-       omap3_save_scratchpad_contents();
-#endif
-
-       return 0;
-}
-
 #endif /* CONFIG_ARCH_OMAP3 */
Index: linux-omap-pm/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/clock34xx.h
+++ linux-omap-pm/arch/arm/mach-omap2/clock34xx.h
@@ -39,9 +39,6 @@ static int omap3_noncore_dpll_enable(str
 static void omap3_noncore_dpll_disable(struct clk *clk);
 static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
 static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
-static void omap3_table_recalc(struct clk *clk);
-static long omap3_round_to_table_rate(struct clk *clk, unsigned long rate);
-static int omap3_select_table_rate(struct clk *clk, unsigned long rate);

 /* Maximum DPLL multiplier, divider values for OMAP3 */
 #define OMAP3_MAX_DPLL_MULT            2048
@@ -3345,26 +3342,6 @@ static struct clk wdt1_fck = {
        .recalc         = &followparent_recalc,
 };

-static struct clk virt_vdd1_prcm_set = {
-       .name = "virt_vdd1_prcm_set",
-       .flags = CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
-       .parent = &mpu_ck, /* Indexed by mpu speed, no parent */
-       .clkdm = { .name = "virt_opp_clkdm" },
-       .recalc = &omap3_table_recalc, /*sets are keyed on mpu rate */
-       .set_rate = &omap3_select_table_rate,
-       .round_rate = &omap3_round_to_table_rate,
-};
-
-static struct clk virt_vdd2_prcm_set = {
-       .name = "virt_vdd2_prcm_set",
-       .flags = CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
-       .parent = &core_ck,
-       .clkdm = { .name = "virt_opp_clkdm" },
-       .recalc = &omap3_table_recalc,
-       .set_rate = &omap3_select_table_rate,
-       .round_rate = &omap3_round_to_table_rate,
-};
-
 static struct clk *onchip_34xx_clks[] __initdata = {
        &omap_32k_fck,
        &virt_12m_ck,
@@ -3588,9 +3565,6 @@ static struct clk *onchip_34xx_clks[] __
        &secure_32k_fck,
        &gpt12_fck,
        &wdt1_fck,
-       /* virtual group clock */
-       &virt_vdd1_prcm_set,
-       &virt_vdd2_prcm_set,
 };

 #endif
Index: linux-omap-pm/arch/arm/mach-omap2/resource34xx.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/resource34xx.c
+++ linux-omap-pm/arch/arm/mach-omap2/resource34xx.c
@@ -18,12 +18,16 @@

 #include <linux/pm_qos_params.h>
 #include <linux/cpufreq.h>
+#include <linux/delay.h>
 #include <mach/powerdomain.h>
 #include <mach/clockdomain.h>
+#include <mach/control.h>
 #include <mach/omap34xx.h>
 #include "smartreflex.h"
 #include "resource34xx.h"
 #include "pm.h"
+#include "cm.h"
+#include "cm-regbits-34xx.h"

 /**
  * init_latency - Initializes the mpu/core latency resource.
@@ -134,14 +138,34 @@ int set_pd_latency(struct shared_resourc
        return 0;
 }

-static struct clk *vdd1_clk;
-static struct clk *vdd2_clk;
 static struct shared_resource *vdd1_resp;
 static struct shared_resource *vdd2_resp;
 static struct device dummy_mpu_dev;
 static struct device dummy_dsp_dev;
+static struct device vdd2_dev;
 static int vdd1_lock;
 static int vdd2_lock;
+static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
+static int curr_vdd1_opp;
+static int curr_vdd2_opp;
+static DEFINE_MUTEX(dvfs_mutex);
+
+static unsigned short get_opp(struct omap_opp *opp_freq_table,
+               unsigned long freq)
+{
+       struct omap_opp *prcm_config;
+       prcm_config = opp_freq_table;
+
+       if (prcm_config->rate <= freq)
+               return prcm_config->opp_id; /* Return the Highest OPP */
+       for (; prcm_config->rate; prcm_config--)
+               if (prcm_config->rate < freq)
+                       return (prcm_config+1)->opp_id;
+               else if (prcm_config->rate == freq)
+                       return prcm_config->opp_id;
+       /* Return the least OPP */
+       return (prcm_config+1)->opp_id;
+}

 /**
  * init_opp - Initialize the OPP resource
@@ -157,19 +181,22 @@ void init_opp(struct shared_resource *re
        * to the  opp set by u-boot.
        */
        if (strcmp(resp->name, "vdd1_opp") == 0) {
-               resp->curr_level = curr_vdd1_prcm_set->opp_id;
-               vdd1_clk = clk_get(NULL, "virt_vdd1_prcm_set");
                vdd1_resp = resp;
+               dpll1_clk = clk_get(NULL, "dpll1_ck");
+               dpll2_clk = clk_get(NULL, "dpll2_ck");
+               resp->curr_level = get_opp(mpu_opps + MAX_VDD1_OPP,
+                               dpll1_clk->rate);
+               curr_vdd1_opp = resp->curr_level;
        } else if (strcmp(resp->name, "vdd2_opp") == 0) {
-               resp->curr_level = curr_vdd2_prcm_set->opp_id;
-               vdd2_clk = clk_get(NULL, "virt_vdd2_prcm_set");
                vdd2_resp = resp;
+               dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
+               resp->curr_level = get_opp(l3_opps + MAX_VDD2_OPP,
+                               dpll2_clk->rate);
+               curr_vdd2_opp = resp->curr_level;
        }
        return;
 }

-static struct device vdd2_dev;
-
 int resource_access_opp_lock(int res, int delta)
 {
        if (res == VDD1_OPP) {
@@ -182,14 +209,94 @@ int resource_access_opp_lock(int res, in
        return -EINVAL;
 }

+#ifndef CONFIG_CPU_FREQ
+static unsigned long compute_lpj(unsigned long ref, u_int div, u_int mult)
+{
+       unsigned long new_jiffy_l, new_jiffy_h;
+
+       /*
+        * Recalculate loops_per_jiffy.  We do it this way to
+        * avoid math overflow on 32-bit machines.  Maybe we
+        * should make this architecture dependent?  If you have
+        * a better way of doing this, please replace!
+        *
+        *    new = old * mult / div
+        */
+       new_jiffy_h = ref / div;
+       new_jiffy_l = (ref % div) / 100;
+       new_jiffy_h *= mult;
+       new_jiffy_l = new_jiffy_l * mult / div;
+
+       return new_jiffy_h + new_jiffy_l * 100;
+}
+#endif
+
+static int program_opp_freq(int res, int target_level, int current_level)
+{
+       int ret = 0, l3_div;
+       int *curr_opp;
+
+       if (res == VDD1_OPP) {
+               curr_opp = &curr_vdd1_opp;
+               clk_set_rate(dpll1_clk, mpu_opps[target_level].rate);
+               clk_set_rate(dpll2_clk, dsp_opps[target_level].rate);
+#ifndef CONFIG_CPU_FREQ
+               /*Update loops_per_jiffy if processor speed is being changed*/
+               loops_per_jiffy = compute_lpj(loops_per_jiffy,
+                       mpu_opps[current_level].rate/1000,
+                       mpu_opps[target_level].rate/1000);
+#endif
+       } else {
+               curr_opp = &curr_vdd2_opp;
+               l3_div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+                       OMAP3430_CLKSEL_L3_MASK;
+               ret = clk_set_rate(dpll3_clk,
+                               l3_opps[target_level].rate * l3_div);
+       }
+       if (ret)
+               return current_level;
+#ifdef CONFIG_PM
+       omap3_save_scratchpad_contents();
+#endif
+       *curr_opp = target_level;
+       return target_level;
+}
+
+static int program_opp(int res, struct omap_opp *opp, int target_level,
+               int current_level)
+{
+       int i, ret = 0, raise;
+#ifdef CONFIG_OMAP_SMARTREFLEX
+       unsigned long t_opp;
+
+       t_opp = ID_VDD(res) | ID_OPP_NO(opp[target_level].opp_id);
+#endif
+       if (target_level > current_level)
+               raise = 1;
+       else
+               raise = 0;
+
+       for (i = 0; i < 2; i++) {
+               if (i == raise)
+                       ret = program_opp_freq(res, target_level,
+                                       current_level);
+#ifdef CONFIG_OMAP_SMARTREFLEX
+               else
+                       sr_voltagescale_vcbypass(t_opp,
+                                       opp[target_level].vsel);
+#endif
+       }
+
+       return ret;
+}
+
 int resource_set_opp_level(int res, u32 target_level, int flags)
 {
-       unsigned long mpu_freq, mpu_old_freq, l3_freq, t_opp;
+       unsigned long mpu_freq, mpu_old_freq;
 #ifdef CONFIG_CPU_FREQ
        struct cpufreq_freqs freqs_notify;
 #endif
        struct shared_resource *resp;
-       int ret;

        if (res == VDD1_OPP)
                resp = vdd1_resp;
@@ -204,13 +311,16 @@ int resource_set_opp_level(int res, u32
        if (!mpu_opps || !dsp_opps || !l3_opps)
                return 0;

+       mutex_lock(&dvfs_mutex);
+
        if (res == VDD1_OPP) {
-               if (flags != OPP_IGNORE_LOCK && vdd1_lock)
+               if (flags != OPP_IGNORE_LOCK && vdd1_lock) {
+                       mutex_unlock(&dvfs_mutex);
                        return 0;
-               mpu_old_freq = get_freq(mpu_opps + MAX_VDD1_OPP,
-                                       curr_vdd1_prcm_set->opp_id);
-               mpu_freq = get_freq(mpu_opps + MAX_VDD1_OPP,
-                                       target_level);
+               }
+               mpu_old_freq = mpu_opps[resp->curr_level].rate;
+               mpu_freq = mpu_opps[target_level].rate;
+
 #ifdef CONFIG_CPU_FREQ
                freqs_notify.old = mpu_old_freq/1000;
                freqs_notify.new = mpu_freq/1000;
@@ -218,65 +328,22 @@ int resource_set_opp_level(int res, u32
                /* Send pre notification to CPUFreq */
                cpufreq_notify_transition(&freqs_notify, CPUFREQ_PRECHANGE);
 #endif
-               t_opp = ID_VDD(VDD1_OPP) |
-                       ID_OPP_NO(mpu_opps[target_level].opp_id);
-               if (resp->curr_level > target_level) {
-                       /* Scale Frequency and then voltage */
-                       clk_set_rate(vdd1_clk, mpu_freq);
-#ifdef CONFIG_OMAP_SMARTREFLEX
-                       sr_voltagescale_vcbypass(t_opp,
-                                       mpu_opps[target_level].vsel);
-#endif
-               } else {
-#ifdef CONFIG_OMAP_SMARTREFLEX
-                       /* Scale Voltage and then frequency */
-                       sr_voltagescale_vcbypass(t_opp,
-                                       mpu_opps[target_level].vsel);
-#endif
-                       clk_set_rate(vdd1_clk, mpu_freq);
-               }
-               resp->curr_level = curr_vdd1_prcm_set->opp_id;
+               resp->curr_level = program_opp(res, mpu_opps, target_level,
+                       resp->curr_level);
 #ifdef CONFIG_CPU_FREQ
                /* Send a post notification to CPUFreq */
                cpufreq_notify_transition(&freqs_notify, CPUFREQ_POSTCHANGE);
 #endif
        } else {
-               if (flags != OPP_IGNORE_LOCK && vdd2_lock)
+               if (!(flags & OPP_IGNORE_LOCK) && vdd2_lock) {
+                       mutex_unlock(&dvfs_mutex);
                        return 0;
-               l3_freq = get_freq(l3_opps + MAX_VDD2_OPP,
-                                       target_level);
-               t_opp = ID_VDD(VDD2_OPP) |
-                       ID_OPP_NO(l3_opps[target_level].opp_id);
-               if (resp->curr_level > target_level) {
-                       /* Scale Frequency and then voltage */
-                       ret = clk_set_rate(vdd2_clk, l3_freq);
-                       if (ret)
-                               return ret;
-#ifdef CONFIG_OMAP_SMARTREFLEX
-                       sr_voltagescale_vcbypass(t_opp,
-                                       l3_opps[target_level].vsel);
-#endif
-               } else {
-#ifdef CONFIG_OMAP_SMARTREFLEX
-                       /* Scale Voltage and then frequency */
-                       sr_voltagescale_vcbypass(t_opp,
-                                       l3_opps[target_level].vsel);
-#endif
-                       ret = clk_set_rate(vdd2_clk, l3_freq);
-                       if (ret) {
-#ifdef CONFIG_OMAP_SMARTREFLEX
-                               /* Setting clock failed, revert voltage */
-                               t_opp = ID_VDD(VDD2_OPP) |
-                                       ID_OPP_NO(l3_opps[resp->curr_level].
-                                                       opp_id);
-                               sr_voltagescale_vcbypass(t_opp,
-                                       l3_opps[resp->curr_level].vsel);
-#endif
-                               return ret;
-                       }
                }
-               resp->curr_level = curr_vdd2_prcm_set->opp_id;
+
+               resp->curr_level = program_opp(res, l3_opps, target_level,
+                       resp->curr_level);
        }
+       mutex_unlock(&dvfs_mutex);
        return 0;
 }

@@ -288,6 +355,16 @@ int set_opp(struct shared_resource *resp

        if (resp == vdd1_resp) {
                resource_set_opp_level(VDD1_OPP, target_level, 0);
+               /*
+               * For VDD1 OPP3 and above, make sure the interconnect
+               * is at 100Mhz or above.
+               * throughput in KiB/s for 100 Mhz = 100 * 1000 * 4.
+               */
+               if (target_level >= 3)
+                       resource_request("vdd2_opp", &vdd2_dev, 400000);
+               else
+                       resource_release("vdd2_opp", &vdd2_dev);
+
        } else if (resp == vdd2_resp) {
                tput = target_level;

@@ -336,11 +413,10 @@ void init_freq(struct shared_resource *r
        */
        if (strcmp(resp->name, "mpu_freq") == 0)
                /* MPU freq in Mhz */
-               resp->curr_level = curr_vdd1_prcm_set->rate;
+               resp->curr_level = mpu_opps[curr_vdd1_opp].rate;
        else if (strcmp(resp->name, "dsp_freq") == 0)
                /* DSP freq in Mhz */
-               resp->curr_level = get_freq(dsp_opps + MAX_VDD2_OPP,
-                                               curr_vdd1_prcm_set->opp_id);
+               resp->curr_level = dsp_opps[curr_vdd1_opp].rate;
        return;
 }

Index: linux-omap-pm/arch/arm/mach-omap2/resource34xx.h
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/resource34xx.h
+++ linux-omap-pm/arch/arm/mach-omap2/resource34xx.h
@@ -28,10 +28,6 @@
 #include <mach/omap-pm.h>
 #include <mach/omap34xx.h>

-extern struct omap_opp *curr_vdd1_prcm_set;
-extern struct omap_opp *curr_vdd2_prcm_set;
-extern unsigned long get_freq(struct  omap_opp *, unsigned short);
-extern unsigned short get_opp(struct omap_opp *, unsigned long);
 extern int sr_voltagescale_vcbypass(u32 target_opp, u8 vsel);

 /*
