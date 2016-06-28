From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] mfd: twl6040: Handle mclk used for HPPLL and optional
 internal clock source
Date: Tue, 28 Jun 2016 16:30:29 +0100
Message-ID: <20160628153029.GC29166@dell>
References: <20160620140718.29057-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160620140718.29057-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, devicetree@vger.kernel.org, robh@kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 20 Jun 2016, Peter Ujfalusi wrote:

> On some boards, like omap5-uevm the MCLK is gated by default and in o=
rder
> to be able to use the High performance modes of twl6040 it need to be
> enabled by SW.
> Add support for handling the MCLK source clock via CCF.
> At the same time lower the print priority of the notification that th=
e 32K
> clock is not provided and it is not going to be handled by the driver=
=2E
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Hi,
>=20
> Changes since v1:
> - Keep the clk32k name and use mclk for the new clock
> - rename the old mclk variable to mclk_rate and use it only to track =
the MCLK
>   frequency
> - rename the sysclk to sysclk_rate also to be more explicit on the me=
aning of
>   this variabe.
>=20
> Regards,
> Peter
>=20
>  Documentation/devicetree/bindings/mfd/twl6040.txt |  4 +--
>  drivers/mfd/twl6040.c                             | 41 +++++++++++++=
+++-------
>  include/linux/mfd/twl6040.h                       |  5 +--
>  3 files changed, 34 insertions(+), 16 deletions(-)

