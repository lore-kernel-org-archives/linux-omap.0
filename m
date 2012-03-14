From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP DSS device tree design problems
Date: Wed, 14 Mar 2012 14:06:34 +0200
Message-ID: <1331726794.2386.66.camel@deskari>
References: <1331559930.2097.100.camel@deskari>  <4F5FCE64.5070902@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-vagGhaxUtYPFFmc1EC/p"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:47372 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758660Ab2CNMGi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 08:06:38 -0400
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so2177679lag.17
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 05:06:37 -0700 (PDT)
In-Reply-To: <4F5FCE64.5070902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Turquette, Mike" <mturquette@ti.com>


--=-vagGhaxUtYPFFmc1EC/p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-03-13 at 23:47 +0100, Cousson, Benoit wrote:

> I'm just wondering if the multiple panels is something supported by the=
=20
> DSI protocol or it is a HW hacks done on TI board only?

In theory both, but the driver doesn't support multiple panels connected
to single DSI output at the same time. And that is, in a way, easier
regarding DT, as all the configuration parameters are specific to DSI
and the panel.

But the case at hand is that two panels are connected to single DSI
output, but there's an external switch/mux between the DSI output or
GPIO lines and the panels. It's not a HW hack on TI development boards
only. The means to switch between the two displays can be anything, from
setting a single GPIO to, say, sending i2c commands to some mux chip.

> > However, here the problem is that while ultimately we're interested in
> > the ddr-clk rate, calculation of the rate is non-trivial and may need
> > customizations at times. So instead of the clock rate we actually need
> > to define a bunch of dividers/multipliers.
>=20
> Well, in theory you should not. This is up to the clock provider to=20
> convert the clock rate in the proper n/m value. This is how it is done=
=20
> for the regular OMAP DPLLs.

Right. But it's a non trivial problem. There are multiple
dividers/multipliers in the path, and the clocks from different points
at that path are used for different purposes. Some of the div/mul fields
are quite wide, so there are a lot of numbers to iterate.=20

And in many cases it's important to get sometimes exact, and sometimes
almost exact, clock rate, but still at times go with a less exact clock
rate if that gives you lower power consumption, or some other similar
side effect.

So we currently calculate the dividers manually in most cases.

