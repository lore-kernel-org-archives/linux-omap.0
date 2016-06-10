From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 6/9] pwms: pwm-ti*: Get the clock from the PWMSS
 parent when using old bindings
Date: Fri, 10 Jun 2016 14:48:10 +0200
Message-ID: <20160610124810.GE27142@ulmo.ba.sec>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-7-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462291015-1919-7-git-send-email-fcooper@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: robh+dt@kernel.org, tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 03, 2016 at 10:56:52AM -0500, Franklin S Cooper Jr wrote:
> When using the old eCAP and ePWM bindings for AM335x and AM437x the clock
> can be retrieved from the PWMSS parent. Newer bindings will insure that
> this clock is provided via device tree.
>=20
> Therefore, update this driver to support the newer and older bindings. In
> the case of the older binding being used give a warning.
>=20
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  drivers/pwm/pwm-tiecap.c   | 7 +++++++
>  drivers/pwm/pwm-tiehrpwm.c | 7 +++++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
> index 616af76..a0833c8 100644
> --- a/drivers/pwm/pwm-tiecap.c
> +++ b/drivers/pwm/pwm-tiecap.c
> @@ -195,6 +195,7 @@ static const struct pwm_ops ecap_pwm_ops =3D {
>  };
> =20
>  static const struct of_device_id ecap_of_match[] =3D {
> +	{ .compatible	=3D "ti,am3352-ecap" },
>  	{ .compatible	=3D "ti,am33xx-ecap" },
>  	{},
>  };
> @@ -213,6 +214,12 @@ static int ecap_pwm_probe(struct platform_device *pd=
ev)
>  		return -ENOMEM;
> =20
>  	clk =3D devm_clk_get(&pdev->dev, "fck");
> +
> +	if (IS_ERR(clk) && of_device_is_compatible(pdev->dev.of_node, "ti,am33x=
x-ecap")) {
> +		dev_warn(&pdev->dev, "Binding is obsolete.\n");
> +		clk =3D devm_clk_get(pdev->dev.parent, "fck");
> +	}

I rewrote this slightly for readability:

	struct device_node *np =3D pdev->dev.of_node;

	if (IS_ERR(clk)) {
		if (of_device_is_compatible(np, "ti,am33xx-ecap")) {
			...
		}
	}

>  	if (IS_ERR(clk)) {
>  		dev_err(&pdev->dev, "failed to get clock\n");
>  		return PTR_ERR(clk);
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 6a41e66..cee29a2 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -426,6 +426,7 @@ static const struct pwm_ops ehrpwm_pwm_ops =3D {
>  };
> =20
>  static const struct of_device_id ehrpwm_of_match[] =3D {
> +	{ .compatible	=3D "ti,am3352-ehrpwm" },
>  	{ .compatible	=3D "ti,am33xx-ehrpwm" },
>  	{},
>  };
> @@ -444,6 +445,12 @@ static int ehrpwm_pwm_probe(struct platform_device *=
pdev)
>  		return -ENOMEM;
> =20
>  	clk =3D devm_clk_get(&pdev->dev, "fck");
> +
> +	if (IS_ERR(clk) && of_device_is_compatible(pdev->dev.of_node, "ti,am33x=
x-ecap")) {
> +		dev_warn(&pdev->dev, "Binding is obsolete.\n");
> +		clk =3D devm_clk_get(pdev->dev.parent, "fck");
> +	}
> +

Same here.

Thierry

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWrcKAAoJEN0jrNd/PrOhv04QAI0lubozNnqPJ+XipFlWkkQZ
hC5AIPHcpsuwcLgDL4qGMlhX2nrwT0lcLfH4P7rbMszbVpAuTB9QfEqGynApT2+I
xPXeQeXne/HsK4kBdujR8Iuxr2ZEOvY1xPnMljajYWfm9QTg3YPT/Y7RbhOBnMSK
mzgjIp7aPxunfM+H0kqA5k+YdPXc2ch/YSfy2pXKIAi33kBaoDNWExWDezUqpZLD
jvsJK1bJqEPeRf98EcRwibiDh22rJy4KcTjLA+Vy/3CzagO3Z+MwI6OLoQ9KThi8
YeJ6Zm2XAcCpxJaq0UJEvJFVkbpkvpTWr5pR80IppqMmfVufd7XGIl8+sAaeK7rJ
M4Ov/ZMtL5NCJ9fSkXj30ZZ3aJ35/PSOc+Hm+t1Vh+oLVAWqof7s0lmhK/f9Z+E1
/amTWLxKBhTrMLfm3/bEUaDQZwcDTMvC1yQgGqeDF9C/DBKC++52KAJttbq3Arxj
se0jGT670xB5l03HBp4JGgxJaobeRBBirdRiU2dMdN7dURWJJDwUAnguCgn6FnIX
nzECwy2AN9CJ/gWsxsr0SYc2UdhTBl45bEFLOydhjJb+oNsi5sYt4Av4vxRTxIv3
lAOrKixXvejOfswgYbJ7Xktt9cU4sxaMKJiXQwM/0PMuty0l1iuwLxhGhpxS0L7k
goD2BqJed+O3MGya6hEw
=1nT8
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
