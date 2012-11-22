From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Thu, 22 Nov 2012 15:56:03 +0200
Message-ID: <20121122135603.GA20066@arwen.pp.htv.fi>
References: <Pine.LNX.4.44L0.1211211028200.1731-100000@iolanthe.rowland.org>
 <50ACFC5D.1090406@ti.com>
 <20121121195436.GF14290@arwen.pp.htv.fi>
 <50AD7C2C.7000608@linaro.org>
 <20121122121845.GB18022@arwen.pp.htv.fi>
 <50AE2D51.5060001@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49299 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899Ab2KVSbJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Nov 2012 13:31:09 -0500
Content-Disposition: inline
In-Reply-To: <50AE2D51.5060001@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: balbi@ti.com, Roger Quadros <rogerq@ti.com>, Alan Stern <stern@rowland.harvard.edu>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 22, 2012 at 09:49:05PM +0800, Andy Green wrote:
> >Again it sounds like something that should be done at the hub driver
> >level. I mean using the GPIO (for reset) and Power Regulator.
> >
> >not implementing the regulator part itself, but using it.
>=20
> If you mean change the regulator managing code from living in
> omap-hsusb to ehci-hcd, it sounds like a good idea.

I mean that drivers/usb/core/hub.c should manage it, since that's what
actually manages the HUB entity.

> >>easily be a PMIC regulator channel: it boils down to controlling a
> >>power rail.  So using struct regulator as the abstraction for the
> >>power is the right way already.
> >
> >I agree with you here. Nevertheless, I'm arguing that this all should be
> >handled by the hub driver, not ehci-omap.
>=20
> If "hub driver" means ehci-hcd then I agree, why not let all the ehci
> platforms have the same regulator management option instead of just
> OMAP.

the reasoning is in alignment with mine, but the "target driver" is
wrong :-)

> From the POV of the original goal of the patch, it was just to give
> us a way to control static power consumption by modprobe.  It would
> work fine to do that by modprobe [-r] smsc95xx same as ehci-hcd
> actually, although I agree it's backward from usual discover -> udev
> -> modprobe POV.  Anyway that is not what we ended up with so no need
> to worry about it.

fair enough, but I would only accept $SUBJECT if in the same series came
the patch moving the code to the right place, otherwise things such as
those never get done because other tasks are prioritized over a "simple
cleanup".

> >>offers a struct regulator.  But there is a quirk on Panda that means
> >>that is not workable.
> >>
> >>On Panda, they share one SoC gpio to reset both an external ULPI PHY
> >>chip and the smsc95xx that is downstream of it.
> >
> >of course. the Network part is attached to one of the Hub ports, that's
> >why the hub exposes only two ports.
>=20
> I am not sure how that makes it an "of course".  It's not like
> there's a shortage of SoC gpio to separate them and allow cleaner
> software.  But never mind that either.

fair enough ;-)

> >>After you power up the smsc95xx, you must reset it in order for
> >>correct operation.  This actually resets the ULPI PHY too.
> >>
> >>The ULPI PHY is permanently powered, only nRESET is provided to
> >>control it.
> >>
> >>For that reason, as an attribute of being on a Panda board, we need
> >>to do the (shared) reset meddling once at hsusb init, and that is why
> >>the patch is as it is.
> >
> >yeah, yeah, but it's not correct to push all that code is the OMAP USB
> >Part when the hub driver is the only one who knows when the hub is going
> >to be reset and the like.
> >
> >You're poking into a HUB, not into the EHCI controller.
>=20
> My patch is just using what's there at the moment.  It only touches
> the board file and does not "push all that code is the OMAP USB
> part".
>=20
> I agree with you what's in the OMAP USB part is better in the generic
> part, but I didn't put it there.

not saying you did, merely checking if Alan would be ok with that code
living in the hub driver, and if he would, I'd ask you or Roger to move
the to it's proper location ;-)

> If you want that moved and nobody else wants to do it, I can probably
> do that in a new, additional patch.  If so you might want to confirm

as long as Alan is ok and it comes in the same series, I'd be really,
really glad to see such a patch and would happily review it.

> you're OK with the magic naming convention for regulators or (as
> Roger suggested earlier) pass it in by platform_data.

I'm not sure if regulator names should be passed via platform_data. I
think Mark Brown would get quite upset if we did such a thing, but I
could be wrong.

--=20
balbi

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQri7zAAoJEIaOsuA1yqREScsP/04j3b4UqKD0K+2xPiGueD3I
dNImI76GazeBxrsU67EkpDMqroOt2eLW64fx62uS0aYBDrJHCKDLgx9YoWhlLzV7
rOmmGwzybgaqHulpWF57Q7Xln2gZmPKViSqkye61eLpDhs+Czr7eAArVcWc1z5Gy
LyC3rV3S4snwpoh8YbY6mS0vHoIOkqbKWIYtlVMdSWL47eUtILPE/jgiIvFdPlrR
mBxJyESBDnTm/ZxS5V/wyLNvxhYCFi1ho2PTRGeTLjKjxw0ur13etw2gy/Lhf2lG
wx6ei6v4Hx8tLLcNfXgWbsWAP5sHtubmLdJcK0cgbrRKueRjZ//8fBL+qY4h+vL9
mXtvA8sQ/r1jPv23ZK/nK51Ivrr0WhuzOkZi1wU6+cysWSlIVP3zRDtKOVtIhhAK
HIQ48ZjM6vkzB6z6JVzaxCrkfd4+Cub6Oeax4xPDZzTWFcqw6bvOO3okxSeKtf9F
ByhoZnxvXWOKb7gs6XMH/k1EVGlgnRNWkncqObVex9OTtXnypdmOvoozPxyZtMO3
Mw4aUlBj8qdOMrpoL8SnPHTgjs3us+NS4HzeIBYQCp0Iyl7aC9sWdtzdLGW6D6vU
MwZOfwBwmD9uIlVyhWc6K1oifSMOafgwAjeBvzPqS/Nf13XPFJnqTWDl1bkOjiom
y17u15sgF4gjZQOh7TtX
=XmYQ
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
