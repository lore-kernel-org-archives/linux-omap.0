From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git 3/6] new sharable twl4030 SIH irq_chip
Date: Fri, 10 Oct 2008 14:21:22 -0700
Message-ID: <200810101421.22602.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:44645 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760054AbYJJV3v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 17:29:51 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Add TWL4030 infrastructure for shared SIH interrupts.

This is basically what the twl4030 GPIO IRQ code does, but
switching to a workqueue to handle each irqchip's mask/unmask
and set_type operations instead of a kthread that must figure
out what to do each time it wakes up.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/mfd/twl4030-core.c  |    2 
 drivers/mfd/twl4030-irq.c   |  322 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/i2c/twl4030.h |    2 
 3 files changed, 323 insertions(+), 3 deletions(-)

--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -757,8 +757,6 @@ twl4030_probe(struct i2c_client *client,
 		status = twl_init_irq(client->irq, pdata->irq_base, pdata->irq_end);
 		if (status < 0)
 			goto fail;
-		dev_info(&client->dev, "IRQ %d chains IRQs %d..%d\n",
-				client->irq, pdata->irq_base, pdata->irq_end - 1);
 	}
 
 	status = add_children(pdata);
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -366,6 +366,300 @@ static inline void activate_irq(int irq)
 #endif
 }
 
