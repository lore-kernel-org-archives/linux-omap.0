From: Jean Pihet <jpihet@mvista.com>
Subject: Re: [PATCH 00/02] OMAP3 clock: Remove virtual clock nodes
Date: Tue, 7 Apr 2009 14:23:22 +0100
Message-ID: <200904071523.22962.jpihet@mvista.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FB102C27@dbde02.ent.ti.com> <873acpzn9y.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KP12JyDGX2Zqmav"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:22038 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbZDGNXj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 09:23:39 -0400
In-Reply-To: <873acpzn9y.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--Boundary-00=_KP12JyDGX2Zqmav
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Rajendra, Kevin,

On Friday 03 April 2009 18:59:21 Kevin Hilman wrote:
> "Nayak, Rajendra" <rnayak@ti.com> writes:
...
> > Patches generated and apply on latest pm branch from Kevin's pm tree.
>
> Rajendra,
>
> This series does not apply against the PM branch.
>
> It seems your patches have TABs converted to spaces.  For example, in
> 01/02 the first hunk which removes a bunch of code is trying to remove
> lines with spaces and the original code is all TABs, so the patch
> fails.
>
> Please resubmit with correct formatting so it applies cleanly.
Here are the reworked patches. Also the warnings have been removed from 
arch/arm/plat-omap/cpu-omap.c and arch/arm/mach-omap2/resource34xx.c.

CPU_FREQ works on Beagleboard with those 2 patches applied.

Hope that helps,
Jean
>
> Kevin
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--Boundary-00=_KP12JyDGX2Zqmav
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0002-This-patch-removes-all-refrences-to-virtual-clock.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-This-patch-removes-all-refrences-to-virtual-clock.patch"

=46rom 7158beddca76bec162d9ce37e731451ea198b821 Mon Sep 17 00:00:00 2001
=46rom: Rajendra Nayak <rnayak@ti.com>
Date: Tue, 7 Apr 2009 14:35:41 +0200
Subject: [PATCH] This patch removes all refrences to virtual clock
 nodes in CPUFreq driver.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Jean Pihet <jpihet@mvista.com>
=2D--
 arch/arm/plat-omap/cpu-omap.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index a4b3392..929e5f7 100644
=2D-- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -40,7 +40,7 @@ static struct cpufreq_frequency_table *freq_table;
 #ifdef CONFIG_ARCH_OMAP1
 #define MPU_CLK		"mpu"
 #elif CONFIG_ARCH_OMAP3
=2D#define MPU_CLK		"virt_vdd1_prcm_set"
+#define MPU_CLK		"arm_fck"
 #else
 #define MPU_CLK		"virt_prcm_set"
 #endif
