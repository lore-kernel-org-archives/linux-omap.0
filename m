From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Date: Mon, 17 Jun 2019 18:02:55 +0100
Message-ID: <20190617170255.GF5316@sirena.org.uk>
References: <20190615163314.28173-1-andreas@kemnade.info>
 <20190617103111.GM5316@sirena.org.uk>
 <20190617130357.41204ff7@kemnade.info>
 <20190617114048.GN5316@sirena.org.uk>
 <20190617182743.7f40f2ee@aktux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SO+9/CRZBGNspxuY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190617182743.7f40f2ee@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, nm@ti.com, vireshk@kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org


--SO+9/CRZBGNspxuY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 06:27:43PM +0200, Andreas Kemnade wrote:

> Citing tps65950 trm page 55:

> The device contains three switch-mode power supplies (SMPS):
> =E2=80=A2 VDD1: 1.2-A, buck DC/DC converter (VOUT =3D 0.6 V to 1.45 V, in=
 steps of 12.5 mV)
> =E2=80=A2 VDD2: 600-mA buck DC/DC converter (VOUT =3D 0.6 V to 1.45 V, in=
 steps of 12.5 mV, and 1.5 V as a
>    single programmable value)

> you are right, they are not really continuous. So should I add these
> 68 steps they have as a voltage list?

There's helpers for linear mappings, you should be able to use those
(see helpers.c).

> I think they are nearly continuous, so we should IMHO rather take that
> not that strict. I guess there are no really continuous regulators, all
> have steps as voltage is specified in a limited resolution. So what is
> the exact meaning of that flag here?

This was added for devices with extremely high resolution interfaces
like some microcontroller interfaces that take voltage values directly
(mirroring the regulator API) or PWM regulators - it's for cases where
enumerating all the voltages is unreasonable.  The TWL4030 regulators
look fairly standard in comparison.

--SO+9/CRZBGNspxuY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Hx74ACgkQJNaLcl1U
h9CWNQf+MwgfRdIW7BcriKWVMF03v0jco6sVD6U8CVZVFsKKZcsnzI2Y68Z90jGL
guU08JDMRePIz7mPhlBSLqwvOIAa7oF3difVoepvu5vyNmckQho4IBpja827vHLY
w7zeVoEE1GIA2X9r4SjY5d0NHVSdfbAkEGXkJCyRvJE+COGUVw2btMe42st8Yh0F
qud88Wj7O1RCHzFmSzK0Q2nIbXSKNzHk7vi6spYUU9TdbloMtiGny7kG9Fto37Kf
wUqHzHHJRCI9KToy7AR3M3Oy1FdmuR8GBnmDcb+Js0kGMmDvcP9+7L7gGZkZV+Pq
hwbZETb/MHtSj7MqotPchV9n1Y0wIA==
=cjH3
-----END PGP SIGNATURE-----

--SO+9/CRZBGNspxuY--
