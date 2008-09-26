From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 12/16] OMAP3: Restore MMU table entry
Date: Fri, 26 Sep 2008 17:49:34 +0530
Message-ID: <01fd01c91fd2$23502d20$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37936 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbYIZMTn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:19:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

During the MMU restoration on the restore path from MPU OFF,
the page table entry for the page consisting of the code being
executed is modified to make MMU return VA=PA.
The MMU is then enabled and the original entry is being 
stored in scratchpad.
This patch reads the original values stored in scratchpad, and
restores them back.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/mach-omap2/pm.h     |    4 ++++
 arch/arm/mach-omap2/pm34xx.c |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/pm.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm.h	2008-09-25 16:27:12.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm.h	2008-09-25 16:27:18.000000000 +0530
@@ -23,6 +23,10 @@ extern atomic_t sleep_block;
 extern void omap2_block_sleep(void);
 extern void omap2_allow_sleep(void);
 
+#define OMAP343X_TABLE_ADDRESS_OFFSET 0x31
+#define OMAP343X_TABLE_VALUE_OFFSET   0x30
+#define OMAP343X_CONTROL_REG_VALUE_OFFSET     0x32
+
 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
 extern int omap2_pm_debug;
Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-09-25 16:27:17.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-09-25 16:27:18.000000000 +0530
@@ -30,6 +30,8 @@
 #include <mach/clockdomain.h>
 #include <mach/powerdomain.h>
 #include <mach/common.h>
+#include <mach/control.h>
+#include <asm/tlbflush.h>
 
 #include "cm.h"
 #include "cm-regbits-34xx.h"
@@ -149,6 +151,33 @@ static irqreturn_t prcm_interrupt_handle
 	return IRQ_HANDLED;
 }
 
+static void restore_control_register(u32 val)
+{
+	__asm__ __volatile__ ("mcr p15, 0, %0, c1, c0, 0" : : "r" (val));
+}
+
+/* Function to restore the table entry that was modified for enabling MMU */
+static void restore_table_entry(void)
+{
+	u32 *scratchpad_address;
+	u32 previous_value, control_reg_value;
+	u32 *address;
+	scratchpad_address = OMAP2_IO_ADDRESS(OMAP343X_SCRATCHPAD);
+	/* Get address of entry that was modified */
+	address = (u32 *)__raw_readl(scratchpad_address
+					+ OMAP343X_TABLE_ADDRESS_OFFSET);
+	/* Get the previous value which needs to be restored */
+	previous_value = __raw_readl(scratchpad_address
+					+ OMAP343X_TABLE_VALUE_OFFSET);
+	address = __va(address);
+	*address = previous_value;
+	flush_tlb_all();
+	control_reg_value = __raw_readl(scratchpad_address
+					+ OMAP343X_CONTROL_REG_VALUE_OFFSET);
+	/* This will enable caches and prediction */
+	restore_control_register(control_reg_value);
+}
+
 static void omap_sram_idle(void)
 {
 	/* Variable to tell what needs to be saved and restored
@@ -209,6 +238,10 @@ static void omap_sram_idle(void)
 	}
 
 	_omap_sram_idle(NULL, save_state);
+	/* Restore table entry modified during MMU restoration */
+	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
+		restore_table_entry();
+
 
 	if (core_next_state < PWRDM_POWER_ON) {
 		/* Disable IO-PAD wakeup */