@@ -82,7 +82,9 @@ static int omap_target(struct cpufreq_policy *policy,
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
+#ifdef CONFIG_ARCH_OMAP1
 	struct cpufreq_freqs freqs;
+#endif
 	int ret =3D 0;
=20
 	/* Ensure desired rate is within allowed range.  Some govenors
@@ -92,13 +94,13 @@ static int omap_target(struct cpufreq_policy *policy,
 	if (target_freq > policy->cpuinfo.max_freq)
 		target_freq =3D policy->cpuinfo.max_freq;
=20
+#ifdef CONFIG_ARCH_OMAP1
 	freqs.old =3D omap_getspeed(0);
 	freqs.new =3D clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
 	freqs.cpu =3D 0;
=20
 	if (freqs.old =3D=3D freqs.new)
 		return ret;
=2D#ifdef CONFIG_ARCH_OMAP1
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 #ifdef CONFIG_CPU_FREQ_DEBUG
 	printk(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
@@ -110,7 +112,7 @@ static int omap_target(struct cpufreq_policy *policy,
 	if (mpu_opps) {
 		int ind;
 		for (ind =3D 1; ind <=3D MAX_VDD1_OPP; ind++) {
=2D			if (mpu_opps[ind].rate/1000 >=3D freqs.new) {
+			if (mpu_opps[ind].rate/1000 >=3D target_freq) {
 				omap_pm_cpu_set_freq
 					(mpu_opps[ind].rate);
 				break;
=2D-=20
1.6.1.2.MVISTA.50.gdf8fd


--Boundary-00=_KP12JyDGX2Zqmav
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0001-This-patch-removes-the-virtual-node-implementation-f.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-This-patch-removes-the-virtual-node-implementation-f.patch"

=46rom 1d629908f5712b7c12994064bbaf25a59d248edc Mon Sep 17 00:00:00 2001
=46rom: Rajendra Nayak <rnayak@ti.com>
Date: Tue, 7 Apr 2009 14:32:25 +0200
Subject: [PATCH] This patch removes the virtual node implementation from cl=
ock f/w.
 The resource framework which would use these nodes for DVFS
 is been updated with most functionality internally, which was earlier
 handled by virtual clock nodes.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Jean Pihet <jpihet@mvista.com>
=2D--
 arch/arm/mach-omap2/clock34xx.c    |  188 -------------------------------
 arch/arm/mach-omap2/clock34xx.h    |   26 -----
 arch/arm/mach-omap2/resource34xx.c |  216 ++++++++++++++++++++++++--------=
=2D---
 arch/arm/mach-omap2/resource34xx.h |    4 -
 4 files changed, 146 insertions(+), 288 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34x=
x.c
index 6d4d4fe..3cee6b4 100644
=2D-- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -48,32 +48,6 @@
=20
 #define MAX_DPLL_WAIT_TRIES		1000000
=20
=2Dstruct omap_opp *curr_vdd1_prcm_set;
=2Dstruct omap_opp *curr_vdd2_prcm_set;
=2Dstatic struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
=2D
=2D#ifndef CONFIG_CPU_FREQ
=2Dstatic unsigned long compute_lpj(unsigned long ref, u_int div, u_int mul=
t)
=2D{
=2D	unsigned long new_jiffy_l, new_jiffy_h;
=2D
=2D	/*
=2D	 * Recalculate loops_per_jiffy.  We do it this way to
=2D	 * avoid math overflow on 32-bit machines.  Maybe we
=2D	 * should make this architecture dependent?  If you have
=2D	 * a better way of doing this, please replace!
=2D	 *
=2D	 *    new =3D old * mult / div
=2D	 */
=2D	new_jiffy_h =3D ref / div;
=2D	new_jiffy_l =3D (ref % div) / 100;
=2D	new_jiffy_h *=3D mult;
=2D	new_jiffy_l =3D new_jiffy_l * mult / div;
=2D
=2D	return new_jiffy_h + new_jiffy_l * 100;
=2D}
=2D#endif
=2D
 #define MIN_SDRC_DLL_LOCK_FREQ		83000000
=20
 #define CYCLES_PER_MHZ			1000000
@@ -786,9 +760,6 @@ int __init omap2_clk_init(void)
 	struct clk **clkp;
 	/* u32 clkrate; */
 	u32 cpu_clkflg;
=2D	unsigned long mpu_speed, core_speed;
=2D	struct omap_opp *prcm_vdd;
=2D
=20
 	/* REVISIT: Ultimately this will be used for multiboot */
 #if 0
@@ -846,32 +817,6 @@ int __init omap2_clk_init(void)
=20
 	recalculate_root_clocks();
