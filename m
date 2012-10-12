From: Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>
Subject: RE: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Fri, 12 Oct 2012 16:28:33 +0300
Message-ID: <1350048513.17145.33.camel@kj-X230>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>
	 ,<87ipag90om.fsf@deeprootsystems.com>
	 <902E09E6452B0E43903E4F2D568737AB2C87B0@DNCE04.ent.ti.com>
Reply-To: kalle.jokiniemi@jolla.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp140.iad.emailsrvr.com ([207.97.245.140]:44971 "EHLO
	smtp140.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757330Ab2JLN2h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Oct 2012 09:28:37 -0400
In-Reply-To: <902E09E6452B0E43903E4F2D568737AB2C87B0@DNCE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Strashko, Grygorii" <grygorii.strashko@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Kankroliwala, Huzefa" <huzefank@ti.com>

Hi,

pe, 2012-10-12 kello 10:18 +0000, Strashko, Grygorii kirjoitti:
> Hi All,
> 
> Sorry, for the late reply.
> + CC Huzefa Kankroliwala - who is I2C driver owner on Android Kernel 3.4.
> 
> Regarding this patch -  from my point of view, it fixes corner case and not an issue in general.
> Let take a look on resume sequence:
>    - platform resume
>    - syscore resume
>    - resume_noirq
>    - enable IRQs - resume_device_irqs()
>      |- at this point IRQ handler will be invoked if IRQ state is IRQS_PENDING.
>      |- so, the I2C device IRQ handler may be called at time when I2C
> 	adapter IRQ is still disabled and, as result, the I2C device
> 	IRQ-handler may fail. (I2C device and I2C adapter may use different
> 	physical IRQ lines)

The use case is to wake up the the device from suspend via twl4030 power
key line. The twl4030 then will interrupt host via the i2c bus. And on
the host the i2c bus is then read by the twl4030-pwrkey threaded SW
interrupt (which is disabled at the point when i2c bus HW interrupt
occurs).


>   - resume_late
>      |- enable I2C bus IRQ
> 
> Possibly, the better way is to enable/disable I2C bus IRQ when needed - in our case in omap_i2c_xfer().
> We use such approach in Android kernel 3.4
> (http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=1445a4d3b587c164bd30d108b61760aaaa07365e)

Sounds like it could work... however I tested the patch above, but my
device now dies when waking it from suspend (autosleep, actually) with
power key :(

Have you guys considered reworking that patch for upstream? There seems
to be some spinlocking there that was not in linux-omap that I tested
on.

- Kalle

> 
> Grygorii
> ________________________________________
> From: Kevin Hilman [khilman@deeprootsystems.com]
> Sent: Friday, October 12, 2012 12:08 AM
> To: Kalle Jokiniemi
> Cc: linux-i2c@vger.kernel.org; w.sang@pengutronix.de; ben-linux@fluff.org; tony@atomide.com; linux-omap@vger.kernel.org; Strashko, Grygorii; Datta, Shubhrajyoti
> Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
> 
> Hi Kalle,
> 
> Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com> writes:
> 
> > The resume_noirq enables interrupts one-by-one starting from
> > first one. Now if the wake up event for suspend came from i2c
> > device, the i2c bus irq gets enabled before the threaded
> > i2c device irq, causing a flood of i2c bus interrupts as the
> > threaded irq that should clear the event is not enabled yet.
> >
> > Fixed the issue by adding suspend_noirq and resume_early
> > functions that keep i2c bus interrupts disabled until
> > resume_noirq has run completely.
> >
> > Issue was detected doing a wake up from autosleep with
> > twl4030 power key on N9. Patch tested on N9.
> >
> > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>
> 
> This version looks good, thanks for the extra comments.
> 
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Tested-by: Kevin Hilman <khilman@ti.com>
> 
> Wolfram, This should also probably be Cc'd to stable since it affects
> earlier kernels as well.  Thanks,
> 
> Kevin
> 
> > ---
> >  drivers/i2c/busses/i2c-omap.c |   34 ++++++++++++++++++++++++++++++++++
> >  1 files changed, 34 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index a0e49f6..991341b 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -1132,6 +1132,36 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
> >  }
> >
> >  #ifdef CONFIG_PM
> > +#ifdef CONFIG_PM_SLEEP
> > +static int omap_i2c_suspend_noirq(struct device *dev)
> > +{
> > +
> > +     struct platform_device *pdev = to_platform_device(dev);
> > +     struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
> > +
> > +     /* Disabling irq here to balance the enable in resume_early */
> > +     disable_irq(_dev->irq);
> > +     return 0;
> > +}
> > +
> > +static int omap_i2c_resume_early(struct device *dev)
> > +{
> > +
> > +     struct platform_device *pdev = to_platform_device(dev);
> > +     struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
> > +
> > +     /*
> > +      * The noirq_resume enables the interrupts one by one,
> > +      * this causes a interrupt flood if the SW irq actually reading
> > +      * event from i2c device is enabled only after i2c bus irq, as the
> > +      * irq that should clear the event is still disabled. We have to
> > +      * keep the bus irq disabled until all other irqs have been enabled.
> > +      */
> > +     enable_irq(_dev->irq);
> > +
> > +     return 0;
> > +}
> > +#endif
> >  #ifdef CONFIG_PM_RUNTIME
> >  static int omap_i2c_runtime_suspend(struct device *dev)
> >  {
> > @@ -1183,6 +1213,10 @@ static int omap_i2c_runtime_resume(struct device *dev)
> >  #endif /* CONFIG_PM_RUNTIME */
> >
> >  static struct dev_pm_ops omap_i2c_pm_ops = {
> > +#ifdef CONFIG_PM_SLEEP
> > +     .suspend_noirq = omap_i2c_suspend_noirq,
> > +     .resume_early = omap_i2c_resume_early,
> > +#endif
> >       SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
> >                          omap_i2c_runtime_resume, NULL)
> >  };


