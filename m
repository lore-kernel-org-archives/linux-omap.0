From: Sebastian Reichel <sre@kernel.org>
Subject: Re: 4.5-rc0 regression: GPRS breaks after very short while
Date: Wed, 18 May 2016 16:16:25 +0200
Message-ID: <20160518141624.GA8025@earth>
References: <20160518074924.GA20652@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160518074924.GA20652@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Wed, May 18, 2016 at 09:49:24AM +0200, Pavel Machek wrote:
> I was afraid another GSM chip desoldered itself in N900, but no, it
> seems to be software this time.
>=20
> In 4.4, GPRS is rock solid, can survive overnight ping.
>=20
> In 4.5-rc0 and v4.6, modem fails when I use gprs for like a
> minute. Phone is not usable.

I only send three modem related changes for v4.5:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/commit/?h=3D=
hsi-for-4.5&id=3D525e1abc6b5a7d8bd9006de1da6e99722305ea2b
HSI: omap_ssi: fix handling ida_simple_get result

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/commit/?h=3D=
hsi-for-4.5&id=3D6bf6ded3008a407ccab5ad72eb59ab71b97cc290
HSI: omap_ssi_port: fix handling of_get_named_gpio result

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/commit/?h=3D=
hsi-for-4.5&id=3D403c5c0650816375527a6feecfb255d9b494dda3
HSI: Remove struct hsi_client private fields from kernel-doc

The last one only changes a comment, so not relevant, the other
two fix error handling during initialization and are most likely
also not the problem. Can you try to bisect the problem?

-- Sebastian

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXPHkwAAoJENju1/PIO/qaX38P/jmPZF913Kf0DvvmOET2iVQ/
TsL1cMpsPbRd1ME3LmUlFMywXqSH4hgRaReT+46/S+01fcpm7JW1JCzB5YQ4Blx9
FV1xAEgHAKQ9hyZYMqjR4jYElx8L+e33/TpnjMV4MkqqKVAZTk4CDWEuxnnnZdsP
9opht1pJda3KJgkruF3Z9xoDT7ZzV45kubYsYs9ksYpxp8Q3pZkoKrcPWZZIIY/1
mGTcGF25Eoifokg+9yIHYpaNaRf5dnVqxvihohVNX8TE9S0U83gVGPwqmTS4kZwB
62fdvUQIAopZVAyfGDDjrqMPzakhPjoXsN/Pr7r3x9orwrLzFZ/rz0cMS4DURsQf
sLXClpAlyPY/Vfd3ZdYyG146UNXGHRy8YgqCE5zd/JE/0+QMy0DEzUcH8okJXD/R
EX9+CNCHia3wlOS0WeZ2QbIF/j5yzS2GwPKSadpkrIaAHOIuTt8zDq1HRIfF9/Yl
+LbtYM6fYW80GEb3Avta8zycP8GkPMr4lvIXV+T9rBM9S0CPpDnfF/ELF6aKNKyg
ljHOSlVP4Xwlju+ZSJ2n1OAdyrgYEVjjdwGrbBet+mSnEjWzK8DW8kd7ZsHBTWOf
7CipPCsB67EKf2q0hVSFY5WYhPJolHKUUqpO4IyJMc57YHfDkZ9XRRUXwsSLCcE+
xbRalp7/Z9y1RULbk+NV
=ZSM3
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
