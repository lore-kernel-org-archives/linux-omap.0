From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 19/41] OMAPDSS: panel-dpi: Add DT support
Date: Mon, 28 Apr 2014 09:13:07 -0700
Message-ID: <20140428161306.GL20807@atomide.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <1390301833-24944-20-git-send-email-tomi.valkeinen@ti.com>
 <20140418155107.GB5354@atomide.com>
 <5358DEEA.1000506@ti.com>
 <20140425235348.GH20807@atomide.com>
 <535E30ED.10903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34667 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932770AbaD1QNR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 12:13:17 -0400
Content-Disposition: inline
In-Reply-To: <535E30ED.10903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joachim Eastwood <manabian@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140428 03:44]:
> On 26/04/14 02:53, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [140424 02:53]:
> >> On 18/04/14 18:51, Tony Lindgren wrote:
> >>
> >>>> +	gpio = of_get_gpio(node, 0);
> >>>> +	if (gpio_is_valid(gpio) || gpio == -ENOENT) {
> >>>> +		ddata->enable_gpio = gpio;
> >>>> +	} else {
> >>>> +		dev_err(&pdev->dev, "failed to parse enable gpio\n");
> >>>> +		return gpio;
> >>>> +	}
> >>>
> >>> We should set the GPIO polarity based on the OF_GPIO_ACTIVE_LOW like
> >>> gpio_backlight_probe_dt is doing. 
> >>
> >> Instead of doing it with the old gpio API, and checking the 'active'
> >> flag everywhere, I think we can use the new gpiod API which handles the
> >> polarity automatically.
> >>
> >> I attached prototype patches (based on -rc2) for panel dpi using that
> >> approach. It's a bit messier than I'd like, because for non-DT boot we
> >> need to request the gpio using the old API, and then convert it to
> >> gpio_desc. We can remove that code when all the boards use DT.
> >>
> >> I've compiled tested this only, as I don't have DPI panels I could use.
> >> I did try similar approach for TFP410, and it seemed to work fine.
> > 
> > Got these working by updating my test patch to use enable-gpios instead
> > of gpios, and had to change from GPIO_ACTIVE_LOW to GPIO_ACTIVE_HIGH.
> > Are we now also breaking legacy booting by reversing the polarity?
> 
> I don't think so. The GPIOs should be active-high by default, if I'm not
> mistaken, so the polarities should be the same for legacy boot with or
> without those patches. Of course, I don't have the boards so I have no
> idea if the polarities have been correct even before.

OK
 
> debugfs/gpio shows the actual value of the gpio, so you could check from
> there what it is.

Yeah that should be checked.
 
> > In any case, looks like we have some duplicate panel code.. Turns
> > out most panel dpi users for omap3 board-*.c files are just
> > sharp-ls037v7dw01 panels but configured in QVGA mode. At least for
> > EVM and and LDP based on looking at the pictures and the configuration
> 
> Hmm, true, board-ldp.c's panel looks very much like sharp-ls037v7dw01.

Yes it seems so also based on the photos of the LCD panel. And 3430sdp
also seems to have something similar but it's upside down.
 
> Which EVM are you talking about?

The LogicPD omap3 EVMs TMDSEVM3530 and TMDSEVM3730. The am335x EVM
has a different larger panel.
 
> > pins (using the names kernel):
> > 
> > QVGA = lcd MO
> > reset = lcd RESB
> > ...
> > 
> > Then the enable_gpio should be just a GPIO controlled 3.3V regulator
> > in most cases. I suggest we move them over to ls037v7dw01 and allow
> > configuring them both for VGA and QVGA depending on the orientation.
> 
> Looking at the panel spec, it has the following pins:
> 
> RESB - reset
> MO - VGA/QVGA
> UD - vertical scanning direction
> LR - horizontal scanning direction
> INI - power on control
> 
> And it needs 3.3V power.
> 
> Are you saying that on some boards the gpio used for enable_gpio is
> actually used to switch on a 3.3V regulator?

The 3.3V GPIO regulator is needed in addition to the configurable pins,
I guess some ls037v7dw01 panels only have a subset of the pins
controllable by GPIOs, and the GPIO regulator may be used instead of
the INI. But that's hard to know without schematics.
 
> > I guess you do have some device with ls037v7dw01 since you've been
> > patching it?
> 
> No, I don't have any boards with that panel.

OK. I'll move my boards over to ls037v7dw01 and do a DT conversion
patch for it that just sets a standard gpios property for panel
ls037v7dw01. The gpios entry can have 0 entries in the middle
depending on wiring configuration and there should not be any need
to name each GPIO.

As far as I'm concerned, your panel-dpi patch is fine with me,
and we should not add more configuration to it for the ls037v7dw01
panels.

Regards,

Tony
