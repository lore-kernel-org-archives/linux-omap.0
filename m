From: David Brownell <david-b@pacbell.net>
Subject: Re: Preempt-RT on OMAP3?
Date: Wed, 8 Apr 2009 15:21:01 -0700
Message-ID: <200904081521.02072.david-b@pacbell.net>
References: <5a7b8b7b0904052025g74325484h66335606bebea5a3@mail.gmail.com> <5a7b8b7b0904062119w42209eedp8645d096acb8c4dd@mail.gmail.com> <5a7b8b7b0904071822r52e910aat2454a63b0edadb69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ONS3JYb9mgVvhb0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:45793 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752466AbZDHWVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Apr 2009 18:21:09 -0400
In-Reply-To: <5a7b8b7b0904071822r52e910aat2454a63b0edadb69@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hugo Vincent <hugo.vincent@gmail.com>
Cc: linux-omap@vger.kernel.org

--Boundary-00=_ONS3JYb9mgVvhb0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 07 April 2009, Hugo Vincent wrote:
> > http://hugovincent.com/files/lkml-20090407/boot3.log
>
> Can anyone give me any pointers on where to start for fixing the
> problems shown in the above boot log?

You'll have to start finding out about all the funky rules
which apply to the -RT kernels, I think.

As a rule, getting drivers to work in RT kernels involves
some changes.  Not all of those changes can work in mainline
kernels.  Some of the changes are driver issues; while some
are changes in RT framework code.  Some are bugfixes.

There are a lot of reasons why not all the RT patches have
made it to mainline ...

 
> It looks like some fairly low level locking bugs (spinlock vs
> raw_spinlock maybe?) in twl4030 IRQ handling and GP timer/clock event
> source setup.

The first lockdep warning is about some IRQ dispatch code.

I happen to have the appended patches sitting around; they
might affect this particular problem (or might not).  I don't
know if they'd even apply to the RT kernel.

Alternatively, there's some odd rule about using workqueues
in the current RT code.  Like not being able to trigger them
from all the usual contexts.  If so, that seems buglike to me.

- Dave


--Boundary-00=_ONS3JYb9mgVvhb0
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="genirq-chipthread.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="genirq-chipthread.patch"

From: David Brownell <dbrownell@users.sourceforge.net>
Subject: GENIRQ: add handle_threaded_irq() flow handler

Define a new flow handler, handle_threaded_irq(), for IRQ threads
to use when chaining IRQs.

Unlike existing flow handlers, handle_simple_irq() and siblings,
this one is used only from sleep-capable contexts.  It always calls
irqaction handlers from that same (shared) sleep-capable context.

This is independent of Thomas' irq threading patchset, and can be
viewed as a complement to it.  This adds support for IRQs whose
handlers must *ONLY* ever run in thread contexts ... instead of
offloading code from hardirq context into a thread.  Another way
this differs is that it doesn't create more kernel threads; it
only leverages an existing thread.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 include/linux/irq.h |    7 ++++-
 kernel/irq/chip.c   |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 2 deletions(-)

--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -278,8 +278,8 @@ static inline int irq_balancing_disabled
 extern irqreturn_t handle_IRQ_event(unsigned int irq, struct irqaction *action);
 
 /*
- * Built-in IRQ handlers for various IRQ types,
- * callable via desc->chip->handle_irq()
+ * IRQ flow handlers for various IRQ types, callable via
+ * generic_handle_irq*() or desc->handle_irq()
  */
 extern void handle_level_irq(unsigned int irq, struct irq_desc *desc);
 extern void handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc);
