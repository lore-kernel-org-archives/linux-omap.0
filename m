From: Pavel Machek <pavel@ucw.cz>
Subject: Re: partial bluetooth success on n900 [was Re: bluetooth/uart
 timeout handling]
Date: Wed, 14 Dec 2016 13:53:23 +0100
Message-ID: <20161214125323.GA4951@amd>
References: <20161016002454.ul5rdqwubvkct4pf@earth>
 <20161018224259.jrwbaal27irzjqyo@earth>
 <20161019092506.GA1461@amd>
 <201612141321.30181@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201612141321.30181@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: tony@atomide.com, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > [  220.248596] tty ttyO1: Radio packet sent
> > [  220.249328] Bluetooth: hci0: Frame reassembly failed (-84)
> > [  220.272949] tty ttyO1: wakeup received: 1 -> 0
> > [  221.283477] tty ttyO1: radio packet timeout!
> > [  221.283630] enqueue: hu c304cc80 skb cd4a9b40
> > [  223.363372] Bluetooth: hci0 command 0xfc18 tx timeout
> > pavel@n900:~$
>=20
> In log are still some failures, but ... is bluetooth working now?

It is... for Sebastian. I'm playing with camera now.

> I see that you applied this patch:=20
> https://git.kernel.org/cgit/linux/kernel/git/pavel/linux-n900.git/commit/=
?id=3D051aa3fbf03ac770d8344690f5a936a7f04c6884
>=20
> Looks like that pinmux is in DTS file incorrect. Can somebody verify it?=
=20
> Maybe Tony?

Yes, it is. Sebastian was pretty certain about that.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhRQMMACgkQMOfwapXb+vImVACfV20SxCy9Q6wkszEJZZT6t6nK
obIAoIJZbo16tmQBnKSiv6uYHLCgbiQa
=zBMr
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
