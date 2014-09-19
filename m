From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH V3 3/3] mfd: palmas: Add support for optional wakeup
Date: Fri, 19 Sep 2014 12:46:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.10.1409191233590.4213@nanos>
References: <1411067086-16613-1-git-send-email-nm@ti.com> <1411067086-16613-4-git-send-email-nm@ti.com> <alpine.DEB.2.10.1409181749170.4206@nanos> <20140919030333.GA6088@kahuna> <alpine.DEB.2.10.1409190710320.5612@nanos> <20140919161927.GA28613@kahuna>
 <alpine.DEB.2.10.1409191027330.5612@nanos> <20140919191649.GQ14505@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140919191649.GQ14505-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 19 Sep 2014, Tony Lindgren wrote:
> * Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> [140919 10:37]:
> >From hardware point of view the wake-up events behave like interrupts
> and could also be used as the only interrupt in some messed up cases.
> That avoids all kinds of custom APIs from driver point.
> 
> The re-entrancy problem we've most likely had ever since we enabled
> the PRCM interrupts, and maybe that's why I did not even consider
> that part. I think before that we were calling the driver interrupt
> after waking up from the PM code..
> 
> Anyways, how about the following to deal with the re-entrancy problem:
> 
> 1. The wake-up interrupt handler must have a separate interrupt
>    handler that just calls tasklet_schedule()
> 
> 2. The device interrupt handler also just calls tasklet_schedule()
> 
> 3. The tasklet then does pm_runtime_get, handles the registers, and
>    so on.
> 
> Or would we still have a re-entrancy problem somewhere else with
> that?

Why on earth are you wanting tasklets in there? That's just silly,
really.

The wakeup handler is supposed to bring the thing out of deep sleep
and nothing else. All you want it to do is to mask itself and save the
information that the real device irq is pending.

A stub handler for the wakeup irq is enough. We can have that in the
irq/pm core and all it would do is simply:

irqreturn_t handle_jinxed_wakeup_irq(unsigned irq, void *dev_id)
{
	unsigned device_irq = get_dev_irq(dev_id);

	force_mask(irq);
	set_irq_pending(device_irq);
	return HANDLED;	
}

So on resume_device_irqs() the real device interrupt gets reenabled
and unmasked (if it was masked) and the interrupt gets resent either
in hardware (level or retrigger) or by the software resend mechanism.

That completely avoids tasklets, reentrant irq handlers and all other
crap which might be required.

Thanks,

	tglx
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
