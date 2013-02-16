From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Sat, 16 Feb 2013 11:22:37 +0200
Message-ID: <20130216092236.GB20007@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215101610.GR17852@n2100.arm.linux.org.uk>
 <511E3797.2070802@ti.com>
 <20130215132726.GT17852@n2100.arm.linux.org.uk>
 <511E38C3.7080404@ti.com>
 <20130215163031.GA5724@atomide.com>
 <20130215164235.GA20840@arwen.pp.htv.fi>
 <511F20B1.8010502@ti.com>
 <20130216085528.GA19639@arwen.pp.htv.fi>
 <511F4EB9.2020408@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53441 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840Ab3BPJWz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Feb 2013 04:22:55 -0500
Content-Disposition: inline
In-Reply-To: <511F4EB9.2020408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, rafael.j.wysocki@intel.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 16, 2013 at 02:47:45PM +0530, Santosh Shilimkar wrote:
> >On Sat, Feb 16, 2013 at 11:31:21AM +0530, Santosh Shilimkar wrote:
> >>>>The main goal is to avoid duplicating data both in hwmod and DT.
> >>>>That's pretty much solved as we can have the driver probe populate
> >>>>the common data for hwmod from DT as Santosh has already demonstrated.
> >>>>
> >>>>Then we also want the driver specific idle and reset code to be done
> >>>>in the drivers rather than in hwmod and glue it together with hwmod
> >>>>using runtime PM. The biggest issue there is how do we reset and idle
> >>>>some piece of hardware for PM purposes when there's no driver loaded.
> >>>
> >>>right, this will be a tough nut to crack.
> >>>
> >>>I guess the only way would be reset all IPs early in the boot process,
> >>>before even creating the platform-devices. Can we do that ? I mean, fr=
om
> >>>omap_device_build_from_dt() we have access to address space of all
> >>>devices, through ti,hwmods we can figure out which hwmods are linked to
> >>>that particular device, so whenever you build a device, you could just
> >>>call _reset().
> >>>
> >>Thats what we do today and it works perfectly. As per Tony's suggestion,
> >>we need to move the non-probed devices reset and idle setup to late_init
> >>which is also doable.
> >>
> >>In that case when probed driver calls runtime_get(), we reset that
> >>device and setup the idle settings. And remainder of the devices
> >>are managed in late_init().
> >
> >what's the point in moving it to late_initcall() ? It makes no
> >difference, if no driver binds to that device it will stay in reset
> >anyway. Maybe what we're missing is properly idling (not exactly) all
> >devices before driver probe kicks in.
> >
> I think it is largely reducing the early init dependencies and also
> reducing the role of platform code who today takes care of every
> device idle and reset initialization. That way late_init() will
> only have to care about the devices which are not probed by
> drivers.
>=20
> Tony, Is that right ?

Makes not much difference, except that you will have to keep track of
which devices have gotten a driver probed and which haven't.

IMO, it sounds a lot better to reset everything early on, so we know
we're starting at a known stage (and thus drop all bootloader
dependencies) then to follow the other route.

> >The difficult part is handling special reset requirements for devices
> >without drivers as there'd be no ->runtime_reset() to call.
> >
> I don't think that requirement exists so if we address the driver
> requirement, we are good. Even otherwise also, it can be managed

Look back at what you want to do at late_initcall() time. You want to
reset all devices which haven't gotten a driver bound to them.

> from platform code.

right, the you will need even more data in hwmod to let it know about
the special devices. /me wonders when the amount of data will actually
decrease.

--=20
balbi

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRH0/cAAoJEIaOsuA1yqREX34QAIc52sJxgoNoa7VK+5hY9+X7
YupTM4AG55XvS7/NE1v1XniZkFQkGGR1VPPVFjI4rCtso7GOHJLT6Lw5IROvHozp
7JHelSpN0spgSqDlhSRbBdfZwb8c7Qz3ea5Cvo+L+zcKCaxCgANksCMp+Xnv/e7k
O8PNPmmBN880fLZ7xycdzEAyale1/GEB7P0ZwSyhVK2W6UerMzNGNBA/a0tVnGA8
amop8H2/BP5uRl3xiy1EVO0G3xkMzQC1l/39aU6AdkcVxSN3am9D5AYR5U/VFQwP
MAgBk+bqyndoCnTimx+f9oP/IVBFsd2ZUqskU9RTG52x1P1jd2diBU9K4vB26RVD
C6ouZLAGpcFlytFLto9+4e3O7XYmEYD63vsd9UUPwiXUn95tPp7zM1dcejotOuVe
IVqR0he9mzwP2bh+eSZFD9cv6RCBA750aRw8vYxkU5ZHd4pfCEKKx7c1w6XIv/O+
YCisxaQRYIKN3qFcuHyDubwJVVf/OjDj2zRywTHTVbdD3ej8hbISsRfXGi17wc8X
SsUVPq0QF1XXv8CI/q6niKnbTzxsS1OlQ9RxwwxADtt/Od9o1BWWnzUSDLRC1gIi
SGs9pSUXF2KZkZ/GvQ1NxUirwdhpn6GeBTgL3Fn6eQJenhSAYux0Hdi3hr4OcmMK
7pcncvZLtEYNZ+vvgIlF
=GcUX
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
