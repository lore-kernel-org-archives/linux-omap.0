From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Tue, 26 Jan 2010 07:44:46 -0800
Message-ID: <201001260744.46780.david-b@pacbell.net>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com> <201001260535.21689.david-b@pacbell.net> <20100126142102.GU15759@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754370Ab0AZPou@vger.kernel.org>
In-Reply-To: <20100126142102.GU15759@rakim.wolfsonmicro.main>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 January 2010, Mark Brown wrote:
> > > Yes please - it's not just chargers either, this can also be used=
 by
> > > PMICs which do power path management that includes USB.
>=20
> > Color me confused ... what do you mean by "power path"?
>=20
> In the sort of design I'm talking about there is generally a system
> power rail which is generated from the various power sources availabl=
e
> to the system, which might include a combination of batteries, USB an=
d
> wall adaptors.

Just as an example:  drivers/mfd/tps6510.c supports exactly
that trio of power sources.  More than one system rail though,
which (as you know) is pretty common -- core !=3D I/O.

It's *way* simpler than e.g. the TWL6030.  :)


> The power path management logic is the hardware which=20
> controls which of these are actually being used as supplies, and may
> also include battery charger management.
>=20
> > Do you mean something like "the board as a whole can take N mA of
> > current from USB", rather than specifically addressing a charger?
>=20
> Pretty much, from this point of view.

OK -- clear now.


> > It's not uncommon to do things like use VBUS current to power the
> > USB circuitry, too. =A0That can leave less for other purposes. =A0A=
ll
> > of that being rather board-specific.
>=20
> In this sort of design either VBUS goes through the power path
> management logic before anything else gets to use it or the hardware
> will know about the headroom it needs to leave. =A0The power path
> management will usually do things like try to suppliment VBUS with an=
y
> battery that's available to generate the main system supply rail.
>=20
> This all needs to function without software since it tends to get use=
d
> to decide things like if the system is able to begin power up at all,=
 .

Yep.  That's part of the reason the USB specs have hard
rules about having 100 mA available (for some period)
even before software can come up.

Bus powered devices can come up on that 100mA, running
enough to enumerate ... and request more power, if they
need it.

Not all Linux systems can boot with that little power!

- Dave
