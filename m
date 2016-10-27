From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] ARM: DRA7: PM: cpuidle MPU CSWR support
Date: Thu, 27 Oct 2016 09:15:01 -0700
Message-ID: <20161027161501.oehhwixykldta7hz@atomide.com>
References: <20161026151703.24730-1-tony@atomide.com>
 <20161026151703.24730-5-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161026151703.24730-5-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>, Keerthy <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Pau Pajuel <ppajuel@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [161026 08:18]:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Add DRA74/72 CPUIDLE support.

And as Nishnath noted, that hardware does not support deeper
idle states properly. So below is patches 4 and 5 updated and
squashed together into a single patche to enable cpuidle only
for omap5.

Regards,

Tony

8< -------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Tue, 25 Oct 2016 08:33:32 -0700
Subject: [PATCH] ARM: OMAP5: Add basic cpuidle MPU CSWR support

Add OMAP5 CPUIDLE support.

This patch adds MPUSS low power states in cpuidle.

        C1 - CPU0 WFI + CPU1 WFI + MPU ON
        C2 - CPU0 RET + CPU1 RET + MPU CSWR

Modified from TI kernel tree commit 605967fd2205 ("ARM: DRA7: PM:
cpuidle MPU CSWR support") except enable cpuidle for omap5 instead
of dra7.

According to Nishanth Menon <nm@ti.com>, cpuidle on dra7 is not
supported properly in the hardware so we don't want to enable it.
However, for omap5 this adds some nice power savings. Note that
the TI 3.8 based tree has other cpuidle states that we may be able
to enable later on.

On omap5-uevm, the power consumption eventually settles down to about
920mW with ehci-omap and ohci-omap3 unloaded compared to about 1.7W
without these patches. Note that it seems to take few minutes after
booting for the idle power to go down to 920mW from 1.3W, no idea so
far what might be causing that.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[ j-keerthy@ti.com rework on 3.14]
Signed-off-by: Keerthy <j-keerthy@ti.com>
[nm@ti.com: updates based on profiling]
[tony@atomide.com: dropped CPUIDLE_FLAG_TIME_VALID no longer used,
changed for omap5 only as requested by Nishanth, updated comments]
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c | 80 ++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/pm44xx.c      |  2 +-
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -21,6 +21,7 @@
 #include "common.h"
 #include "pm.h"
 #include "prm.h"
+#include "soc.h"
 #include "clockdomain.h"
 
 #define MAX_CPUS	2
@@ -30,6 +31,7 @@ struct idle_statedata {
 	u32 cpu_state;
 	u32 mpu_logic_state;
 	u32 mpu_state;
+	u32 mpu_state_vote;
 };
 
 static struct idle_statedata omap4_idle_data[] = {
@@ -50,12 +52,26 @@ static struct idle_statedata omap4_idle_data[] = {
 	},
 };
 
+static struct idle_statedata omap5_idle_data[] = {
+	{
+		.cpu_state = PWRDM_POWER_ON,
+		.mpu_state = PWRDM_POWER_ON,
+		.mpu_logic_state = PWRDM_POWER_ON,
+	},
+	{
+		.cpu_state = PWRDM_POWER_RET,
+		.mpu_state = PWRDM_POWER_RET,
+		.mpu_logic_state = PWRDM_POWER_RET,
+	},
+};
+
 static struct powerdomain *mpu_pd, *cpu_pd[MAX_CPUS];
 static struct clockdomain *cpu_clkdm[MAX_CPUS];
 
 static atomic_t abort_barrier;
 static bool cpu_done[MAX_CPUS];
 static struct idle_statedata *state_ptr = &omap4_idle_data[0];
+static DEFINE_RAW_SPINLOCK(mpu_lock);
 
 /* Private functions */
 
@@ -77,6 +93,32 @@ static int omap_enter_idle_simple(struct cpuidle_device *dev,
 	return index;
 }
 
+static int omap_enter_idle_smp(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv,
+			       int index)
+{
+	struct idle_statedata *cx = state_ptr + index;
+	unsigned long flag;
+
+	raw_spin_lock_irqsave(&mpu_lock, flag);
+	cx->mpu_state_vote++;
+	if (cx->mpu_state_vote == num_online_cpus()) {
+		pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
+		omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
+	}
+	raw_spin_unlock_irqrestore(&mpu_lock, flag);
+
+	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
+
+	raw_spin_lock_irqsave(&mpu_lock, flag);
+	if (cx->mpu_state_vote == num_online_cpus())
+		omap_set_pwrdm_state(mpu_pd, PWRDM_POWER_ON);
+	cx->mpu_state_vote--;
+	raw_spin_unlock_irqrestore(&mpu_lock, flag);
+
+	return index;
+}
+
 static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
@@ -220,6 +262,32 @@ static struct cpuidle_driver omap4_idle_driver = {
 	.safe_state_index = 0,
 };
 
+static struct cpuidle_driver omap5_idle_driver = {
+	.name				= "omap5_idle",
+	.owner				= THIS_MODULE,
+	.states = {
+		{
+			/* C1 - CPU0 ON + CPU1 ON + MPU ON */
+			.exit_latency = 2 + 2,
+			.target_residency = 5,
+			.enter = omap_enter_idle_simple,
+			.name = "C1",
+			.desc = "CPUx WFI, MPUSS ON"
+		},
+		{
+			/* C2 - CPU0 RET + CPU1 RET + MPU CSWR */
+			.exit_latency = 48 + 60,
+			.target_residency = 100,
+			.flags = CPUIDLE_FLAG_TIMER_STOP,
+			.enter = omap_enter_idle_smp,
+			.name = "C2",
+			.desc = "CPUx CSWR, MPUSS CSWR",
+		},
+	},
+	.state_count = ARRAY_SIZE(omap5_idle_data),
+	.safe_state_index = 0,
+};
+
 /* Public functions */
 
 /**
@@ -230,6 +298,16 @@ static struct cpuidle_driver omap4_idle_driver = {
  */
 int __init omap4_idle_init(void)
 {
+	struct cpuidle_driver *idle_driver;
+
+	if (soc_is_omap54xx()) {
+		state_ptr = &omap5_idle_data[0];
+		idle_driver = &omap5_idle_driver;
+	} else {
+		state_ptr = &omap4_idle_data[0];
+		idle_driver = &omap4_idle_driver;
+	}
+
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	cpu_pd[0] = pwrdm_lookup("cpu0_pwrdm");
 	cpu_pd[1] = pwrdm_lookup("cpu1_pwrdm");
@@ -244,5 +322,5 @@ int __init omap4_idle_init(void)
 	/* Configure the broadcast timer on each cpu */
 	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
 
-	return cpuidle_register(&omap4_idle_driver, cpu_online_mask);
+	return cpuidle_register(idle_driver, cpu_online_mask);
 }
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -287,7 +287,7 @@ int __init omap4_pm_init(void)
 	/* Overwrite the default cpu_do_idle() */
 	arm_pm_idle = omap_default_idle;
 
-	if (cpu_is_omap44xx())
+	if (cpu_is_omap44xx() || soc_is_omap54xx())
 		omap4_idle_init();
 
 err2:
-- 
2.9.3
