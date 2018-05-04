From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv2] serial: 8250: omap: Fix idling of clocks for unused uarts
Date: Fri,  4 May 2018 10:31:03 -0700
Message-ID: <20180504173103.73881-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vignesh R <vigneshr@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

I noticed that unused UARTs won't necessarily idle properly always
unless at least one byte tx transfer is done first.

After some debugging I narrowed down the problem to the scr register
dma configuration bits that need to be set before softreset for the
clocks to idle. Unless we do this, the module clkctrl idlest bits
may be set to 1 instead of 3 meaning the clock will never idle and
is blocking deeper idle states for the whole domain.

This might be related to the configuration done by the bootloader
or kexec booting where certain configurations cause the 8250 or
the clkctrl clock to jam in a way where setting of the scr bits
and reset is needed to clear it. I've tried diffing the 8250
registers for the various modes, but did not see anything specific.
So far I've only seen this on omap4 but I'm suspecting this might
also happen on the other clkctrl using SoCs considering they
already have a quirk enabled for UART_ERRATA_CLOCK_DISABLE.

Let's fix the issue by configuring scr before reset for basic dma
even if we don't use it. The scr register will be reset when we do
softreset few lines after, and we restore scr on resume. We should
do this for all the SoCs with UART_ERRATA_CLOCK_DISABLE quirk flag
set since the ones with UART_ERRATA_CLOCK_DISABLE are all based
using clkctrl similar to omap4.

Looks like both OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL
bits are needed for the clkctrl to idle after a softreset.

And we need to add omap4 to also use the UART_ERRATA_CLOCK_DISABLE
for the related workaround to be enabled. This same compatible
value will also be used for omap5.

Fixes: cdb929e4452a ("serial: 8250_omap: workaround errata around
idling UART after using DMA")
Cc: Keerthy <j-keerthy@ti.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v1:

- Do the write in two steps as noted by Vignesh

- Update the comments for clkctrl status bits, it's two bits
  instead of just one bit

---
 arch/arm/mach-actions/platsmp.c     |  6 +++---
 arch/arm/mach-exynos/platsmp.c      | 12 ++++++------
 arch/arm/mach-hisi/platmcpm.c       | 22 +++++++++++-----------
 arch/arm/mach-omap2/omap-smp.c      | 10 +++++-----
 arch/arm/mach-prima2/platsmp.c      | 10 +++++-----
 arch/arm/mach-qcom/platsmp.c        | 10 +++++-----
 arch/arm/mach-spear/platsmp.c       | 10 +++++-----
 arch/arm/mach-sti/platsmp.c         | 10 +++++-----
 arch/arm/mach-sunxi/mc_smp.c        | 20 ++++++++++----------
 arch/arm/plat-versatile/platsmp.c   | 10 +++++-----
 drivers/tty/serial/8250/8250_omap.c | 16 +++++++++++++++-
 11 files changed, 75 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -39,7 +39,7 @@ static void __iomem *sps_base_addr;
 static void __iomem *timer_base_addr;
 static int ncores;
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 void owl_secondary_startup(void);
 
@@ -93,7 +93,7 @@ static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 	udelay(10);
 
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	smp_send_reschedule(cpu);
 
@@ -106,7 +106,7 @@ static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	writel(0, timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
 	writel(0, timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
 
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return 0;
 }
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -224,7 +224,7 @@ static void __iomem *scu_base_addr(void)
 	return (void __iomem *)(S5P_VA_SCU);
 }
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 static void exynos_secondary_init(unsigned int cpu)
 {
@@ -237,8 +237,8 @@ static void exynos_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr)
@@ -302,7 +302,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * The secondary processor is waiting to be released from
@@ -329,7 +329,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		if (timeout == 0) {
 			printk(KERN_ERR "cpu1 power enable failed");
-			spin_unlock(&boot_lock);
+			raw_spin_unlock(&boot_lock);
 			return -ETIMEDOUT;
 		}
 	}
