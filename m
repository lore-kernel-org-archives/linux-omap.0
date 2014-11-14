From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V3 3/3] mfd: palmas: Add support for optional wakeup
Date: Fri, 14 Nov 2014 09:08:17 -0800
Message-ID: <20141114170816.GW26481@atomide.com>
References: <alpine.DEB.2.10.1409190710320.5612@nanos>
 <20140919161927.GA28613@kahuna>
 <alpine.DEB.2.10.1409191027330.5612@nanos>
 <20140919191649.GQ14505@atomide.com>
 <alpine.DEB.2.10.1409191233590.4213@nanos>
 <20141002034345.GH3122@atomide.com>
 <20141106204629.GF31454@atomide.com>
 <alpine.DEB.2.11.1411131053050.3935@nanos>
 <20141113174030.GM26481@atomide.com>
 <20141114161901.GG11538@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141114161901.GG11538@saruman>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [141114 08:20]:
> On Thu, Nov 13, 2014 at 09:40:31AM -0800, Tony Lindgren wrote:
> > +/**
> > + *	handle_wakeirq_thread - call device runtime pm calls on wake-up interrupt
> > + *	@wakeirq: device specific wake-up interrupt
> > + *	@dev_id: struct device entry
> > + */
> > +irqreturn_t handle_wakeirq_thread(int wakeirq, void *dev_id)
> > +{
> > +	struct device *dev = dev_id;
> > +	irqreturn_t ret = IRQ_NONE;
> > +
> > +	if (pm_runtime_suspended(dev)) {
> > +		pm_runtime_mark_last_busy(dev);
> > +		pm_request_resume(dev);
> 
> this assumes that every driver's ->resume() callback has a:
> 
> 	if (pending)
> 		handle_pending_irqs();
> 
> which might not be very nice. I'd rather follow what Thomas suggested
> and always pass device irq so this can mark it pending. Keep in mind
> that we *don't* need a pm_runtime_get_sync() in every IRQ handler
> because of that. Adding it is but the easiest way to get things working
> and, quite frankly, very silly.
> 
> what we want is rather:
> 
> 	irqreturn_t my_handler(int irq, void *dev_id)
> 	{
> 		struct device *dev = dev_id;
> 
> 		if (pm_runtime_suspended(dev)) {
> 			pending_irqs_to_be_handled_from_runtime_resume = true;
> 			pm_runtime_get(dev);
> 			clear_irq_source(dev);
> 			return IRQ_HANDLED;
> 		}
> 	}
> 
> or something similar.

Yeah I'll take a look.
 
> > +		ret = IRQ_HANDLED;
> > +	}
> 
> you're not masking the wake irq here which means that when this handler
> returns, wake irq will be unmasked by core IRQ subsystem leaving it
> unmasked after ->resume().

It currently assumes the consumer driver takes care of it. But I get
your point, we should be able to automate this further.

And right now there's also a dependency on dev->power.irq_safe so
RPM_ASYNC is not set. And this all should ideally work even with runtime
PM not set as it's also needed for resume from suspend.
 
> you *know* you'll pass a NULL top half handler, why don't you just force
> IRQF_ONESHOT instead of erroring out ? Just add:
> 
> 	wakeflags |= IRQF_ONESHOT;
> 
> and get it over with :-)

Good point :)
 
Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