Applied, thanks.

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
> index 852d5874aabb..ab328ec49353 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -323,8 +323,7 @@ int twl6040_power(struct twl6040 *twl6040, int on=
)
> =20
>  		/* Default PLL configuration after power up */
>  		twl6040->pll =3D TWL6040_SYSCLK_SEL_LPPLL;
> -		twl6040->sysclk =3D 19200000;
> -		twl6040->mclk =3D 32768;
> +		twl6040->sysclk_rate =3D 19200000;
>  	} else {
>  		/* already powered-down */
>  		if (!twl6040->power_count) {
> @@ -352,8 +351,12 @@ int twl6040_power(struct twl6040 *twl6040, int o=
n)
>  		regcache_cache_only(twl6040->regmap, true);
>  		regcache_mark_dirty(twl6040->regmap);
> =20
> -		twl6040->sysclk =3D 0;
> -		twl6040->mclk =3D 0;
> +		twl6040->sysclk_rate =3D 0;
> +
> +		if (twl6040->pll =3D=3D TWL6040_SYSCLK_SEL_HPPLL) {
> +			clk_disable_unprepare(twl6040->mclk);
> +			twl6040->mclk_rate =3D 0;
> +		}
> =20
>  		clk_disable_unprepare(twl6040->clk32k);
>  	}
> @@ -377,15 +380,15 @@ int twl6040_set_pll(struct twl6040 *twl6040, in=
t pll_id,
> =20
>  	/* Force full reconfiguration when switching between PLL */
>  	if (pll_id !=3D twl6040->pll) {
> -		twl6040->sysclk =3D 0;
> -		twl6040->mclk =3D 0;
> +		twl6040->sysclk_rate =3D 0;
> +		twl6040->mclk_rate =3D 0;
>  	}
> =20
>  	switch (pll_id) {
>  	case TWL6040_SYSCLK_SEL_LPPLL:
>  		/* low-power PLL divider */
>  		/* Change the sysclk configuration only if it has been canged */
> -		if (twl6040->sysclk !=3D freq_out) {
> +		if (twl6040->sysclk_rate !=3D freq_out) {
>  			switch (freq_out) {
>  			case 17640000:
>  				lppllctl |=3D TWL6040_LPLLFIN;
> @@ -427,6 +430,8 @@ int twl6040_set_pll(struct twl6040 *twl6040, int =
pll_id,
>  			ret =3D -EINVAL;
>  			goto pll_out;
>  		}
> +
> +		clk_disable_unprepare(twl6040->mclk);
>  		break;
>  	case TWL6040_SYSCLK_SEL_HPPLL:
>  		/* high-performance PLL can provide only 19.2 MHz */
> @@ -437,7 +442,7 @@ int twl6040_set_pll(struct twl6040 *twl6040, int =
pll_id,
>  			goto pll_out;
>  		}
> =20
> -		if (twl6040->mclk !=3D freq_in) {
> +		if (twl6040->mclk_rate !=3D freq_in) {
>  			hppllctl &=3D ~TWL6040_MCLK_MSK;
> =20
>  			switch (freq_in) {
> @@ -468,6 +473,9 @@ int twl6040_set_pll(struct twl6040 *twl6040, int =
pll_id,
>  				goto pll_out;
>  			}
> =20
> +			/* When switching to HPPLL, enable the mclk first */
> +			if (pll_id !=3D twl6040->pll)
> +				clk_prepare_enable(twl6040->mclk);
>  			/*
>  			 * enable clock slicer to ensure input waveform is
>  			 * square
> @@ -483,6 +491,8 @@ int twl6040_set_pll(struct twl6040 *twl6040, int =
pll_id,
>  			lppllctl &=3D ~TWL6040_LPLLENA;
>  			twl6040_reg_write(twl6040, TWL6040_REG_LPPLLCTL,
>  					  lppllctl);
> +
> +			twl6040->mclk_rate =3D freq_in;
>  		}
>  		break;
>  	default:
> @@ -491,8 +501,7 @@ int twl6040_set_pll(struct twl6040 *twl6040, int =
pll_id,
>  		goto pll_out;
>  	}
> =20
> -	twl6040->sysclk =3D freq_out;
> -	twl6040->mclk =3D freq_in;
> +	twl6040->sysclk_rate =3D freq_out;
>  	twl6040->pll =3D pll_id;
> =20
>  pll_out:
> @@ -512,7 +521,7 @@ EXPORT_SYMBOL(twl6040_get_pll);
> =20
>  unsigned int twl6040_get_sysclk(struct twl6040 *twl6040)
>  {
> -	return twl6040->sysclk;
> +	return twl6040->sysclk_rate;
>  }
>  EXPORT_SYMBOL(twl6040_get_sysclk);
> =20
> @@ -655,10 +664,18 @@ static int twl6040_probe(struct i2c_client *cli=
ent,
>  	if (IS_ERR(twl6040->clk32k)) {
>  		if (PTR_ERR(twl6040->clk32k) =3D=3D -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
> -		dev_info(&client->dev, "clk32k is not handled\n");
> +		dev_dbg(&client->dev, "clk32k is not handled\n");
>  		twl6040->clk32k =3D NULL;
>  	}
> =20
> +	twl6040->mclk =3D devm_clk_get(&client->dev, "mclk");
> +	if (IS_ERR(twl6040->mclk)) {
> +		if (PTR_ERR(twl6040->mclk) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_dbg(&client->dev, "mclk is not handled\n");
> +		twl6040->mclk =3D NULL;
> +	}
> +
>  	twl6040->supplies[0].supply =3D "vio";
>  	twl6040->supplies[1].supply =3D "v2v1";
>  	ret =3D devm_regulator_bulk_get(&client->dev, TWL6040_NUM_SUPPLIES,
> diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.=
h
> index 8e95cd87cd74..36795a1be479 100644
> --- a/include/linux/mfd/twl6040.h
> +++ b/include/linux/mfd/twl6040.h
> @@ -226,6 +226,7 @@ struct twl6040 {
>  	struct regmap_irq_chip_data *irq_data;
>  	struct regulator_bulk_data supplies[2]; /* supplies for vio, v2v1 *=
/
>  	struct clk *clk32k;
> +	struct clk *mclk;
>  	struct mutex mutex;
>  	struct mutex irq_mutex;
>  	struct mfd_cell cells[TWL6040_CELLS];
> @@ -237,8 +238,8 @@ struct twl6040 {
> =20
>  	/* PLL configuration */
>  	int pll;
> -	unsigned int sysclk;
> -	unsigned int mclk;
> +	unsigned int sysclk_rate;
> +	unsigned int mclk_rate;
> =20
>  	unsigned int irq;
>  	unsigned int irq_ready;

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