@@ -375,7 +375,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * calibrations, then wait for it to finish
 	 */
 fail:
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? ret : 0;
 }
diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
--- a/arch/arm/mach-hisi/platmcpm.c
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -61,7 +61,7 @@
 
 static void __iomem *sysctrl, *fabric;
 static int hip04_cpu_table[HIP04_MAX_CLUSTERS][HIP04_MAX_CPUS_PER_CLUSTER];
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 static u32 fabric_phys_addr;
 /*
  * [0]: bootwrapper physical address
@@ -113,7 +113,7 @@ static int hip04_boot_secondary(unsigned int l_cpu, struct task_struct *idle)
 	if (cluster >= HIP04_MAX_CLUSTERS || cpu >= HIP04_MAX_CPUS_PER_CLUSTER)
 		return -EINVAL;
 
-	spin_lock_irq(&boot_lock);
+	raw_spin_lock_irq(&boot_lock);
 
 	if (hip04_cpu_table[cluster][cpu])
 		goto out;
@@ -147,7 +147,7 @@ static int hip04_boot_secondary(unsigned int l_cpu, struct task_struct *idle)
 
 out:
 	hip04_cpu_table[cluster][cpu]++;
-	spin_unlock_irq(&boot_lock);
+	raw_spin_unlock_irq(&boot_lock);
 
 	return 0;
 }
@@ -162,11 +162,11 @@ static void hip04_cpu_die(unsigned int l_cpu)
 	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 	hip04_cpu_table[cluster][cpu]--;
 	if (hip04_cpu_table[cluster][cpu] == 1) {
 		/* A power_up request went ahead of us. */
-		spin_unlock(&boot_lock);
+		raw_spin_unlock(&boot_lock);
 		return;
 	} else if (hip04_cpu_table[cluster][cpu] > 1) {
 		pr_err("Cluster %d CPU%d boots multiple times\n", cluster, cpu);
@@ -174,7 +174,7 @@ static void hip04_cpu_die(unsigned int l_cpu)
 	}
 
 	last_man = hip04_cluster_is_down(cluster);
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 	if (last_man) {
 		/* Since it's Cortex A15, disable L2 prefetching. */
 		asm volatile(
@@ -203,7 +203,7 @@ static int hip04_cpu_kill(unsigned int l_cpu)
 	       cpu >= HIP04_MAX_CPUS_PER_CLUSTER);
 
 	count = TIMEOUT_MSEC / POLL_MSEC;
-	spin_lock_irq(&boot_lock);
+	raw_spin_lock_irq(&boot_lock);
 	for (tries = 0; tries < count; tries++) {
 		if (hip04_cpu_table[cluster][cpu])
 			goto err;
@@ -211,10 +211,10 @@ static int hip04_cpu_kill(unsigned int l_cpu)
 		data = readl_relaxed(sysctrl + SC_CPU_RESET_STATUS(cluster));
 		if (data & CORE_WFI_STATUS(cpu))
 			break;
-		spin_unlock_irq(&boot_lock);
+		raw_spin_unlock_irq(&boot_lock);
 		/* Wait for clean L2 when the whole cluster is down. */
 		msleep(POLL_MSEC);
-		spin_lock_irq(&boot_lock);
+		raw_spin_lock_irq(&boot_lock);
 	}
 	if (tries >= count)
 		goto err;
@@ -231,10 +231,10 @@ static int hip04_cpu_kill(unsigned int l_cpu)
 		goto err;
 	if (hip04_cluster_is_down(cluster))
 		hip04_set_snoop_filter(cluster, 0);
-	spin_unlock_irq(&boot_lock);
+	raw_spin_unlock_irq(&boot_lock);
 	return 1;
 err:
-	spin_unlock_irq(&boot_lock);
+	raw_spin_unlock_irq(&boot_lock);
 	return 0;
 }
 #endif
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -69,7 +69,7 @@ static const struct omap_smp_config omap5_cfg __initconst = {
 	.startup_addr = omap5_secondary_startup,
 };
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 void __iomem *omap4_get_scu_base(void)
 {
@@ -136,8 +136,8 @@ static void omap4_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -150,7 +150,7 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * Update the AuxCoreBoot0 with boot state for secondary core.
@@ -229,7 +229,7 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return 0;
 }
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
--- a/arch/arm/mach-prima2/platsmp.c
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -22,7 +22,7 @@
 
 static void __iomem *clk_base;
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 static void sirfsoc_secondary_init(unsigned int cpu)
 {
@@ -36,8 +36,8 @@ static void sirfsoc_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 static const struct of_device_id clk_ids[]  = {
@@ -75,7 +75,7 @@ static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	/* make sure write buffer is drained */
 	mb();
 
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * The secondary processor is waiting to be released from
@@ -107,7 +107,7 @@ static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? -ENOSYS : 0;
 }
diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -46,7 +46,7 @@
 
 extern void secondary_startup_arm(void);
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 #ifdef CONFIG_HOTPLUG_CPU
 static void qcom_cpu_die(unsigned int cpu)
@@ -60,8 +60,8 @@ static void qcom_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 static int scss_release_secondary(unsigned int cpu)
@@ -284,7 +284,7 @@ static int qcom_boot_secondary(unsigned int cpu, int (*func)(unsigned int))
 	 * set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
@@ -297,7 +297,7 @@ static int qcom_boot_secondary(unsigned int cpu, int (*func)(unsigned int))
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return ret;
 }
diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
--- a/arch/arm/mach-spear/platsmp.c
+++ b/arch/arm/mach-spear/platsmp.c
@@ -32,7 +32,7 @@ static void write_pen_release(int val)
 	sync_cache_w(&pen_release);
 }
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 static void __iomem *scu_base = IOMEM(VA_SCU_BASE);
 
@@ -47,8 +47,8 @@ static void spear13xx_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -59,7 +59,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * The secondary processor is waiting to be released from
@@ -84,7 +84,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? -ENOSYS : 0;
 }
diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -35,7 +35,7 @@ static void write_pen_release(int val)
 	sync_cache_w(&pen_release);
 }
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 static void sti_secondary_init(unsigned int cpu)
 {
@@ -48,8 +48,8 @@ static void sti_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -60,7 +60,7 @@ static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * The secondary processor is waiting to be released from
@@ -91,7 +91,7 @@ static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? -ENOSYS : 0;
 }
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -369,7 +369,7 @@ static void __naked sunxi_mc_smp_secondary_startup(void)
 	);
 }
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 static bool sunxi_mc_smp_cluster_is_down(unsigned int cluster)
 {
@@ -401,7 +401,7 @@ static int sunxi_mc_smp_boot_secondary(unsigned int l_cpu, struct task_struct *i
 	if (cluster >= SUNXI_NR_CLUSTERS || cpu >= SUNXI_CPUS_PER_CLUSTER)
 		return -EINVAL;
 
-	spin_lock_irq(&boot_lock);
+	raw_spin_lock_irq(&boot_lock);
 
 	if (sunxi_mc_smp_cpu_table[cluster][cpu])
 		goto out;
@@ -419,7 +419,7 @@ static int sunxi_mc_smp_boot_secondary(unsigned int l_cpu, struct task_struct *i
 
 out:
 	sunxi_mc_smp_cpu_table[cluster][cpu]++;
-	spin_unlock_irq(&boot_lock);
+	raw_spin_unlock_irq(&boot_lock);
 
 	return 0;
 }
@@ -450,13 +450,13 @@ static void sunxi_mc_smp_cpu_die(unsigned int l_cpu)
 	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	pr_debug("%s: cluster %u cpu %u\n", __func__, cluster, cpu);
 
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 	sunxi_mc_smp_cpu_table[cluster][cpu]--;
 	if (sunxi_mc_smp_cpu_table[cluster][cpu] == 1) {
 		/* A power_up request went ahead of us. */
 		pr_debug("%s: aborting due to a power up request\n",
 			 __func__);
-		spin_unlock(&boot_lock);
+		raw_spin_unlock(&boot_lock);
 		return;
 	} else if (sunxi_mc_smp_cpu_table[cluster][cpu] > 1) {
 		pr_err("Cluster %d CPU%d boots multiple times\n",
@@ -465,7 +465,7 @@ static void sunxi_mc_smp_cpu_die(unsigned int l_cpu)
 	}
 
 	last_man = sunxi_mc_smp_cluster_is_down(cluster);
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	gic_cpu_if_down(0);
 	if (last_man)
@@ -541,11 +541,11 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
 
 	/* wait for CPU core to die and enter WFI */
 	count = TIMEOUT_USEC / POLL_USEC;
-	spin_lock_irq(&boot_lock);
+	raw_spin_lock_irq(&boot_lock);
 	for (tries = 0; tries < count; tries++) {
-		spin_unlock_irq(&boot_lock);
+		raw_spin_unlock_irq(&boot_lock);
 		usleep_range(POLL_USEC / 2, POLL_USEC);
-		spin_lock_irq(&boot_lock);
+		raw_spin_lock_irq(&boot_lock);
 
 		/*
 		 * If the user turns off a bunch of cores at the same
@@ -592,7 +592,7 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
 	sunxi_cluster_powerdown(cluster);
 
 out:
-	spin_unlock_irq(&boot_lock);
+	raw_spin_unlock_irq(&boot_lock);
 	pr_debug("%s: cluster %u cpu %u powerdown: %d\n",
 		 __func__, cluster, cpu, ret);
 	return !ret;
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -32,7 +32,7 @@ static void write_pen_release(int val)
 	sync_cache_w(&pen_release);
 }
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 void versatile_secondary_init(unsigned int cpu)
 {
@@ -45,8 +45,8 @@ void versatile_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -57,7 +57,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * This is really belt and braces; we hold unintended secondary
@@ -87,7 +87,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? -ENOSYS : 0;
 }
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1110,13 +1110,14 @@ static int omap8250_no_handle_irq(struct uart_port *port)
 	return 0;
 }
 
+static const u8 omap4_habit = UART_ERRATA_CLOCK_DISABLE;
 static const u8 am3352_habit = OMAP_DMA_TX_KICK | UART_ERRATA_CLOCK_DISABLE;
 static const u8 dra742_habit = UART_ERRATA_CLOCK_DISABLE;
 
 static const struct of_device_id omap8250_dt_ids[] = {
 	{ .compatible = "ti,omap2-uart" },
 	{ .compatible = "ti,omap3-uart" },
-	{ .compatible = "ti,omap4-uart" },
+	{ .compatible = "ti,omap4-uart", .data = &omap4_habit, },
 	{ .compatible = "ti,am3352-uart", .data = &am3352_habit, },
 	{ .compatible = "ti,am4372-uart", .data = &am3352_habit, },
 	{ .compatible = "ti,dra742-uart", .data = &dra742_habit, },
@@ -1362,6 +1363,19 @@ static int omap8250_soft_reset(struct device *dev)
 	int sysc;
 	int syss;
 
+	/*
+	 * At least on omap4, unused uarts may not idle after reset without
+	 * a basic scr dma configuration even with no dma in use. The
+	 * module clkctrl status bits will be 1 instead of 3 blocking idle
+	 * for the whole clockdomain. The softreset below will clear scr,
+	 * and we restore it on resume so this is safe to do on all SoCs
+	 * needing omap8250_soft_reset() quirk. Do it in two writes as
+	 * recommended in the comment for omap8250_update_scr().
+	 */
+	serial_out(up, UART_OMAP_SCR, OMAP_UART_SCR_DMAMODE_1);
+	serial_out(up, UART_OMAP_SCR,
+		   OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL);
+
 	sysc = serial_in(up, UART_OMAP_SYSC);
 
 	/* softreset the UART */
-- 
2.17.0
