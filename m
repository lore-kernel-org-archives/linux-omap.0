From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 22/22] twl4030-core: portability updates
Date: Mon, 29 Sep 2008 16:14:39 +0300
Message-ID: <1222694079-16289-23-git-send-email-felipe.balbi@nokia.com>
References: <1222694079-16289-1-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-2-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-3-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-4-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-5-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-6-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-7-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-8-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-9-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-10-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-11-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-12-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-13-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-14-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-15-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-16-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-17-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-18-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-19-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-20-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-21-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-22-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29694 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbYI2NPa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:15:30 -0400
In-Reply-To: <1222694079-16289-22-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Improve handling of the OMAP-specific setup in twl4030-core,
and remove various warnings on non-OMAP builds.

The main remaining portability problem for this core code (from
a build perspective) is needing symbols like TWL4030_PWR_IRQ_BASE
which are undesirable and platform-specific.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-core.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 6941360..bcd2a3c 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -588,7 +588,7 @@ static unsigned twl4030_irq_base;
  */
 static int twl4030_irq_thread(void *data)
 {
-	int irq = (int)data;
+	long irq = (long)data;
 	irq_desc_t *desc = irq_desc + irq;
 	static unsigned i2c_errors;
 	const static unsigned max_i2c_errors = 100;
@@ -872,15 +872,15 @@ err:
 	return status;
 }
 
-static struct task_struct * __init start_twl4030_irq_thread(int irq)
+static struct task_struct * __init start_twl4030_irq_thread(long irq)
 {
 	struct task_struct *thread;
 
 	init_completion(&irq_event);
 	thread = kthread_run(twl4030_irq_thread, (void *)irq,
-			     "twl4030 irq %d", irq);
+			     "twl4030 irq %ld", irq);
 	if (!thread)
-		pr_err("%s: could not create twl4030 irq %d thread!\n",
+		pr_err("%s: could not create twl4030 irq %ld thread!\n",
 		       DRIVER_NAME, irq);
 
 	return thread;
@@ -913,16 +913,18 @@ static int __init unprotect_pm_master(void)
 static int __init power_companion_init(void)
 {
 	int e = 0;
-
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	struct clk *osc;
 	u32 rate;
 	u8 ctrl = HFCLK_FREQ_26_MHZ;
 
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	if (cpu_is_omap2430())
 		osc = clk_get(NULL, "osc_ck");
 	else
 		osc = clk_get(NULL, "osc_sys_ck");
+#else
+	osc = ERR_PTR(-EIO);
+#endif
 	if (IS_ERR(osc)) {
 		printk(KERN_WARNING "Skipping twl4030 internal clock init and "
 				"using bootloader value (unknown osc rate)\n");
@@ -949,7 +951,6 @@ static int __init power_companion_init(void)
 	/* effect->MADC+USB ck en */
 	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
 	e |= protect_pm_master();
-#endif	/* OMAP */
 
 	return e;
 }
@@ -1054,9 +1055,9 @@ static void twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 	twl4030_irq_base = irq_base;
 	/* install an irq handler for each of the PIH modules */
 	for (i = irq_base; i < irq_end; i++) {
-		set_irq_chip(i, &twl4030_irq_chip);
-		set_irq_handler(i, do_twl4030_module_irq);
-		set_irq_flags(i, IRQF_VALID);
+		set_irq_noprobe(i);
+		set_irq_chip_and_handler(i, &twl4030_irq_chip,
+				do_twl4030_module_irq);
 	}
 
 	/* install an irq handler to demultiplex the TWL4030 interrupt */
-- 
1.6.0.2.307.gc427

