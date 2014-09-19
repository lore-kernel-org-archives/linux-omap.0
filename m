From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V3 3/3] mfd: palmas: Add support for optional wakeup
Date: Fri, 19 Sep 2014 12:16:49 -0700
Message-ID: <20140919191649.GQ14505@atomide.com>
References: <1411067086-16613-1-git-send-email-nm@ti.com>
 <1411067086-16613-4-git-send-email-nm@ti.com>
 <alpine.DEB.2.10.1409181749170.4206@nanos>
 <20140919030333.GA6088@kahuna>
 <alpine.DEB.2.10.1409190710320.5612@nanos>
 <20140919161927.GA28613@kahuna>
 <alpine.DEB.2.10.1409191027330.5612@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1409191027330.5612@nanos>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> [140919 10:37]:
> On Fri, 19 Sep 2014, Nishanth Menon wrote:
> > On 08:37-20140919, Thomas Gleixner wrote:
> > > The other omap drivers using this have the same issue ... And of
> > > course they are subtly different.
> > > 
> > > The uart one handles the actual device interrupt, which is violating
> > > the general rule of possible interrupt reentrancy in the pm-runtime
> > > case if the two interrupts are affine to two different cores. Yes,
> > > it's protected by a lock and works by chance ....
> > > 
> > > The mmc one issues a disable_irq_nosync() in the wakeup irq handler
> > > itself.
> > > 
> > > WHY does one driver need that and the other does not? You are not even
> > > able to come up with a common scheme for OMAP. I don't want to see the
> > > mess others are going to create when this stuff becomes more used.
> > > 
> > > Thanks,
> > > 
> > > 	tglx
> > 
> > I think I understand your concern - I request Tony to comment about
> > this. I mean, I can try and hook things like uart in other drivers
> > (like https://patchwork.kernel.org/patch/4759171/ ), but w.r.t overall
> > generic usage guideline wise, I would prefer Tony to comment.
> 
> No, the uart and that i2c thing are just wrong. Assume the following
> 
> device irq affine to cpu0
> wakeup irq affine to cpu1
> 
> CPU 0				CPU 1
> 
> runtime suspend
> 
>  enable_wake(wakeup irq);
> 
> wakeup interrupt is raised	device interrupt is raised
> 
>   dev_handler(device)		dev_handler(device)
> 
> It might work due to locking, but it is nevertheless wrong. Interrupt
> handlers for devices are guaranteed not to be reentrant. And this
> brilliant stuff simply violates that guarantee. So, no. It's wrong
> even if it happens to work by chance.

Hmm yeah that's a good point indeed.

>From hardware point of view the wake-up events behave like interrupts
and could also be used as the only interrupt in some messed up cases.
That avoids all kinds of custom APIs from driver point.

The re-entrancy problem we've most likely had ever since we enabled
the PRCM interrupts, and maybe that's why I did not even consider
that part. I think before that we were calling the driver interrupt
after waking up from the PM code..

Anyways, how about the following to deal with the re-entrancy problem:

1. The wake-up interrupt handler must have a separate interrupt
   handler that just calls tasklet_schedule()

2. The device interrupt handler also just calls tasklet_schedule()

3. The tasklet then does pm_runtime_get, handles the registers, and
   so on.

Or would we still have a re-entrancy problem somewhere else with
that?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
