From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH] mcspi: Add support for GPIO chip select lines
Date: Fri, 24 Dec 2010 01:05:56 -0500
Message-ID: <878vzfr9h7.fsf@gmail.com>
References: <1b68c6791001272033q60dd31dbif4de285cd9bac83d@mail.gmail.com> <1292954195-20204-2-git-send-email-bgamari.foss@gmail.com> <AANLkTi=L+ZfwVy+O=oAXx8EHGisCdW1Pg4U+dQa4ZzEN@mail.gmail.com> <871v58xf0k.fsf@gmail.com> <AANLkTi=d_xkhksY=qzUOmjYYs8OkX13+8_4byZtnX9i5@mail.gmail.com> <87y67fx5vb.fsf@gmail.com> <20101224032819.GC2491@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57473 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab0LXGF7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Dec 2010 01:05:59 -0500
Received: by qwa26 with SMTP id 26so6862785qwa.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 22:05:58 -0800 (PST)
In-Reply-To: <20101224032819.GC2491@angua.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: beagleboard <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Michael Hennerich <michael.hennerich@analog.com>, spi-devel-general <spi-devel-general@lists.sourceforge.net>, Eric Miao <eric.miao@canonical.com>

On Thu, 23 Dec 2010 20:28:19 -0700, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, Dec 23, 2010 at 09:27:20PM -0500, Ben Gamari wrote:
> > I understand your concerns, but I'm not sure how to satisfy them without
> > crippling the design's ability to accomodate my use-case. I can't pass a
> > GPIO line per spi_board_info since in my case of a multiplexed CS
> > configuration a single pin's state does not uniquely determine the
> > desired CS. The only other option I can think of is that we somehow
> > provide a list of GPIOs for each bus and map the CS numbers to
> > permutations of GPIO states. Unfortunately, I don't know of any suitable
> > structure to put this GPIO list in. Perhaps I'm missing something obvious?
> 
> Close, but not quite.  Assign one gpio number to each cs state, and
> write a gpio controller driver that maps the linux-gpio number to the
> physical gpio state permutation.  The mapping from gpio# to ss# is
> 1:1, but the driver behind the gpio# can do whatever you need it to
> do.
> 
I see. I'm still not convinced that this is the route to take,
however. It seems like this virtual gpio interface is not only pretty
clunky (simple board file glue turns into an entire gpio chip driver),
it seems like this is a very inaccurate and not very useful way to
expose a multiplexed CS configuration; e.g. what is this chip driver to
do if the user tries to set two CS pins at once? Is there precedent for
using the GPIO subsystem in this way?

Cheers,

- Ben

