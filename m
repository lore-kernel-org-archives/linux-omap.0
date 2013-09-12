From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] DRIVERS: IRQCHIP: Add crossbar irqchip driver
Date: Fri, 13 Sep 2013 00:12:24 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1309130010110.4089@ionos.tec.linutronix.de>
References: <1379000351-15672-1-git-send-email-r.sricharan@ti.com> <1379000351-15672-2-git-send-email-r.sricharan@ti.com> <20130912205417.GA539@radagast> <alpine.DEB.2.02.1309122334370.4089@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1309122334370.4089-3cz04HxQygjZikZi3RtOZ1XZhhPuCNm+@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 12 Sep 2013, Thomas Gleixner wrote:

> On Thu, 12 Sep 2013, Felipe Balbi wrote:
> 
> > On Thu, Sep 12, 2013 at 09:09:08PM +0530, Sricharan R wrote:
> > > +unsigned int crossbar_request_irq(struct irq_data *d)
> > > +{
> > > +	int cb_no = d->hwirq;
> > > +	int virq = allocate_free_irq(cb_no);
> > > +	void *irq = &cb->crossbar_map[cb_no].hwirq;
> > > +	int err;
> > > +
> > > +	err = request_threaded_irq(virq, crossbar_irq, NULL,
> > > +				   0, "CROSSBAR", irq);
> > 
> > this is wrong, why don't you just set crossbar up as a chained handler.
> 
> That's just a detail, which does not solve the underlying problem of
> the crossbar -> GIC mapping.

And actually the thing is the other way round:

GIC distributes to crossbar, so the underlying GIC irq would be the
chained handler.

Still does not solve the setup/request_irq issue.

Thanks,

	tglx
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
