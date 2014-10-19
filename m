From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: USB Ethernet gadget on Nokia n900
Date: Sun, 19 Oct 2014 16:58:45 +0200
Message-ID: <201410191658.45851@pali>
References: <20141019090107.GA19132@amd> <20141019100739.GA2547@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2906362.bYiEn6s3DN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141019100739.GA2547@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart2906362.bYiEn6s3DN
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 19 October 2014 12:07:39 Pavel Machek wrote:
> On Sun 2014-10-19 11:01:07, Pavel Machek wrote:
> > Hi!
> >=20
> > From 3.6 to 3.10, USB networking works on Nokia N900. With
> > 3.11, it fails with messages on the host. I also tried to
> > get it to work on 3.14 and 3.17, with no luck.
> >=20
> > Any ideas? Does it work for you? Any config options to watch
> > for?
>=20
> With 3.17, I get
>=20
> omap_musb_mailbox: musb core is not yet ready
>=20
> message. It looks related...?

Can you try tree https://gitorious.org/linux-n900/linux-n900/ ?

I think with rx51_defconfig from above tree it worked fine for=20
3.10 - 3.13 versions.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2906362.bYiEn6s3DN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlRD0aUACgkQi/DJPQPkQ1J+1wCfcLaU/j4/zQfX7IVsCMtuKaNc
TksAoMtKmguK1txrwe8WDZQwKuARe1QL
=CI8B
-----END PGP SIGNATURE-----

--nextPart2906362.bYiEn6s3DN--
