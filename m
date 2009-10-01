From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 09/28] OMAP3: PM: Restore MMU table entry
Date: Thu,  1 Oct 2009 16:58:39 -0700
Message-ID: <1254441538-9257-10-git-send-email-khilman@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-4-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-5-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-6-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-7-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-8-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-9-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:58920 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbZJAX7M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:12 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so574597pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:16 -0700 (PDT)
In-Reply-To: <1254441538-9257-9-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

During the MMU restoration on the restore path from MPU OFF, the page
table entry for the page consisting of the code being executed is
modified to make MMU return VA=PA.

The MMU is then enabled and the original entry is being stored in
scratchpad.  This patch reads the original values stored in
scratchpad, and restores them back.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7eab539..ee8a4a3 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -29,6 +29,8 @@
 #include <mach/control.h>
 #include <mach/serial.h>
 
+#include <asm/tlbflush.h>
+
 #include "cm.h"
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
@@ -164,6 +166,33 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
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
@@ -220,6 +249,10 @@ static void omap_sram_idle(void)
 	_omap_sram_idle(NULL, save_state);
 	cpu_init();
 
+	/* Restore table entry modified during MMU restoration */
+	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
+		restore_table_entry();
+
 	if (core_next_state < PWRDM_POWER_ON) {
 		if (per_next_state < PWRDM_POWER_ON)
 			omap_uart_resume_idle(2);
-- 
1.6.4.3

