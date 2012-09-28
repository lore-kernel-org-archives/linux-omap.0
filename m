From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Powering OMAP's pins
Date: Fri, 28 Sep 2012 09:13:47 +0300
Message-ID: <1348812827.4872.10.camel@lappyti>
References: <1348568474.2342.35.camel@deskari>
	 <20120925153806.GC4840@atomide.com> <1348592700.2342.49.camel@deskari>
	 <20120925190721.GD4840@atomide.com> <1348643142.2376.13.camel@deskari>
	 <20120926185912.GG4840@atomide.com> <1348730334.5559.9.camel@lappyti>
	 <20120927184341.GK4840@atomide.com> <20120927185138.GL4840@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Z2c0+JE/fFpC5VSWvcpN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:48087 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751700Ab2I1GOR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 02:14:17 -0400
Received: by lagh6 with SMTP id h6so853359lag.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 23:13:54 -0700 (PDT)
In-Reply-To: <20120927185138.GL4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>


--=-Z2c0+JE/fFpC5VSWvcpN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-27 at 11:51 -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120927 11:45]:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120927 00:20]:
> >=20
> > > I could be mistaken how to HW works (but it does work like that for
> > > dss), but sounds to me that uart and gpio drivers (and perhaps some
> > > others, I didn't go through all the pins) need similar pin->regulator
> > > mapping as you suggested for omapdss.
> >=20
> > Yes it seems that there are supply voltage regulator domains
> > that are specific to some subsystems. I wonder if these are needed
> > in all mux modes, or only when the pins are muxed for that particular
> > subsystem? It could be that the documentation is missing some
> > information here..
> >=20
> > For example, what happens if you try to use some vdds_dsi powered
> > pin in GPIO mode without vdds_dsi?

I have not tested that.

> Seems like this may provide some clues from "3.6 Power-up and Power-down"=
:
>=20
>  "If the SDI, DSI, or CSI2 and CSIb interfaces are used in standard
>  LVCMOS mode (that is, GPIO mode) rather than PHY mode (that is, serial
>  differential mode), then vdds_sdi, vdds_dsi, vdds_csi2, and vdds_csib
>  may also be connected to vdds. Please, see the recommended SDI, DSI,
>  CSI2, and CSIb power supply noise of Table 3-5, Recommended Operating
>  Conditions."
>=20
> So based on that it seems that tweaking of the regulators for these
> pins is only needed for DSS etc, not for GPIO or serial usage.

I don't read the above paragraph the same way.

What I think it means is that if, say, a board does not use DSI at all,
the vdds_dsi input pin in OMAP could be connected to vdds instead of the
normal DSI power from the TWL chip, thus making the OMAP's vdds_dsi
"always on". Which means that in some boards the vdds_dsi in TWL is not
needed if the pins are used.

However, that doesn't mean that the vdds_dsi input is always connected
to vdds if the pins are used for non-DSI uses. A board may well use only
some of the DSI pins for display, leaving the rest free for other uses.
E.g. on omap3 there are 6 DSI pins, and a display panel could well use
only 4 of them. If the 2 other pins are used as GPIOs, handling vdds_dsi
is still required when using those GPIOs.

So I think the above paragraph confirms that the power for the pins is
indeed required, and handling for the regulator is needed for GPIOs,
uarts, etc. also.

 Tomi


--=-Z2c0+JE/fFpC5VSWvcpN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQZUAbAAoJEPo9qoy8lh711mgQALB09XwjaGaI2C6JV0p+0mqH
dalmcDrzg0R9/lLsxTQ3IvLaR0a831jen9atbSZJbhjNbNKfNnb/G8uONqayFThh
DMEiTu6XglPQcTACetlwvmACAVW6MUR+ERA+ztcyJiQ7IjljPbsGF1U1T9WDxuzE
5JUjoceymIHwmexILErXGQuFQFK1P4CRH+6NNoE6b9+HYRL2I0DS5aB6ZHZFjkTz
Y9yYN5SOlVeKCrg6JHgjZPGjgcQQAtFou0rpvnvXh0lO40DEMkvzBlTd1x8YoS/2
XSPbyA79G8/O4WT3ICfCcCQwBADdlSaB+QhSlB3eLzST9D4Z3NfRB1lBdigZtSRY
cjyfQhzW9Ef+KUOEGfGvZ1i8vYLD9OIaqeG26/9GFT1w+7KoDaTo2sTF+B4AAZ3c
I1FYHklevzrEsEbdnHdSNZGdd5dq/5Ly6pj/bvzQutNGruE5F1xV7uQVvD1/QF2G
aBGAEDyP3gmuDQ0KjIjqQKIolt70ouDwNxyk7vTPp4k8TkWY2LphUfBN25WxpLGj
7yXmu9Lk8+soflSlrnrqnJCvV39AR6cKBQZC+YPcjxGbXWeYNQO3YnYRhxWsQp8G
6TJUCWIqT7U8OGapmxAzm8HK4XfTfLl3NTepLDxjn/lpslUPzACyVlYyGQxSA3Gz
WMIgUA4h+IoDQh+WIIPj
=RS7n
-----END PGP SIGNATURE-----

--=-Z2c0+JE/fFpC5VSWvcpN--

