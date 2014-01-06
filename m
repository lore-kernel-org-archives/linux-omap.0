From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: [RFC] drivers: irq-chip: Enable SGI's for Secure-to-NonSecure
 communication use-cases
Date: Mon, 6 Jan 2014 05:09:04 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EDAD1B8@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51218 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbaAFFJn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jan 2014 00:09:43 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>

Hi,

Currently the Software Generated Interrupts (SGI) are restricted to use only
for SMP architecture for inter-processor communication as rightly documented 
in ARM GIC spec V1.

In the system with the uniprocessor (and/or multiprocessor variants) architecture with 
TRUSTZONE enabled device (like, AM43xx device), the SGI can be used for 
communication between secure-to-nonsecure world.
And in order to enable SGI event from secure world to non-secure world,
GIC driver __must__ support registration of interrupt service routines for SGI's;
which is currently restricted by GIC driver.

The usecase is something like,

On any asynchronous HW or SW events, certain secure functionality gets triggered 
and SGI will be used to notify to the public world on the completion and/or result of operation.

Non Secure           |           Secure (TrustZone)
 (Linux Booted      |         (Secure software init happed 
   To prompt)         |          and trusted code getting executed)
                                |
    (On any secure operation Where we would
          like public world communication)
                                |
                                |         - Use SGI to trigger event to public Linux code
                                |         - And share the public info/data with public world for further processing
                          <=====      
  Public code         |
  handles it            |

In order to prototype and to make sure that it works, 
I did change the GIC driver to allow registration of SGI interrupts (interrupts 0 - 16) and 
tried it on AM43xx EVM and pasted the diff of the changes below.
I have also validated using SGI for secure to non-secure communication.

The idea behind this RFC (or rather query) is, to get feedback or 
comments on the use-case of using SGI for secure-to-nonsecure communication 
on non-SMP architecture or SMP architecture with uniprocessor.
I understand that, lot of things I need to take care from SMP architecture perspective. 
Based on the feedback I can spend more time to make below changes more generic to handle 
both uniprocessor and multi-processor architectures including more validation.

Also, please note that, this requires change in all the DT files using GIC interrupt controller.

Any pointers and suggestions are welcome here.

Thanks,
Vaibhav

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index d0e9480..135385a 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -290,7 +290,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
                irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
                irqnr = irqstat & ~0x1c00;

-               if (likely(irqnr > 15 && irqnr < 1021)) {
+               if (likely(irqnr >= 0 && irqnr < 1021)) {
                        irqnr = irq_find_mapping(gic->domain, irqnr);
                        handle_IRQ(irqnr, regs);
                        continue;
@@ -324,7 +324,7 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
                goto out;

        cascade_irq = irq_find_mapping(chip_data->domain, gic_irq);
-       if (unlikely(gic_irq < 32 || gic_irq > 1020))
+       if (unlikely(gic_irq > 1020))
                handle_bad_irq(cascade_irq, desc);
        else
                generic_handle_irq(cascade_irq);
@@ -395,20 +395,20 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
        cpumask = gic_get_cpumask(gic);
        cpumask |= cpumask << 8;
        cpumask |= cpumask << 16;
-       for (i = 32; i < gic_irqs; i += 4)
+       for (i = 0; i < gic_irqs; i += 4)
                writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);

        /*
         * Set priority on all global interrupts.
         */
-       for (i = 32; i < gic_irqs; i += 4)
+       for (i = 0; i < gic_irqs; i += 4)
                writel_relaxed(0xa0a0a0a0, base + GIC_DIST_PRI + i * 4 / 4);

        /*
         * Disable all interrupts.  Leave the PPI and SGIs alone
         * as these enables are banked registers.
         */
-       for (i = 32; i < gic_irqs; i += 32)
+       for (i = 0; i < gic_irqs; i += 32)
                writel_relaxed(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);

        writel_relaxed(1, base + GIC_DIST_CTRL);
@@ -672,7 +672,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
                                irq_hw_number_t hw)
 {
-       if (hw < 32) {
+       if (hw < 0) {
                irq_set_percpu_devid(irq);
                irq_set_chip_and_handler(irq, &gic_chip,
                                         handle_percpu_devid_irq);
@@ -696,8 +696,11 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
			if (intsize < 3)
                return -EINVAL;

-        /* Get the interrupt number and add 16 to skip over SGIs */
-       *out_hwirq = intspec[1] + 16;
-
-       /* For SPIs, we need to add 16 more to get the GIC irq ID number */
-       if (!intspec[0])
-               *out_hwirq += 16;
-
+       *out_hwirq = intspec[1];
        *out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
        return 0;
 }
@@ -785,11 +780,11 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
         * For secondary GICs, skip over PPIs, too.
         */
        if (gic_nr == 0 && (irq_start & 31) > 0) {
-               hwirq_base = 16;
+               hwirq_base = 0;
                if (irq_start != -1)
                        irq_start = (irq_start & ~31) + 16;
        } else {
-               hwirq_base = 32;
+               hwirq_base = 0;
        }

        /*
@@ -803,7 +798,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
        gic->gic_irqs = gic_irqs;

        gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
-       irq_base = irq_alloc_descs(irq_start, 16, gic_irqs, numa_node_id());
+       irq_base = irq_alloc_descs(irq_start, 0, gic_irqs, numa_node_id());
        if (IS_ERR_VALUE(irq_base)) {
                WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
                     irq_start);

