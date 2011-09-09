From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
 gic_arch_extn
Date: Fri, 9 Sep 2011 09:19:33 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109090912130.2723@ionos>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com> <878vpyhotu.fsf@ti.com> <4E69961D.40700@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38409 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757431Ab1IIHTf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 03:19:35 -0400
In-Reply-To: <4E69961D.40700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

On Fri, 9 Sep 2011, Santosh wrote:

> On Thursday 08 September 2011 11:57 PM, Kevin Hilman wrote:
> > Santosh Shilimkar<santosh.shilimkar@ti.com>  writes:
> > 
> > > OMAP WakeupGen is the interrupt controller extension used along
> > > with ARM GIC to wake the CPU out from low power states on
> > > external interrupts.
> > > 
> > > The WakeupGen unit is responsible for generating wakeup event
> > > from the incoming interrupts and enable bits. It is implemented
> > > in MPU always ON power domain. During normal operation,
> > > WakeupGen delivers external interrupts directly to the GIC.
> > > 
> > > Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> > > Cc: Kevin Hilman<khilman@ti.com>
> > 
> > [...]
> > 
> > > +#ifdef CONFIG_PM
> > > +/*
> > > + * Masking wakeup irqs is handled by the IRQCHIP_MASK_ON_SUSPEND flag,
> > > + * so no action is necessary in set_wake, but implement an empty handler
> > > + * here to prevent enable_irq_wake() returning an error.
> > > + * FIXME: Remove the dummy handler once gen irq code fix above.
> > > + */
> > 
> > Just curious... is there a fix for this pending for v3.2?
> > 
> I have sent a proposed change to Thomas but have not seen
> any response yet from him.
> 
> http://www.spinics.net/lists/arm-kernel/msg134297.html

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 0a7840a..cd4bc01 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c

@@ -467,6 +467,9 @@ static int set_irq_wake_real(unsigned int irq, unsigned int on)

   struct irq_desc *desc = irq_to_desc(irq);
   int ret = -ENXIO;

+  if (irq_desc_get_chip(desc)->flags & IRQCHIP_MASK_ON_SUSPEND)
+     return 0;
+
	if (desc->irq_data.chip->irq_set_wake)
 	   ret = desc->irq_data.chip->irq_set_wake(&desc->irq_data, on);

The flag says: MASK ON SUSPEND and it does not imply that you don't
need a wake function. There might be cases where you want to setup
stuff in that function in order to have the wakeup happen on that
interrupt line despite of the mask on suspend.

We either need a separate flag or a global dummy set_wake function in
the core to avoid empty copies all over the place.

Thanks,

	tglx
