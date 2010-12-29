From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC/PATCH 3/3] mfd: twl4030-irq: implement bus_*lock
Date: Wed, 29 Dec 2010 02:38:28 +0200
Message-ID: <1293583108.1822.3.camel@eowin>
References: <20101228161657.GF2239@legolas.emea.dhcp.ti.com>
	 <1293556459-28613-1-git-send-email-balbi@ti.com>
	 <1293556459-28613-4-git-send-email-balbi@ti.com>
	 <20101228235836.GA2609@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101228235836.GA2609@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, 2010-12-28 at 23:58 +0000, Mark Brown wrote:
> On Tue, Dec 28, 2010 at 07:14:19PM +0200, Felipe Balbi wrote:
> 
> > +static void twl4030_sih_bus_sync_unlock(unsigned int irq)
> > +{
> > +       struct sih_agent        *agent = get_irq_chip_data(irq);
> > +
> > +       mutex_unlock(&agent->irq_lock);
> > +}
> 
> I suspect you need to do some sort of sync with the hardware here - the
> _sync bit of the name comes from the fact that the mask and unmask stuff
> is still called with IRQs disabled and so can't touch and I2C chip, this
> is called after reenabling them give a chance for the updates done to
> be reflected in the hardware.  The implementation everyone else has done
> is to update a register cache in the other functions then write that
> out here before dropping the mutex.

now that I look at some gpio chips I see what you're saying, will update
that tomorrow. Thanks

> >  static struct irq_chip twl4030_sih_irq_chip = {
> >  	.name		= "twl4030",
> >  	.mask		= twl4030_sih_mask,
> >  	.unmask		= twl4030_sih_unmask,
> >  	.set_type	= twl4030_sih_set_type,
> > +	.bus_lock	= twl4030_sih_bus_lock,
> > +	.bus_sync_unlock = twl4030_sih_bus_sync_unlock,
> >  };
> 
> I just realised that this collides with the conversion to the irq_
> versions that has been done on the driver in -next by either myself or
> Lennart (we both submitted essentially the same patches and a couple of
> his went in) - that was a purely mechanical conversion that didn't
> address any of the issues this patch addresses but they're touching the
> same code.

no problem. This will actually only be able on 2.6.39 merge window
anyway, so I'll have plenty of time to rebase on 2.6.38 and get these
patches queued.

ps: sorry the mail change, out of the office.

-- 
balbi