=20
=2D	dpll1_clk =3D clk_get(NULL, "dpll1_ck");
=2D	dpll2_clk =3D clk_get(NULL, "dpll2_ck");
=2D	dpll3_clk =3D clk_get(NULL, "dpll3_m2_ck");
=2D
=2D	mpu_speed =3D dpll1_clk->rate;
=2D	if (mpu_opps) {
=2D		prcm_vdd =3D mpu_opps + MAX_VDD1_OPP;
=2D		for (; prcm_vdd->rate; prcm_vdd--) {
=2D			if (prcm_vdd->rate <=3D mpu_speed) {
=2D				curr_vdd1_prcm_set =3D prcm_vdd;
=2D				break;
=2D			}
=2D		}
=2D	}
=2D
=2D	core_speed =3D dpll3_clk->rate;
=2D	if (l3_opps) {
=2D		prcm_vdd =3D l3_opps + MAX_VDD2_OPP;
=2D		for (; prcm_vdd->rate; prcm_vdd--) {
=2D			if (prcm_vdd->rate <=3D core_speed) {
=2D				curr_vdd2_prcm_set =3D prcm_vdd;
=2D				break;
=2D			}
=2D		}
=2D	}
=2D
 	printk(KERN_INFO "Clocking rate (Crystal/DPLL/ARM core): "
 	       "%ld.%01ld/%ld/%ld MHz\n",
 	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
@@ -886,137 +831,4 @@ int __init omap2_clk_init(void)
 	return 0;
 }
