From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: lp873x: Update the enable mask for LDOs and
 BUCKs
Date: Mon, 9 Oct 2017 15:20:53 +0100
Message-ID: <20171009142053.rogvykzmoatduv6i@sirena.co.uk>
References: <1506515140-26058-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4oup3jqy24xnlipa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506515140-26058-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--4oup3jqy24xnlipa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2017 at 05:55:40PM +0530, Keerthy wrote:
> The reset value of the EN_PIN_CTRL bit fields of LDOs and BUCKs
> need not be set correctly. Hence update the enable mask to include
> the EN_PIN_CTRL bit. While enabling this should be set to 1 so
> that all the regulators are tied to EN pin.

I'm not sure I follow the logic here entirely.  It sounds like this is a
register bit to control if the regulators are enabled and disabled via a
GPIO instead of the register which is something that people might want
to use in some systems.  Shouldn't this be dependent on some system
configration instead?

>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/regulator/lp873x-regulator.c | 19 ++++++++++---------
>  include/linux/mfd/lp873x.h           |  4 ++++
>  2 files changed, 14 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp8=
73x-regulator.c
> index 70e3df6..77bea82 100644
> --- a/drivers/regulator/lp873x-regulator.c
> +++ b/drivers/regulator/lp873x-regulator.c
> @@ -20,7 +20,7 @@
>  #include <linux/mfd/lp873x.h>
> =20
>  #define LP873X_REGULATOR(_name, _id, _of, _ops, _n, _vr, _vm, _er, _em, \
> -			 _delay, _lr, _cr)				\
> +			 _dv, _delay, _lr, _cr)				\
>  	[_id] =3D {							\
>  		.desc =3D {						\
>  			.name			=3D _name,		\
> @@ -36,6 +36,7 @@
>  			.vsel_mask		=3D _vm,			\
>  			.enable_reg		=3D _er,			\
>  			.enable_mask		=3D _em,			\
> +			.disable_val		=3D _dv,			\
>  			.ramp_delay		=3D _delay,		\
>  			.linear_ranges		=3D _lr,			\
>  			.n_linear_ranges	=3D ARRAY_SIZE(_lr),	\
> @@ -175,21 +176,21 @@ static int lp873x_buck_get_current_limit(struct reg=
ulator_dev *rdev)
>  	LP873X_REGULATOR("BUCK0", LP873X_BUCK_0, "buck0", lp873x_buck01_ops,
>  			 256, LP873X_REG_BUCK0_VOUT,
>  			 LP873X_BUCK0_VOUT_BUCK0_VSET, LP873X_REG_BUCK0_CTRL_1,
> -			 LP873X_BUCK0_CTRL_1_BUCK0_EN, 10000,
> -			 buck0_buck1_ranges, LP873X_REG_BUCK0_CTRL_2),
> +			 LP873X_BUCK_ENABLE_MASK, LP873X_BUCK_DISABLE_VAL,
> +			 10000, buck0_buck1_ranges, LP873X_REG_BUCK0_CTRL_2),
>  	LP873X_REGULATOR("BUCK1", LP873X_BUCK_1, "buck1", lp873x_buck01_ops,
>  			 256, LP873X_REG_BUCK1_VOUT,
>  			 LP873X_BUCK1_VOUT_BUCK1_VSET, LP873X_REG_BUCK1_CTRL_1,
> -			 LP873X_BUCK1_CTRL_1_BUCK1_EN, 10000,
> -			 buck0_buck1_ranges, LP873X_REG_BUCK1_CTRL_2),
> +			 LP873X_BUCK_ENABLE_MASK, LP873X_BUCK_DISABLE_VAL,
> +			 10000, buck0_buck1_ranges, LP873X_REG_BUCK1_CTRL_2),
>  	LP873X_REGULATOR("LDO0", LP873X_LDO_0, "ldo0", lp873x_ldo01_ops, 26,
>  			 LP873X_REG_LDO0_VOUT, LP873X_LDO0_VOUT_LDO0_VSET,
> -			 LP873X_REG_LDO0_CTRL,
> -			 LP873X_LDO0_CTRL_LDO0_EN, 0, ldo0_ldo1_ranges, 0xFF),
> +			 LP873X_REG_LDO0_CTRL, LP873X_LDO_ENABLE_MASK,
> +			 LP873X_LDO_DISABLE_VAL, 0, ldo0_ldo1_ranges, 0xFF),
>  	LP873X_REGULATOR("LDO1", LP873X_LDO_1, "ldo1", lp873x_ldo01_ops, 26,
>  			 LP873X_REG_LDO1_VOUT, LP873X_LDO1_VOUT_LDO1_VSET,
> -			 LP873X_REG_LDO1_CTRL,
> -			 LP873X_LDO1_CTRL_LDO1_EN, 0, ldo0_ldo1_ranges, 0xFF),
> +			 LP873X_REG_LDO1_CTRL, LP873X_LDO_ENABLE_MASK,
> +			 LP873X_LDO_DISABLE_VAL, 0, ldo0_ldo1_ranges, 0xFF),
>  };
> =20
>  static int lp873x_regulator_probe(struct platform_device *pdev)
> diff --git a/include/linux/mfd/lp873x.h b/include/linux/mfd/lp873x.h
> index edbec83..53888d4 100644
> --- a/include/linux/mfd/lp873x.h
> +++ b/include/linux/mfd/lp873x.h
> @@ -77,6 +77,8 @@
>  #define LP873X_BUCK0_CTRL_1_BUCK0_RDIS_EN	BIT(2)
>  #define LP873X_BUCK0_CTRL_1_BUCK0_EN_PIN_CTRL	BIT(1)
>  #define LP873X_BUCK0_CTRL_1_BUCK0_EN		BIT(0)
> +#define LP873X_BUCK_ENABLE_MASK			(BIT(0) | BIT(1))
> +#define	LP873X_BUCK_DISABLE_VAL			BIT(1)
> =20
>  #define LP873X_BUCK0_CTRL_2_BUCK0_ILIM		0x38
>  #define LP873X_BUCK0_CTRL_2_BUCK0_SLEW_RATE	0x07
> @@ -96,6 +98,8 @@
>  #define LP873X_LDO0_CTRL_LDO0_RDIS_EN		BIT(2)
>  #define LP873X_LDO0_CTRL_LDO0_EN_PIN_CTRL	BIT(1)
>  #define LP873X_LDO0_CTRL_LDO0_EN		BIT(0)
> +#define LP873X_LDO_ENABLE_MASK			(BIT(0) | BIT(1))
> +#define LP873X_LDO_DISABLE_VAL			BIT(1)
> =20
>  #define LP873X_LDO1_CTRL_LDO1_RDIS_EN		BIT(2)
>  #define LP873X_LDO1_CTRL_LDO1_EN_PIN_CTRL	BIT(1)
> --=20
> 1.9.1
>=20

--4oup3jqy24xnlipa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnbhcQACgkQJNaLcl1U
h9AYUQf/cV9L+AlYRJK1lmFsXGghg9aASaFXZu4cFlbpUesKhXm6S5MRdWWAobfB
tPwbBPGFGANk7hRYnXxorP5iSmwveHEEIEIu4jxoeTYM65MVxjJfG5Sx6SwKuLrY
XcMfTfn8pOdUbXW17wkZ+shnB6wiLfAymccevBrdYPj8navYW/K3s31UbqNHsL/F
OH/eIFWJ/rh3YynJbOobQ3PdpFKB3UXGBszqMU2V/pxa2NKQb4XVwhzcBr5BerbD
DOJHJgV0Mwv+Tea4O2e+/w15mcFw1vG9wiGNGiK/fZvuhv+FC9mAgoPNUN4lKRsg
2ZZ8M7YzOvhbGKhEoEv51G3qE8zu7Q==
=3JEz
-----END PGP SIGNATURE-----

--4oup3jqy24xnlipa--
