From: Sebastian Reichel <sre@ring0.de>
Subject: Re: N900 board code in 3.14
Date: Fri, 22 Nov 2013 00:51:13 +0100
Message-ID: <20131121235111.GC9772@earth.universe>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <20131116120508.GA22335@earth.universe>
 <20131116141226.GD10317@atomide.com>
 <20131116155031.GA5104@earth.universe>
 <20131121185844.GA10023@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:35730 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab3KUXvX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Nov 2013 18:51:23 -0500
Content-Disposition: inline
In-Reply-To: <20131121185844.GA10023@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Thu, Nov 21, 2013 at 10:58:45AM -0800, Tony Lindgren wrote:
> Also, I just posted a patch to fix the eMMC that you may want to
> try out.

Let's move eMMC diskussion to that patch :)

> > > > [...]
> > > >=20
> > > > My suggestion would be:
> > > >  1. Find a better workaround for omapdss to acquire the SDI
> > > >     regulator. My current hack is obviously not acceptable.
> > > >  2. Load the panel driver via DT as seen above and reference
> > > >     the omapdss interface with something like the above
> > > >     "ti,dss-source".
> > >=20
> > > To me it seems that we should be able to add minimal panel entries to=
 DT
> > > if we stick to existing standard bindings. Then the timings etc can be
> > > set up based on the compatible flag. So I would leave out the propert=
ies
> > > for ti,sdi-datapairs and ti,dss-source for now, and just set those in
> > > the driver based on the sony,acx565akm compatible flag. Or maybe it s=
hould
> > > be sony,acx565akm-n900 if there's some board specific configuration i=
nfo.
> >=20
> > So we add reset-gpio and label to the DT data (they are panel
> > specific and independent of omapdss) and just hardcode "dsi.0"
> > with 2 data lanes into the driver? That sounds fine for me.
> >=20
> > If neither Tomi nor anybody else has better ideas I will cook a
> > patch for that. I'm not sure how to setup the vdds_sdi regulator for
> > omapdss, though. Is there an example for a legacy driver using a DT
> > regulator available?
>=20
> Not that I know of :)

Javier Martinez Canillas patch did what I was thinking of in [0].
My suggestion would be to add something like this pseudocode to
omapdss:

if(board_is_n900_dt()) {
    vdds_dsi =3D devm_regulator_get(&dpi.pdev->dev, "V28");
}

The problem is, that we do not want to name the regulator
"vdds_dsi", since it's not used exclusivly for omapdss.

In the future it can get the regulator via phandle of course.

> But I guess only the panel driver would need to parse the
> compatible flag and the rest of the DSS could still be initialize
> the legacy way if needed.

Yes, except of the regulator. I will try to get this working
tomorrow.

[0] http://www.spinics.net/lists/arm-kernel/msg286896.html

-- Sebastian

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSjpxvAAoJENju1/PIO/qaC1wP/Ru8HxiHX/XFqzeuOt76pmfn
7GoCxO0puU8ourO7TbmOLicxfFE402MyDpmDDzIcdNfZNXoU4PQUyx98WB3ncTmr
IvxDfexLgKkg6Z5xe5ghk2CoBh3pkzvakTzwopqhthf5qCmL5scKAVu1nYsyNLeC
KMuPYmkkR5yd1lLswzUGmnaWE1N1WI2w8654Mk4gwJ0Ek44kwwXQc5IeDTY4yERR
c7+KzcSJJo4pU0CzyvFnG/STM4RX2E80c0hD1AvsrHkj3CV+xtae8Ki+h88AM/o0
OYd/3MTaFUwxx7LaeIyL8P3VfP+XvC38fbvxpiieuqv90bM8gAGbz6vGUS9fT6J9
JZ8sej8G8KluppXZsEgbZiR+/5iDdTs6dECMV9cmFvgE12QpQ39e+EtF6RtbAEx0
KErY2dKQ3KEJJY2zrx1pZ3TB2KRA9X5wEn5HpjD8sA4JRNoC+Z0uTksQK3/GrDh+
TW5ObCZCkGwVzQ6jRMqH0RgWGN9GGEmZO4aoXMOnk+PMgMK5OGyrQhuhfAKA5vzo
dwJKUmrHbFsCxA1hrJS+X3PCKNYQ8PCOWZC0mvivAz09mlvMFz8jqIn+w090WFgq
wYL6T5ZGTuRwwRrhmGnLGo6uBoP6FbtLhf9dg9AKZ0PcnbfsPNIXvkBs9kC6v2zB
bdiqCW1VU60CbRACsdz9
=Is9G
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
