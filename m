From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/2] ARM: OMAP4460: cpuidle: WA for ROM bug because of CA9
 r2pX gic control register change
Date: Thu, 17 Oct 2013 12:24:01 +0300
Message-ID: <525FACB1.3030101@ti.com>
References: <1382000776-15897-3-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382000776-15897-3-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>, open list <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On OMAP4+ devices, GIC register context is lost when MPUSS hits the
OSWR. On the CPU wakeup path, ROM code gets executed and one of the
steps in it is to restore the saved context of the GIC.

The ROM code uses GICD != 1 condition to decide how the GIC registers
are handled in wakeup path from OSWR. But, GICD  register has changed
between CortexA9 r1pX and r2pX and it contains 2 bits now. Secure view
which ROM code sees:
       bit 1 == Enable Non-secure
       bit 0 == Enable secure
Non-secure view which HLOS sees:
       bit 0 == Enable Non-secure

As result, on OMAP4460(r2pX) devices, when the ROM code is executed
during CPU1 wakeup, GICD == 3 and it fails to understand the real wakeup
power state and reconfigures GIC distributor to boot values and, as
result, the entire interrupt controller context will loose in a live
system.

Hence, implement a workaround on OMAP4460 devices in case if MPUSS has
hit OSWR - as long as CPU1 sees GICD == 1 in it's wakeup path from OSWR,
the issue won't happen:
      1.1) CPU0 must disable the GIC distributor, before doing the CPU1
wakeup,
      1.2) CPU0 should wait until CPU1 will re-enable the GIC distributor
        2) CPU1 must re-enable the GIC distributor on it's wakeup path.

The workaround for CPUIdle has been implemented in the same way as
for boot-up & hot-plug path in:
  - http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;
a=commitdiff;h=ff999b8a0983ee15668394ed49e38d3568fc6859

For more information see:
- https://patchwork.kernel.org/patch/1609011/
- http://www.spinics.net/lists/arm-kernel/msg201402.html

The ROM code bug is applicable to only OMAP4460(r2pX) devices.
OMAP4470 (also r2pX) is not affected by this bug because ROM code has been
fixed.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>
Reported-and-Tested-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
  arch/arm/mach-omap2/common.h       |    1 +
  arch/arm/mach-omap2/cpuidle44xx.c  |   34 
+++++++++++++++++++++++++++++++++-
  arch/arm/mach-omap2/omap4-common.c |    6 ++++++
  3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index b875a4a..7957110 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -232,6 +232,7 @@ static inline void __iomem *omap4_get_scu_base(void)

  extern void __init gic_init_irq(void);
  extern void gic_dist_disable(void);
+extern void gic_dist_enable(void);
  extern bool gic_dist_disabled(void);
  extern void gic_timer_retrigger(void);
  extern void omap_smc1(u32 fn, u32 arg);
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c 
b/arch/arm/mach-omap2/cpuidle44xx.c
index 384aa1c..528638b 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -80,6 +80,7 @@ static int omap_enter_idle_coupled(struct 
cpuidle_device *dev,
  			int index)
  {
  	struct idle_statedata *cx = state_ptr + index;
+	u32 mpuss_context_lost = 0;

  	/*
  	 * CPU0 has to wait and stay ON until CPU1 is OFF state.
@@ -126,13 +127,44 @@ static int omap_enter_idle_coupled(struct 
cpuidle_device *dev,
  	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
  	cpu_done[dev->cpu] = true;

+	mpuss_context_lost = omap4_mpuss_read_prev_context_state();
+
  	/* Wakeup CPU1 only if it is not offlined */
  	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
+		/*
+		 * GIC distributor control register has changed between
+		 * CortexA9 r1pX and r2pX. The Control Register secure
+		 * banked version is now composed of 2 bits:
+		 * bit 0 == Secure Enable
+		 * bit 1 == Non-Secure Enable
+		 * The Non-Secure banked register has not changed
+		 * Because the ROM Code is based on the r1pX GIC, the CPU1
+		 * GIC restoration will cause a problem to CPU0 Non-Secure SW.
+		 * The workaround must be:
+		 * 1) Before doing the CPU1 wakeup, CPU0 must disable
+		 * the GIC distributor and wait until it will be enabled by CPU1
+		 * 2) CPU1 must re-enable the GIC distributor on
+		 * it's wakeup path.
+		 */
+		if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD) &&
+		    mpuss_context_lost)
+			gic_dist_disable();
+
  		clkdm_wakeup(cpu_clkdm[1]);
  		omap_set_pwrdm_state(cpu_pd[1], PWRDM_POWER_ON);
  		clkdm_allow_idle(cpu_clkdm[1]);
+
+		if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD) &&
+		    mpuss_context_lost)
+			while (gic_dist_disabled()) {
+				udelay(1);
+				cpu_relax();
+			}
  	}

+	if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD) && dev->cpu)
+		gic_dist_enable();
+
  	/*
  	 * Call idle CPU PM exit notifier chain to restore
  	 * VFP and per CPU IRQ context.
@@ -143,7 +175,7 @@ static int omap_enter_idle_coupled(struct 
cpuidle_device *dev,
  	 * Call idle CPU cluster PM exit notifier chain
  	 * to restore GIC and wakeupgen context.
  	 */
-	if (dev->cpu == 0 && omap4_mpuss_read_prev_context_state())
+	if (dev->cpu == 0 && mpuss_context_lost)
  		cpu_cluster_pm_exit();

  fail:
diff --git a/arch/arm/mach-omap2/omap4-common.c 
b/arch/arm/mach-omap2/omap4-common.c
index 5791143..3ad4a8c 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -128,6 +128,12 @@ void gic_dist_disable(void)
  		__raw_writel(0x0, gic_dist_base_addr + GIC_DIST_CTRL);
  }

+void gic_dist_enable(void)
+{
+	if (gic_dist_base_addr)
+		__raw_writel(0x1, gic_dist_base_addr + GIC_DIST_CTRL);
+}
+
  bool gic_dist_disabled(void)
  {
  	return !(__raw_readl(gic_dist_base_addr + GIC_DIST_CTRL) & 0x1);
-- 
1.7.9.5
