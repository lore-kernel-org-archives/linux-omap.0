From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl6040: Handle mclk used for HPPLL and optional
 internal clock source
Date: Thu, 16 Jun 2016 16:16:58 +0100
Message-ID: <20160616151658.GA21702@dell>
References: <1462965209-6955-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462965209-6955-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 11 May 2016, Peter Ujfalusi wrote:

> On some boards, like omap5-uevm the MCLK is gated by default and in o=
rder
> to be able to use the High performance modes of twl6040 it need to be
> enabled by SW.
> Add support for handling the MCLK source clock via CCF.
> At the same time lover the print priority of the notification that th=
e 32K

Mr Lover Lover!

> clock is not proveded so it is not going to be handled by the driver.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/twl6040.txt |  4 +--
>  drivers/mfd/twl6040.c                             | 34 +++++++++++++=
++++------
>  include/linux/mfd/twl6040.h                       |  3 +-
>  3 files changed, 29 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/twl6040.txt b/Docu=
mentation/devicetree/bindings/mfd/twl6040.txt
> index a41157b5d930..e6afdfa3543d 100644
> --- a/Documentation/devicetree/bindings/mfd/twl6040.txt
> +++ b/Documentation/devicetree/bindings/mfd/twl6040.txt
> @@ -19,8 +19,8 @@ Required properties:
> =20
>  Optional properties, nodes:
>  - enable-active-high: To power on the twl6040 during boot.
> -- clocks: phandle to the clk32k clock provider
> -- clock-names: Must be "clk32k"
> +- clocks: phandle to the clk32k and/or to mclk clock provider
> +- clock-names: Must be "clk32k" for the 32K clock and "mclk" for the=
 MCLK.
> =20
>  Vibra functionality
>  Required properties:
> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> index 852d5874aabb..f3dcf3a85e84 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -291,7 +291,7 @@ int twl6040_power(struct twl6040 *twl6040, int on=
)
>  		if (twl6040->power_count++)
>  			goto out;
> =20
> -		ret =3D clk_prepare_enable(twl6040->clk32k);
> +		ret =3D clk_prepare_enable(twl6040->clk32k_clk);
>  		if (ret) {
>  			twl6040->power_count =3D 0;
>  			goto out;
> @@ -304,7 +304,7 @@ int twl6040_power(struct twl6040 *twl6040, int on=
)
>  			/* use automatic power-up sequence */
>  			ret =3D twl6040_power_up_automatic(twl6040);
>  			if (ret) {
> -				clk_disable_unprepare(twl6040->clk32k);
> +				clk_disable_unprepare(twl6040->clk32k_clk);
>  				twl6040->power_count =3D 0;
>  				goto out;
>  			}
> @@ -312,7 +312,7 @@ int twl6040_power(struct twl6040 *twl6040, int on=
)
>  			/* use manual power-up sequence */
>  			ret =3D twl6040_power_up_manual(twl6040);
>  			if (ret) {
> -				clk_disable_unprepare(twl6040->clk32k);
> +				clk_disable_unprepare(twl6040->clk32k_clk);
>  				twl6040->power_count =3D 0;
>  				goto out;
>  			}
> @@ -355,7 +355,10 @@ int twl6040_power(struct twl6040 *twl6040, int o=
n)
>  		twl6040->sysclk =3D 0;
>  		twl6040->mclk =3D 0;
> =20
> -		clk_disable_unprepare(twl6040->clk32k);
> +		if (twl6040->pll =3D=3D TWL6040_SYSCLK_SEL_HPPLL)
> +			clk_disable_unprepare(twl6040->mclk_clk);
> +
> +		clk_disable_unprepare(twl6040->clk32k_clk);
>  	}
> =20
>  out:
> @@ -427,6 +430,8 @@ int twl6040_set_pll(struct twl6040 *twl6040, int =
pll_id,
>  			ret =3D -EINVAL;
>  			goto pll_out;
>  		}
> +
> +		clk_disable_unprepare(twl6040->mclk_clk);
>  		break;
>  	case TWL6040_SYSCLK_SEL_HPPLL:
>  		/* high-performance PLL can provide only 19.2 MHz */
> @@ -468,6 +473,9 @@ int twl6040_set_pll(struct twl6040 *twl6040, int =
pll_id,
>  				goto pll_out;
>  			}
> =20
> +			/* When switching to HPPLL, enable the mclk first */
> +			if (pll_id !=3D twl6040->pll)
> +				clk_prepare_enable(twl6040->mclk_clk);
>  			/*
>  			 * enable clock slicer to ensure input waveform is
>  			 * square
> @@ -651,12 +659,20 @@ static int twl6040_probe(struct i2c_client *cli=
ent,
> =20
>  	i2c_set_clientdata(client, twl6040);
> =20
> -	twl6040->clk32k =3D devm_clk_get(&client->dev, "clk32k");
> -	if (IS_ERR(twl6040->clk32k)) {
> -		if (PTR_ERR(twl6040->clk32k) =3D=3D -EPROBE_DEFER)
> +	twl6040->clk32k_clk =3D devm_clk_get(&client->dev, "clk32k");
> +	if (IS_ERR(twl6040->clk32k_clk)) {
> +		if (PTR_ERR(twl6040->clk32k_clk) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_dbg(&client->dev, "clk32k is not handled\n");
> +		twl6040->clk32k_clk =3D NULL;
> +	}
> +
> +	twl6040->mclk_clk =3D devm_clk_get(&client->dev, "mclk");
> +	if (IS_ERR(twl6040->mclk_clk)) {
> +		if (PTR_ERR(twl6040->mclk_clk) =3D=3D -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
> -		dev_info(&client->dev, "clk32k is not handled\n");
> -		twl6040->clk32k =3D NULL;
> +		dev_dbg(&client->dev, "mclk is not handled\n");
> +		twl6040->mclk_clk =3D NULL;
>  	}
> =20
>  	twl6040->supplies[0].supply =3D "vio";
> diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.=
h
> index 8f9fc3d26e6d..a7c50e54f3e0 100644
> --- a/include/linux/mfd/twl6040.h
> +++ b/include/linux/mfd/twl6040.h
> @@ -224,7 +224,8 @@ struct twl6040 {
>  	struct regmap *regmap;
>  	struct regmap_irq_chip_data *irq_data;
>  	struct regulator_bulk_data supplies[2]; /* supplies for vio, v2v1 *=
/
> -	struct clk *clk32k;
> +	struct clk *clk32k_clk;
> +	struct clk *mclk_clk;

Not sure I get the naming here.

What's wrong with clk32k and mclk?

>  	struct mutex mutex;
>  	struct mutex irq_mutex;
>  	struct mfd_cell cells[TWL6040_CELLS];

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
