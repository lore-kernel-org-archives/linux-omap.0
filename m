From: Sebastian Reichel <sre@ring0.de>
Subject: Re: N900 board code in 3.14
Date: Sat, 23 Nov 2013 22:09:13 +0100
Message-ID: <20131123210912.GA29088@earth.universe>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <20131116120508.GA22335@earth.universe>
 <20131116141226.GD10317@atomide.com>
 <20131116155031.GA5104@earth.universe>
 <20131121185844.GA10023@atomide.com>
 <20131121235111.GC9772@earth.universe>
 <CABxcv==b-Nj4ADT+qN9qLC8bL5raqkRkaLkGG0cMNrZV8njhDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:56920 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab3KWVJp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 23 Nov 2013 16:09:45 -0500
Content-Disposition: inline
In-Reply-To: <CABxcv==b-Nj4ADT+qN9qLC8bL5raqkRkaLkGG0cMNrZV8njhDg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 22, 2013 at 11:41:27AM +0100, Javier Martinez Canillas wrote:
> I dropped that patch from my series and posted a v2 that just name the
> VPLL2 regulator as vdds_dsi [1]. That way will be safer for Tony and
> Benoit to take this series as a fix for the -rc cycle since the
> changes are contained within IGEP boards DTS.

I know, but the patch serves as example for me :)

> > My suggestion would be to add something like this pseudocode to
> > omapdss:
> >
> > if(board_is_n900_dt()) {
> >     vdds_dsi =3D devm_regulator_get(&dpi.pdev->dev, "V28");
> > }
> >
> > The problem is, that we do not want to name the regulator
> > "vdds_dsi", since it's not used exclusivly for omapdss.
> >
> > In the future it can get the regulator via phandle of course.
>=20
> For what is worth I think that your suggestion is a good workaround.
> Please just add a comment specifying that it is a hack and that we
> have to get rid of these once the DSS DT bindings land on mainline and
> we can use a phandle to get the regulator.

I just sent a patchset, that adds DT panel support for N900.

-- Sebastian

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSkRl3AAoJENju1/PIO/qaWUwP/jb2mBZc0ZyVK06ObxGiWkBR
yz966blVNeXEwFjUyWwx8UJrpBGBxfQNSlsTK4RZmzdz7efWnDx4neVSz7n1xxJh
6+q5JS3PNCd577XiLYRtZz98tb8J8ierWKfx7YLF8WALANyuBM+feU2bNJ6jocib
s6+MHQOVuZrvRXOrN5laO9V6MUD9EC3Oh7gkX3l/KaR6JalBzUyKDkpqDH6hHK40
pE0Rjlo9rWkz2fV9fWXHxHPISh87QLId8CgiSZpozUeYwTXqqa5m99PbtFGn2hI9
aAwta1kM9OqGsL21NKqd9b8FC3DTHgCwJytrB+FKtWDFpn04LofEfOlpoTbok7/b
F5n8G75qEAwiKht5rRBJhWcEWU3Ykrmc+UG7Yggx8twdAMXYR/ZWAtT1LZKfBLVk
4a5B0Uldfh3lO/cGxiv8bM2J7y7Z7O3ecttB92v6nmTftLB/0O4nf7EIdM77fbA6
3TO5plOPQR8KHrMYXzuzx+0vsgrFqUuj+6t6oAeKtRSAGFDphOkuucWS6LMAm1ck
GrzOiM5noZz0Ar1TLKnf7HSCARE7OXGSlQEtLze5VsKB7cNL5k3Uj1ycVkiGBv1w
cUiz3rr/sPTlHlstkHnB/vSPhyYpz3eDPGOI4UByDTESQE2MpIvEub8rQ8z7b3sZ
tnNbgF/MjpmP8iR+WoRM
=Q1c1
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
