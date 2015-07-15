From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] irqchip: omap-intc: improve IRQ handler
Date: Wed, 15 Jul 2015 01:15:42 -0700
Message-ID: <20150715064923.GA17550@atomide.com>
References: <1420224433-27001-1-git-send-email-balbi@ti.com>
 <20150119213458.GK18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150119213458.GK18552@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Felipe,

* Tony Lindgren <tony@atomide.com> [150119 13:41]:
> * Felipe Balbi <balbi@ti.com> [150102 10:50]:
> > as it turns out the current IRQ number will
> > *always* be available from SIR register which
> > renders the reads of PENDING registers as plain
> > unnecessary overhead.
> > 
> > In order to catch any situation where SIR reads
> > as zero, we're adding a WARN() to turn it into
> > a very verbose error and users actually report
> > it.
> > 
> > With this patch average running time of
> > omap_intc_handle_irq() reduced from about 28.5us
> > to 19.8us as measured by the kernel function
> > profiler.
> > 
> > Tested with BeagleBoneBlack Rev A5C.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> Jason, looks like this is not showing up in Linux next. The
> same for the changes I did for dm81xx.

Can you please resend this to Jason? Looks like this
is still not merged.

Regards,

Tony

> > Before applying, it would be very nice to get reports
> > from other folks on different platforms, specially OMAP2/3
> > ones which I don't have (easy) access.
> > 
> >  drivers/irqchip/irq-omap-intc.c | 35 +++++------------------------------
> >  1 file changed, 5 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
> > index 28718d3..a2da6d5 100644
> > --- a/drivers/irqchip/irq-omap-intc.c
> > +++ b/drivers/irqchip/irq-omap-intc.c
> > @@ -315,37 +315,12 @@ static int __init omap_init_irq(u32 base, struct device_node *node)
> >  static asmlinkage void __exception_irq_entry
> >  omap_intc_handle_irq(struct pt_regs *regs)
> >  {
> > -	u32 irqnr = 0;
> > -	int handled_irq = 0;
> > -	int i;
> > -
> > -	do {
> > -		for (i = 0; i < omap_nr_pending; i++) {
> > -			irqnr = intc_readl(INTC_PENDING_IRQ0 + (0x20 * i));
> > -			if (irqnr)
> > -				goto out;
> > -		}
> > -
> > -out:
> > -		if (!irqnr)
> > -			break;
> > -
> > -		irqnr = intc_readl(INTC_SIR);
> > -		irqnr &= ACTIVEIRQ_MASK;
> > +	u32 irqnr;
> >  
> > -		if (irqnr) {
> > -			handle_domain_irq(domain, irqnr, regs);
> > -			handled_irq = 1;
> > -		}
> > -	} while (irqnr);
> > -
> > -	/*
> > -	 * If an irq is masked or deasserted while active, we will
> > -	 * keep ending up here with no irq handled. So remove it from
> > -	 * the INTC with an ack.
> > -	 */
> > -	if (!handled_irq)
> > -		omap_ack_irq(NULL);
> > +	irqnr = intc_readl(INTC_SIR);
> > +	irqnr &= ACTIVEIRQ_MASK;
> > +	WARN(!irqnr, "Spuriour IRQ ?\n");
> > +	handle_domain_irq(domain, irqnr, regs);
> >  }
> >  
> >  void __init omap2_init_irq(void)
> > -- 
> > 2.2.0
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
