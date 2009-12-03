From: Tony Lindgren <tony@atomide.com>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Wed, 2 Dec 2009 16:59:21 -0800
Message-ID: <20091203005921.GO4348@atomide.com>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
 <1259599010.4649.51.camel@thunk>
 <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com>
 <20091130194031.GV4348@atomide.com>
 <fa686aa40912020707p70eb693dp6fcd03facabb5892@mail.gmail.com>
 <20091202155319.GA3628@lixom.net>
 <fa686aa40912020804g34e1258k626349d711cfadd4@mail.gmail.com>
 <20091202161657.GA3903@lixom.net>
 <fa686aa40912020924i6079275n5ad31fa91e52b8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50693 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbZLCA7V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 19:59:21 -0500
Content-Disposition: inline
In-Reply-To: <fa686aa40912020924i6079275n5ad31fa91e52b8a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Olof Johansson <olof@lixom.net>, Peter Barada <peterb@logicpd.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org

* Grant Likely <grant.likely@secretlab.ca> [091202 09:24]:
> On Wed, Dec 2, 2009 at 9:16 AM, Olof Johansson <olof@lixom.net> wrote=
:
> > On Wed, Dec 02, 2009 at 09:04:49AM -0700, Grant Likely wrote:
> >
> >> Ah, you're talking about pin muxing configuration, right? =A0Yes, =
that
> >> GPIO binding deals with controllers, not pin mux. =A0Pin mux is ve=
ry
> >> much an SoC specific thing that isn't mapped easily to a generic
> >> binding.
> >
> > Yep.
> >
> >> On the 5200, I haven't attempted to describe pin-mux in the device
> >> tree at all, and have either expected firmware to set it up correc=
tly,
> >> or fixed it up in the platform code.
> >
> > Yeah. And it's one of the things Tony commented on that firmware te=
nds
> > to get wrong, seems like people aren't doing complete mux configs i=
n
> > u-boot, etc.
> >
> > So, if it needs to be fixed up in platform code, there will (likely=
) be
> > need for board-specific code there anyway. A bummer, since the devi=
ce
> > tree would otherwise make it real easy to bring up new boards witho=
ut
> > kernel code changes.
>=20
> I didn't create a binding on the 5200 because I actually see very
> little buggy firmware in that regard (partially because I kept tellin=
g
> people to go fix their firmware).  :-)  If it ends up being the norm
> that the kernel has to fix it for a given SoC, then I would create an
> SoC-specific binding for pin mux configuration in the device tree so
> that some degree of common code can still fix it up.
>=20
> It should be feasible for board-specific code to be the exception, no=
t the rule.

The problem with pin multiplexing is that development boards such as
Beagle don't know the desired configuration in the bootloader.
There are pins available for connecting external hardware, such as
I2C, SPI, or whatever to the 16-bit GPMC bus. Also, the bootloaders
tend not to care about pin multiplexing for power management.

We now have kernel cmdline override for pin multiplexing, but
that does not help with adding platform_data for custom I2C or
SPI devices.

Just something to keep in mind, I still think we can benefit
from the open firmware support in various ways :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
