From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP3LOGIC: Adding DSS support
Date: Mon, 12 Dec 2011 13:10:38 +0200
Message-ID: <1323688238.3852.18.camel@deskari>
References: <1323345948-14533-1-git-send-email-alexg@meprolight.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Sfg6qxC+RiiI4n0RcGW6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53848 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750748Ab1LLLKp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 06:10:45 -0500
Received: by lahi5 with SMTP id i5so1875878lah.28
        for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:10:42 -0800 (PST)
In-Reply-To: <1323345948-14533-1-git-send-email-alexg@meprolight.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alex <alexg@meprolight.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tim.nordell@logicpd.com, baruch@tkos.co.il


--=-Sfg6qxC+RiiI4n0RcGW6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2011-12-08 at 14:05 +0200, Alex wrote:
> This patch adds DSS2 support to the LogicPD OMAP 35x Torpedo boardfile. L=
CD and
> TV-out are supported.
>=20
> Signed-off-by: Alex Gershgorin <alexg@meprolight.com>
> ---
>  arch/arm/mach-omap2/board-omap3logic.c |  151 ++++++++++++++++++++++++++=
++++++
>  1 files changed, 151 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2=
/board-omap3logic.c
> index 7c0f193..86175fa 100644
> --- a/arch/arm/mach-omap2/board-omap3logic.c
> +++ b/arch/arm/mach-omap2/board-omap3logic.c
> @@ -7,6 +7,9 @@
>   * Copyright (C) 2010 Logic Product Development, Inc.
>   * Peter Barada <peter.barada@logicpd.com>
>   *
> + * Copyright (C) 2011 Meprolight, Ltd.
> + * Alex Gershgorin <alexg@meprolight.com>
> + *
>   * Modified from Beagle, EVM, and RX51
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -44,6 +47,10 @@
>  #include <plat/gpmc-smsc911x.h>
>  #include <plat/gpmc.h>
>  #include <plat/sdrc.h>
> +#include <plat/vram.h>
> +
> +#include <video/omapdss.h>
> +#include <video/omap-panel-generic-dpi.h>
> =20
>  #define OMAP3LOGIC_SMSC911X_CS			1
> =20
> @@ -58,6 +65,14 @@ static struct regulator_consumer_supply omap3logic_vmm=
c1_supply[] =3D {
>  	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
>  };
> =20
> +static struct regulator_consumer_supply omap3logic_vdds_supplies[] =3D {
> +	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
> +};
> +
> +static struct regulator_consumer_supply omap3logic_vdac_supply =3D
> +	REGULATOR_SUPPLY("vdda_dac", "omapdss_venc");
> +
>  /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card =3D=3D max=
 220 mA) */
