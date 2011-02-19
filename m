From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 10/17] omap4: pm: Add L2 cache lowpower support
Date: Sat, 19 Feb 2011 16:12:31 +0530
Message-ID: <1298112158-28469-11-git-send-email-santosh.shilimkar@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48719 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058Ab1BSKm5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Feb 2011 05:42:57 -0500
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

When MPUSS hits off-mode e, L2 cache is lost. This patch adds L2X0
necessary maintenance operations and context restoration in the
low power code.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap4-mpuss-lowpower.c |   11 +++++
 arch/arm/mach-omap2/omap4-sar-layout.h     |    2 +
 arch/arm/mach-omap2/sleep44xx.S            |   64 ++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
index a30f19b..bff768f 100644
--- a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
@@ -49,6 +49,7 @@
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/hardware/gic.h>
+#include <asm/hardware/cache-l2x0.h>
 
 #include <plat/omap44xx.h>
 #include <mach/omap4-common.h>
@@ -341,6 +342,7 @@ int __init omap4_mpuss_init(void)
 {
 	struct omap4_cpu_pm_info *pm_info;
 	u8 i;
+	u32 val;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
 		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
@@ -410,6 +412,15 @@ int __init omap4_mpuss_init(void)
 	for (i = 0; i < max_spi_reg; i++)
 		sar_writel(GIC_ISR_NON_SECURE, ICDISR_SPI_OFFSET, i);
 
+#ifdef CONFIG_CACHE_L2X0
+	/*
+	 * Save the L2X0 AUXCTRL value to SAR memory. Its used to
+	 * in every restore patch MPUSS OFF path.
+	 */
+	val = __raw_readl(l2cache_base + L2X0_AUX_CTRL);
+	__raw_writel(val, sar_ram_base + L2X0_AUXCTRL_OFFSET);
+#endif
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index 5a815c4..eb2d53b 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -25,6 +25,8 @@
 #define MMU_OFFSET				0xd00
 #define SCU_OFFSET0				0xd20
 #define SCU_OFFSET1				0xd24
+#define L2X0_OFFSET				0xd28
+#define L2X0_AUXCTRL_OFFSET			0xd2c
 
 /* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK3 */
 #define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index bb42a7a..e683f78 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -13,6 +13,7 @@
 #include <asm/system.h>
 #include <asm/smp_scu.h>
 #include <asm/memory.h>
+#include <asm/hardware/cache-l2x0.h>
 
 #include <plat/omap44xx.h>
 #include <mach/omap4-common.h>
@@ -56,6 +57,7 @@ ENTRY(omap4_cpu_suspend)
 	beq	do_WFI				@ Nothing to save, jump to WFI
 	ldr	r8, =sar_ram_base
 	ldr	r8, [r8]
+	str	r1, [r8, #L2X0_OFFSET]		@ Store save state
 	ands	r0, r0, #0x0f
 	orreq	r8, r8, #CPU0_SAVE_OFFSET
 	orrne	r8, r8, #CPU1_SAVE_OFFSET
@@ -131,6 +133,42 @@ ENTRY(omap4_cpu_suspend)
 	ldr	r0, =scu_base
 	ldr	r0, [r0]
 	bl     scu_power_mode
+	isb
+	dsb
+
+#ifdef CONFIG_CACHE_L2X0
+	/*
+	 * Clean and invalidate the L2 cache.
+	 * Common cache-l2x0.c functions can't be used here since it
+	 * uses spinlocks. We are out of coherency here with data cache
+	 * disabled. The spinlock implementation uses exclusive load/store
+	 * instruction which can fail without data cache being enabled.
+	 * OMAP4 hardware doesn't support exclusive monitor which can
+	 * overcome exclusive access issue. Because of this, CPU can
+	 * lead to deadlock.
+	 */
+l2x_clean_inv:
+	ldr	r8, =sar_ram_base
+	ldr	r8, [r8]
+	ldr	r0, [r8, #L2X0_OFFSET]
+	cmp	r0, #3
+	bne	do_WFI
+	ldr	r2, =l2cache_base
+	ldr	r2, [r2]
+	mov	r0, #0xff
+	str	r0, [r2, #L2X0_CLEAN_WAY]
+wait:
+	ldr	r0, [r2, #L2X0_CLEAN_WAY]
+	ands	r0, r0, #0xff
+	bne	wait
+l2x_sync:
+	mov	r0, #0x0
+	str	r0, [r2, #L2X0_CACHE_SYNC]
+sync:
+	ldr	r0, [r2, #L2X0_CACHE_SYNC]
+	ands	r0, r0, #0x1
+	bne	sync
+#endif
 
 do_WFI:
 	/*
@@ -193,6 +231,32 @@ ENDPROC(omap4_cpu_suspend)
  */
 
 ENTRY(omap4_cpu_resume)
+#ifdef CONFIG_CACHE_L2X0
+	/*
+	 * Restore the L2 AUXCTRL and enable the L2 cache.
+	 * 0x109 =  Program the L2X0 AUXCTRL
+	 * 0x102 =  Enable the L2 using L2X0 CTRL
+	 * register r0 contains value to be programmed.
+	 * L2 cache is already invalidate by ROM code as part
+	 * of MPUSS OFF wakeup path.
+	 */
+	ldr	r2, =OMAP44XX_L2CACHE_BASE
+	ldr	r0, [r2, #L2X0_CTRL]
+	and	r0, #0x0f
+	cmp	r0, #1
+	beq	skip_l2en			@ Skip if already enabled
+	ldr	r3, =OMAP44XX_SAR_RAM_BASE
+	ldr	r0, [r3, #L2X0_AUXCTRL_OFFSET]
+	ldr	r12, =0x109			@ Setup L2 AUXCTRL value
+	dsb
+	smc	#0
+	mov	r0, #0x1
+	ldr	r12, =0x102			@ Enable L2 Cache controller
+	dsb
+	smc	#0
+skip_l2en:
+#endif
+
 	/*
 	 * Check the wakeup cpuid and use appropriate
 	 * SAR BANK location for context restore.
-- 
1.6.0.4

