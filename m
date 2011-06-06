From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 4/4] mfd: global Suspend and resume support of ehci and
 ohci
Date: Mon, 6 Jun 2011 12:06:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106061141130.1953-100000@iolanthe.rowland.org>
References: <20110605195413.GC18731@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110605195413.GC18731-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, 5 Jun 2011, Felipe Balbi wrote:

> Hi,
> 
> On Sun, Jun 05, 2011 at 03:30:55PM -0400, Alan Stern wrote:
> > > > > good point. BTW, do we need this #ifdef CONFIG_PM stuff which has been
> > > > > popping on most drivers recently ? To me it looks like driver.pm field
> > > > > is always available even if PM is disabled, so what's the point ? Saving
> > > > > a few bytes ?
> > > > 
> > > > Basically, yes (you may want to avoid defining the object this points to if
> > > > CONFIG_PM is unset).
> > > 
> > > wouldn't it look nicer to have a specific section for dev_pm_ops which
> > > gets automatically freed if CONFIG_PM isn't set ? I mean, there are a
> > > few drivers which don't have the ifdeferry around dev_pm_ops anyway.
> > > 
> > > So, something like:
> > > 
> > > #define __pm_ops	__section(.pm.ops)
> > > 
> > > static const struct dev_pm_ops my_driver_pm_ops __pm_ops = {
> > > 	.suspend	= my_driver_suspend,
> > > 	.resume		= my_driver_resume,
> > > 	[ blablabla ]
> > > };
> > > 
> > > to simplify things, you could:
> > > 
> > > #define DEFINE_DEV_PM_OPS(_ops)		\
> > > 	const struct dev_pm_ops _ops __pm_ops
> > > 
> > > that would mean changes to all linker scripts, though and a utility call
> > > that only does anything ifndef CONFIG_PM to free the .pm.ops section.
> > 
> > In my opinion this would make programming harder, not easier.  It's
> 
> I tend to disagree with this statement, see below.
> 
> > very easy to understand "#ifdef" followed by "#endif"; people see them
> 
> very true... Still everybody has to put them in place.

True.  But with your suggestion, people have to remember to use 
__pm_ops and DEFINE_DEV_PM_OPS.

> > all the time.  The new tags you propose would force people to go
> > searching through tons of source files to see what they mean, and then
> 
> only those who want to see "how things work" would be forced to do that,
> other people would be allowed to "assume it's doing the right thing".

But what is the "right thing"?  Suppose you want to have conditional 
support for dev_pm_ops whenever CONFIG_PM is enabled and you _also_ 
want to have conditional support for runtime PM whenever 
CONFIG_PM_RUNTIME is enabled?

> > readers would still have to figure out when these tags should be used
> > or what advantage they might bring.
> 
> not really, if you add a macro which adds that correctly and during
> review we only accept drivers using that particular macro, things
> wouldn't go bad at all.
> 
> > It's a little like "typedef struct foo foo_t;" -- doing this forces
> 
> hey c'mon. Then you're saying that all __initdata, __devinitdata,
> __initconst and all of those are "typedef struct foo foo_t" ;-)

No.  Unlike foo_t, they don't obscure important information and they do 
provide a significant gain in simplicity.  On the other hand, they also 
provide a certain degree of confusion.  Remember all the difficulty we 
had with intialization code sections in the gadget framework.

> > people to remember one extra piece of information that serves no real
> > purpose except perhaps a minimal reduction in the amount of typing.  
> 
> and a guarantee that the unused data will be freed when it's really not
> needed ;-)

You can obtain that same guarantee by using #ifdef ... #endif.  Even 
better, you can guarantee that the unused data won't be present at all, 
as opposed to loaded and then freed.

> > Since the limiting factor in kernel programming is human brainpower,
> > not source file length, this is a bad tradeoff.  (Not to mention that
> 
> OTOH we are going through a big re-factor of the ARM port to reduce the
> amount of code. Not that these few characters would change much but my
> point is that amount of code also matters. So does uniformity, coding
> style, etc...
> 
> > it also obscures an important fact: A foo_t is an extended structure
> > rather than a single value.)
> 
> then it would make sense to have dev_pm_ops only defined when CONFIG_PM
> is set to force all drivers stick to a common way of handling this.
> 
> Besides, currently, everybody who wants to keep the ifdeferry, needs to
> define a macro for &my_dev_pm_ops or have two #ifdef..#endif blocks.
> 
> Either you do:
> 
> #ifdef CONFIG_PM
> static int my_driver_suspend(struct device *dev)
> {
> 	...
> 
> 	return 0;
> }
> ....
> 
> static const struct dev_pm_ops my_driver_pm_ops = {
> 	.suspend	= my_driver_suspend,
> 	...
> };
> 
> #define DEV_PM_OPS	(&my_driver_pm_ops)
> #else
> #define DEV_PM_OPS	NULL
> #endif
> 
> static struct platform_driver my_driver = {
> 	...
> 	.driver	= {
> 		.pm = DEV_PM_OPS
> 	},
> };
> 
> or you do:
> 
> #ifdef CONFIG_PM
> static int my_driver_suspend(struct device *dev)
> {
> 	...
> 
> 	return 0;
> }
> ....
> 
> static const struct dev_pm_ops my_driver_pm_ops = {
> 	.suspend	= my_driver_suspend,
> 	...
> };
> 
> #endif
> 
> static struct platform_driver my_driver = {
> 	...
> 	.driver	= {
> #ifdef CONFIG_PM
> 		.pm = &my_driver_pm_ops,
> #endif
> 	},
> };

Whereas your way people write:

static int __pm_ops my_driver_suspend(struct device *dev)
{
	...

	return 0;
}
....

static DEFINE_DEV_PM_OPS(my_driver_pm_ops) = {
	.suspend	= my_driver_suspend,
	...
};

static struct platform_driver my_driver = {
	...
	.driver	= {
		.pm = &my_driver_pm_ops,
	},
};

It doesn't seem like a good idea to keep the invalid pointer to 
my_driver_pm_ops, even though it should never get used.

An approach that might work better would be for the PM core to define a 
suitable macro:

#ifdef CONFIG_PM
	#define DEV_PM_OPS_REF(my_pm_ops)	&(my_pm_ops)
#else
	#define DEV_PM_OPS_REF(my_pm_ops)	NULL
#endif

Then people could write

static struct platform_driver my_driver = {
	...
	.driver	= {
		.pm = DEV_PM_OPS_REF(my_driver_pm_ops),
	},
};

without worrying about whether or not my_driver_pm_ops was defined.  
And only one #ifdef block would be needed.

> So, while this is a small thing which is easy to understand, it's still
> yet another thing that all drivers have to remember to add. And when
> everybody needs to remember that, I'd rather have it done
> "automatically" by other means.
> 
> I mean, we already free .init.* sections after __init anyway, so what's
> the problem in freeing another section ? I don't see it as obfuscation
> at all. I see it as if the kernel is smart enough to free all unused
> data by itself, without myself having to add ifdefs or freeing it by my
> own.
> 
> On top of all that, today, we have driver with both ways of ifdefs plus
> drivers with no ifdeferry at all, leaving dev_pm_ops floating around for
> nothing.
> 
> IMHO, if things aren't uniform, we will have small problems, such as
> this, proliferate because new drivers are based on other drivers,
> generally.

I have to agree that uniformity is to be desired.  And it's probably 
already way too late, because we can't prevent new drivers from being 
based on the existing drivers -- even if all the existing drivers get 
changed over (which seems unlikely).

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
