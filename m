From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [ARM][OMAP] TWL4030 IRQ
Date: Mon, 29 Jun 2009 10:30:04 +0100
Message-ID: <20090629093004.GA2111@n2100.arm.linux.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E9C6@dbde02.ent.ti.com> <20090624075756.GA13052@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33477 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbZF2JaO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 05:30:14 -0400
Content-Disposition: inline
In-Reply-To: <20090624075756.GA13052@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jun 24, 2009 at 08:57:56AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 24, 2009 at 01:16:52PM +0530, Shilimkar, Santosh wrote:
> > After digging a bit, the proposed twl_irq change would need some major 
> > changes.
> > 
> > 1. All the T2(TWL)drivers ( rtc, madc, bci, gpio, keypad, usb, mmc)needs
> > modification.Currently twl_irq fw implements kind of "twl4030_irq_chip" 
> > which allows all the T2 drivers to get virtual interrupt numbers and can
> > make use of standard "request_irq" linux api.
> 
> You can still use virtual interrupt numbers.  All you're changing is
> _how_ you're handling the interrupts internally.
> 
> I'll see about creating a patch tomorrow.

And here it is - I've only build-tested it so far.

 drivers/mfd/twl4030-irq.c |   55 ++++++++++++++++++--------------------------
 1 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index bae61b2..4bb1ea7 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -180,15 +180,9 @@ static struct completion irq_event;
 static int twl4030_irq_thread(void *data)
 {
 	long irq = (long)data;
-	struct irq_desc *desc = irq_to_desc(irq);
 	static unsigned i2c_errors;
 	static const unsigned max_i2c_errors = 100;
 
-	if (!desc) {
-		pr_err("twl4030: Invalid IRQ: %ld\n", irq);
-		return -EINVAL;
-	}
-
 	current->flags |= PF_NOFREEZE;
 
 	while (!kthread_should_stop()) {
@@ -240,38 +234,25 @@ static int twl4030_irq_thread(void *data)
 		}
 		local_irq_enable();
 
-		desc->chip->unmask(irq);
+		enable_irq(irq);
 	}
 
 	return 0;
 }
 
 /*
- * handle_twl4030_pih() is the desc->handle method for the twl4030 interrupt.
- * This is a chained interrupt, so there is no desc->action method for it.
+ * handle_twl4030_pih() is the handler for the main twl4030 interrupt.
  * Now we need to query the interrupt controller in the twl4030 to determine
  * which module is generating the interrupt request.  However, we can't do i2c
  * transactions in interrupt context, so we must defer that work to a kernel
  * thread.  All we do here is acknowledge and mask the interrupt and wakeup
  * the kernel thread.
  */
-static void handle_twl4030_pih(unsigned int irq, struct irq_desc *desc)
-{
-	/* Acknowledge, clear *AND* mask the interrupt... */
-	desc->chip->ack(irq);
-	complete(&irq_event);
-}
-
-static struct task_struct *start_twl4030_irq_thread(long irq)
+static irqreturn_t handle_twl4030_pih(int irq, void *devid)
 {
-	struct task_struct *thread;
-
-	init_completion(&irq_event);
-	thread = kthread_run(twl4030_irq_thread, (void *)irq, "twl4030-irq");
-	if (!thread)
-		pr_err("twl4030: could not create irq %ld thread!\n", irq);
-
-	return thread;
+	disable_irq_nosync(irq);
+	complete(devid);
+	return IRQ_HANDLED;
 }
 
 /*----------------------------------------------------------------------*/
@@ -734,18 +715,28 @@ int twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 	}
 
 	/* install an irq handler to demultiplex the TWL4030 interrupt */
-	task = start_twl4030_irq_thread(irq_num);
-	if (!task) {
-		pr_err("twl4030: irq thread FAIL\n");
-		status = -ESRCH;
-		goto fail;
+	init_completion(&irq_event);
+
+	status = request_irq(irq_num, handle_twl4030_pih, IRQF_DISABLED,
+				"TWL4030-PIH", &irq_event);
+	if (status < 0) {
+		pr_err("twl4030: could not claim irq%d: %d\n", irq_num, status);
+		goto fail_rqirq;
 	}
 
-	set_irq_data(irq_num, task);
-	set_irq_chained_handler(irq_num, handle_twl4030_pih);
+	task = kthread_run(twl4030_irq_thread, (void *)irq_num, "twl4030-irq");
+	if (IS_ERR(task)) {
+		pr_err("twl4030: could not create irq %d thread!\n", irq_num);
+		status = PTR_ERR(task);
+		goto fail_kthread;
+	}
 
 	return status;
 
+fail_kthread:
+	free_irq(irq_num, &irq_event);
+fail_rqirq:
+	/* clean up twl4030_sih_setup */
 fail:
 	for (i = irq_base; i < irq_end; i++)
 		set_irq_chip_and_handler(i, NULL, NULL);