=20
=2Dunsigned long get_freq(struct omap_opp *opp_freq_table,
=2D		      unsigned short opp)
=2D{
=2D	struct omap_opp *prcm_config;
=2D	prcm_config =3D opp_freq_table;
=2D
=2D	for (; prcm_config->opp_id; prcm_config--)
=2D		if (prcm_config->opp_id =3D=3D opp)
=2D			return prcm_config->rate;
=2D	return 0;
=2D}
=2D
=2Dunsigned short get_opp(struct omap_opp *opp_freq_table,
=2D		     unsigned long freq)
=2D{
=2D	struct omap_opp *prcm_config;
=2D	prcm_config =3D opp_freq_table;
=2D
=2D	if (prcm_config->rate <=3D freq)
=2D		return prcm_config->opp_id; /* Return the Highest OPP */
=2D	for (; prcm_config->rate; prcm_config--)
=2D		if (prcm_config->rate < freq)
=2D			return (prcm_config+1)->opp_id;
=2D		else if (prcm_config->rate =3D=3D freq)
=2D			return prcm_config->opp_id;
=2D	/* Return the least OPP */
=2D	return (prcm_config+1)->opp_id;
=2D}
=2D
=2Dstatic void omap3_table_recalc(struct clk *clk)
=2D{
=2D	if ((clk !=3D &virt_vdd1_prcm_set) && (clk !=3D &virt_vdd2_prcm_set))
=2D		return;
=2D
=2D	if ((curr_vdd1_prcm_set) && (clk =3D=3D &virt_vdd1_prcm_set))
=2D		clk->rate =3D curr_vdd1_prcm_set->rate;
=2D	else if ((curr_vdd2_prcm_set) && (clk =3D=3D &virt_vdd2_prcm_set))
=2D		clk->rate =3D curr_vdd2_prcm_set->rate;
=2D	pr_debug("CLK RATE:%lu\n", clk->rate);
=2D}
=2D
=2Dstatic long omap3_round_to_table_rate(struct clk *clk, unsigned long rat=
e)
=2D{
=2D	struct omap_opp *ptr;
=2D	long highest_rate;
=2D
=2D	if ((clk !=3D &virt_vdd1_prcm_set) && (clk !=3D &virt_vdd2_prcm_set))
=2D		return -EINVAL;
=2D
=2D	if (!mpu_opps || !dsp_opps || !l3_opps)
=2D		return -EINVAL;
=2D
=2D	highest_rate =3D -EINVAL;
=2D
=2D	if (clk =3D=3D &virt_vdd1_prcm_set)
=2D		ptr =3D mpu_opps + MAX_VDD1_OPP;
=2D	else
=2D		ptr =3D dsp_opps + MAX_VDD2_OPP;
=2D
=2D	for (; ptr->rate; ptr--) {
=2D		highest_rate =3D ptr->rate;
=2D		pr_debug("Highest speed : %lu, rate: %lu\n", highest_rate,
=2D								rate);
=2D		if (ptr->rate <=3D rate)
=2D			break;
=2D	}
=2D	return highest_rate;
=2D}
=2D
=2Dstatic int omap3_select_table_rate(struct clk *clk, unsigned long rate)
=2D{
=2D	struct omap_opp *prcm_vdd =3D NULL;
=2D	unsigned long found_speed =3D 0, curr_mpu_speed;
=2D	int index =3D 0;
=2D	int l3_div;
=2D	int ret;
=2D
=2D	if ((clk !=3D &virt_vdd1_prcm_set) && (clk !=3D &virt_vdd2_prcm_set))
=2D		return -EINVAL;
=2D
=2D	if (!mpu_opps || !dsp_opps || !l3_opps)
=2D		return -EINVAL;
=2D
=2D	if (clk =3D=3D &virt_vdd1_prcm_set) {
=2D		prcm_vdd =3D mpu_opps + MAX_VDD1_OPP;
=2D		index =3D MAX_VDD1_OPP;
=2D	} else if (clk =3D=3D &virt_vdd2_prcm_set) {
=2D		prcm_vdd =3D l3_opps + MAX_VDD2_OPP;
=2D		index =3D MAX_VDD2_OPP;
=2D	}
=2D
=2D	for (; prcm_vdd && prcm_vdd->rate; prcm_vdd--, index--) {
=2D		if (prcm_vdd->rate <=3D rate) {
=2D			found_speed =3D prcm_vdd->rate;
=2D			pr_debug("Found speed =3D %lu\n", found_speed);
=2D			break;
=2D		}
=2D	}
=2D
=2D	if (!found_speed) {
=2D		printk(KERN_INFO "Could not set table rate to %luMHz\n",
=2D		       rate / 1000000);
=2D		return -EINVAL;
=2D	}
=2D
=2D
=2D	if (clk =3D=3D &virt_vdd1_prcm_set) {
=2D		curr_mpu_speed =3D curr_vdd1_prcm_set->rate;
=2D		clk->rate =3D prcm_vdd->rate;
=2D		clk_set_rate(dpll1_clk, prcm_vdd->rate);
=2D		clk_set_rate(dpll2_clk, dsp_opps[index].rate);
=2D		curr_vdd1_prcm_set =3D prcm_vdd;
=2D#ifndef CONFIG_CPU_FREQ
=2D		/*Update loops_per_jiffy if processor speed is being changed*/
=2D		loops_per_jiffy =3D compute_lpj(loops_per_jiffy,
=2D					curr_mpu_speed/1000, found_speed/1000);
=2D#endif
=2D	} else {
=2D		l3_div =3D cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
=2D			OMAP3430_CLKSEL_L3_MASK;
=2D		ret =3D clk_set_rate(dpll3_clk, prcm_vdd->rate * l3_div);
=2D		if (ret)
=2D			return ret;
=2D		curr_vdd2_prcm_set =3D prcm_vdd;
=2D	}
=2D
=2D#ifdef CONFIG_PM
=2D	omap3_save_scratchpad_contents();
=2D#endif
=2D
=2D	return 0;
=2D}
=2D
 #endif /* CONFIG_ARCH_OMAP3 */
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34x=
x.h
index e0dd7f3..f00bdf7 100644
=2D-- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -39,9 +39,6 @@ static int omap3_noncore_dpll_enable(struct clk *clk);
 static void omap3_noncore_dpll_disable(struct clk *clk);
 static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate=
);
 static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate=
);
=2Dstatic void omap3_table_recalc(struct clk *clk);
=2Dstatic long omap3_round_to_table_rate(struct clk *clk, unsigned long rat=
e);
=2Dstatic int omap3_select_table_rate(struct clk *clk, unsigned long rate);
=20
 /* Maximum DPLL multiplier, divider values for OMAP3 */
 #define OMAP3_MAX_DPLL_MULT		2048
