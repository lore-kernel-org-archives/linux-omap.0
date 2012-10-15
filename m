From: Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>
Subject: Re: [PATCH] i2c: omap: fix spurious IRQs: disable/enable IRQ at
 INTC when idle
Date: Mon, 15 Oct 2012 09:25:37 +0300
Message-ID: <1350282337.17145.45.camel@kj-X230>
References: <1350067225-24589-1-git-send-email-khilman@deeprootsystems.com>
	 <CAM=Q2csm0Eh9F6d1wKhEfOOtG+aY+Fh8D-dKPC0RMbKupVQHYQ@mail.gmail.com>
Reply-To: kalle.jokiniemi@jolla.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp170.iad.emailsrvr.com ([207.97.245.170]:46027 "EHLO
	smtp170.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab2JOGZk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 02:25:40 -0400
In-Reply-To: <CAM=Q2csm0Eh9F6d1wKhEfOOtG+aY+Fh8D-dKPC0RMbKupVQHYQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-i2c@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Huzefa Kankroliwala <huzefank@ti.com>, Nishanth Menon <nm@ti.com>

Hi,

la, 2012-10-13 kello 01:00 +0530, Shubhrajyoti Datta kirjoitti:
> On Sat, Oct 13, 2012 at 12:10 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
> > From: Kevin Hilman <khilman@ti.com>
> >
> > Currently, runtime PM is used to keep the device enabled only during
> > active transfers and for a configurable runtime PM autosuspend timout
> > after an xfer.
> >
> > In addition to idling the device, driver's ->runtime_suspend() method
> > currently disables device interrupts when idle.  However, on some SoCs
> > (notably OMAP4+), the I2C hardware may shared with other coprocessors.
> > This means that the MPU will still recieve interrupts if a coprocessor
> > is using the I2C device.  To avoid this, also disable interrupts at
> > the MPU INTC when idling the device in ->runtime_suspend() (and
> > re-enable them in ->runtime_resume().)  This part based on an original
> > patch from Shubhrajyoti Datta.  NOTE: for proper sharing the I2C with
> > a coprocessor, this driver still needs hwspinlock support added.
> >
> > This change is also meant to address an issue reported by Kalle
> > Jokiniemi where I2C bus interrupt may be enabled before an I2C device
> > interrupt handler (e.g. just after noirq resume phase) causing an

It is actually in middle of resume_noirq.

> > interrupt flood on the I2C bus interrupt before the device interrupt
> > is enabled (e.g. interrupts coming from devices on I2C connected PMIC
> > before the PMIC chained hanlder is enabled.)  This problem is addresed
> > by ensuring that the I2C bus interrupt left disabled until an I2C xfer
> > is requested.
> 
> Looks good to me.
> Will wait for Kalle though.

Does not work for me :(

As I said, the issue occurs for me when I enter static suspend (echo mem
> /sys/power/autosleep or /sys/power/state). I don't think doing this
just in runtime pm will fix my issue. Or do those handlers get run in
the normal suspend path as well?

- Kalle

> 
> >
> > Cc: Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>
> > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>,
> > Cc: Huzefa Kankroliwala <huzefank@ti.com>
> > Cc: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> > ---
> >  drivers/i2c/busses/i2c-omap.c |    3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index db31eae..e6413e8 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -1255,6 +1255,7 @@ static int omap_i2c_runtime_suspend(struct device *dev)
> >                 /* Flush posted write */
> >                 omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
> >         }
> > +       disable_irq(_dev->irq);
> >
> >         return 0;
> >  }
> > @@ -1275,6 +1276,8 @@ static int omap_i2c_runtime_resume(struct device *dev)
> >                 omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> >         }
> >
> > +       enable_irq(_dev->irq);
> > +
> >         /*
> >          * Don't write to this register if the IE state is 0 as it can
> >          * cause deadlock.
> > --
> > 1.7.9.2
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


