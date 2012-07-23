From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP4: twl-common: Support for additional devices
 on i2c1 bus
Date: Mon, 23 Jul 2012 10:47:33 +0200
Message-ID: <500D0FA5.3020208@ti.com>
References: <1342168682-15888-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:42959 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751691Ab2GWIrD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jul 2012 04:47:03 -0400
Received: by obbwd20 with SMTP id wd20so9664424obb.9
        for <linux-omap@vger.kernel.org>; Mon, 23 Jul 2012 01:47:01 -0700 (PDT)
In-Reply-To: <1342168682-15888-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On 07/13/2012 10:38 AM, Peter Ujfalusi wrote:
> On OMAP4 the i2c1 bus is dedicated for the PMIC and audio related dev=
ices.
> Manufacturers can opt to use different codec than twl6040 and also ca=
n add
> audio related IC to the bus (external amplifier for example on SDP443=
0).
>=20
> Make it possible to add differnet set of additional devices to i2c1 b=
us on
> OMAP4 boards.

Would it be possible to queue this patch for 3.6?

Thank you,

P=E9ter

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>=20
> Changes since v1:
> Generated against l-o/master
>=20
> Regards,
> Peter
>=20
>  arch/arm/mach-omap2/board-4430sdp.c    |   12 +++++++++-
>  arch/arm/mach-omap2/board-omap4panda.c |   12 +++++++++-
>  arch/arm/mach-omap2/twl-common.c       |   35 +++++++++-------------=
---------
>  arch/arm/mach-omap2/twl-common.h       |    3 +-
>  4 files changed, 32 insertions(+), 30 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap=
2/board-4430sdp.c
> index ad8a7d9..26466f2 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -547,6 +547,14 @@ static struct twl6040_platform_data twl6040_data=
 =3D {
>  	.irq_base	=3D TWL6040_CODEC_IRQ_BASE,
>  };
> =20
> +static struct i2c_board_info __initdata sdp4430_i2c_1_boardinfo[] =3D=
 {
> +	{
> +		I2C_BOARD_INFO("twl6040", 0x4b),
> +		.irq =3D OMAP44XX_IRQ_SYS_2N,
> +		.platform_data =3D &twl6040_data,
> +	},
> +};
> +
>  static struct twl4030_platform_data sdp4430_twldata =3D {
>  	/* Regulators */
>  	.vusim		=3D &sdp4430_vusim,
> @@ -580,8 +588,8 @@ static int __init omap4_i2c_init(void)
>  			TWL_COMMON_REGULATOR_CLK32KG |
>  			TWL_COMMON_REGULATOR_V1V8 |
>  			TWL_COMMON_REGULATOR_V2V1);
> -	omap4_pmic_init("twl6030", &sdp4430_twldata,
> -			&twl6040_data, OMAP44XX_IRQ_SYS_2N);
> +	omap4_pmic_init("twl6030", &sdp4430_twldata, sdp4430_i2c_1_boardinf=
o,
> +			ARRAY_SIZE(sdp4430_i2c_1_boardinfo));
>  	omap_register_i2c_bus(2, 400, NULL, 0);
>  	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
>  				ARRAY_SIZE(sdp4430_i2c_3_boardinfo));
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-o=
map2/board-omap4panda.c
> index b627cdc..5becba2 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -266,6 +266,14 @@ static struct twl6040_platform_data twl6040_data=
 =3D {
>  	.irq_base	=3D TWL6040_CODEC_IRQ_BASE,
>  };
> =20
> +static struct i2c_board_info __initdata panda_i2c_1_boardinfo[] =3D =
{
> +	{
> +		I2C_BOARD_INFO("twl6040", 0x4b),
> +		.irq =3D OMAP44XX_IRQ_SYS_2N,
> +		.platform_data =3D &twl6040_data,
> +	},
> +};
> +
>  /* Panda board uses the common PMIC configuration */
>  static struct twl4030_platform_data omap4_panda_twldata;
> =20
> @@ -293,8 +301,8 @@ static int __init omap4_panda_i2c_init(void)
>  			TWL_COMMON_REGULATOR_CLK32KG |
>  			TWL_COMMON_REGULATOR_V1V8 |
>  			TWL_COMMON_REGULATOR_V2V1);
> -	omap4_pmic_init("twl6030", &omap4_panda_twldata,
> -			&twl6040_data, OMAP44XX_IRQ_SYS_2N);
> +	omap4_pmic_init("twl6030", &omap4_panda_twldata, panda_i2c_1_boardi=
nfo,
> +			ARRAY_SIZE(panda_i2c_1_boardinfo));
>  	omap_register_i2c_bus(2, 400, NULL, 0);
>  	/*
>  	 * Bus 3 is attached to the DVI port where devices like the pico DL=
P
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/t=
wl-common.c
> index 3882f3c..d52be85 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -39,16 +39,6 @@ static struct i2c_board_info __initdata pmic_i2c_b=
oard_info =3D {
>  	.flags		=3D I2C_CLIENT_WAKE,
>  };
> =20
> -static struct i2c_board_info __initdata omap4_i2c1_board_info[] =3D =
{
> -	{
> -		.addr		=3D 0x48,
> -		.flags		=3D I2C_CLIENT_WAKE,
> -	},
> -	{
> -		I2C_BOARD_INFO("twl6040", 0x4b),
> -	},
> -};
> -
>  #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>  static int twl_set_voltage(void *data, int target_uV)
>  {
> @@ -77,30 +67,25 @@ void __init omap_pmic_init(int bus, u32 clkrate,
> =20
>  void __init omap4_pmic_init(const char *pmic_type,
>  		    struct twl4030_platform_data *pmic_data,
> -		    struct twl6040_platform_data *twl6040_data, int twl6040_irq)
> +		    struct i2c_board_info *devices, int nr_devices)
>  {
>  	/* PMIC part*/
>  	omap_mux_init_signal("sys_nirq1", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_=
OFF_WAKEUPENABLE);
> -	strncpy(omap4_i2c1_board_info[0].type, pmic_type,
> -		sizeof(omap4_i2c1_board_info[0].type));
> -	omap4_i2c1_board_info[0].irq =3D OMAP44XX_IRQ_SYS_1N;
> -	omap4_i2c1_board_info[0].platform_data =3D pmic_data;
> -
> -	/* TWL6040 audio IC part */
> -	omap4_i2c1_board_info[1].irq =3D twl6040_irq;
> -	omap4_i2c1_board_info[1].platform_data =3D twl6040_data;
> -
> -	omap_register_i2c_bus(1, 400, omap4_i2c1_board_info, 2);
> +	omap_pmic_init(1, 400, pmic_type, OMAP44XX_IRQ_SYS_1N, pmic_data);
> =20
> +	/* Register additional devices on i2c1 bus if needed */
> +	if (devices)
> +		i2c_register_board_info(1, devices, nr_devices);
>  }
> =20
>  void __init omap_pmic_late_init(void)
>  {
>  	/* Init the OMAP TWL parameters (if PMIC has been registerd) */
> -	if (pmic_i2c_board_info.irq)
> -		omap3_twl_init();
> -	if (omap4_i2c1_board_info[0].irq)
> -		omap4_twl_init();
> +	if (!pmic_i2c_board_info.irq)
> +		return;
> +
> +	omap3_twl_init();
> +	omap4_twl_init();
>  }
> =20
>  #if defined(CONFIG_ARCH_OMAP3)
> diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/t=
wl-common.h
> index 8fe71cf..de062c7 100644
> --- a/arch/arm/mach-omap2/twl-common.h
> +++ b/arch/arm/mach-omap2/twl-common.h
> @@ -32,6 +32,7 @@
> =20
>  struct twl4030_platform_data;
>  struct twl6040_platform_data;
> +struct i2c_board_info;
> =20
>  void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int=
 pmic_irq,
>  		    struct twl4030_platform_data *pmic_data);
> @@ -51,7 +52,7 @@ static inline void omap3_pmic_init(const char *pmic=
_type,
> =20
>  void omap4_pmic_init(const char *pmic_type,
>  		    struct twl4030_platform_data *pmic_data,
> -		    struct twl6040_platform_data *audio_data, int twl6040_irq);
> +		    struct i2c_board_info *devices, int nr_devices);
> =20
>  void omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
>  			   u32 pdata_flags, u32 regulators_flags);
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