>  static struct regulator_init_data omap3logic_vmmc1 =3D {
>  	.constraints =3D {
> @@ -74,6 +89,34 @@ static struct regulator_init_data omap3logic_vmmc1 =3D=
 {
>  	.consumer_supplies      =3D omap3logic_vmmc1_supply,
>  };
> =20
> +static struct regulator_init_data omap3logic_vpll2 =3D {
> +	.constraints =3D {
> +		.name			=3D "VDDS_DSI",
> +		.min_uV			=3D 1800000,
> +		.max_uV			=3D 1800000,
> +		.apply_uV		=3D true,
> +		.always_on		=3D true,
> +		.valid_modes_mask	=3D REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		=3D REGULATOR_CHANGE_MODE,
> +	},
> +	.num_consumer_supplies  =3D ARRAY_SIZE(omap3logic_vdds_supplies),
> +	.consumer_supplies      =3D omap3logic_vdds_supplies,
> +};
> +
> +static struct regulator_init_data omap3logic_vdac =3D {
> +	.constraints =3D {
> +		.min_uV			=3D 1800000,
> +		.max_uV			=3D 1800000,
> +		.valid_modes_mask	=3D REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		=3D REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	=3D 1,
> +	.consumer_supplies	=3D &omap3logic_vdac_supply,
> +};
> +
>  static struct twl4030_gpio_platform_data omap3logic_gpio_data =3D {
>  	.gpio_base	=3D OMAP_MAX_GPIO_LINES,
>  	.irq_base	=3D TWL4030_GPIO_IRQ_BASE,
> @@ -91,6 +134,8 @@ static struct twl4030_platform_data omap3logic_twldata=
 =3D {
>  	/* platform_data for children goes here */
>  	.gpio		=3D &omap3logic_gpio_data,
>  	.vmmc1		=3D &omap3logic_vmmc1,
> +	.vpll2		=3D &omap3logic_vpll2,
> +	.vdac		=3D &omap3logic_vdac,
>  };

The regulators are already set up in twl-common.c, so there shouldn't be
need for the code above.

> =20
>  static int __init omap3logic_i2c_init(void)
> @@ -182,6 +227,110 @@ static inline void __init board_smsc911x_init(void)
>  	gpmc_smsc911x_init(&board_smsc911x_data);
>  }
> =20
> +#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
> +
> +#define OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO	154
> +#define OMAP3_TORPEDO_LCD_ENABLE_GPIO		155
> +#define OMAP3_TORPEDO_LCD_PWM_GPIO		56

The PWM gpio doesn't seem to be used. Is it needed for something?

> +static struct gpio omap3logic_dss_gpios[] __initdata =3D {
> +	{OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW, "lcd_bl_pwr"},
> +	{OMAP3_TORPEDO_LCD_PWM_GPIO, GPIOF_OUT_INIT_LOW, "lcd bl enable"},
> +	{OMAP3_TORPEDO_LCD_ENABLE_GPIO, GPIOF_OUT_INIT_LOW, "lcd enable"},
> +};
> +
> +static int omap3logic_enable_lcd(struct omap_dss_device *dssdev)
> +{
> +	gpio_set_value_cansleep(OMAP3_TORPEDO_LCD_ENABLE_GPIO, 1);
> +	msleep(20);
> +	gpio_set_value_cansleep(OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, 1);
> +
> +	return 0;
> +}
> +
> +static void omap3logic_disable_lcd(struct omap_dss_device *dssdev)
> +{
> +	gpio_set_value_cansleep(OMAP3_TORPEDO_LCD_ENABLE_GPIO, 0);
> +	msleep(20);
> +	gpio_set_value_cansleep(OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, 0);
> +}

Is there a particular reason for msleep(20) in the enable and disable
function?

> +
> +static struct panel_generic_dpi_data lcd_panel =3D {
> +	.name			=3D "sharp_lq",
> +	.platform_enable	=3D omap3logic_enable_lcd,
> +	.platform_disable	=3D omap3logic_disable_lcd,
> +};
> +
> +static struct omap_dss_device omap3logic_lcd_device =3D {
> +	.name			=3D "lcd",
> +	.driver_name		=3D "generic_dpi_panel",
> +	.type			=3D OMAP_DISPLAY_TYPE_DPI,
> +	.data			=3D &lcd_panel,
> +	.phy.dpi.data_lines	=3D 16,
> +};
> +
> +static struct omap_dss_device omap3logic_tv_device =3D {
> +	.name			=3D "tv",
> +	.driver_name		=3D "venc",
> +	.type			=3D OMAP_DISPLAY_TYPE_VENC,
> +	.phy.venc.type		=3D OMAP_DSS_VENC_TYPE_SVIDEO,
> +};
> +
> +static struct omap_dss_device *omap3logic_dss_devices[] =3D {
> +	&omap3logic_lcd_device,
> +	&omap3logic_tv_device,
> +};
> +
> +static struct omap_dss_board_info omap3logic_dss_data =3D {
> +	.num_devices		=3D ARRAY_SIZE(omap3logic_dss_devices),
> +	.devices		=3D omap3logic_dss_devices,
> +	.default_device		=3D &omap3logic_lcd_device,
> +};
> +
> +static void __init omap3logic_display_init(void)
> +{
> +	int r;
> +
> +	r =3D gpio_request_array(omap3logic_dss_gpios,
> +			       ARRAY_SIZE(omap3logic_dss_gpios));
> +	if (r) {
> +		printk(KERN_ERR "failed to get lcd_panel_* gpios\n");
> +		return;
> +	}
> +
> +	gpio_export(OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, 0);
> +	gpio_export(OMAP3_TORPEDO_LCD_ENABLE_GPIO, 0);
> +	gpio_export(OMAP3_TORPEDO_LCD_PWM_GPIO, 0);
> +
> +	r =3D omap_display_init(&omap3logic_dss_data);
> +	if (r) {
> +		pr_err("OMAP3LOGIC: failed to register DSS device\n");
> +		gpio_free_array(omap3logic_dss_gpios,
> +				ARRAY_SIZE(omap3logic_dss_gpios));
> +	}
> +}
> +
> +static void __init omap3logic_video_mem_init(void)
> +{
> +	/*
> +	 * GFX 480x272x32bpp
> +	 * VID1/2 480x272x32bpp double buffered
> +	 */
> +	omap_vram_set_sdram_vram(PAGE_ALIGN(480 * 272 * 4) +
> +			2 * PAGE_ALIGN(480 * 272 * 4 * 2), 0);
> +}

You should normally let the bootloader or the user define the vram size
via boot parameters, not in the board file like this.

 Tomi


--=-Sfg6qxC+RiiI4n0RcGW6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO5eEuAAoJEPo9qoy8lh71uMAP/2IffjqTzeZocSqHTEzkIjAq
ru73pJ7Qv7vPTPR50O0mpzWPq72kV5Nw6kJmFREAFe2WD7puH3wuovd8nYYy9pkE
ZEqH8r3Yj7urVeEiM9/FaLwQye/vtl0W39O8RsJL89wiqIsJQlUE5qpSre0MK5eo
t+AbHnmjfJq/f4axVTS0frvGLalJaJuU0bU1IDqavmPUBStDoZ8iIep1HXH8ubnh
K3MSkpdFQDd5xqaJwevLye7euuSCHY2Z+NVi0Uv+hkmbj1aK5LBVffpv/KFwlF44
hzhjxuBAgPNlexbjg2AIaqQ8iGJEO8bzdfjXX+eb3UsAPKeI+vnyOoM943qfr9e6
ovImpNibiFYfMZ1CuMsVPPcP7aOBbsajiPHsjr7SqOWz7iHmDDs2O4zKjBACcplP
ROMnx47ZvhLNmaCM3psFbjtu5nF/JrkNtcE6bjJZpa2FRPlckvgLnwHkGMg59F7R
joJiUp59ZTjH3vE5Z+A/RHkqyHPcRjGYJ/xElBpTmFbTmhG6nUEEvTXh9CgPpVCv
9u7464LuZSUPa1Qn7uW57qS2dMFeaLzDybL5+GZuawFGUZDHLzXOeSHg3rMXaPTk
JWaiRy0OOexwXtP2SdeEvjdh0FysCFAAaxLNUe4+IokgY84XVPylc1Hr0CztFvVz
Dr+GmW8Ef80jEj81NvLl
=kyRl
-----END PGP SIGNATURE-----

--=-Sfg6qxC+RiiI4n0RcGW6--