> > and the Taal driver would ignore those, but dsi driver would use them?
> > This looks like quite easy solution to this, but also doesn't feel
> > right. So my current idea is to have clk-div tables in the dsi node,
> > something like this:
> >
> > dsi1 {
> > 	omap-specific-clk-divs =3D<
> > 		250 1 2 3 4 5 6 7 /* divs that produce 250MHz clk */
> > 		350 7 6 5 4 3 2 1 /* divs that produce 350MHz clk */
> > 	>;
>=20
> That's the idea, except that this will represent the clock provider.

Hmm... So. Should I have something like:

dsi1 {
	dsi1-pll: dsipll {
	 	clk-table =3D <
 			250 1 2 3 4 5 6 7 /* 250MHz clk */
 			350 7 6 5 4 3 2 1 /* 350MHz clk */
		>;
	};

	taal {
		dsi-clk-src =3D <&dsi1-pll>;
		dsi-clk-rate =3D <250000000>;
	};
}

But no, I don't think that's correct. The panel is not using the DSI
PLL. DSI protocol engine and DSI PHY are using the DSI PLL, and they
produce the output on the DSI bus, with the speed that the panel wants.

> > 	taal {
> > 		dsi-ddr-clk =3D<250000000>;
>=20
> And here you will have a phandle to the clock provider. And use it to=20
> set the proper clock rate.

I'm not sure if a "clock provider" is correct here. It's not really a
clock, in the strict sense, that goes to the panel from OMAP. It's the
speed of the DSI bus we are talking about here.

> > lanes =3D<
> > 	/* pad-pair number, polarity */
> > 	1 0	/* DSI pad pair 1 is used for clk, pol +/-  */
> > 	2 1	/* DSI pad pair 2 is used for data1, pol -/+ */
> > 	0 0	/* DSI pad pair 0 is used for data2, pol +/- */
> >> ;
> >
> > Now, I don't quite know where this data should be. If it's in the
> > dsi-node, it doesn't work with multiple panels.
>=20
> Is the lane configuration only dependent of the panel?

If you mean, is the lane config the same on every board that uses the
panel, then no. The lane config tells which pin on OMAP is used for
which purpose in the DSI bus.

So if the DSI panel supports two datalanes, it means it has 6 DSI pins:
2 for clk +/-, 2 for data1, 2 for data2. The HW designed then connects,
say, the panel's CLK+ pin to one of OMAPs DSI pins. The OMAP pin has to
be configured in the system config level for DSI operation, and also we
need to configure the function of the pin to CLK+ in the DSI HW module.

> > But then, it's quite
> > OMAP specific thing. While other platforms probably need some kind of
> > pad configuration also, it may be something totally different. And so i=
t
> > doesn't feel right in the taal-node either.
> >
> > And a look-up table like in the clock case doesn't make much sense
> > either, as we don't have a key here, as we had in the clock case (the
> > dsi-ddr-clk).
>=20
> The lane configuration code will belong to the DSI driver. The data will=
=20
> belong to the panel. The panel might use some phandle to the various DSI=
=20
> lane config a provide the needed information.
>=20
> This look pretty similar to the pinmux device tree binding that is=20
> currently under discussion.
>=20
> > So basically the only option I've come up with is to define the lane
> > configuration in the panel's data, and let the dsi driver peek there an=
d
> > configure the HW. And this doesn't feel right.
>=20
> This is fine, except for the last part. The panel driver should retrieve=
=20
> the data from the panel node, and call some DSI configuration API using=
=20
> the DSI phandle retrieved from the panel node as well or using the=20
> parent node directly if the hierarchy is always the same.

Ok. Then the data format for the lane configuration needs to be generic
so that it fits to all platforms. The one I had is omap specific.

Hmm... Perhaps then something like this:

lanes =3D <
	2	/* clk + */
	3	/* clk - */
	4	/* data1 + */
	5	/* data1 - */
	0	/* data2 + */
	1	/* data2 - */
	>;

Here the number maps to a DSI pin on the particular DSI output used by
the panel. The DSI driver then needs to use some logic to decide what to
do to convert the pin number in the lane data to actual HW
configuration.

 Tomi


--=-vagGhaxUtYPFFmc1EC/p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPYInKAAoJEPo9qoy8lh710WQP/i5IcO0fNY4meziB5NlRhL53
/qwnZg09Au3S7r+AFmV/11L8kWfy4fqqFsbsVV7SihD/ZLXTIk14R5Qk7EjiZDyk
lxAYQSaYK3wXdjdk5FAn3fNI9ZpWdgsHceZfqFluezKxRPrOtTNrHMmDvfWdAUEd
eDAtCvQIRl9Vec6X34g0EHAcnsOHAB+7XZxxbMq3SaVcYTXzYO8hJrfLIUghvKtK
bfKdkpDPmqpn10FUqiJENUfshKDD26iOhqARxLIXI95bGmqMfoQdNCUMnIiU70gN
E+I6cjVLPmCxBMeBOCME3mU4Qr0AEPH9IBq8j4GUyVxnZmD4jNCjACaDoecbr+Qx
0HJ5ZyVGtreDAFwsbMJID+b/ngSQevxjFj4U5ZZtBjV7W6w5N9InYxX3pbn62nUw
biIdMte69VirCHGWyI2MTr6PxRvx7OjCHCxt/ald7ULHPajxoarQgHjVKSNupfeO
eTi9+ToyWYT6Rz5nSzHhiR4GeaSae4wfa9X1avumXACP3e9H8+kWxgxOchuaL0A1
CTCfvjtWcUNlYr4iZBLLnAd3uGEpovuWdyI2oblmVzkvNmJxSXRJBjyjLVrob4oW
E+sUvk7dQL/GYhAnCRndzM7sXcta/yqYrdtfk3lRTHJ6tHc0uIj5P/KGc4HRzRL5
bBPMbBgMv4T/a7jNBrEs
=trrT
-----END PGP SIGNATURE-----

--=-vagGhaxUtYPFFmc1EC/p--