@@ -3345,26 +3342,6 @@ static struct clk wdt1_fck =3D {
 	.recalc		=3D &followparent_recalc,
 };
=20
=2Dstatic struct clk virt_vdd1_prcm_set =3D {
=2D	.name =3D "virt_vdd1_prcm_set",
=2D	.flags =3D CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
=2D	.parent =3D &mpu_ck, /* Indexed by mpu speed, no parent */
=2D	.clkdm =3D { .name =3D "virt_opp_clkdm" },
=2D	.recalc =3D &omap3_table_recalc, /*sets are keyed on mpu rate */
=2D	.set_rate =3D &omap3_select_table_rate,
=2D	.round_rate =3D &omap3_round_to_table_rate,
=2D};
=2D
=2Dstatic struct clk virt_vdd2_prcm_set =3D {
=2D	.name =3D "virt_vdd2_prcm_set",
=2D	.flags =3D CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
=2D	.parent =3D &core_ck,
=2D	.clkdm =3D { .name =3D "virt_opp_clkdm" },
=2D	.recalc =3D &omap3_table_recalc,
=2D	.set_rate =3D &omap3_select_table_rate,
=2D	.round_rate =3D &omap3_round_to_table_rate,
=2D};
=2D
 static struct clk *onchip_34xx_clks[] __initdata =3D {
 	&omap_32k_fck,
 	&virt_12m_ck,
@@ -3588,9 +3565,6 @@ static struct clk *onchip_34xx_clks[] __initdata =3D {
 	&secure_32k_fck,
 	&gpt12_fck,
 	&wdt1_fck,
=2D	/* virtual group clock */
=2D	&virt_vdd1_prcm_set,
=2D	&virt_vdd2_prcm_set,
 };
=20
 #endif
diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resou=
rce34xx.c
index fd67c39..f9092d7 100644
=2D-- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -18,12 +18,16 @@
=20
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
=20
 /**
  * init_latency - Initializes the mpu/core latency resource.
@@ -134,14 +138,34 @@ int set_pd_latency(struct shared_resource *resp, u32 =
latency)
 	return 0;
 }
=20
=2Dstatic struct clk *vdd1_clk;
=2Dstatic struct clk *vdd2_clk;
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
+		unsigned long freq)
+{
+	struct omap_opp *prcm_config;
+	prcm_config =3D opp_freq_table;
+
+	if (prcm_config->rate <=3D freq)
+		return prcm_config->opp_id; /* Return the Highest OPP */
+	for (; prcm_config->rate; prcm_config--)
+		if (prcm_config->rate < freq)
+			return (prcm_config+1)->opp_id;
+		else if (prcm_config->rate =3D=3D freq)
+			return prcm_config->opp_id;
+	/* Return the least OPP */
+	return (prcm_config+1)->opp_id;
+}
=20
 /**
  * init_opp - Initialize the OPP resource
@@ -151,25 +175,28 @@ void init_opp(struct shared_resource *resp)
 	resp->no_of_users =3D 0;
=20
 	if (!mpu_opps || !dsp_opps || !l3_opps)
=2D		return 0;
+		return;
=20
 	/* Initialize the current level of the OPP resource
 	* to the  opp set by u-boot.
 	*/
 	if (strcmp(resp->name, "vdd1_opp") =3D=3D 0) {
=2D		resp->curr_level =3D curr_vdd1_prcm_set->opp_id;
=2D		vdd1_clk =3D clk_get(NULL, "virt_vdd1_prcm_set");
 		vdd1_resp =3D resp;
+		dpll1_clk =3D clk_get(NULL, "dpll1_ck");
+		dpll2_clk =3D clk_get(NULL, "dpll2_ck");
+		resp->curr_level =3D get_opp(mpu_opps + MAX_VDD1_OPP,
+				dpll1_clk->rate);
+		curr_vdd1_opp =3D resp->curr_level;
 	} else if (strcmp(resp->name, "vdd2_opp") =3D=3D 0) {
=2D		resp->curr_level =3D curr_vdd2_prcm_set->opp_id;
=2D		vdd2_clk =3D clk_get(NULL, "virt_vdd2_prcm_set");
 		vdd2_resp =3D resp;
+		dpll3_clk =3D clk_get(NULL, "dpll3_m2_ck");
+		resp->curr_level =3D get_opp(l3_opps + MAX_VDD2_OPP,
+				dpll2_clk->rate);
+		curr_vdd2_opp =3D resp->curr_level;
 	}
 	return;
 }
