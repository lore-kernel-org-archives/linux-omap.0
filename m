From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 08/17] omap4: pm: Add GIC save/restore support
Date: Sat, 19 Feb 2011 16:12:29 +0530
Message-ID: <1298112158-28469-9-git-send-email-santosh.shilimkar@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48724 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab1BSKnD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Feb 2011 05:43:03 -0500
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP4 when attempting MPU off-mode or OSWR, the GIC context is
lost. This patch adds GIC context save and restore support.

The context save is done by software and restore is done by
ROM code from predefined SAR locations where the context suppose
to be saved. Refer to ROM code specs for the GIC layout details.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap-hotplug.c         |    4 +
 arch/arm/mach-omap2/omap4-mpuss-lowpower.c |  176 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap4-sar-layout.h     |   20 +++
 3 files changed, 199 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index cf4ab15..deab389 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -19,6 +19,8 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
+#include <asm/hardware/gic.h>
+
 #include <mach/omap4-common.h>
 #include <mach/omap-wakeupgen.h>
 
@@ -58,6 +60,7 @@ void platform_cpu_die(unsigned int cpu)
 		 * clear all interrupt wakeup sources
 		 */
 		omap_wakeupgen_irqmask_all(cpu, 1);
+		gic_secondary_set(0, true);
 		omap4_enter_lowpower(cpu, PWRDM_POWER_OFF);
 		this_cpu = hard_smp_processor_id();
 		if (omap_read_auxcoreboot0() == this_cpu) {
@@ -65,6 +68,7 @@ void platform_cpu_die(unsigned int cpu)
 			 * OK, proper wakeup, we're done
 			 */
 			omap_wakeupgen_irqmask_all(this_cpu, 0);
+			gic_secondary_set(0, false);
 
 			/* Restore clockdomain to hardware supervised */
 			clkdm_allow_idle(cpu1_clkdm);
diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
index c0f358d..4140251 100644
--- a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
@@ -47,6 +47,8 @@
 #include <asm/tlbflush.h>
 #include <asm/smp_scu.h>
 #include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/hardware/gic.h>
 
 #include <plat/omap44xx.h>
 #include <mach/omap4-common.h>
@@ -59,6 +61,19 @@
 
 #define CPU0_ID				0x0
 #define CPU1_ID				0x1
+#define GIC_MASK_ALL			0x0
+#define GIC_ISR_NON_SECURE		0xffffffff
+#define SPI_ENABLE_SET_OFFSET		0x04
+#define PPI_PRI_OFFSET			0x1c
+#define SPI_PRI_OFFSET			0x20
+#define SPI_TARGET_OFFSET		0x20
+#define SPI_CONFIG_OFFSET		0x20
+
+/* GIC save SAR bank base */
+static struct powerdomain *mpuss_pd;
+
+/* Variables to store maximum spi(Shared Peripheral Interrupts) registers. */
+static u32 max_spi_irq, max_spi_reg;
 
 struct omap4_cpu_pm_info {
 	struct powerdomain *pwrdm;
@@ -67,6 +82,17 @@ struct omap4_cpu_pm_info {
 
 static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
 
+/* Helper functions */
+static inline void sar_writel(u32 val, u32 offset, u8 idx)
+{
+	__raw_writel(val, sar_ram_base + offset + 4 * idx);
+}
+
+static inline u32 gic_readl(u32 offset, u8 idx)
+{
+	return __raw_readl(gic_dist_base_addr + offset + 4 * idx);
+}
+
 /*
  * Set the CPUx powerdomain's previous power state
  */
@@ -124,6 +150,85 @@ static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
 }
 
 /*
+ * Save GIC context in SAR RAM. Restore is done by ROM code
+ * GIC is lost only when MPU hits OSWR or OFF. It consists
+ * of a distributor and a per-CPU interface module. The GIC
+ * save restore is optimised to save only necessary registers.
+ */
+static void gic_save_context(void)
+{
+	u8 i;
+	u32 val;
+
+	/*
+	 * Interrupt Clear Enable registers are inverse of set enable
+	 * and hence not needed to be saved. ROM code programs it
+	 * based on Set Enable register values.
+	 */
+
+	/* Save CPU 0 Interrupt Set Enable register */
+	val = gic_readl(GIC_DIST_ENABLE_SET, 0);
+	sar_writel(val, ICDISER_CPU0_OFFSET, 0);
+
+	/* Disable interrupts on CPU1 */
+	sar_writel(GIC_MASK_ALL, ICDISER_CPU1_OFFSET, 0);
+
+	/* Save all SPI Set Enable register */
+	for (i = 0; i < max_spi_reg; i++) {
+		val = gic_readl(GIC_DIST_ENABLE_SET + SPI_ENABLE_SET_OFFSET, i);
+		sar_writel(val, ICDISER_SPI_OFFSET, i);
+	}
+
+	/*
+	 * Interrupt Priority Registers
+	 * Secure sw accesses, last 5 bits of the 8 bits (bit[7:3] are used)
+	 * Non-Secure sw accesses, last 4 bits (i.e. bits[7:4] are used)
+	 * But the Secure Bits[7:3] are shifted by 1 in Non-Secure access.
+	 * Secure (bits[7:3] << 1)== Non Secure bits[7:4]
+	 * Hence right shift the value by 1 while saving the priority
+	 */
+
+	/* Save SGI priority registers (Software Generated Interrupt) */
+	for (i = 0; i < 4; i++) {
+		val = gic_readl(GIC_DIST_PRI, i);
+
+		/* Save the priority bits of the Interrupts */
+		sar_writel(val >> 0x1, ICDIPR_SFI_CPU0_OFFSET, i);
+
+		/* Disable the interrupts on CPU1 */
+		sar_writel(GIC_MASK_ALL, ICDIPR_SFI_CPU1_OFFSET, i);
+	}
+
+	/* Save PPI priority registers (Private Peripheral Intterupts) */
+	val = gic_readl(GIC_DIST_PRI + PPI_PRI_OFFSET, 0);
+	sar_writel(val >> 0x1, ICDIPR_PPI_CPU0_OFFSET, 0);
+	sar_writel(GIC_MASK_ALL, ICDIPR_PPI_CPU1_OFFSET, 0);
+
+	/* SPI priority registers - 4 interrupts/register */
+	for (i = 0; i < (max_spi_irq / 4); i++) {
+		val = gic_readl((GIC_DIST_PRI + SPI_PRI_OFFSET), i);
+		sar_writel(val >> 0x1, ICDIPR_SPI_OFFSET, i);
+	}
+
+	/* SPI Interrupt Target registers - 4 interrupts/register */
+	for (i = 0; i < (max_spi_irq / 4); i++) {
+		val = gic_readl((GIC_DIST_TARGET + SPI_TARGET_OFFSET), i);
+		sar_writel(val, ICDIPTR_SPI_OFFSET, i);
+	}
+
+	/* SPI Interrupt Congigeration eegisters- 16 interrupts/register */
+	for (i = 0; i < (max_spi_irq / 16); i++) {
+		val = gic_readl((GIC_DIST_CONFIG + SPI_CONFIG_OFFSET), i);
+		sar_writel(val, ICDICFR_OFFSET, i);
+	}
+
+	/* Set the Backup Bit Mask status for GIC */
+	val = __raw_readl(sar_ram_base + SAR_BACKUP_STATUS_OFFSET);
+	val |= (SAR_BACKUP_STATUS_GIC_CPU0 | SAR_BACKUP_STATUS_GIC_CPU1);
+	__raw_writel(val, sar_ram_base + SAR_BACKUP_STATUS_OFFSET);
+}
+
+/*
  * OMAP4 MPUSS Low Power Entry Function
  *
  * The purpose of this function is to manage low power programming
@@ -131,11 +236,25 @@ static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
  * Paramenters:
  *	cpu : CPU ID
  *	power_state: Targetted Low power state.
+ *
+ * MPUSS Low power states
+ * The basic rule is that the MPUSS power domain must be at the higher or
+ * equal power state (state that consume more power) than the higher of the
+ * two CPUs. For example, it is illegal for system power to be OFF, while
+ * the power of one or both of the CPU is DORMANT. When an illegal state is
+ * entered, then the hardware behavior is unpredictable.
+ *
+ * MPUSS state for the context save
+ * save_state =
+ *	0 - Nothing lost and no need to save: MPUSS INACTIVE
+ *	1 - CPUx L1 and logic lost: MPUSS CSWR
+ *	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
+ *	3 - CPUx L1 and logic lost + GIC + L2 lost: MPUSS OFF
  */
 int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 {
 	unsigned int save_state = 0;
-	unsigned int wakeup_cpu = hard_smp_processor_id();
+	unsigned int wakeup_cpu;
 
 	if ((cpu > NR_CPUS) || (omap_rev() == OMAP4430_REV_ES1_0))
 		goto ret;
@@ -159,6 +278,23 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 		goto ret;
 	}
 
+	/*
+	 * MPUSS book keeping should be executed by master
+	 * CPU only which is also the last CPU to go down.
+	 */
+	if (cpu)
+		goto cpu_prepare;
+
+	/*
+	 * Check MPUSS next state and save GIC if needed
+	 * GIC lost during MPU OFF and OSWR
+	 */
+	if (pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_OFF) {
+		gic_save_context();
+		save_state = 3;
+	}
+
+cpu_prepare:
 	clear_cpu_prev_pwrst(cpu);
 	set_cpu_next_pwrst(cpu, power_state);
 	scu_pwrst_prepare(cpu, power_state);
@@ -179,6 +315,19 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	wakeup_cpu = hard_smp_processor_id();
 	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
 
+	/* If !master cpu return to hotplug-path */
+	if (wakeup_cpu)
+		goto ret;
+
+	/* Check MPUSS previous power state and enable GIC if needed */
+	if (pwrdm_read_prev_pwrst(mpuss_pd) == PWRDM_POWER_OFF) {
+		/* Clear SAR BACKUP status */
+		__raw_writel(0x0, sar_ram_base + SAR_BACKUP_STATUS_OFFSET);
+		/* Enable GIC distributor and inteface on CPU0*/
+		gic_secondary_set(CPU0_ID, 1);
+		gic_dist_set(CPU0_ID, 1);
+	}
+
 ret:
 	return 0;
 }
@@ -189,6 +338,7 @@ ret:
 int __init omap4_mpuss_init(void)
 {
 	struct omap4_cpu_pm_info *pm_info;
+	u8 i;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
 		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
@@ -234,6 +384,30 @@ int __init omap4_mpuss_init(void)
 	__raw_writel(virt_to_phys(omap4_cpu_resume),
 			sar_ram_base + CPU0_WAKEUP_NS_PA_ADDR_OFFSET);
 
+	mpuss_pd = pwrdm_lookup("mpu_pwrdm");
+	if (!mpuss_pd) {
+		pr_err("Failed to get lookup for MPUSS pwrdm\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Find out how many interrupts are supported.
+	 * OMAP4 supports max of 128 SPIs where as GIC can support
+	 * up to 1020 interrupt sources.
+	 */
+	max_spi_reg = __raw_readl(gic_dist_base_addr + GIC_DIST_CTR) & 0x1f;
+	max_spi_irq = max_spi_reg * 32;
+
+	/*
+	 * Mark the PPI and SPI interrupts as non-secure.
+	 * program the SAR locations for interrupt security registers to
+	 * reflect the same.
+	 */
+	sar_writel(GIC_ISR_NON_SECURE, ICDISR_CPU0_OFFSET, 0);
+	sar_writel(GIC_ISR_NON_SECURE, ICDISR_CPU1_OFFSET, 0);
+	for (i = 0; i < max_spi_reg; i++)
+		sar_writel(GIC_ISR_NON_SECURE, ICDISR_SPI_OFFSET, i);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index c4251db..0a19f49 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -30,6 +30,26 @@
 #define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
 #define CPU1_WAKEUP_NS_PA_ADDR_OFFSET		0xa08
 
+ /* GIC save restore offset from SAR_BANK3 */
+#define SAR_BACKUP_STATUS_OFFSET		(SAR_BANK3_OFFSET + 0x500)
+#define SAR_SECURE_RAM_SIZE_OFFSET		(SAR_BANK3_OFFSET + 0x504)
+#define SAR_SECRAM_SAVED_AT_OFFSET		(SAR_BANK3_OFFSET + 0x508)
+#define ICDISR_CPU0_OFFSET			(SAR_BANK3_OFFSET + 0x50c)
+#define ICDISR_CPU1_OFFSET			(SAR_BANK3_OFFSET + 0x510)
+#define ICDISR_SPI_OFFSET			(SAR_BANK3_OFFSET + 0x514)
+#define ICDISER_CPU0_OFFSET			(SAR_BANK3_OFFSET + 0x524)
+#define ICDISER_CPU1_OFFSET			(SAR_BANK3_OFFSET + 0x528)
+#define ICDISER_SPI_OFFSET			(SAR_BANK3_OFFSET + 0x52c)
+#define ICDIPR_SFI_CPU0_OFFSET			(SAR_BANK3_OFFSET + 0x53c)
+#define ICDIPR_PPI_CPU0_OFFSET			(SAR_BANK3_OFFSET + 0x54c)
+#define ICDIPR_SFI_CPU1_OFFSET			(SAR_BANK3_OFFSET + 0x550)
+#define ICDIPR_PPI_CPU1_OFFSET			(SAR_BANK3_OFFSET + 0x560)
+#define ICDIPR_SPI_OFFSET			(SAR_BANK3_OFFSET + 0x564)
+#define ICDIPTR_SPI_OFFSET			(SAR_BANK3_OFFSET + 0x5e4)
+#define ICDICFR_OFFSET				(SAR_BANK3_OFFSET + 0x664)
+#define SAR_BACKUP_STATUS_GIC_CPU0		0x1
+#define SAR_BACKUP_STATUS_GIC_CPU1		0x2
+
 #ifndef __ASSEMBLER__
 
 extern void __iomem *sar_ram_base;
-- 
1.6.0.4

