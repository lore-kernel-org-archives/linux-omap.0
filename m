From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH V3 3/3] mfd: palmas: Add support for optional wakeup
Date: Fri, 19 Sep 2014 10:36:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.10.1409191027330.5612@nanos>
References: <1411067086-16613-1-git-send-email-nm@ti.com> <1411067086-16613-4-git-send-email-nm@ti.com> <alpine.DEB.2.10.1409181749170.4206@nanos> <20140919030333.GA6088@kahuna> <alpine.DEB.2.10.1409190710320.5612@nanos> <20140919161927.GA28613@kahuna>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140919161927.GA28613@kahuna>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 19 Sep 2014, Nishanth Menon wrote:
> On 08:37-20140919, Thomas Gleixner wrote:
> > The other omap drivers using this have the same issue ... And of
> > course they are subtly different.
> > 
> > The uart one handles the actual device interrupt, which is violating
> > the general rule of possible interrupt reentrancy in the pm-runtime
> > case if the two interrupts are affine to two different cores. Yes,
> > it's protected by a lock and works by chance ....
> > 
> > The mmc one issues a disable_irq_nosync() in the wakeup irq handler
> > itself.
> > 
> > WHY does one driver need that and the other does not? You are not even
> > able to come up with a common scheme for OMAP. I don't want to see the
> > mess others are going to create when this stuff becomes more used.
> > 
> > Thanks,
> > 
> > 	tglx
> 
> I think I understand your concern - I request Tony to comment about
> this. I mean, I can try and hook things like uart in other drivers
> (like https://patchwork.kernel.org/patch/4759171/ ), but w.r.t overall
> generic usage guideline wise, I would prefer Tony to comment.

No, the uart and that i2c thing are just wrong. Assume the following

device irq affine to cpu0
wakeup irq affine to cpu1

CPU 0				CPU 1

runtime suspend

 enable_wake(wakeup irq);

wakeup interrupt is raised	device interrupt is raised

  dev_handler(device)		dev_handler(device)

It might work due to locking, but it is nevertheless wrong. Interrupt
handlers for devices are guaranteed not to be reentrant. And this
brilliant stuff simply violates that guarantee. So, no. It's wrong
even if it happens to work by chance.

Thanks,

	tglx
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
