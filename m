From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 6/6] omap3: pm: Use exported set_cr() instead of a custom one.
Date: Mon, 21 Feb 2011 18:49:25 +0530
Message-ID: <1298294365-30770-7-git-send-email-santosh.shilimkar@ti.com>
References: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41446 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755994Ab1BUNTg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 08:19:36 -0500
In-Reply-To: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Remove the custom restore_control_register() and use the exported
set_cr() instead to set the system control register(SCTRL) value.

No functional change.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2f864e4..63a3e1d 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -311,11 +311,6 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void restore_control_register(u32 val)
-{
-	__asm__ __volatile__ ("mcr p15, 0, %0, c1, c0, 0" : : "r" (val));
-}
-
 /* Function to restore the table entry that was modified for enabling MMU */
 static void restore_table_entry(void)
 {
@@ -337,7 +332,7 @@ static void restore_table_entry(void)
 	control_reg_value = __raw_readl(scratchpad_address
 					+ OMAP343X_CONTROL_REG_VALUE_OFFSET);
 	/* This will enable caches and prediction */
-	restore_control_register(control_reg_value);
+	set_cr(control_reg_value);
 }
 
 void omap_sram_idle(void)
-- 
1.6.0.4