+/*----------------------------------------------------------------------*/
+
+static DEFINE_SPINLOCK(sih_agent_lock);
+
+static struct workqueue_struct *wq;
+
+struct sih_agent {
+	int			irq_base;
+	const struct sih	*sih;
+
+	u32			imr;
+	bool			imr_change_pending;
+	struct work_struct	mask_work;
+
+	u32			edge_change;
+	struct work_struct	edge_work;
+};
+
+static void twl4030_sih_do_mask(struct work_struct *work)
+{
+	struct sih_agent	*agent;
+	const struct sih	*sih;
+	union {
+		u8	bytes[4];
+		u32	word;
+	}			imr;
+	int			status;
+
+	agent = container_of(work, struct sih_agent, mask_work);
+
+	/* see what work we have */
+	spin_lock_irq(&sih_agent_lock);
+	if (agent->imr_change_pending) {
+		sih = agent->sih;
+		/* byte[0] gets overwritten as we write ... */
+		imr.word = cpu_to_le32(agent->imr << 8);
+		agent->imr_change_pending = false;
+	} else
+		sih = NULL;
+	spin_unlock_irq(&sih_agent_lock);
+	if (!sih)
+		return;
+
+	/* write the whole mask ... simpler than subsetting it */
+	status = twl4030_i2c_write(sih->module, imr.bytes,
+			sih->mask[irq_line].imr_offset, sih->bytes_ixr);
+	if (status)
+		pr_err("twl4030: %s, %s --> %d\n", __func__,
+				"write", status);
+}
+
+static void twl4030_sih_do_edge(struct work_struct *work)
+{
+	struct sih_agent	*agent;
+	const struct sih	*sih;
+	u8			bytes[6];
+	u32			edge_change;
+	int			status;
+
+	agent = container_of(work, struct sih_agent, edge_work);
+
+	/* see what work we have */
+	spin_lock_irq(&sih_agent_lock);
+	edge_change = agent->edge_change;
+	agent->edge_change = 0;;
+	sih = edge_change ? agent->sih : NULL;
+	spin_unlock_irq(&sih_agent_lock);
+	if (!sih)
+		return;
+
+	/* Read, reserving first byte for write scratch.  Yes, this
+	 * could be cached for some speedup ... but be careful about
+	 * any processor on the other IRQ line, EDR registers are
+	 * shared.
+	 */
+	status = twl4030_i2c_read(sih->module, bytes + 1,
+			sih->edr_offset, sih->bytes_edr);
+	if (status) {
+		pr_err("twl4030: %s, %s --> %d\n", __func__,
+				"read", status);
+		return;
+	}
+
+	/* Modify only the bits we know must change */
+	while (edge_change) {
+		int		i = fls(edge_change) - 1;
+		struct irq_desc	*d = irq_desc + i + agent->irq_base;
+		int		byte = 1 + (i >> 2);
+		int		off = (i & 0x3) * 2;
+
+		bytes[byte] &= ~(0x03 << off);
+
+		spin_lock_irq(&d->lock);
+		if (d->status & IRQ_TYPE_EDGE_RISING)
+			bytes[byte] |= BIT(off + 1);
+		if (d->status & IRQ_TYPE_EDGE_FALLING)
+			bytes[byte] |= BIT(off + 0);
+		spin_unlock_irq(&d->lock);
+
+		edge_change &= ~BIT(i);
+	}
+
+	/* Write */
+	status = twl4030_i2c_write(sih->module, bytes,
+			sih->edr_offset, sih->bytes_edr);
+	if (status)
+		pr_err("twl4030: %s, %s --> %d\n", __func__,
+				"write", status);
+}
+
+/*----------------------------------------------------------------------*/
+
+/*
+ * All irq_chip methods get issued from code holding irq_desc[irq].lock,
+ * which can't perform the underlying I2C operations (because they sleep).
+ * So we must hand them off to a thread (workqueue) and cope with asynch
+ * completion, potentially including some re-ordering, of these requests.
+ */
+
+static void twl4030_sih_mask(unsigned irq)
+{
+	struct sih_agent *sih = get_irq_chip_data(irq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sih_agent_lock, flags);
+	sih->imr |= BIT(irq - sih->irq_base);
+	sih->imr_change_pending = true;
+	queue_work(wq, &sih->mask_work);
+	spin_unlock_irqrestore(&sih_agent_lock, flags);
+}
+
+static void twl4030_sih_unmask(unsigned irq)
+{
+	struct sih_agent *sih = get_irq_chip_data(irq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sih_agent_lock, flags);
+	sih->imr &= ~BIT(irq - sih->irq_base);
+	sih->imr_change_pending = true;
+	queue_work(wq, &sih->mask_work);
+	spin_unlock_irqrestore(&sih_agent_lock, flags);
+}
+
+static int twl4030_sih_set_type(unsigned irq, unsigned trigger)
+{
+	struct sih_agent *sih = get_irq_chip_data(irq);
+	struct irq_desc *desc = irq_desc + irq;
+	unsigned long flags;
+
+	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
+		return -EINVAL;
+
+	spin_lock_irqsave(&sih_agent_lock, flags);
+	if ((desc->status & IRQ_TYPE_SENSE_MASK) != trigger) {
+		desc->status &= ~IRQ_TYPE_SENSE_MASK;
+		desc->status |= trigger;
+		sih->edge_change |= BIT(irq - sih->irq_base);
+		queue_work(wq, &sih->edge_work);
+	}
+	spin_unlock_irqrestore(&sih_agent_lock, flags);
+	return 0;
+}
+
+static struct irq_chip twl4030_sih_irq_chip = {
+	.name		= "twl4030",
+	.mask		= twl4030_sih_mask,
+	.unmask		= twl4030_sih_unmask,
+	.set_type	= twl4030_sih_set_type,
+};
+
+/*----------------------------------------------------------------------*/
+
+static inline int sih_read_isr(const struct sih *sih)
+{
+	int status;
+	union {
+		u8 bytes[4];
+		u32 word;
+	} isr;
+
+	/* FIXME need retry-on-error ... */
+
+	isr.word = 0;
+	status = twl4030_i2c_read(sih->module, isr.bytes,
+			sih->mask[irq_line].isr_offset, sih->bytes_ixr);
+
+	return (status < 0) ? status : le32_to_cpu(isr.word);
+}
+
+/*
+ * Generic handler for SIH interrupts ... we "know" this is called
+ * in task context, with IRQs enabled.
+ */
+static void handle_twl4030_sih(unsigned irq, struct irq_desc *desc)
+{
+	struct sih_agent *agent = get_irq_data(irq);
+	const struct sih *sih = agent->sih;
+	int isr;
+
+	/* reading ISR acks the IRQs, using clear-on-read mode */
+	local_irq_enable();
+	isr = sih_read_isr(sih);
+	local_irq_disable();
+
+	if (isr < 0) {
+		pr_err("twl4030: %s SIH, read ISR error %d\n",
+			sih->name, isr);
+		/* REVISIT:  recover; eventually mask it all, etc */
+		return;
+	}
+
+	while (isr) {
+		irq = fls(isr);
+		irq--;
+		isr &= ~BIT(irq);
+
+		if (irq < sih->bits)
+			generic_handle_irq(agent->irq_base + irq);
+		else
+			pr_err("twl4030: %s SIH, invalid ISR bit %d\n",
+				sih->name, irq);
+	}
+}
+
+static unsigned twl4030_irq_next;
+
+/* returns the first IRQ used by this SIH bank,
+ * or negative errno
+ */
+int twl4030_sih_setup(int module)
+{
+	int			sih_mod;
+	const struct sih	*sih = NULL;
+	struct sih_agent	*agent;
+	int			i, irq;
+	int			status = -EINVAL;
+	unsigned		irq_base = twl4030_irq_next;
+
+	/* only support modules with standard clear-on-read for now */
+	for (sih_mod = 0, sih = sih_modules;
+			sih_mod < ARRAY_SIZE(sih_modules);
+			sih_mod++, sih++) {
+		if (sih->module == module && sih->set_cor) {
+			if (!WARN((irq_base + sih->bits) > NR_IRQS,
+					"irq %d for %s too big\n",
+					irq_base + sih->bits,
+					sih->name))
+				status = 0;
+			break;
+		}
+	}
+	if (status < 0)
+		return status;
+
+	agent = kzalloc(sizeof *agent, GFP_KERNEL);
+	if (!agent)
+		return -ENOMEM;
+
+	status = 0;
+
+	agent->irq_base = irq_base;
+	agent->sih = sih;
+	agent->imr = ~0;
+	INIT_WORK(&agent->mask_work, twl4030_sih_do_mask);
+	INIT_WORK(&agent->edge_work, twl4030_sih_do_edge);
+
+	for (i = 0; i < sih->bits; i++) {
+		irq = irq_base + i;
+
+		set_irq_chip_and_handler(irq, &twl4030_sih_irq_chip,
+				handle_edge_irq);
+		set_irq_chip_data(irq, agent);
+		activate_irq(irq);
+	}
+
+	status = irq_base;
+	twl4030_irq_next += i;
+
+	/* replace generic PIH handler (handle_simple_irq) */
+	irq = sih_mod + twl4030_irq_base;
+	set_irq_data(irq, agent);
+	set_irq_chained_handler(irq, handle_twl4030_sih);
+
+	pr_info("twl4030: %s (irq %d) chaining IRQs %d..%d\n", sih->name,
+			irq, irq_base, twl4030_irq_next - 1);
+
+	return status;
+}
+
+/* FIXME need a call to reverse twl4030_sih_setup() ... */
+
+
+/*----------------------------------------------------------------------*/
+
 /* FIXME pass in which interrupt line we'll use ... */
 #define twl_irq_line	0
 