@@ -288,6 +288,9 @@ extern void handle_simple_irq(unsigned i
 extern void handle_percpu_irq(unsigned int irq, struct irq_desc *desc);
 extern void handle_bad_irq(unsigned int irq, struct irq_desc *desc);
 
+/* Flow handler that must only be called from sleeping context */
+extern void handle_threaded_irq(unsigned int irq, struct irq_desc *desc);
+
 /*
  * Monolithic do_IRQ implementation.
  */
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -300,6 +300,67 @@ static inline void mask_ack_irq(struct i
 }
 
 /**
+ *	handle_threaded_irq - flow handler reusing current irq thread
+ *	@irq:	the interrupt number
+ *	@desc:	the interrupt description structure for this irq
+ *	Context: irq thread, with IRQs enabled
+ *
+ *	IRQ threads which demultiplex IRQs may use this flow handler
+ *	to chain those demultiplexed IRQs to subsidiary handlers, when
+ *	all that IRQ dispatch logic must run in sleeping contexts.
+ *
+ *	Examples include some multifunction I2C and SPI based devices
+ *	(where access to registers, including ones involved in IRQ
+ *	dispatching, requires sleeping) that have multiple independent
+ *	maskable interupts.
+ *
+ *	The irq thread using this flow handler must handle any ack,
+ *	clear, mask or unmask issues needed.
+ */
+void
+handle_threaded_irq(unsigned int irq, struct irq_desc *desc)
+{
+	struct irqaction *action;
+	irqreturn_t action_ret;
+
+	spin_lock_irq(&desc->lock);
+
+	if (unlikely(desc->status & IRQ_INPROGRESS))
+		goto out_unlock;
+	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
+	kstat_incr_irqs_this_cpu(irq, desc);
+
+	action = desc->action;
+	if (unlikely(!action || (desc->status & IRQ_DISABLED)))
+		goto out_unlock;
+
+	desc->status |= IRQ_INPROGRESS;
+	spin_unlock_irq(&desc->lock);
+
+	/* simplified handle_IRQ_event():  no random sampling;
+	 * IRQs are always enabled so action->handler may sleep;
+	 * no hooks for handing off to yet another irq thread.
+	 */
+	action_ret = IRQ_NONE;
+	do {
+		/* REVISIT can we get some explicit knowledge that this
+		 * handler expects to run in thread context?  Maybe an
+		 * IRQF_THREADED check, or a new handler type ...
+		 */
+		action_ret |= action->handler(irq, action->dev_id);
+		action = action->next;
+	} while (action);
+
+	if (!noirqdebug)
+		note_interrupt(irq, desc, action_ret);
+
+	spin_lock_irq(&desc->lock);
+	desc->status &= ~IRQ_INPROGRESS;
+out_unlock:
+	spin_unlock_irq(&desc->lock);
+}
+
+/**
  *	handle_simple_irq - Simple and software-decoded IRQs.
  *	@irq:	the interrupt number
  *	@desc:	the interrupt description structure for this irq

--Boundary-00=_ONS3JYb9mgVvhb0
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="genirq-twl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="genirq-twl.patch"

From: David Brownell <dbrownell@users.sourceforge.net>
Subject: twl4030: use new handle_threaded_irq() flow handler

Make the toplevel twl4030 irq dispatch code use the new 
handle_threaded_irq() flow handler.  Also, minor cleanup,
use the newish generic_handle_irq_desc().

Since that flow handler guarantees the IRQ handlers are
called only in a normal (sleeping) thread context, remove
some of the workarounds for the lockdep goofage whereby
it breaks various drivers by forcing IRQF_DISABLED on.
 
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/mfd/twl4030-irq.c     |   15 +++++----------
 drivers/rtc/rtc-twl4030.c     |    8 --------
 drivers/usb/otg/twl4030-usb.c |    8 --------
 3 files changed, 5 insertions(+), 26 deletions(-)

--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -215,7 +215,6 @@ static int twl4030_irq_thread(void *data
 		}
 
 		/* these handlers deal with the relevant SIH irq status */
-		local_irq_disable();
 		for (module_irq = twl4030_irq_base;
 				pih_isr;
 				pih_isr >>= 1, module_irq++) {
@@ -235,10 +234,9 @@ static int twl4030_irq_thread(void *data
 					note_interrupt(module_irq, d,
 							IRQ_NONE);
 				else
-					d->handle_irq(module_irq, d);
+					generic_handle_irq_desc(module_irq, d);
 			}
 		}
-		local_irq_enable();
 
 		desc->chip->unmask(irq);
 	}
@@ -578,7 +576,7 @@ static inline int sih_read_isr(const str
 }
 
 /*
- * Generic handler for SIH interrupts ... we "know" this is called
+ * Generic handler for SIH interrupts ... we know this is called
  * in task context, with IRQs enabled.
  */
 static void handle_twl4030_sih(unsigned irq, struct irq_desc *desc)
@@ -588,10 +586,7 @@ static void handle_twl4030_sih(unsigned 
 	int isr;
 
 	/* reading ISR acks the IRQs, using clear-on-read mode */
-	local_irq_enable();
 	isr = sih_read_isr(sih);
-	local_irq_disable();
-
 	if (isr < 0) {
 		pr_err("twl4030: %s SIH, read ISR error %d\n",
 			sih->name, isr);
@@ -658,7 +653,7 @@ int twl4030_sih_setup(int module)
 		irq = irq_base + i;
 
 		set_irq_chip_and_handler(irq, &twl4030_sih_irq_chip,
-				handle_edge_irq);
+				handle_threaded_irq);
 		set_irq_chip_data(irq, agent);
 		activate_irq(irq);
 	}
@@ -666,7 +661,7 @@ int twl4030_sih_setup(int module)
 	status = irq_base;
 	twl4030_irq_next += i;
 
-	/* replace generic PIH handler (handle_simple_irq) */
+	/* replace generic PIH handler (handle_threaded_irq) */
 	irq = sih_mod + twl4030_irq_base;
 	set_irq_data(irq, agent);
 	set_irq_chained_handler(irq, handle_twl4030_sih);
@@ -719,7 +714,7 @@ int twl_init_irq(int irq_num, unsigned i
 
 	for (i = irq_base; i < irq_end; i++) {
 		set_irq_chip_and_handler(i, &twl4030_irq_chip,
-				handle_simple_irq);
+				handle_threaded_irq);
 		activate_irq(i);
 	}
 	twl4030_irq_next = i;
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -325,14 +325,6 @@ static irqreturn_t twl4030_rtc_interrupt
 	int res;
 	u8 rd_reg;
 
-#ifdef CONFIG_LOCKDEP
-	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
-	 * we don't want and can't tolerate.  Although it might be
-	 * friendlier not to borrow this thread context...
-	 */
-	local_irq_enable();
-#endif
-
 	res = twl4030_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
 	if (res)
 		goto out;
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -576,14 +576,6 @@ static irqreturn_t twl4030_usb_irq(int i
 	struct twl4030_usb *twl = _twl;
 	int status;
 
-#ifdef CONFIG_LOCKDEP
-	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
-	 * we don't want and can't tolerate.  Although it might be
-	 * friendlier not to borrow this thread context...
-	 */
-	local_irq_enable();
-#endif
-
 	status = twl4030_usb_linkstat(twl);
 	if (status != USB_LINK_UNKNOWN) {
 

--Boundary-00=_ONS3JYb9mgVvhb0--
