From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/4] DRIVERS: IRQCHIP: Add crossbar irqchip driver
Date: Thu, 12 Sep 2013 23:35:32 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1309122334370.4089@ionos.tec.linutronix.de>
References: <1379000351-15672-1-git-send-email-r.sricharan@ti.com> <1379000351-15672-2-git-send-email-r.sricharan@ti.com> <20130912205417.GA539@radagast>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130912205417.GA539@radagast>
Sender: linux-doc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sricharan R <r.sricharan@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, 12 Sep 2013, Felipe Balbi wrote:

> On Thu, Sep 12, 2013 at 09:09:08PM +0530, Sricharan R wrote:
> > +unsigned int crossbar_request_irq(struct irq_data *d)
> > +{
> > +	int cb_no = d->hwirq;
> > +	int virq = allocate_free_irq(cb_no);
> > +	void *irq = &cb->crossbar_map[cb_no].hwirq;
> > +	int err;
> > +
> > +	err = request_threaded_irq(virq, crossbar_irq, NULL,
> > +				   0, "CROSSBAR", irq);
> 
> this is wrong, why don't you just set crossbar up as a chained handler.

That's just a detail, which does not solve the underlying problem of
the crossbar -> GIC mapping.

Thanks,

	tglx
