From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Thu, 14 May 2015 08:59:46 -0700
Message-ID: <20150514155945.GL15563@atomide.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <1431560196-5722-3-git-send-email-tony@atomide.com>
 <20150514020634.GB20006@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150514020634.GB20006@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [150513 19:09]:
> On Wed, May 13, 2015 at 04:36:33PM -0700, Tony Lindgren wrote:
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -85,6 +85,7 @@ config ARCH_OMAP2PLUS
> >  	select OMAP_DM_TIMER
> >  	select OMAP_GPMC
> >  	select PINCTRL
> > +	select PM_WAKEIRQ if PM_SLEEP
> >  	select SOC_BUS
> >  	select TI_PRIV_EDMA
> >  	select OMAP_IRQCHIP
> 
> seems like enabling this for OMAP should be a patch of its own.

Sure if people prefer that.
 
> > --- /dev/null
> > +++ b/drivers/base/power/wakeirq.c
> > +
> > +err_unlock:
> > +	spin_unlock_irqrestore(&dev->power.lock, flags);
> > +err_free_mem:
> 
> minor nit, there's no memory being freed here :-)

Will fix.
 
> > +void dev_pm_clear_wake_irq(struct device *dev)
> > +{
> > +	struct wake_irq *wirq = dev->power.wakeirq;
> > +	unsigned long flags;
> > +
> > +	if (!wirq)
> 
> WARN() to catch bad users ? Maybe with unlikely() around to give
> compiler a hint that this is likely not going to happen ?

Sure.
 
> > +static irqreturn_t handle_threaded_wakeirq(int wakeirq, void *_wirq)
> > +{
> > +	struct wake_irq *wirq = _wirq;
> > +	irqreturn_t ret = IRQ_NONE;
> > +
> > +	if (!pm_runtime_suspended(wirq->dev))
> 
> should you WARN() here ? Why would this IRQ fire if we're not
> pm_runtime_suspended() ?

Hmm or we could just leave it out. I had it initially to test
things with the wake-up interrupt enabled during runtime also.
 
> > +int dev_pm_request_wake_irq(struct device *dev,
> > +			    int irq,
> > +			    irq_handler_t handler,
> > +			    unsigned long irqflags,
> > +			    void *data)
> > +{
> > +	struct wake_irq *wirq;
> > +	int err;
> > +
> > +	wirq = devm_kzalloc(dev, sizeof(*wirq), GFP_KERNEL);
> > +	if (!wirq)
> > +		return -ENOMEM;
> > +
> > +	wirq->dev = dev;
> > +	wirq->irq = irq;
> > +	wirq->handler = handler;
> 
> you need to make sure that IRQF_ONESHOT is set in cases where handler is
> NULL. Either set it by default:
> 
> 	if (!handler)
> 		irqflags |= IRQF_ONESHOT;
> 
> or WARN() about it:
> 
> 	WARN_ON((!handler && !(irqflags & IRQF_ONESHOT));
> 
> Actually, after reading more of the code, you have some weird circular
> call chain going on here. If handler is a valid function pointer, you
> use as primary handler, so IRQ core will call it from hardirq context.
> But you also save that pointer as wirq->handler, and call that from
> within handle_threaded_wakeirq(). Essentially, handler() is called
> twice, once with IRQs disabled, one with IRQs (potentially) enabled.
> 
> What did you have in mind for handler() anyway, it seems completely
> unnecessary.

Yeah.. Let's just leave it out. You already mentioned it earlier and
there's no use for it.

The device driver can deal with the situation anyways in runtime resume.

And like you said, it must be IRQF_ONESHOT, now there's a chance of
consumer drivers passing other flags too.

The the IO wake-up interrupt vs dedicated wake-up interrupt functions
can be just something like:

int dev_pm_request_wake_irq(struct device *dev, int irq);
int dev_pm_request_wake_irq_managed(struct device *dev, int irq);
 
> > +void dev_pm_free_wake_irq(struct device *dev)
> > +{
> > +	struct wake_irq *wirq = dev->power.wakeirq;
> > +	unsigned long flags;
> > +
> > +	if (!wirq)
> > +		return;
> > +
> > +	spin_lock_irqsave(&dev->power.lock, flags);
> > +	wirq->manage_irq = false;
> > +	spin_unlock_irqrestore(&dev->power.lock, flags);
> > +	devm_free_irq(wirq->dev, wirq->irq, wirq);
> 
> this seems unnecessary, the IRQ will be freed anyway when the device
> kobj is destroyed, dev_pm_clear_wake_irq() seems important, however.
> 
> > +	dev_pm_clear_wake_irq(dev);
> > +}

The life cycle of the request and free of the wake irq is not the
same as the life cycle of the device driver. For example, serial
drivers can request interrupts on startup and free them on shutdown.

> > +void dev_pm_enable_wake_irq(struct device *dev)
> > +{
> > +	struct wake_irq *wirq = dev->power.wakeirq;
> > +
> > +	if (wirq && wirq->manage_irq)
> > +		enable_irq(wirq->irq);
> > +}
> > +EXPORT_SYMBOL_GPL(dev_pm_enable_wake_irq);
> 
> you probably want to enable dev_pm_enable_wake_irq() automatically for
> from rpm_suspend(). According to runtime_pm documentation, wakeup should
> always be enabled for runtime suspended devices. I didn't really look
> through the whole thing yet to know if you did call it or not.

Yes I think we can also automate that part, I've been playing with an
additional patch doing that for pm runtime. Been still thinking if
there's any need to manage that in the consomer driver, I guess not.
 
> > +void dev_pm_disable_wake_irq(struct device *dev)
> > +{
> > +	struct wake_irq *wirq = dev->power.wakeirq;
> > +
> > +	if (wirq && wirq->manage_irq)
> > +		disable_irq_nosync(wirq->irq);
> > +}
> > +EXPORT_SYMBOL_GPL(dev_pm_disable_wake_irq);
> 
> likewise, call this automatically from rpm_resume().

Right.
 
> This brings up a question, actually. What to do with devices which were
> already runtime suspended when user initiated suspend-to-ram ? Do we
> leave wakeups enabled, or do we revisit device_may_wakeup() and
> conditionally runtime_resume the device, disable wakeup, and let its
> ->suspend() callback be called ?

I believe that's already handled properly, but implemented in each
consumer driver with the if device_may_wakeup enabled_irq_wake.

Regards,

Tony
