From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Tue, 21 Aug 2012 13:49:49 +0300
Message-ID: <1345546189.4085.52.camel@deskari>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
	 <1345023063.3494.20.camel@deskari> <502BBFBB.6090303@8d.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-kq8+dePPdzNcOhCtqfaf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:52839 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756539Ab2HUKty (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 06:49:54 -0400
Received: by lagy9 with SMTP id y9so4124774lag.33
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 03:49:52 -0700 (PDT)
In-Reply-To: <502BBFBB.6090303@8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Cc: linux-omap@vger.kernel.org


--=-kq8+dePPdzNcOhCtqfaf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-15 at 11:26 -0400, Rapha=C3=ABl Ass=C3=A9nat wrote:

> > +
> > +	/* ChiMei G121S1-L01 */
> > +	{
> > +		{
>=20
> ...
>=20
> > +			.vsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
> > +			.hsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
> > +			.data_pclk_edge	=3D OMAPDSS_DRIVE_SIG_RISING_EDGE,
> > +			.de_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
> > +			.sync_pclk_edge	=3D OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
>=20
> Actually those 3 panels only use the DE signal. The hsync/vsync signals
> are not used and on our system we mux them out to make sure they are
> kept low as recommended in the panel datasheets.
>=20
> Since vsync/hsync are not used, I think the vsync_level, hsync_level and
> sync_pclk_edge entries could be removed. Otherwise the updated patch
> works fine as is.

Okay. How do panels like that work? How can they know where a new frame
starts?

Actually, I now googled for those panels, and they are all LVDS panels,
not DPI panels. So the patch doesn't look correct at all.

Do you have a DPI-to-LVDS converter chip on your board?

 Tomi


--=-kq8+dePPdzNcOhCtqfaf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQM2fNAAoJEPo9qoy8lh71S1sP/jKPflNHqGyCU1+ur9AnSowq
6gG/Xf4mnTv8tEOfrhIW18lu+ixekOwHm37w/SBnxN6fr0KcUCI+XdLk7ksotyR3
1e1PD3ieFAzbiqwMdNmhcM6etcUW+qGbxwr4csOGlAFknOgh8W7h7sQVnxBR+9wJ
yhLWMVauNFMgEkgCjCCB0qRrLxq6sduMUos1PPGVN0G8HuizHUHOSEkoeuzFJlLR
NcCzL4GyOiBvKV5ninT0QEvX0pof/qR+F9WCUnzoGhvOEkiJQAWwcOs92PIuBGUd
YEMfViz+vSjAToBMKbmfjc/d49Dz90SmU0Cte2dRcDaqgil9PiqEJePoIahFAkf9
TC/oD51eVvQED52Ouw0mokEq3Q11MtA2sJS5GU6J81TIEw7UTyvOlvTbNQpAYIxA
AMxG+NLZ2N+H1zp5+N7HtbvDl6ZNPDhS5pFKBxczYW9pTsayWUwnPs0nL5VvnloK
L7H0Z6Wceg4HNBQ0bdKcBb4UwoAiRFta8I+iB199sCoyjNDPZ6X9ewYv9TrnJcug
g50BqoYRn1eWo9ySvDWFC2yLPd0CLx600jc0CMe37JK0CBN34tM6xaVfmUySUZZq
ZpDk5vYaFtRqBIy6j6sY4Ehwtkn9c5jfsCkXblGIaCRT6Co6y5PhWg/AeYBnyDyI
Urv5JEoOnhEC9akBez6s
=uLst
-----END PGP SIGNATURE-----

--=-kq8+dePPdzNcOhCtqfaf--

