From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH] mcspi: Add support for GPIO chip select lines
Date: Thu, 23 Dec 2010 21:27:20 -0500
Message-ID: <87y67fx5vb.fsf@gmail.com>
References: <1b68c6791001272033q60dd31dbif4de285cd9bac83d@mail.gmail.com> <1292954195-20204-2-git-send-email-bgamari.foss@gmail.com> <AANLkTi=L+ZfwVy+O=oAXx8EHGisCdW1Pg4U+dQa4ZzEN@mail.gmail.com> <871v58xf0k.fsf@gmail.com> <AANLkTi=d_xkhksY=qzUOmjYYs8OkX13+8_4byZtnX9i5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37508 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab0LXC1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 21:27:24 -0500
Received: by vws16 with SMTP id 16so2625441vws.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 18:27:23 -0800 (PST)
In-Reply-To: <AANLkTi=d_xkhksY=qzUOmjYYs8OkX13+8_4byZtnX9i5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: beagleboard <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Michael Hennerich <michael.hennerich@analog.com>, spi-devel-general <spi-devel-general@lists.sourceforge.net>, Eric Miao <eric.miao@canonical.com>

On Thu, 23 Dec 2010 17:37:12 -0700, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, Dec 23, 2010 at 4:09 PM, Ben Gamari <bgamari.foss@gmail.com> wrote:
> > The reason I left this up to the board is it's easy to foresee cases
> > where you want a non-trivial mapping between logical CS numbers and CS
> > pin states. In my case, I using a 2-to-4 multiplexer as the source of
> > chip select.
> 
> Hi Ben,
> 
> I understand and appreciate the motivation.  However in practice, the
> gpio api is sufficient for pretty much any use case, even when the
> backing gpio controller driver ends up driving some oddball device
> with different constraints.  The big downside to using a callback is
> that it forces all users to do the extra work of implementing the
> callback.  With the gpio api, only the oddball cases have to do extra
> code (to adapt the custom device to the gpio api).

I understand your concerns, but I'm not sure how to satisfy them without
crippling the design's ability to accomodate my use-case. I can't pass a
GPIO line per spi_board_info since in my case of a multiplexed CS
configuration a single pin's state does not uniquely determine the
desired CS. The only other option I can think of is that we somehow
provide a list of GPIOs for each bus and map the CS numbers to
permutations of GPIO states. Unfortunately, I don't know of any suitable
structure to put this GPIO list in. Perhaps I'm missing something obvious?

- Ben
