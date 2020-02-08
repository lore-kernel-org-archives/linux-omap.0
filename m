From: Pavel Machek <pavel@ucw.cz>
Subject: Re: mmc0 on Nokia N900 on Linux 5.4.18
Date: Sat, 8 Feb 2020 20:04:48 +0100
Message-ID: <20200208190448.GA12984@amd>
References: <5362c659-120f-5247-aaa5-7916229300bc@wizzup.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:47694 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbgBHTEv (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sat, 8 Feb 2020 14:04:51 -0500
Content-Disposition: inline
In-Reply-To: <5362c659-120f-5247-aaa5-7916229300bc@wizzup.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "Arthur D." <spinal.by@gmail.com>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> When booting Linux 5.4.18 with omap2plus_defconfig, I no longer get a
> /dev/mmcblk0 device - the one corresponding to my microSD card, where
> u-boot also loads the kernel from.
>=20
> This also likely seems to be a regression, but I haven't tried to hunt
> it down yet.
>=20
> Kernel log attached, below.

Do you have back cover attached? That's common trap...

Best regards,
								Pavel
							=09

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4/BlAACgkQMOfwapXb+vITUQCgoiH2D1wFnADsQ4UFgBXrK9fn
P4IAoKnRWeiMKsmhjmiNTOEs1bcQ2sLR
=k/Du
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
