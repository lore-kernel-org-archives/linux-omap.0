From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 21/25] twl4030-core: portability updates
Date: Tue, 30 Sep 2008 21:43:05 +0300
Message-ID: <1222800189-29737-22-git-send-email-me@felipebalbi.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
 <1222800189-29737-2-git-send-email-me@felipebalbi.com>
 <1222800189-29737-3-git-send-email-me@felipebalbi.com>
 <1222800189-29737-4-git-send-email-me@felipebalbi.com>
 <1222800189-29737-5-git-send-email-me@felipebalbi.com>
 <1222800189-29737-6-git-send-email-me@felipebalbi.com>
 <1222800189-29737-7-git-send-email-me@felipebalbi.com>
 <1222800189-29737-8-git-send-email-me@felipebalbi.com>
 <1222800189-29737-9-git-send-email-me@felipebalbi.com>
 <1222800189-29737-10-git-send-email-me@felipebalbi.com>
 <1222800189-29737-11-git-send-email-me@felipebalbi.com>
 <1222800189-29737-12-git-send-email-me@felipebalbi.com>
 <1222800189-29737-13-git-send-email-me@felipebalbi.com>
 <1222800189-29737-14-git-send-email-me@felipebalbi.com>
 <1222800189-29737-15-git-send-email-me@felipebalbi.com>
 <1222800189-29737-16-git-send-email-me@felipebalbi.com>
 <1222800189-29737-17-git-send-email-me@felipebalbi.com>
 <1222800189-29737-18-git-send-email-me@felipebalbi.com>
 <1222800189-29737-19-git-send-email-me@felipebalbi.com>
 <1222800189-29737-20-git-send-email-me@felipebalbi.com>
 <1222800189-29737-21-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60303 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbYI3SsM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 14:48:12 -0400
In-Reply-To: <1222800189-29737-21-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Improve handling of the OMAP-specific setup in twl4030-core,
and remove various warnings on non-OMAP builds.

The main remaining portability problem for this core code (from
a build perspective) is needing symbols like TWL4030_PWR_IRQ_BASE
which are undesirable and platform-specific.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-core.c |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 43424a8..efba776 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -75,6 +75,19 @@
 #define twl_has_usb()	false
 #endif
 
+static inline void activate_irq(int irq)
+{
+#ifdef CONFIG_ARM
+	/* ARM requires an extra step to clear IRQ_NOREQUEST, which it
+	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
+	 */
+	set_irq_flags(irq, IRQF_VALID);
+#else
+	/* same effect on other architectures */
+	set_irq_noprobe(irq);
+#endif
+}
+
 /* Primary Interrupt Handler on TWL4030 Registers */
 
 /* Register Definitions */
@@ -584,7 +597,7 @@ static unsigned twl4030_irq_base;
  */
 static int twl4030_irq_thread(void *data)
 {
-	int irq = (int)data;
+	long irq = (long)data;
 	irq_desc_t *desc = irq_desc + irq;
 	static unsigned i2c_errors;
 	const static unsigned max_i2c_errors = 100;
@@ -868,15 +881,15 @@ err:
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
@@ -909,16 +922,18 @@ static int __init unprotect_pm_master(void)
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
@@ -945,7 +960,6 @@ static int __init power_companion_init(void)
 	/* effect->MADC+USB ck en */
 	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
 	e |= protect_pm_master();
-#endif	/* OMAP */
 
 	return e;
 }
@@ -1051,9 +1065,9 @@ static void twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 
 	/* install an irq handler for each of the PIH modules */
 	for (i = irq_base; i < irq_end; i++) {
-		set_irq_chip(i, &twl4030_irq_chip);
-		set_irq_handler(i, do_twl4030_module_irq);
-		set_irq_flags(i, IRQF_VALID);
+		set_irq_chip_and_handler(i, &twl4030_irq_chip,
+				do_twl4030_module_irq);
+		activate_irq(i);
 	}
 
 	/* install an irq handler to demultiplex the TWL4030 interrupt */
-- 
1.6.0.1.196.g01914

