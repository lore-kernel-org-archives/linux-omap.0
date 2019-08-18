From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: wifi on Motorola Droid 4 in 5.3-rc2
Date: Sun, 18 Aug 2019 13:46:51 +0200
Message-ID: <20190818114651.GB32205@amd>
References: <20190818104629.GA27360@amd>
 <CAOf5uwnUx3mtGGHFGqKB30qcb_AMhMEhHLp2pf-4pUdhi7KP7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOf5uwnUx3mtGGHFGqKB30qcb_AMhMEhHLp2pf-4pUdhi7KP7w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, nekit1000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mpartap-hi6Y0CQ0nG0@public.gmane.org, Merlijn Wajer <merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org>, "open list:TI WILINK WIRELES..." <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > First, I guess I should mention that this is first time I'm attempting
> > to get wifi going on D4.
> >
> > I'm getting this:
> >
> > user@devuan:~/g/ofono$ sudo ifconfig wlan0 down
> > user@devuan:~/g/ofono$ sudo ifconfig wlan0 up
> > user@devuan:~/g/ofono$ sudo iwlist wlan0 scan
> > wlan0     Interface doesn't support scanning.
> >
>=20
> Try to use iw command. iwlist use an obsolete interface that you need
> to activate in kernel for back compatibility with old command. Can be
> your problem?

Two more reboots (with no changes in the config) and wifi now
works. Thanks!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1ZOqsACgkQMOfwapXb+vJeKgCgszMHogT0O+ruZtqWBP12TiL9
+ksAoKsdUdt9JhrYHrfPq4rbghETIMap
=hXX3
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
