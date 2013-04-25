From: Felipe Balbi <balbi@ti.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Thu, 25 Apr 2013 18:13:04 +0300
Message-ID: <20130425151304.GK19395@arwen.pp.htv.fi>
References: <20130422180316.GA10155@atomide.com>
 <5176A45B.5@ti.com>
 <20130423172353.GD10155@atomide.com>
 <20130423213151.GM10155@atomide.com>
 <20130423231605.GO10155@atomide.com>
 <517770A0.4000609@ti.com>
 <20130424190821.GB5184@atomide.com>
 <20130424192330.GC5184@atomide.com>
 <20130425090447.GK7889@arwen.pp.htv.fi>
 <20130425150120.GH5184@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWJxWxNlJUNgDlXi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52704 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758409Ab3DYPNk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Apr 2013 11:13:40 -0400
Content-Disposition: inline
In-Reply-To: <20130425150120.GH5184@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

--pWJxWxNlJUNgDlXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Thu, Apr 25, 2013 at 08:01:20AM -0700, Tony Lindgren wrote:
> > > > > >>>>>>>2. MUSB fails with legacy booting and DT on panda es
> > > > > >>>>>>>
> > > > > >>>>>>>With both legacy and DT booting I get something like:
> > > > > >>>>>>>
> > > > > >>>>>>>HS USB OTG: no transceiver configured
> > > > > >>>>>>>musb-hdrc musb-hdrc.0.auto: musb_init_controller failed wi=
th status -517
> > > > > >>>>>>
> > > > > >>>>>>The dt should work fine with https://patchwork.kernel.org/p=
atch/2423061/.
> > > > > >>>>>
> > > > > >>>>>OK thanks for checking that.
> > > > > >
> > > > > >Kishon, I think there's also some other issue remaining
> > > > > >in linux next with MUSB and DT. I'm still getting the
> > > > > >"HS USB OTG: no transceiver configured" although the nop
> > > > > >xceiv is compiled in. Maybe give it a try against linux
> > > > > >next?
> > > > >=20
> > > > > For OMAP4 MUSB, you'll need omap-usb2 phy. I've attached my .conf=
ig.
> > > >=20
> > > > Thanks your config helped me to track it down. Looks like I got
> > > > the PHYs the wrong way around between EHCI and MUSB..
> > > >=20
> > > > In any case, I did have omap-usb2 compiled in, but I did not have
> > > > OMAP_OCP2SCP=3Dy set. Should OMAP_USB2 depend on that?
> > > >=20
> > > > Also, looks like MUSB just sits in b_idle mode though, so no more
> > > > ID pin interrupt for some reason.
> > >=20
> > > OK looks like I got the ID interrupt going by enabling
> > > CONFIG_TWL6030_USB=3Dy. Still stays in a_idle with no keyboard
> > > after plugging it in, but now changes between a and b mode.
> >=20
> > come again, you ground ID pin and have no devices attached ? Then it
> > should stay in a_idle.
>=20
> After playing with looks like it detects the keyboard after replugging
> the cable a few times. So it's not detecting the keyboard every time when
> plugged in, but sounds like that's not related to the DT patches. It's
> probably the session bit related issues again..

could be, that part definitely needs some clenaning.

--=20
balbi

--pWJxWxNlJUNgDlXi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJReUgAAAoJEIaOsuA1yqREPqwP/0s0HcW9rmfRsDxzJIUitXBC
v8y/C20EWrqjaYRHObZz2fKZsKLDkNQZE9fiMnS4XRqlcmvArFBS/5jE2tpBnwYf
fMM9JW8Um1sKfRFAbKpghNOcirM+Ya08I+sRlu3AV9FaBYkvWsE+UlcL012W5YyJ
b920gphHNsvkzq5/4a7jxazIkL5YMet3MOyRhUAVeoFy/KguE3Y2KopbRO31uxV3
ycmGgIWPS+hCi2lx3nZmknvcGMpwFNRNelelQ2+RozpA9/+FVlGJjlF4WJx33pXE
CY1nFe/BjWgjEpivSPQ1holzTJRKbsaeswoQe1G22Hj0XZ9wgzWa0ZwhAZcUObgg
xgaVPnQLns4fI2KAk0azfcyVYd0h36UuZ/LqqoVvyY+qWHszc08V32+V27tXi3I+
pf0F55aDNqlkl7Q+/8yuPE6IBuYQ9tWnouYqZ7iC1JD/KNgXiZawMNpdLcH/2A7H
s6bL7O+Oz11HRYFw2al50bd0nroLqS5jsa+dF1OOTz72o8p0h7Ugoey/VakpQuOi
m/PK67HbULB5mHOEgWaKkXNSIFZjJt5t81S5/TtDpjGUhmW6qe44dJGXxs7p1pST
EeUBSwzwUWWezU6R+GNWcT9pTCNglF907Wm/nZFGyrs1CLalz6y6ooAndAHZ3Srs
Gjxzqza5VAMKiWwC06fs
=F0NM
-----END PGP SIGNATURE-----

--pWJxWxNlJUNgDlXi--
