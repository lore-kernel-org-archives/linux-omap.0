From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH V3 3/3] mfd: palmas: Add support for optional wakeup
Date: Thu, 13 Nov 2014 11:03:14 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1411131053050.3935@nanos>
References: <1411067086-16613-1-git-send-email-nm@ti.com> <1411067086-16613-4-git-send-email-nm@ti.com> <alpine.DEB.2.10.1409181749170.4206@nanos> <20140919030333.GA6088@kahuna> <alpine.DEB.2.10.1409190710320.5612@nanos> <20140919161927.GA28613@kahuna>
 <alpine.DEB.2.10.1409191027330.5612@nanos> <20140919191649.GQ14505@atomide.com> <alpine.DEB.2.10.1409191233590.4213@nanos> <20141002034345.GH3122@atomide.com> <20141106204629.GF31454@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141106204629.GF31454-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Tony,

On Thu, 6 Nov 2014, Tony Lindgren wrote:
> 
> Any comments on the patch below? Let me know if you want to keep the
> devm stuff out of kernel/irq/manage.c.

Sorry, this slipped through the cracks.
 
> > +static int setup_wakeirq(struct device *dev, unsigned int wakeirq,
> > +			 unsigned long wakeflags, bool devm)
> > +{
> > +	int ret;
> > +
> > +	if (!(dev && wakeirq)) {
> > +		pr_err("Missing device or wakeirq for %s irq %d\n",
> > +		       dev_name(dev), wakeirq);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!(wakeflags &
> > +	      (IRQF_TRIGGER_LOW | IRQF_TRIGGER_HIGH | IRQF_ONESHOT))) {
> > +		pr_err("Invalid wakeirq for %s irq %d, must be level oneshot\n",
> > +		       dev_name(dev), wakeirq);

This looks odd.

Why do you want to enforce LEVEL and ONESHOT?  I can see the point for
ONESHOT, but I'm wondering about the requirement for level.

Now if you really want to enforce level AND oneshot, your check is
wrong as it will not trigger on

      wakeflags = IRQF_TRIGGER_LOW;
      wakeflags = IRQF_TRIGGER_HIGH;
      wakeflags = IRQF_ONESHOT;

Not what you really want, right?

> > +int request_wake_irq(struct device *dev, unsigned int wakeirq,
> > +		     unsigned long wakeflags)
> > +{
> > +	return setup_wakeirq(dev, wakeirq, wakeflags, false);
> > +}
> > +EXPORT_SYMBOL(request_wake_irq);

  _GPL please

> > +
> > +int devm_request_wake_irq(struct device *dev, unsigned int wakeirq,
> > +			  unsigned long wakeflags)
> > +{
> > +	return setup_wakeirq(dev, wakeirq, wakeflags, false);

Shouldnt that have devm = true?

Thanks,

	tglx
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
