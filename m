From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH V3 3/3] mfd: palmas: Add support for optional wakeup
Date: Thu, 13 Nov 2014 23:25:28 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1411132251170.3935@nanos>
References: <alpine.DEB.2.10.1409181749170.4206@nanos> <20140919030333.GA6088@kahuna> <alpine.DEB.2.10.1409190710320.5612@nanos> <20140919161927.GA28613@kahuna> <alpine.DEB.2.10.1409191027330.5612@nanos> <20140919191649.GQ14505@atomide.com>
 <alpine.DEB.2.10.1409191233590.4213@nanos> <20141002034345.GH3122@atomide.com> <20141106204629.GF31454@atomide.com> <alpine.DEB.2.11.1411131053050.3935@nanos> <20141113174030.GM26481@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141113174030.GM26481-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 13 Nov 2014, Tony Lindgren wrote:
> Oops thanks for catching that. As the devres stuff is separate, I've
> updated the patch to keep it that way by adding a minimal manage.h.
> This avoids including internals.h in devres.c. Does that seem usable
> for you?

What's wrong with internals.h? devres.c is core code, so it is not
affected of the ban to include internals.h :)
 
> +/**
> + *	init_disabled_wakeirq - initialize a wake-up interrupt for a device
> + *	@dev: device to wake up on the wake-up interrupt
> + *	@wakeirq: wake-up interrupt for the device
> + *	@wakeflags: wake-up interrupt flags
> + *
> + *	Note that the wake-up interrupt starts disabled. The wake-up interrupt
> + *	is typically enabled from the device pm_runtime_suspend() and disabled
> + *	again in the device pm_runtime_resume(). For runtime PM, the wake-up
> + *	interrupt should be always enabled, and for device suspend and resume,
> + *	the wake-up interrupt should be enabled depending on the device specific
> + *	configuration for device_can_wakeup().
> + *
> + *	Note also that we are not resending the lost device interrupts.
> + *	We assume that the wake-up interrupt just needs to wake-up the device,
> + *	and then device pm_runtime_resume() can deal with the situation.
> + *
> + *	There are at least the following reasons to not resend the lost device
> + *	interrupts automatically based on the wake-up interrupt:
> + *
> + *	1. There can be interrupt reentry issues calling the device interrupt
> + *	   based on the wake-up interrupt if done in the device driver. It
> + *	   could be done with check_irq_resend() after checking the device
> + *	   interrupt mask if we really wanted to though.
> + *
> + *	2. The device interrupt handler would need to be set up properly with
> + *	   pm_runtime_irq_safe(). Ideally you don't want to call pm_runtime
> + *	   calls from the device interrupt handler at all.
> + *
> + *	3. The IRQ subsystem may not know if it's safe to call the device
> + *	   interrupt unless the driver updates the interrupt status with
> + *	   disable_irq() and enable_irq() in addition to just disabling the
> + *	   interrupt at the hardware level in the device registers.
> + *
> + *	So if replaying the lost device interrupts is absolutely needed from the
> + *	hardware point of view, it's probably best to set up a completely
> + *	separate wake-up interrupt handler for the wake-up interrupt in the
> + *	device driver because of the reasons above.

Can we please kill this last paragraph? I'm already seeing the
gazillion of "I think it is required to do so for my soooo special
chip" implementations in random drivers which all get it wrong again.

So I'd rather provide a mechanism upfront which lets the driver know
that the wakeup interrupt originated from that device, i.e. let the
wake up handler call

     pm_wakeup_irq(dev);

which calls:

      pm_runtime_mark_last_busy(dev);
      pm_request_resume(dev);

and aside of that tells the device via a flag or preferrably a
sequence counter that the wakeup irq has been triggered. So affected
devices can handle it based on that information w/o implementing the
next broken variant of wakeup irq handlers.

That also allows to remove the wakeflags check for level/edge.

> + */
> +int init_disabled_wakeirq(struct device *dev, unsigned int wakeirq,
> +			  unsigned long wakeflags)
> +{
> +	if (!(dev && wakeirq)) {

This is the second time I stumbled over this. While it is correct it
would be simpler to parse 

      if (!dev || !wakeirq) {

At least for my review damaged brain :)

> +		pr_err("Missing device or wakeirq for %s irq %d\n",
> +		       dev_name(dev), wakeirq);
> +		return -EINVAL;
> +	}
> +
> +	if (!(wakeflags & IRQF_ONESHOT)) {
> +		pr_err("Invalid wakeirq for %s irq %d, must be oneshot\n",
> +		       dev_name(dev), wakeirq);
> +		return -EINVAL;
> +	}

Is there a reason why we force the wakeirq into a threaded handler?

Thanks,

	tglx
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
