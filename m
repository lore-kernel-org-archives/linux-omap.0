From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [[PATCH v2]] OMAP: omap4-panda: add WiLink shared transport power
 functions
Date: Thu, 17 Jan 2013 10:30:15 +0100
Message-ID: <50F7C4A7.5060202@ti.com>
References: <1358372702-13102-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358372702-13102-1-git-send-email-coelho@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Luca,

On 01/16/2013 10:45 PM, Luciano Coelho wrote:
> The code to enable and disable the WiLink shared transport has been
> removed from the TI-ST driver, so it must be implemented in the board
> files instead.  Add the relevant operations to Panda's board file.
>=20
> Additionally, add the UART2 muxing data, so it's properly configured.
>=20
> Cc: stable <stable@vger.kernel.org> [3.7]
> Signed-off-by: Luciano Coelho <coelho@ti.com>
> ---
>=20
> In v2: use gpio_request_one() instead of gpio_request() and
> gpio_direction_output(). (Thanks Fabio!)
>=20
>  arch/arm/mach-omap2/board-omap4panda.c |   50 ++++++++++++++++++++++=
+++++++---
>  1 file changed, 46 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-o=
map2/board-omap4panda.c
> index 5c8e9ce..f44fccf 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -51,18 +51,50 @@
>  #define GPIO_HUB_NRESET		62
>  #define GPIO_WIFI_PMENA		43
>  #define GPIO_WIFI_IRQ		53
> +#define GPIO_BT_EN		46
> =20
>  /* wl127x BT, FM, GPS connectivity chip */
> +static int plat_kim_chip_enable(struct kim_data_s *kim_data)
> +{
> +	gpio_set_value(GPIO_BT_EN, GPIO_LOW);
> +	mdelay(5);
> +	gpio_set_value(GPIO_BT_EN, GPIO_HIGH);
> +	mdelay(100);
> +
> +	return 0;
> +}
> +
> +static int plat_kim_chip_disable(struct kim_data_s *kim_data)
> +{
> +	gpio_set_value(GPIO_BT_EN, GPIO_LOW);
> +	mdelay(1);
> +	gpio_set_value(GPIO_BT_EN, GPIO_HIGH);
> +	mdelay(1);
> +	gpio_set_value(GPIO_BT_EN, GPIO_LOW);
> +
> +	return 0;
> +}
> +
>  static struct ti_st_plat_data wilink_platform_data =3D {
> -	.nshutdown_gpio	=3D 46,
>  	.dev_name	=3D "/dev/ttyO1",
>  	.flow_cntrl	=3D 1,
>  	.baud_rate	=3D 3000000,
> -	.chip_enable	=3D NULL,
> -	.suspend	=3D NULL,
> -	.resume		=3D NULL,
> +	.chip_enable	=3D plat_kim_chip_enable,
> +	.chip_disable	=3D plat_kim_chip_disable,

I just wonder how this is going to work with DT... You are not going to=
 have
the ability to use callback in this form.
I think the GPIO handling should be done in the driver itself rather th=
an in
the board file.

>  };
> =20
> +static int wilink_st_init(void)
> +{
> +	int status;
> +
> +	status =3D gpio_request_one(GPIO_BT_EN, GPIOF_OUT_INIT_LOW, "kim");
> +	if (status)
> +		pr_err("%s: failed to request gpio %d\n", __func__,
> +		       GPIO_BT_EN);
> +
> +	return status;
> +}
> +
>  static struct platform_device wl1271_device =3D {
>  	.name	=3D "kim",
>  	.id	=3D -1,
> @@ -397,6 +429,12 @@ static struct omap_board_mux board_mux[] __initd=
ata =3D {
>  		  OMAP_PULL_ENA),
>  	OMAP4_MUX(ABE_MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> =20
> +	/* UART2 - BT/FM/GPS shared transport */
> +	OMAP4_MUX(UART2_CTS,	OMAP_PIN_INPUT	| OMAP_MUX_MODE0),
> +	OMAP4_MUX(UART2_RTS,	OMAP_PIN_OUTPUT	| OMAP_MUX_MODE0),
> +	OMAP4_MUX(UART2_RX,	OMAP_PIN_INPUT	| OMAP_MUX_MODE0),
> +	OMAP4_MUX(UART2_TX,	OMAP_PIN_OUTPUT	| OMAP_MUX_MODE0),
> +
>  	{ .reg_offset =3D OMAP_MUX_TERMINATOR },
>  };
> =20
> @@ -433,6 +471,10 @@ static void __init omap4_panda_init(void)
>  	if (ret)
>  		pr_err("error setting wl12xx data: %d\n", ret);
> =20
> +	ret =3D wilink_st_init();
> +	if (ret)
> +		pr_err("WiLink shared transport init failed: %d\n", ret);
> +
>  	omap4_panda_init_rev();
>  	omap4_panda_i2c_init();
>  	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
>=20


--=20
P=E9ter
