From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 04/06] restores the MMU table entry
Date: Tue, 26 Aug 2008 18:35:08 +0530 (IST)
Message-ID: <33866.192.168.10.89.1219755908.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41264 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbYHZNFO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 09:05:14 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7QD59Fv005212
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 08:05:14 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m7QD57NP022299
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 08:05:08 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch restores the table entry that was modified for
enabling the MMU in the sram code.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/mach-omap2/pm.h     |    3 +++
 arch/arm/mach-omap2/pm34xx.c |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/pm.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm.h	2008-08-26 17:22:23.000000000
+0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm.h	2008-08-26 17:33:54.000000000 +0530
@@ -23,6 +23,9 @@ extern atomic_t sleep_block;
 extern void omap2_block_sleep(void);
 extern void omap2_allow_sleep(void);

+#define OMAP343X_TABLE_ADDRESS_OFFSET	0x31
+#define OMAP343X_TABLE_VALUE_OFFSET	0x30
+#define OMAP343X_CONTROL_REG_VALUE_OFFSET	0x32

 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-08-26
17:30:53.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-08-26 17:33:54.000000000
+0530
@@ -30,6 +30,8 @@
 #include <mach/clockdomain.h>
 #include <mach/powerdomain.h>
 #include <mach/common.h>
+#include <mach/control.h>
+#include <asm/tlbflush.h>

 #include "cm.h"
 #include "cm-regbits-34xx.h"
@@ -181,6 +183,36 @@ static irqreturn_t prcm_interrupt_handle
 	return IRQ_HANDLED;
 }

+static void restore_control_register(u32 val)
+{
+	__asm__ __volatile__ ("mcr p15, 0, %0, c1, c0, 0" : : "r" (val));
+}
+
+/* Function to restore the table entry that was modified for enabling MMU*/
+static void restore_table_entry(void)
+{
+	u32 *scratchpad_address;
+	u32 previous_value, control_reg_value;
+	u32 *address;
+	/* Get virtual address of SCRATCHPAD */
+	scratchpad_address = (u32 *) io_p2v(OMAP343X_SCRATCHPAD);
+	/* Get address of entry that was modified */
+	address = (u32 *) *(scratchpad_address + OMAP343X_TABLE_ADDRESS_OFFSET);
+	/* Get the previous value which needs to be restored */
+	previous_value = *(scratchpad_address + OMAP343X_TABLE_VALUE_OFFSET);
+	/* Convert address to virtual address */
+	address = __va(address);
+	/* Restore table entry */
+	*address = previous_value;
+	/* Flush TLB */
+	flush_tlb_all();
+	control_reg_value = *(scratchpad_address
+				 + OMAP343X_CONTROL_REG_VALUE_OFFSET);
+	/* Restore control register*/
+	/* This will enable caches and prediction */
+	restore_control_register(control_reg_value);
+}
+
 void omap_sram_idle(void)
 {
 	/* Variable to tell what needs to be saved and restored
@@ -240,6 +272,10 @@ void omap_sram_idle(void)
 	}

 	_omap_sram_idle(NULL, save_state);
+	/* Restore table entry modified during MMU restoration */
+	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
+		restore_table_entry();
+

 	if (core_next_state < PWRDM_POWER_ON) {
 		/* Disable IO-PAD wakeup */


