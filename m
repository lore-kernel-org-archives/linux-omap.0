From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/8] ASoC: TPA6130A2 amplifier driver
Date: Thu, 8 Oct 2009 14:53:42 +0100
Message-ID: <20091008135342.GJ29176@rakim.wolfsonmicro.main>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
 <1255003137-1034-2-git-send-email-eduardo.valentin@nokia.com>
 <20091008125213.GA29176@rakim.wolfsonmicro.main>
 <200910081638.24229.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38846 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758294AbZJHNyU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 09:54:20 -0400
Content-Disposition: inline
In-Reply-To: <200910081638.24229.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@GMAIL.COM>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Thu, Oct 08, 2009 at 04:38:24PM +0300, Peter Ujfalusi wrote:
> On Thursday 08 October 2009 15:52:13 ext Mark Brown wrote:
> > On Thu, Oct 08, 2009 at 02:58:50PM +0300, Eduardo Valentin wrote:
> > > +struct tpa6130a2_platform_data {
> > > +	int (*set_power)(int state);
> > > +};

> > Why is this a callback and not just a GPIO number?  That'd seem simpler
> > for users.

> Well, same amount of code, but in different place if the power is enabled 

Until someone adds a second board, at which point they need to copy the
code to acquire and release the GPIO.

> through a GPIO. But if the power is controlled via different means (nothing 
> comes to mind, but there are exotic systems out there), in this way it is simple 
> to handle

I suspect we can deal with that adequately when it crops up, for example
by having the driver set up a default callback function if a GPIO is
specified instead of a callback.

> > > +	pdata = (struct tpa6130a2_platform_data *)client->dev.platform_data;
> > > +	/* Set default register values */
> > > +	data->regs[TPA6130A2_REG_CONTROL] = TPA6130A2_SWS |
> > > +					    TPA6130A2_HP_EN_R |
> > > +					    TPA6130A2_HP_EN_L;

> > This looks like you could implement stereo paths with individual power
> > control?

> Can we put something in between DAPM_OUTPUT and DAPM_HP to handle the stereo 
> path correctly?

Yes.

> We could have two paths from codec to the "TPA6130A2 Headphone", which is needed 
> to actually control the power of the amplifier.

Or make "TPA6130A2 Headphone" be a SND_SOC_DAPM_SUPPLY() connected to
the individual channels for the headphone outputs, which should do the
right thing.

> At the end we are not really gaining much, but one more level of switch on the 
> path.
> We could have simple mute alsa controls in tpa6130a2_controls for the amplifier 
> itself...

It'd mean that mono outputs would only need to enable one of the
channels.  Depending on the hardware feeding the amp this may behave
better - there may be some noise or leakage on the idle channel which
it'd be better to avoid amplifying - and it should certainly use a
little less power.

> > > +	err = tpa6130a2_i2c_read(TPA6130A2_REG_VERSION) &
> > > +				 TPA6130A2_VERSION_MASK;
> > > +	if ((err != 1) && (err != 2)) {
> > > +		dev_err(dev, "Unexpected headphone amplifier chip version "
> > > +		       "of 0x%02x, was expecting 0x01 or 0x02\n", err);
> > > +		err = -ENODEV;

> > This seems a bit excessive - is it really likely that the register map
> > would be changed incompatibly in a future version?

> Hmm, we have only seen these versions of the chip, and we know that the driver 
> works with these. Also we don't have any information on different versions, but 
> I would think that the register map is not changing (the reset values for some 
> registers are different)

It's fairly common to see some incompatible changes in early silicon
revisions but once things get properly launched it's fairly unusual.
I'd be more inclined to print a warning here rather than fail - chances
are that the driver will work fine with any new revisions that are
produced.
