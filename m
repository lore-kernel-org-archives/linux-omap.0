From: David Brownell <david-b@pacbell.net>
Subject: [patch 2/2 rc8-omap-git] twl4030-core irq simplification
Date: Mon, 6 Oct 2008 20:43:35 -0700
Message-ID: <200810062043.35080.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:33648 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753583AbYJGDni (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 23:43:38 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Simplify twl4030 IRQ handling by removing a needless custom flow
handler.  The top level IRQs, from the PIH, are well suited for
handle_simple_irq() ... they can't be acked or masked.

Switching resolves some issues with how IRQs were dispatched.
Notably, abuse of desc->status, IRQ accounting, and handling
of various faults.

In short, use standard genirq code.

Drivers that request_irq() to the PIH will need to pay more
attention to things like setting IRQF_DISABLED (since it's
no longer ignored), and making I2C calls from handlers (you'll
need a lockdep workaround).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Tested with the updated TWL GPIO and pwrirq drivers (now using
handle_edge_irq).  It should behave without those updates, too.

 drivers/mfd/twl4030-core.c |   75 ++-----------------------------------------
 1 file changed, 4 insertions(+), 71 deletions(-)

--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -535,68 +535,6 @@ EXPORT_SYMBOL(twl4030_i2c_read_u8);
 
 /*----------------------------------------------------------------------*/
 
-/*
- * do_twl4030_module_irq() is the desc->handle method for each of the twl4030
- * module interrupts that doesn't chain to another irq_chip (GPIO, power, etc).
- * It executes in kernel thread context.  On entry, cpu interrupts are disabled.
- */
-static void do_twl4030_module_irq(unsigned int irq, irq_desc_t *desc)
-{
-	struct irqaction *action;
-	const unsigned int cpu = smp_processor_id();
-
-	/*
-	 * Earlier this was desc->triggered = 1;
-	 */
-	desc->status |= IRQ_LEVEL;
-
-	/*
-	 * The desc->handle method would normally call the desc->chip->ack
-	 * method here, but we won't bother since our ack method is NULL.
-	 */
-
-	if (!desc->depth) {
-		kstat_cpu(cpu).irqs[irq]++;
-
-		action = desc->action;
-		if (action) {
-			int ret;
-			int status = 0;
-			int retval = 0;
-
-			local_irq_enable();
-
-			do {
-				/* Call the ISR with cpu interrupts enabled */
-				ret = action->handler(irq, action->dev_id);
-				if (ret == IRQ_HANDLED)
-					status |= action->flags;
-				retval |= ret;
-				action = action->next;
-			} while (action);
-
-			if (status & IRQF_SAMPLE_RANDOM)
-				add_interrupt_randomness(irq);
-
-			local_irq_disable();
-
-			if (retval != IRQ_HANDLED)
-				printk(KERN_ERR "ISR for TWL4030 module"
-					" irq %d can't handle interrupt\n",
-					irq);
-
-			/*
-			 * Here is where we should call the unmask method, but
-			 * again we won't bother since it is NULL.
-			 */
-		} else
-			printk(KERN_CRIT "TWL4030 module irq %d has no ISR"
-					" but can't be masked!\n", irq);
-	} else
-		printk(KERN_CRIT "TWL4030 module irq %d is disabled but can't"
-				" be masked!\n", irq);
-}
-
 static unsigned twl4030_irq_base;
 
 static struct completion irq_event;
@@ -611,7 +549,6 @@ static int twl4030_irq_thread(void *data
 	static unsigned i2c_errors;
 	const static unsigned max_i2c_errors = 100;
 
-	daemonize("twl4030-irq");
 	current->flags |= PF_NOFREEZE;
 
 	while (!kthread_should_stop()) {
@@ -691,8 +625,7 @@ static struct task_struct * __init start
 	struct task_struct *thread;
 
 	init_completion(&irq_event);
-	thread = kthread_run(twl4030_irq_thread, (void *)irq,
-			     "twl4030 irq %ld", irq);
+	thread = kthread_run(twl4030_irq_thread, (void *)irq, "twl4030-irq");
 	if (!thread)
 		pr_err("%s: could not create twl4030 irq %ld thread!\n",
 		       DRIVER_NAME, irq);
@@ -1126,7 +1059,7 @@ static void twl_init_irq(int irq_num, un
 	/* install an irq handler for each of the PIH modules */
 	for (i = irq_base; i < irq_end; i++) {
 		set_irq_chip_and_handler(i, &twl4030_irq_chip,
-				do_twl4030_module_irq);
+				handle_simple_irq);
 		activate_irq(i);
 	}
 