@@ -375,6 +669,7 @@ int twl_init_irq(int irq_num, unsigned i
 
 	int			status;
 	int			i;
+	struct task_struct	*task;
 
 	/*
 	 * Mask and clear all TWL4030 interrupts since initially we do
@@ -384,6 +679,12 @@ int twl_init_irq(int irq_num, unsigned i
 	if (status < 0)
 		return status;
 
+	wq = create_singlethread_workqueue("twl4030-irqchip");
+	if (!wq) {
+		pr_err("twl4030: workqueue FAIL\n");
+		return -ESRCH;
+	}
+
 	twl4030_irq_base = irq_base;
 
 	/* install an irq handler for each of the SIH modules;
@@ -392,17 +693,36 @@ int twl_init_irq(int irq_num, unsigned i
 	twl4030_irq_chip = dummy_irq_chip;
 	twl4030_irq_chip.name = "twl4030";
 
+	twl4030_sih_irq_chip.ack = dummy_irq_chip.ack;
+
 	for (i = irq_base; i < irq_end; i++) {
 		set_irq_chip_and_handler(i, &twl4030_irq_chip,
 				handle_simple_irq);
 		activate_irq(i);
 	}
+	twl4030_irq_next = i;
+	pr_info("twl4030: %s (irq %d) chaining IRQs %d..%d\n", "PIH",
+			irq_num, irq_base, twl4030_irq_next - 1);
 
 	/* install an irq handler to demultiplex the TWL4030 interrupt */
-	set_irq_data(irq_num, start_twl4030_irq_thread(irq_num));
+	task = start_twl4030_irq_thread(irq_num);
+	if (!task) {
+		pr_err("twl4030: irq thread FAIL\n");
+		status = -ESRCH;
+		goto fail;
+	}
+
+	set_irq_data(irq_num, task);
 	set_irq_chained_handler(irq_num, handle_twl4030_pih);
 
 	return status;
+
+fail:
+	for (i = irq_base; i < irq_end; i++)
+		set_irq_chip_and_handler(i, NULL, NULL);
+	destroy_workqueue(wq);
+	wq = NULL;
+	return status;
 }
 
 int twl_exit_irq(void)
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -277,6 +277,8 @@ struct twl4030_platform_data {
 
 /*----------------------------------------------------------------------*/
 
+int twl4030_sih_setup(int module);
+
 /*
  * FIXME completely stop using TWL4030_IRQ_BASE ... instead, pass the
  * IRQ data to subsidiary devices using platform device resources.
