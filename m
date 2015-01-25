From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Sun, 25 Jan 2015 22:49:48 +0100
Message-ID: <20150125214947.GB20695@earth.universe>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <20150113204219.GJ2419@atomide.com>
 <20150115142536.GC512@earth.universe>
 <201501241300.00723@pali>
 <20150125212015.GA14307@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35207 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbbAYVty (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 25 Jan 2015 16:49:54 -0500
Content-Disposition: inline
In-Reply-To: <20150125212015.GA14307@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2015 at 10:22:58PM +0100, Pavel Machek wrote:
> > Another regression for DT setup (which does not occur for board code):
> >=20
> > omap_hsmmc driver does not export slot_name sysfs entry because
> > it not supported by DT yet. Entry slot_name is used by userspace
> > application to determinate if mmc block device is internal eMMC
> > memory or external uSD card. So support for this property also in
> > DT is needed.
> >=20
> > Here is simple patch which fix this problem:
>=20
> Thanks!
>=20
> Does it need line into Documentation/devicetree/ somewhere?

Documentation/devicetree/bindings/mmc/mmc.txt (generic)
Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt (omap specific)

-- Sebastian

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUxWT7AAoJENju1/PIO/qaNiMP/0rjUsyPGFTfegZoB/qPV0VR
SQlGRLadjXAGggpCMY7Q+a0oYrENZOw5EeA4Odk3L70cUs2fcXbeChAkz1kQYeoP
GQf35B/2qhXO5sWjCQXLd4Isc4tu2TRHRMKspa2fr1HClTTTQTVTZTIrxEn/oYJc
QIp5dSxC7ELocOY+ov6Lk590t2ku9EX84mg/JSPjDLNTIWW3u39QRzRnJBQnVzCj
nzH65Axoxww38AyWvxl8zvQJ9uFx6MgEma3oEn9y42z1Pu4em8Dn25KKSaFmZvTg
vsDxIfjsWht4VvpBDVCv8E/utCY8iPCRUbRrKI6ZHS1SQ0OOuuKdeq1HzNt4jCLT
BwrG5hUWiZTbclKiR8y3lpELoFzn6i5V0mD7zxErtnQYAsEOWSfncVp2DGgkWyer
ltReLrcjg1Tb4LhDtZ0B5uYoPcIKxn/MtFSp/tMfIAhY41szYUgEUhnS4Pad+H2Q
HA9hqJxt1PyUFNd9pWLNZgRtnGVTOuZ4zbpzNjBsT+XURSCLL7RCvVCaZh9DSPzi
Jv6XUzwnrCgMDEOXfqx8SmIbF4LOpsg7RVuVjYClI8AlNm7gFM2g3h0EjzPXvoyw
QL50vmuZhqe1hcPg98W2Bwr7WLdxPGSHiZXCY/ll9kZRfPQuQjahUnDsPGshcuc5
vPIwmG4pIC/7igcrSoP6
=fYyz
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
