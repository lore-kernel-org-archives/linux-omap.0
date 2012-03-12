From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: OMAP DSS device tree design problems
Date: Mon, 12 Mar 2012 15:45:30 +0200
Message-ID: <1331559930.2097.100.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-JeQqltkxHosH/ZWcEd1T"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56896 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752604Ab2CLNpf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 09:45:35 -0400
Received: by lbon10 with SMTP id n10so1781465lbo.39
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 06:45:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Archit Taneja <archit@ti.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>


--=-JeQqltkxHosH/ZWcEd1T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm struggling with the design of the DT data for OMAP display subsystem
driver, and any thoughts and ideas are welcome. This mail is a rather
long one, where I'm trying to show the different approaches I've
thought.

So the .dts format would be something like this, taking 4430SDP as an
example. It's just an outline, missing dispc, hwmods,
compatible-properties etc, which are not so relevant here.

ocp {
	dss {
		dsi1 {
			taal {

			};
		};
	};
};

So there we have a Taal panel, connected to DSI1 output interface, which
is part of the OMAP display subsystem.

One thing to note here is that although there's only one panel under
dsi1 in this case, the current SW supports having multiple panels under
one output interface. And while the output can support only one active
panel at a time, we do have boards where two panels are connected to one
output, and there's some kind of HW switch used to select which panel is
enabled.

The first problem here is that I don't know how to manage the switch
part. With current SW we have had the switch handling in the board
files, in functions called when a display is enabled/disabled. I guess
one option is to have the switch related code in their own drivers,
totally apart from the dss code, perhaps offering a sysfs interface or
such. And then, if the switch happens to be in the wrong position, the
panel will fail in some way.

The second problem is about the DT properties. With multiple panels it's
not possible to do this:

dsi1 {
	dsi-ddr-clk =3D <250000000>;

	taal {
	};

	some-other-panel {
	};
};

because the panels could require different dsi clock rates. So we need
something like this:

dsi1 {
	taal {
		dsi-ddr-clk =3D <250000000>;
	};

	some-other-panel {
		dsi-ddr-clk =3D <350000000>;
	};
};

However, here the problem is that while ultimately we're interested in
the ddr-clk rate, calculation of the rate is non-trivial and may need
customizations at times. So instead of the clock rate we actually need
to define a bunch of dividers/multipliers.

But these dividers are OMAP specific things, and do not belong to Taal
driver. So this bring the question: is the general rule about DT node
properties such that only the driver handling the particular node should
read the properties in that node? So, in the example above, should the
dsi driver only read props in the dsi1 and dsi2 nodes, and never look at
props in the taal nodes?

So basically, can we do this:

dsi1 {
	taal {
		omap-specific-clk-divs =3D <1 2 3 4 5 6 7>;
	};

	some-other-panel {
		omap-specific-clk-divs =3D <7 6 5 4 3 2 1>;
	};
};

and the Taal driver would ignore those, but dsi driver would use them?
This looks like quite easy solution to this, but also doesn't feel
right. So my current idea is to have clk-div tables in the dsi node,
something like this:

dsi1 {
	omap-specific-clk-divs =3D <
		250 1 2 3 4 5 6 7 /* divs that produce 250MHz clk */
		350 7 6 5 4 3 2 1 /* divs that produce 350MHz clk */
	>;

	taal {
		dsi-ddr-clk =3D <250000000>;
	};

	some-other-panel {
		dsi-ddr-clk =3D <350000000>;
	};
};

Here the panel drivers would ask the DSI driver to configure DSI DDR clk
of 250/350MHz, and the DSI driver would then use the lookup table to
find the dividers. If the lookup fails, the DSI driver could fail or try
to calculate the dividers itself. Other platforms could handle the DDR
clk configuration however they see best.

---

Another thing related to DSI command mode panels is the DSI lane
configuration, and I can't make my mind if they belong to the panel
driver in some way or not.

So, again taking SDP board and Taal as an example, we have 6 pads on
OMAP which are used for communicating with Taal. The pads need to be
muxed to DSI mode like any other OMAP pads. Currently the pad muxing is
not touched by the driver, but I think it's doable in the DSI driver (as
long as the DSI driver knows the required pad config).

However, that's not enough.

DSI uses differential pairs for communication (a "lane" consists of two
wires), and we have always one clock lane, and a number of data lanes.
In Taal's case we have a clock lane and two data lanes, which means 6
pads/wires.

We need to configure which of the OMAPs pads is used for which function,
so, for example, pad x and x+1 are used for clock lane, and x is the
negative pair and x+1 is the positive pair. And this configuration has
to match the wiring going to the panel, so that clk+ from OMAP goes to
clk+ in the panel.

So it dts data we need something, perhaps, like below. Here we define
the pad numbers and polarities in an array, where the first cell-pair is
for clk, then data1, then data2 and so on (if there are more than two
data lanes).

lanes =3D <
	/* pad-pair number, polarity */
	1 0	/* DSI pad pair 1 is used for clk, pol +/-  */
	2 1	/* DSI pad pair 2 is used for data1, pol -/+ */
	0 0	/* DSI pad pair 0 is used for data2, pol +/- */
>;

Now, I don't quite know where this data should be. If it's in the
dsi-node, it doesn't work with multiple panels. But then, it's quite
OMAP specific thing. While other platforms probably need some kind of
pad configuration also, it may be something totally different. And so it
doesn't feel right in the taal-node either.

And a look-up table like in the clock case doesn't make much sense
either, as we don't have a key here, as we had in the clock case (the
dsi-ddr-clk).

So basically the only option I've come up with is to define the lane
configuration in the panel's data, and let the dsi driver peek there and
configure the HW. And this doesn't feel right.

 Tomi


--=-JeQqltkxHosH/ZWcEd1T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPXf36AAoJEPo9qoy8lh71qR4QAJbhwkImXs8b6Zi0hkuZTtDQ
yHmuMfMgvSiZW9fx1u7IEd7srb9c2Dmf5b7SA9z6e3y8pnYqbI+5jWKQPJ6Xd99t
LeoPKyANpZLu1S6Rg2ohdXOCPMw/XBKmNyVlEWnChU6Jef902TUIKL6DX5QPXmUt
WGLRlU3Qsu1+B5Y1KGpdoLKQfx3A+35h2YI/+PNvHMAph81XUQ+kBpxL5DMkZYq3
j/flnlkiDJc8eg+rbO17cuJwAxUjOSIR96dzIJoFlu2Lag/CbL0xUfRoc3kAfGRH
hGkO8vturBkHRacMqQYjfEg/hzaQOzUxXkU3lOzY8jSWFIQF1mLFMnh3nApKvJmt
m3anpL3O33gIMUZTquUPcg/SUbA0Tyhqp8HE3eocbZI3qDPjMIyEfbCcIUZK/MiR
ZtBogTr4evqYjzBwj8lN9M1dFssz8l9EYLQP5h6GL27FjlPpKYRjPWHjm04Ld2+x
tELM3Njx/mfK4xwzHJ8PIZ5x06psbBGB9AKT2xd6Lqo+yPkp3ygbiSYOsxwZ5EO3
5NxFNS2lg6lysSC8rLETx7gCvIt416CJB0TQ/2CyByqjRE1UAk8tuUz8YG+VMEfJ
WmzbTzgIcA0LYwybDDN32GUVmmYdof2e+DjPrKd8ybSKtzXfVMUc4yikxDomPrTQ
UzEyNSfc1SphqQzwCyjx
=fpk3
-----END PGP SIGNATURE-----

--=-JeQqltkxHosH/ZWcEd1T--

