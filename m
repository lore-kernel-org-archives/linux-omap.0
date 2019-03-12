From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH v2 0/7] i2c: core: introduce atomic transfers
Date: Tue, 12 Mar 2019 16:45:01 +0100
Message-ID: <20190312154501.6v2symbq6eutp6dj@ninjato>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <CAHp75Vc-WYUJgaDPuWUn-_0Cizq=MG7N2cdHJxaEbad+xntcjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zkokbbl47s6o5i5w"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vc-WYUJgaDPuWUn-_0Cizq=MG7N2cdHJxaEbad+xntcjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--zkokbbl47s6o5i5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > So, finally, here is the second RFC for supporting I2C transfers in ato=
mic
> > contexts (i.e. very late). This will need some text because I tried som=
e things
> > on the way but had to discard them. However, I think it is important to=
 have
> > that documented.
>=20
> > Sorry, no TLDR; text here - I think this topic deserves a few words ;)
>=20
> Thank you for this work! It was indeed interesting reading.

Thanks, glad to hear that :)

> And since your series is targetting some exiting use cases, I would
> drop as well academic variants of brain-damaged hw design, I think it
> worth to go.

Well, yes and no. I am with you that some complicated muxed setups could
be argued to be way over the top. However, with the panic
fault-injector, I can get my simple "PMIC directly (even exclusively)
attached to root adapter" setup to stall. By simply ignoring the lock,
such setups could work again. But this series does not implement this
because it would need a redesign, i.e. tie into i2c_transfer and not
later in __i2c_transfer.

Yet, before doing this, I was interested in discussion if ignoring the
lock is really desirable.

This series seems like a valid approach to me if we still want to
respect the locking.


--zkokbbl47s6o5i5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyH0/0ACgkQFA3kzBSg
Kbb02g//bFuyt6ZF0xKTx4YGhpVUmqDkQpdYzmFvXr2J4/UUeL43QsGvO4P05zuh
in13OeiEaWgo1tnE6u9E+DrzEDzPNRiTwER4SB24KbymIncuoyNhBE0UIbuglcbE
j1XUxgKQMl4YhZuTKGWZVuBCFaPty4vSxSzjrYgE2pk59ETbZiKOplCkklTHhfVX
u77k21N3rO8DJpqhRAsEc2hA5hIH8PTw/TfDlwC6/QQNmHZDHxBS7Ae6t36mkhSS
jHhI17n+oXL/WJqcQp0vPaU7rXuS8ZMw9VuoB/djEuZC7POxydKERicPKUKpcM8x
iFBWBP370FOQGXxOnCUrwz6j9cooR3D7frKliTmQYWn3WKf1mf7lcW1cVqpxzp5h
U+PbpWwI1ZmqixC2XhNfhmKuWaLfIcCj0UacaSge0Fya+P1nIg+RSnm0OBuMa0uW
wKrVXMKUPcDY8IFcqygQE0kkmPnws5kQI1/mN62efcLmI5+Z/zNNx+y1Axyv8Mq8
dteeml5Ig8tiRzUDLBmCv/MYMDEJTi4guZe7NLPCz04Z8TGMgXtp0bkoFM5TRwET
iWl3w9okHcetxUO8Mf2RkS80p6yy0b0B1Z9ND4IjcSkvunXxRl+ygtwjHtd68iZK
ujH2j4D5SGLXuygLnSsjpJXRzN+FjoXnuF1Y880JSCoNhJ6aL0c=
=rDLe
-----END PGP SIGNATURE-----

--zkokbbl47s6o5i5w--