=20
=2Dstatic struct device vdd2_dev;
=2D
 int resource_access_opp_lock(int res, int delta)
 {
 	if (res =3D=3D VDD1_OPP) {
@@ -182,14 +209,94 @@ int resource_access_opp_lock(int res, int delta)
 	return -EINVAL;
 }
=20
+#ifndef CONFIG_CPU_FREQ
+static unsigned long compute_lpj(unsigned long ref, u_int div, u_int mult)
+{
+	unsigned long new_jiffy_l, new_jiffy_h;
+
+	/*
+	 * Recalculate loops_per_jiffy.  We do it this way to
+	 * avoid math overflow on 32-bit machines.  Maybe we
+	 * should make this architecture dependent?  If you have
+	 * a better way of doing this, please replace!
+	 *
+	 *    new =3D old * mult / div
+	 */
+	new_jiffy_h =3D ref / div;
+	new_jiffy_l =3D (ref % div) / 100;
+	new_jiffy_h *=3D mult;
+	new_jiffy_l =3D new_jiffy_l * mult / div;
+
+	return new_jiffy_h + new_jiffy_l * 100;
+}
+#endif
+
+static int program_opp_freq(int res, int target_level, int current_level)
+{
+	int ret =3D 0, l3_div;
+	int *curr_opp;
+
+	if (res =3D=3D VDD1_OPP) {
+		curr_opp =3D &curr_vdd1_opp;
+		clk_set_rate(dpll1_clk, mpu_opps[target_level].rate);
+		clk_set_rate(dpll2_clk, dsp_opps[target_level].rate);
+#ifndef CONFIG_CPU_FREQ
+		/*Update loops_per_jiffy if processor speed is being changed*/
+		loops_per_jiffy =3D compute_lpj(loops_per_jiffy,
+			mpu_opps[current_level].rate/1000,
+			mpu_opps[target_level].rate/1000);
+#endif
+	} else {
+		curr_opp =3D &curr_vdd2_opp;
+		l3_div =3D cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+			OMAP3430_CLKSEL_L3_MASK;
+		ret =3D clk_set_rate(dpll3_clk,
+				l3_opps[target_level].rate * l3_div);
+	}
+	if (ret)
+		return current_level;
+#ifdef CONFIG_PM
+	omap3_save_scratchpad_contents();
+#endif
+	*curr_opp =3D target_level;
+	return target_level;
+}
+
+static int program_opp(int res, struct omap_opp *opp, int target_level,
+		int current_level)
+{
+	int i, ret =3D 0, raise;
+#ifdef CONFIG_OMAP_SMARTREFLEX
+	unsigned long t_opp;
+
+	t_opp =3D ID_VDD(res) | ID_OPP_NO(opp[target_level].opp_id);
+#endif
+	if (target_level > current_level)
+		raise =3D 1;
+	else
+		raise =3D 0;
+
+	for (i =3D 0; i < 2; i++) {
+		if (i =3D=3D raise)
+			ret =3D program_opp_freq(res, target_level,
+					current_level);
+#ifdef CONFIG_OMAP_SMARTREFLEX
+		else
+			sr_voltagescale_vcbypass(t_opp,
+					opp[target_level].vsel);
+#endif
+	}
+
+	return ret;
+}
+
 int resource_set_opp_level(int res, u32 target_level, int flags)
 {
=2D	unsigned long mpu_freq, mpu_old_freq, l3_freq, t_opp;
+	unsigned long mpu_freq, mpu_old_freq;
 #ifdef CONFIG_CPU_FREQ
 	struct cpufreq_freqs freqs_notify;
 #endif
 	struct shared_resource *resp;
=2D	int ret;
=20
 	if (res =3D=3D VDD1_OPP)
 		resp =3D vdd1_resp;
@@ -204,13 +311,16 @@ int resource_set_opp_level(int res, u32 target_level,=
 int flags)
 	if (!mpu_opps || !dsp_opps || !l3_opps)
 		return 0;
=20
+	mutex_lock(&dvfs_mutex);
+
 	if (res =3D=3D VDD1_OPP) {
=2D		if (flags !=3D OPP_IGNORE_LOCK && vdd1_lock)
+		if (flags !=3D OPP_IGNORE_LOCK && vdd1_lock) {
+			mutex_unlock(&dvfs_mutex);
 			return 0;
=2D		mpu_old_freq =3D get_freq(mpu_opps + MAX_VDD1_OPP,
=2D					curr_vdd1_prcm_set->opp_id);
=2D		mpu_freq =3D get_freq(mpu_opps + MAX_VDD1_OPP,
=2D					target_level);
+		}
+		mpu_old_freq =3D mpu_opps[resp->curr_level].rate;
+		mpu_freq =3D mpu_opps[target_level].rate;
+
 #ifdef CONFIG_CPU_FREQ
 		freqs_notify.old =3D mpu_old_freq/1000;
 		freqs_notify.new =3D mpu_freq/1000;
@@ -218,65 +328,22 @@ int resource_set_opp_level(int res, u32 target_level,=
 int flags)
 		/* Send pre notification to CPUFreq */
 		cpufreq_notify_transition(&freqs_notify, CPUFREQ_PRECHANGE);
 #endif
=2D		t_opp =3D ID_VDD(PRCM_VDD1) |
=2D			ID_OPP_NO(mpu_opps[target_level].opp_id);
=2D		if (resp->curr_level > target_level) {
=2D			/* Scale Frequency and then voltage */
=2D			clk_set_rate(vdd1_clk, mpu_freq);
=2D#ifdef CONFIG_OMAP_SMARTREFLEX
=2D			sr_voltagescale_vcbypass(t_opp,
=2D					mpu_opps[target_level].vsel);
=2D#endif
=2D		} else {
=2D#ifdef CONFIG_OMAP_SMARTREFLEX
=2D			/* Scale Voltage and then frequency */
=2D			sr_voltagescale_vcbypass(t_opp,
=2D					mpu_opps[target_level].vsel);
=2D#endif
=2D			clk_set_rate(vdd1_clk, mpu_freq);
=2D		}
=2D		resp->curr_level =3D curr_vdd1_prcm_set->opp_id;
+		resp->curr_level =3D program_opp(res, mpu_opps, target_level,
+			resp->curr_level);
 #ifdef CONFIG_CPU_FREQ
 		/* Send a post notification to CPUFreq */
 		cpufreq_notify_transition(&freqs_notify, CPUFREQ_POSTCHANGE);
 #endif
 	} else {
=2D		if (flags !=3D OPP_IGNORE_LOCK && vdd2_lock)
+		if (!(flags & OPP_IGNORE_LOCK) && vdd2_lock) {
+			mutex_unlock(&dvfs_mutex);
 			return 0;
=2D		l3_freq =3D get_freq(l3_opps + MAX_VDD2_OPP,
=2D					target_level);
=2D		t_opp =3D ID_VDD(PRCM_VDD2) |
=2D			ID_OPP_NO(l3_opps[target_level].opp_id);
=2D		if (resp->curr_level > target_level) {
=2D			/* Scale Frequency and then voltage */
=2D			ret =3D clk_set_rate(vdd2_clk, l3_freq);
=2D			if (ret)
=2D				return ret;
=2D#ifdef CONFIG_OMAP_SMARTREFLEX
=2D			sr_voltagescale_vcbypass(t_opp,
=2D					l3_opps[target_level].vsel);
=2D#endif
=2D		} else {
=2D#ifdef CONFIG_OMAP_SMARTREFLEX
=2D			/* Scale Voltage and then frequency */
=2D			sr_voltagescale_vcbypass(t_opp,
=2D					l3_opps[target_level].vsel);
=2D#endif
=2D			ret =3D clk_set_rate(vdd2_clk, l3_freq);
=2D			if (ret) {
=2D#ifdef CONFIG_OMAP_SMARTREFLEX
=2D				/* Setting clock failed, revert voltage */
=2D				t_opp =3D ID_VDD(PRCM_VDD2) |
=2D					ID_OPP_NO(l3_opps[resp->curr_level].
=2D							opp_id);
=2D				sr_voltagescale_vcbypass(t_opp,
=2D					l3_opps[resp->curr_level].vsel);
=2D#endif
=2D				return ret;
=2D			}
 		}
=2D		resp->curr_level =3D curr_vdd2_prcm_set->opp_id;
+
+		resp->curr_level =3D program_opp(res, l3_opps, target_level,
+			resp->curr_level);
 	}
+	mutex_unlock(&dvfs_mutex);
 	return 0;
 }
=20
@@ -288,6 +355,16 @@ int set_opp(struct shared_resource *resp, u32 target_l=
evel)
=20
 	if (resp =3D=3D vdd1_resp) {
 		resource_set_opp_level(VDD1_OPP, target_level, 0);
+		/*
+		 * For VDD1 OPP3 and above, make sure the interconnect
+		 * is at 100Mhz or above.
+		 * throughput in KiB/s for 100 Mhz =3D 100 * 1000 * 4.
+		 */
+		if (target_level >=3D 3)
+			resource_request("vdd2_opp", &vdd2_dev, 400000);
+		else
+			resource_release("vdd2_opp", &vdd2_dev);
+
 	} else if (resp =3D=3D vdd2_resp) {
 		tput =3D target_level;
=20
@@ -336,11 +413,10 @@ void init_freq(struct shared_resource *resp)
 	*/
 	if (strcmp(resp->name, "mpu_freq") =3D=3D 0)
 		/* MPU freq in Mhz */
=2D		resp->curr_level =3D curr_vdd1_prcm_set->rate;
+		resp->curr_level =3D mpu_opps[curr_vdd1_opp].rate;
 	else if (strcmp(resp->name, "dsp_freq") =3D=3D 0)
 		/* DSP freq in Mhz */
=2D		resp->curr_level =3D get_freq(dsp_opps + MAX_VDD2_OPP,
=2D						curr_vdd1_prcm_set->opp_id);
+		resp->curr_level =3D dsp_opps[curr_vdd1_opp].rate;
 	return;
 }
=20
diff --git a/arch/arm/mach-omap2/resource34xx.h b/arch/arm/mach-omap2/resou=
rce34xx.h
index 543bb91..b847208 100644
=2D-- a/arch/arm/mach-omap2/resource34xx.h
+++ b/arch/arm/mach-omap2/resource34xx.h
@@ -28,10 +28,6 @@
 #include <mach/omap-pm.h>
 #include <mach/omap34xx.h>
=20
=2Dextern struct omap_opp *curr_vdd1_prcm_set;
=2Dextern struct omap_opp *curr_vdd2_prcm_set;
=2Dextern unsigned long get_freq(struct  omap_opp *, unsigned short);
=2Dextern unsigned short get_opp(struct omap_opp *, unsigned long);
 extern int sr_voltagescale_vcbypass(u32 target_opp, u8 vsel);
=20
 /*
=2D-=20
1.6.1.2.MVISTA.50.gdf8fd


--Boundary-00=_KP12JyDGX2Zqmav--
