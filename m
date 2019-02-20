From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] regulator: tps65218.c: fix LS3 issues
Date: Wed, 20 Feb 2019 16:40:03 +0000
Message-ID: <20190220164003.GC9878@sirena.org.uk>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1550650552-26013-2-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550650552-26013-2-git-send-email-Christian.Hohnstaedt@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc: J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 09:15:50AM +0100, Christian Hohnstaedt wrote:

> - Fix list of valid LS3 currents from mA to =B5A
> - Fix selection of min/max microAmps of LS3.
>   Selecting one of the configured values as max value now really
>   selects it instead of the next lower one

This is two separate changes so should have been two separate patches,
that way things are easier to review since it's clear what change does
what and if there's a problem with one change the other doesn't need to
get held up.

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxtguIACgkQJNaLcl1U
h9AF0Qf/fl2EYOJDIhIr5YJ368Jm/dHKVxTRIjwETYMpyWf2QvKsdU4NnUdnxDiB
PEkmQJA8Z0qy0DTcrd97md6/HpozZMf3G2zY8nZP42URa/V8wn/eXnAIUIHi8Nro
cI8sL+/1Bk6tl0b/0kcK0uu6m116D77y9ZMGf/nXHBKByePKC7VrnjFH8TPkT7mF
HT8hT1ePV4u1xiKiazDsRmCN5T057AbmP60H/+PiZnO3ASdYGPgqIFzyIJVmMtbm
4q2gDdP1abbb8Ia2vF0s2R93/CTXNclHcXpNTHAYhkaT8zycg4vU4cpxoMOYNw6w
bFUOtyDlKyGgIHMh+aOLG/kFhlEcxA==
=Toz0
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
