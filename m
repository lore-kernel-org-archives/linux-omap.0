From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Thu, 03 Dec 2009 10:46:51 +0200
Message-ID: <1259830011.10805.60.camel@localhost>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
	 <1259599010.4649.51.camel@thunk>
	 <fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com>
	 <20091130194031.GV4348@atomide.com>
	 <fa686aa40912020707p70eb693dp6fcd03facabb5892@mail.gmail.com>
	 <20091203010051.GP4348@atomide.com>
	 <20091203065651.GH17675@esdhcp04058.research.nokia.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58558 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbZLCIrF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 03:47:05 -0500
In-Reply-To: <20091203065651.GH17675@esdhcp04058.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Peter Barada <peterb@logicpd.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Olof Johansson <olof@lixom.net>

On Thu, 2009-12-03 at 08:56 +0200, Mika Westerberg wrote:
> On Thu, Dec 03, 2009 at 02:00:52AM +0100, ext Tony Lindgren wrote:
> > * Grant Likely <grant.likely@secretlab.ca> [091202 07:06]:
> > > On Mon, Nov 30, 2009 at 12:40 PM, Tony Lindgren <tony@atomide.com=
> wrote:
> > > > * Grant Likely <grant.likely@secretlab.ca> [091130 09:01]:
> >=20
> > <snip>
> >=20
> > > >
> > > > maybe you've already thought through all this.. But would it be
> > > > possible to do lightweight device tree that we just use to popu=
late
> > > > the platform data?
> > >=20
> > > This is completely possible.  Just having the device tree availab=
le
> > > doesn't force the kernel to use it for everything.  I've found it
> > > useful to start small and add things as I need them.  Most import=
ant
> > > thing to remember is to follow the documented & established devic=
e
> > > tree conventions so that common code can understand it.
> >=20
> > OK, sounds good to me.
>=20
> Hi,
>=20
> This device tree stuff sounds like very cool way of doing things. Hop=
e
> it is ready soon :)
>=20
> Meanwhile, would it be OK to implement something to get the serial dr=
iver
> taking control of the all the UARTs? Any comments on adding new funct=
ion
> to mach-omap2/serial.c: omap_serial_init_port(int port) that could be
> used from board files instead of omap_serial_init()?

Device tree is really promising, but we do need an alternative method
anyway, because not everyone will use the device tree. IOW, device tree
does not exist yet, and will not be mandatory, so an alternative is
required.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
