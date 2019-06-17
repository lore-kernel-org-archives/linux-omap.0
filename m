From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Date: Mon, 17 Jun 2019 13:03:57 +0200
Message-ID: <20190617130357.41204ff7@kemnade.info>
References: <20190615163314.28173-1-andreas@kemnade.info>
        <20190617103111.GM5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/T/ae9AiTrO+noE5l2ZRMJjS"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617103111.GM5316@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, nm@ti.com, vireshk@kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/T/ae9AiTrO+noE5l2ZRMJjS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 17 Jun 2019 11:31:11 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Sat, Jun 15, 2019 at 06:33:14PM +0200, Andreas Kemnade wrote:
>=20
> > The VDD1/VDD2 regulators on twl4030 are neither defined with
> > voltage lists nor with the continuous flag set, so
> > regulator_is_supported_voltage() returns false and an error
> > before above mentioned commit (which was considered success)
> > The result is that after the above mentioned commit cpufreq
> > does not work properly e.g. dm3730. =20
>=20
> Why is this a good fix and not defining the supported voltages?  These
> look like fairly standard linear range regulators.

I am fixing the definition of the two regulators in the patch.
I am defining them as continuous.=20
Voltage ranges are defined in
arch/arm/boot/dts/twl4030.dtsi
Only the continuous flag is missing.

Is there anything else do you want to be defined?

Regards,
Andreas

--Sig_/T/ae9AiTrO+noE5l2ZRMJjS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl0Hc50ACgkQl4jFM1s/
ye8YpA/8CrtqyQjtHJXh7k+8PQQp3Shw7IYEnKTorCO7pz3jS6Y9LTGR11kH5GVe
tsZpUKXcGjbNGPo9Urnb78t+SWySAABsd9F0zF00m0Ma8qA8KptW1Zggs1+zzm5z
P+ariX43asVqSXLbdNAEEPrFmWSeHTl1+n6vk/D3FPxAisyPKknRwPSZ6nv/6w6V
/IIiUYaJ1X4oBbr3ydhsIVmbmAsE1U6R5nl+nw5/+fRPakD2WVyv5oGCm6sgglvX
5lLnvhZE1S6YJF/eSUwlqbJt0R9KLFCWlvede0a4OAx5tDvIqqyEGzjGjUt+YKBQ
e3Jb8c2/oh29MtQHLvxxBEvWih0yact/T7ZDKUGsgJ9L0epJ56EGgFUTYmwQTDck
Y2z4jt7ciNCcBSDx1SGhRZeUoBEeCrUzsRL6Pqeuxf1s6O9bnP1Xs1mbZOYmMkVl
XPxpNqgbJNV1LLOHBHqac7nrm1lzkKPIbkNEk79A7pbWtWH67PoEUXcr5Y8Jkkjl
HM4Qwzd3KM3DZvHed666wpJ6n8LSUb7f0TqzRJPjFt8AYsgu4uoQcwWycFVDGWDS
P0t/41wyQQOCxzNIMj9HRaKnryqqo7+Frg+KaRuzXkUrAi6uwDFDH/jUbk/jmr0g
AzX7JHDzzEVtdslahvTmKXparIef4Lch42NvaE0naDOyabZLRtg=
=3Fg4
-----END PGP SIGNATURE-----

--Sig_/T/ae9AiTrO+noE5l2ZRMJjS--
