From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH] mcspi: Add support for GPIO chip select lines
Date: Sun, 13 Feb 2011 17:07:54 -0500
Message-ID: <87bp2fwptx.fsf@gmail.com>
References: <1b68c6791001272033q60dd31dbif4de285cd9bac83d@mail.gmail.com> <1292954195-20204-2-git-send-email-bgamari.foss@gmail.com> <AANLkTi=L+ZfwVy+O=oAXx8EHGisCdW1Pg4U+dQa4ZzEN@mail.gmail.com> <871v58xf0k.fsf@gmail.com> <AANLkTi=d_xkhksY=qzUOmjYYs8OkX13+8_4byZtnX9i5@mail.gmail.com> <87y67fx5vb.fsf@gmail.com> <20101224032819.GC2491@angua.secretlab.ca> <878vzfr9h7.fsf@gmail.com> <20110212083324.GA17755@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57810 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab1BMWIA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Feb 2011 17:08:00 -0500
Received: by qwa26 with SMTP id 26so2708815qwa.19
        for <linux-omap@vger.kernel.org>; Sun, 13 Feb 2011 14:08:00 -0800 (PST)
In-Reply-To: <20110212083324.GA17755@angua.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: beagleboard <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Michael Hennerich <michael.hennerich@analog.com>, spi-devel-general <spi-devel-general@lists.sourceforge.net>, Eric Miao <eric.miao@canonical.com>

On Sat, 12 Feb 2011 01:33:24 -0700, Grant Likely <grant.likely@secretlab.ca> wrote:
> (Sorry for the really laggy reply)
> 
No worries, I was just starting to think about this again myself.

> I don't see it being that big a deal.  gpio drivers are pretty
> lightweight and it is fine to have domain-specific limitations on how
> gpios for a particular "gpio controller" behave.  In your example, if
> the hardware doesn't support enabling 2 CS pins at once, then you make
> a choice, either setting one when the other is already set simply does
> not work; or it could reset the other state.  Either choice would be
> fine.  The SPI driver must do the right thing regardless and deselect
> the previous CS line before enabling a new one.
> 
Having now finally having had a chance to implement a gpio_chip driver,
I agree. It's quite simple and seems to fill the need pretty well

> The other alternative would be to implement a new SPI chipselect
> common infrastructure, but IMO, that would just end up looking like a
> duplication of the gpio infrastructure.
> 
I think you are probably right. GPIO seems to be a good fit.

Patch coming shortly.  I use spi_board_info.controller_data to pass the
gpio number to the controller which doesn't seem like the best way
forward, but I wasn't sure how else to proceed. Also, since the gpio
numbers are dynamically determined spi_board_info.controller_data must
be filled in at runtime, which is also a bit of a bummer (although not
easily solved as far as I can tell). Let me know what you think.

 - Ben
