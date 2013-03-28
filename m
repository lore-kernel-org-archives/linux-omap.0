From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 ROM Random Number Generator support
Date: Thu, 28 Mar 2013 14:44:11 -0700
Message-ID: <20130328214411.GZ10155@atomide.com>
References: <201302281905.48546@pali>
 <201303272303.44420@pali>
 <20130327222524.GR10155@atomide.com>
 <201303281854.02847@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201303281854.02847@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, Russell King <linux@arm.linux.org.uk>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130328 10:58]:
>=20
> Here is new version of patch:
>=20
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -486,6 +486,23 @@ static void omap_init_mcspi(void)
>  static inline void omap_init_mcspi(void) {}
>  #endif
> =20
> +extern u32 *omap3_rom_rng_call(u32 id, u32 proc, u32 flags, u32 va_p=
tr);
> +
> +static struct platform_device omap3_rom_rng_device =3D {
> +	.name		=3D "omap3-rom-rng",
> +	.id		=3D -1,
> +	.dev	=3D {
> +		.platform_data	=3D omap3_rom_rng_call,
> +	},
> +};
> +
> +static void omap_init_rom_rng(void)
> +{
> +	if (!cpu_is_omap34xx() || omap_type() =3D=3D OMAP2_DEVICE_TYPE_GP)
> +		return;
> +	platform_device_register(&omap3_rom_rng_device);
> +}
> +
>  /**
>   * omap_init_rng - bind the RNG hwmod to the RNG omap_device
>   *

This driver probably only works on Nokia boards because of the
different SMC call numbering. Until it's been verified on some
other HS omap34xx, I'd probably register this only from the
Nokia board-*.c file.

> --- /dev/null
> +++ b/drivers/char/hw_random/omap3-rom-rng.c
> +static int omap3_rom_rng_probe(struct platform_device *pdev)
> +{
> +	printk(KERN_INFO "%s: initializing\n", omap3_rom_rng_name);
> +
> +	omap3_rom_rng_call =3D pdev->dev.platform_data;
> +	if (!omap3_rom_rng_call) {
> +		printk(KERN_ERR "%s: omap3_rom_rng_call is NULL\n",
> +		       omap3_rom_rng_name);
> +		return -EINVAL;
> +	}
> +
> +	setup_timer(&idle_timer, omap3_rom_idle_rng, 0);
> +	rng_clk =3D clk_get_sys("omap_rng", "ick");
> +	if (IS_ERR(rng_clk)) {
> +		printk(KERN_ERR "%s: unable to get RNG clock\n",
> +		       omap3_rom_rng_name);
> +		return IS_ERR(rng_clk);
> +	}

You can use regular clk_get if you add the alias to
struct omap_clk omap3xxx_clks table.

Regards,

Tony
