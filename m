From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 07/11] mfd: Drop unnecessary static
Date: Mon, 24 Jul 2017 21:20:26 +0200
Message-ID: <20170724192026.GF32425@amd>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
 <1500149266-32357-8-git-send-email-Julia.Lawall@lip6.fr>
 <D2DCD2EA-E216-45D4-87F5-375C30F4AC76@gmail.com>
 <alpine.DEB.2.20.1707152254380.5105@hadrien>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1707152254380.5105@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Mark D Rustad <mrustad@gmail.com>, Tony Lindgren <tony@atomide.com>, keescook@chromium.org, kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Drop static on a local variable, when the variable is initialized bef=
ore
> > > any possible use.  Thus, the static has no benefit.

Actually... it has possible other benefit -- saving stack space. I've
used static for that purpose before. So ... careful with the
automation.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAll2SHoACgkQMOfwapXb+vJ/BgCeJV9jNXiD3P7c9ZgXkWNaMmdy
Wu0An0OKd8tWIa0ig042NowwGtXv727U
=OuPP
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
