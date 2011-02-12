From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mcspi: Add support for GPIO chip select lines
Date: Sat, 12 Feb 2011 01:33:24 -0700
Message-ID: <20110212083324.GA17755@angua.secretlab.ca>
References: <1b68c6791001272033q60dd31dbif4de285cd9bac83d@mail.gmail.com>
 <1292954195-20204-2-git-send-email-bgamari.foss@gmail.com>
 <AANLkTi=L+ZfwVy+O=oAXx8EHGisCdW1Pg4U+dQa4ZzEN@mail.gmail.com>
 <871v58xf0k.fsf@gmail.com>
 <AANLkTi=d_xkhksY=qzUOmjYYs8OkX13+8_4byZtnX9i5@mail.gmail.com>
 <87y67fx5vb.fsf@gmail.com>
 <20101224032819.GC2491@angua.secretlab.ca>
 <878vzfr9h7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:46375 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab1BLId3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 03:33:29 -0500
Received: by pxi15 with SMTP id 15so554848pxi.19
        for <linux-omap@vger.kernel.org>; Sat, 12 Feb 2011 00:33:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <878vzfr9h7.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: beagleboard <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Michael Hennerich <michael.hennerich@analog.com>, spi-devel-general <spi-devel-general@lists.sourceforge.net>, Eric Miao <eric.miao@canonical.com>

On Fri, Dec 24, 2010 at 01:05:56AM -0500, Ben Gamari wrote:
> On Thu, 23 Dec 2010 20:28:19 -0700, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Thu, Dec 23, 2010 at 09:27:20PM -0500, Ben Gamari wrote:
> > > I understand your concerns, but I'm not sure how to satisfy them without
> > > crippling the design's ability to accomodate my use-case. I can't pass a
> > > GPIO line per spi_board_info since in my case of a multiplexed CS
> > > configuration a single pin's state does not uniquely determine the
> > > desired CS. The only other option I can think of is that we somehow
> > > provide a list of GPIOs for each bus and map the CS numbers to
> > > permutations of GPIO states. Unfortunately, I don't know of any suitable
> > > structure to put this GPIO list in. Perhaps I'm missing something obvious?
> > 
> > Close, but not quite.  Assign one gpio number to each cs state, and
> > write a gpio controller driver that maps the linux-gpio number to the
> > physical gpio state permutation.  The mapping from gpio# to ss# is
> > 1:1, but the driver behind the gpio# can do whatever you need it to
> > do.
> > 
> I see. I'm still not convinced that this is the route to take,
> however. It seems like this virtual gpio interface is not only pretty
> clunky (simple board file glue turns into an entire gpio chip driver),
> it seems like this is a very inaccurate and not very useful way to
> expose a multiplexed CS configuration; e.g. what is this chip driver to
> do if the user tries to set two CS pins at once?

(Sorry for the really laggy reply)

I don't see it being that big a deal.  gpio drivers are pretty
lightweight and it is fine to have domain-specific limitations on how
gpios for a particular "gpio controller" behave.  In your example, if
the hardware doesn't support enabling 2 CS pins at once, then you make
a choice, either setting one when the other is already set simply does
not work; or it could reset the other state.  Either choice would be
fine.  The SPI driver must do the right thing regardless and deselect
the previous CS line before enabling a new one.

The other alternative would be to implement a new SPI chipselect
common infrastructure, but IMO, that would just end up looking like a
duplication of the gpio infrastructure.

Regardless, my point still stands, platform callbacks for what amounts
to gpio manipulations doesn't make a whole lot of sense.

> Is there precedent for
> using the GPIO subsystem in this way?

Yes, in drivers/spi look at mpc52xx_spi.c, davinci_spi.c, ath79_spi.c,
atmel_spi.c, and many more.  Grep for gpio in drivers/spi.

g.

