From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Thu, 14 May 2015 09:28:23 -0700
Message-ID: <20150514162822.GM15563@atomide.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <1431560196-5722-3-git-send-email-tony@atomide.com>
 <20150514020634.GB20006@saruman.tx.rr.com>
 <20150514155945.GL15563@atomide.com>
 <20150514160902.GF24269@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150514160902.GF24269@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [150514 09:12]:
> On Thu, May 14, 2015 at 08:59:46AM -0700, Tony Lindgren wrote:
> > > > +int dev_pm_request_wake_irq(struct device *dev,
> > > > +			    int irq,
> > > > +			    irq_handler_t handler,
> > > > +			    unsigned long irqflags,
> > > > +			    void *data)
> > > > +{
> > > > +	struct wake_irq *wirq;
> > > > +	int err;
> > > > +
> > > > +	wirq = devm_kzalloc(dev, sizeof(*wirq), GFP_KERNEL);
> > > > +	if (!wirq)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	wirq->dev = dev;
> > > > +	wirq->irq = irq;
> > > > +	wirq->handler = handler;
> > > 
> > > you need to make sure that IRQF_ONESHOT is set in cases where handler is
> > > NULL. Either set it by default:
> > > 
> > > 	if (!handler)
> > > 		irqflags |= IRQF_ONESHOT;
> > > 
> > > or WARN() about it:
> > > 
> > > 	WARN_ON((!handler && !(irqflags & IRQF_ONESHOT));
> > > 
> > > Actually, after reading more of the code, you have some weird circular
> > > call chain going on here. If handler is a valid function pointer, you
> > > use as primary handler, so IRQ core will call it from hardirq context.
> > > But you also save that pointer as wirq->handler, and call that from
> > > within handle_threaded_wakeirq(). Essentially, handler() is called
> > > twice, once with IRQs disabled, one with IRQs (potentially) enabled.
> > > 
> > > What did you have in mind for handler() anyway, it seems completely
> > > unnecessary.
> > 
> > Yeah.. Let's just leave it out. You already mentioned it earlier and
> > there's no use for it.
> > 
> > The device driver can deal with the situation anyways in runtime resume.
> > 
> > And like you said, it must be IRQF_ONESHOT, now there's a chance of
> > consumer drivers passing other flags too.
> > 
> > The the IO wake-up interrupt vs dedicated wake-up interrupt functions
> > can be just something like:
> > 
> > int dev_pm_request_wake_irq(struct device *dev, int irq);
> 
> right, then it's always IRQF_ONESHOT and always threaded.

Yes threaded is just fine here at least for the cases I've seen.

PM runtime resume may need to bring up regulators, clocks and restore
the driver context etc.
 
> > int dev_pm_request_wake_irq_managed(struct device *dev, int irq);
> 
> I don't get this. Would this request with devm_ while the former
> wouldn't use devm_ ?

Typo :) Both can be devm no problem.
 
> > > > +void dev_pm_free_wake_irq(struct device *dev)
> > > > +{
> > > > +	struct wake_irq *wirq = dev->power.wakeirq;
> > > > +	unsigned long flags;
> > > > +
> > > > +	if (!wirq)
> > > > +		return;
> > > > +
> > > > +	spin_lock_irqsave(&dev->power.lock, flags);
> > > > +	wirq->manage_irq = false;
> > > > +	spin_unlock_irqrestore(&dev->power.lock, flags);
> > > > +	devm_free_irq(wirq->dev, wirq->irq, wirq);
> > > 
> > > this seems unnecessary, the IRQ will be freed anyway when the device
> > > kobj is destroyed, dev_pm_clear_wake_irq() seems important, however.
> > > 
> > > > +	dev_pm_clear_wake_irq(dev);
> > > > +}
> > 
> > The life cycle of the request and free of the wake irq is not the
> > same as the life cycle of the device driver. For example, serial
> > drivers can request interrupts on startup and free them on shutdown.
> 
> fair enough, but then we start to consider the benefits of using
> devm_ IRQ :-)

Hmm probably the extra checks do not hurt there either.
 
> > > > +void dev_pm_disable_wake_irq(struct device *dev)
> > > > +{
> > > > +	struct wake_irq *wirq = dev->power.wakeirq;
> > > > +
> > > > +	if (wirq && wirq->manage_irq)
> > > > +		disable_irq_nosync(wirq->irq);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dev_pm_disable_wake_irq);
> > > 
> > > likewise, call this automatically from rpm_resume().
> > 
> > Right.
> >  
> > > This brings up a question, actually. What to do with devices which were
> > > already runtime suspended when user initiated suspend-to-ram ? Do we
> > > leave wakeups enabled, or do we revisit device_may_wakeup() and
> > > conditionally runtime_resume the device, disable wakeup, and let its
> > > ->suspend() callback be called ?
> > 
> > I believe that's already handled properly, but implemented in each
> > consumer driver with the if device_may_wakeup enabled_irq_wake.
> 
> I see, but perhaps even that can be partially automated at some point
> :-)

Yeah it seems we might be able to eventually.

Regards,

Tony
