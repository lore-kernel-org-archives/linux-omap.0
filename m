From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 00/18] mfd: demodularization of non-modular drivers
Date: Thu, 7 Mar 2019 09:35:18 +0100
Message-ID: <20190307083518.GA8052@amd>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
 <20190116132431.GE23399@dell>
 <20190306231003.GD7915@amd>
 <20190307041808.GK26690@windriver.com>
 <20190307082524.GB4634@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307082524.GB4634@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@gnudd.com>, Arnd Bergmann <arnd@arndb.de>, Charles Keepax <ckeepax@opensource.cirrus.com>, Cory Maccarrone <darkstar6262@gmail.com>, Davide Ciminaghi <ciminaghi@gnudd.com>, Dong Aisheng <dong.aisheng@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Haojian Zhuang <haojian.zhuang@marvell.com>, Jin Park <jinyoungp@nvidia.com>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mattias Nilsson <mattias.i.nilsson@stericsson.com>, Michael Hennerich <michael.hennerich@analog.com>
List-Id: linux-omap@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Pavel, I hope this more extended explanation makes sense to you, and
> > that you simply have not seen me write these same details in the past.
>=20
> Blimey.  That's a really long winded way of saying:
>=20
>   "Modular-ness is actually broken in these drivers; [Paul]'s patches
>    make that point clear for all to see.  If people (authors/distros)
>    wish them to be modular, they need to fix them properly."

Has that been checked?

I mean... when I saw the patch I thought "perhaps it should be doing
bool->tristate instead"?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyA18YACgkQMOfwapXb+vLAxgCgjWvBc8EJQsh4mCq7bC/TE0MP
NMcAnj2AFRWY1cOOafm4t7W7JJ/IunmV
=V5hv
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
