From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] regulator: tps65218: Add support for LS2
Date: Wed, 20 Feb 2019 16:48:51 +0000
Message-ID: <20190220164851.GD9878@sirena.org.uk>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1550650552-26013-4-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550650552-26013-4-git-send-email-Christian.Hohnstaedt@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc: J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 09:15:52AM +0100, Christian Hohnstaedt wrote:

> +	TPS65218_REGULATOR("LS2", "regulator-ls2", TPS65218_LS_2,
> +			   REGULATOR_CURRENT, tps65218_ls23_ops, 0, 0, 0,
> +			   TPS65218_REG_ENABLE2, TPS65218_ENABLE2_LS2_EN,
> +			   TPS65218_REG_CONFIG2, TPS65218_CONFIG2_LS2ILIM_MASK,
> +			   NULL, 0, 0, 0, 0, 0),

This doesn't build:

drivers/regulator/tps65218-regulator.c:309:45: error: =E2=80=98TPS65218_LS_=
2=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98TPS65=
218_LS_3=E2=80=99?
  TPS65218_REGULATOR("LS2", "regulator-ls2", TPS65218_LS_2,
                                             ^~~~~~~~~~~~~
drivers/regulator/tps65218-regulator.c:36:11: note: in definition of macro =
=E2=80=98TPS65218_REGULATOR=E2=80=99
   .id   =3D _id,   \
           ^~~


--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxthPIACgkQJNaLcl1U
h9DsAgf/WkKqcdvfWvkg3h0NefjkVrMRy33gImEH7gvnZESxXvliAIKhh4UabR8r
Alv+8XitzO2SIE8/uZUM8mR2VaBi7hAFADkWUyCT5Ci14uyEEZQE+h4I4TMC1Rpn
Xv9PswEQT1cOeLMOl30TfMuvD+1JQB4sxNvYo08NSj0AkwA9GYjLZPa7UuVBzNx+
U4JAmozNmrVgGyHFEjSJYEmW/XVijlXKVqB5E+22HM/+NykfUpLcGd0Ax/GC4gmk
Hvk/ooXkd3km2y5LmogRQexahL89Sq/bD6aAmX3ObbDyr/kHaglDvw/FxYm1+O6F
t5qdsu65MJcZ9wHB/eoTpZyVLWuQSg==
=3vRS
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
