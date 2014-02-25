From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
Date: Tue, 25 Feb 2014 17:51:21 +0100
Message-ID: <2364124.7r818M0xAj@avalon>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch> <20140225123921.GY27282@n2100.arm.linux.org.uk> <20140225134139.GA23898@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2927578.JVIdYpNYua"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:37252 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbaBYQuJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Feb 2014 11:50:09 -0500
In-Reply-To: <20140225134139.GA23898@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Javier Martinez Canillas <javier@dowhile0.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ash Charles <ash@gumstix.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--nextPart2927578.JVIdYpNYua
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Tuesday 25 February 2014 14:41:48 Sebastian Reichel wrote:
> On Tue, Feb 25, 2014 at 12:39:21PM +0000, Russell King - ARM Linux wr=
ote:
> > > That compatible string is correct according to the latest series
> > > posted by Tomi Valkeinen to add DT bindings for the OMAP Display
> > > SubSystem (DSS) [0].
> >=20
> > in which case:
> >=20
> > N    N   AA     CCCC  K  K
> > NN   N  A  A   C    C K K
> > N N  N A    A C       KK
> > N  N N AAAAAA C       KK
> > N   NN A    A  C    C K K
> > N    N A    A   CCCC  K  K
> >=20
> > Yes, that's a very big nack.  Two things:
> >=20
> > 1. OMAP really doesn't have the right to define a compatible string=
 which
> >    is as generic as "hdmi-connector".
>=20
> AFAIK the idea was to have "hdmi-connector" as part of the common
> display framework [1]. It's not really platform specific, since it's
> just a connector.
>=20
> Since omapdss does not yet implement the common display framework,
> but wants to keep a stable DT API it rewrites "hdmi-connector" to
> "omapdss,hdmi-connector" for now.

And since the common display framework has been pretty much nacked, we =
have no=20
framework on which drivers can rely ;-)

> > 2. Even with "omapdss," before it, the convention that DT people ha=
ve
> >    adopted is for the prefix to be "companyname," and not a subsyst=
em.
> >=20
> > I'm not the only one with this concern - I discussed it with Arnd l=
ast
> > night and his comments were about it being "obviously bogus".
> >=20
> > > The property is added on this patch [1] and as far as I understoo=
d the
> > > idea is that it could be a generic DT binding that can be used by=

> > > platform specific HDMI connectors like the omap dss HDMI connecto=
r [2].
> >=20
> > Why do the physical connectors need a DT binding?
>=20
> This is the termination of the video bus and useful information for
> xrandr.

I don't think all physical connectors require a DT binding per-se, but =
they=20
need to be represented in DT as they're part of the hardware. We could =
push=20
connector-related information to the nodes of all chips that have inter=
faces=20
wired directly to connectors, but that would result in more complex DT=20=

bindings and core. I believe modeling connectors using separate DT node=
s is be=20
best, and would allow easier support for more complex connectors that c=
arry=20
multiple streams/signals in parallel (video, audio, DDC, ...).

> > Surely what needs the DT binding is the HDMI encoder - and that cer=
tainly
> > should no way be a generic name, because there's no such thing as a=

> > generic HDMI encoder chip.
>=20
> The HDMI encoder and companion chips are described separatly and prop=
erly
> prefixed [0].
>=20
> [0] http://www.spinics.net/lists/linux-omap/msg102522.html
> [1] https://lwn.net/Articles/563157/

=2D-=20
Regards,

Laurent Pinchart

--nextPart2927578.JVIdYpNYua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTDMoOAAoJEIkPb2GL7hl1aOoIAIjcSDcG1W6KcIfXvhm7B9sE
IlcxSaRiftGCl6mVoP5jNsffdqLlfM4A6q9SbAJSwTrNKsm9W4jUj5fUXPs13HBE
lcCjwkYdUFcqs6+5688nPMLZOuj+W2vDwDB3ReSXKHIWHlq4G25488zWV0g+1bGT
gVGnvtw8Oq8E5011BIqEVTA905LJvMv0K18a2GgkTXlco9i78fNmCNGSg400mDbf
Hcb9Y14bUn3KcLmFuvC92pzeHlDqtIeTNW2ko8ONT/HYYF7E3ykRM68m2y9K22LO
PV8HzH4NDG7m1n9LQPN2zFnFP/zwTkP7Cf4n76xa8s/zTs+b8J2Gs48InJEM4+U=
=OY0Z
-----END PGP SIGNATURE-----

--nextPart2927578.JVIdYpNYua--

