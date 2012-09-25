From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3] ARM: OMAP4: twl-common: Support for additional devices
 on i2c1 bus
Date: Tue, 25 Sep 2012 11:48:19 +0300
Message-ID: <50616FD3.3030203@ti.com>
References: <1348478688-5737-1-git-send-email-peter.ujfalusi@ti.com> <20120924154315.GY28835@atomide.com> <20120924173407.GH28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:54604 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753652Ab2IYIrT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 04:47:19 -0400
Received: by obbuo13 with SMTP id uo13so5586099obb.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 01:47:17 -0700 (PDT)
In-Reply-To: <20120924173407.GH28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On 09/24/2012 08:34 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120924 08:44]:
>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120924 02:24]:
>>> On OMAP4 the i2c1 bus is dedicated for the PMIC and audio related d=
evices.
>>> Manufacturers can opt to use different codec than twl6040 and also =
can add
>>> audio related IC to the bus (external amplifier for example on SDP4=
430).
>>>
>>> Make it possible to add different set of additional devices to i2c1=
 bus on
>>> OMAP4 boards.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>> Hi Tony,
>>>
>>> I have refreshed the patch on top of arm-soc/for-next branch. Would=
 it be
>>> possible to queue this patch via arm-soc so it will be in 3.7-rc1 a=
lready?
>>> Originally this patch was sent for 3.6...
>>
>> Yes sorry the platform code has been been badly ignored
>> lately.. Let's see if we can still get it in now that there's
>> -rc7 tagged.
>=20
> I've updated this for the sparse IRQ changes that remove irqs.h.
> Updated patch below.

Looks good to me.

Thank you,
P=E9ter

>=20
> Tony
>=20
>=20
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Date: Mon, 24 Sep 2012 12:24:48 +0300
> Subject: [PATCH] ARM: OMAP4: twl-common: Support for additional devic=
es on
>  i2c1 bus
>=20
> On OMAP4 the i2c1 bus is dedicated for the PMIC and audio related dev=
ices.
> Manufacturers can opt to use different codec than twl6040 and also ca=
n add
> audio related IC to the bus (external amplifier for example on SDP443=
0).
>=20
> Make it possible to add different set of additional devices to i2c1 b=
us on
> OMAP4 boards.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> [tony@atomide.com: updated for removal of irqs.h]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap=
2/board-4430sdp.c
> index e82098f..749ce96 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -545,6 +545,14 @@ static struct twl6040_platform_data twl6040_data=
 =3D {
>  	.audpwron_gpio	=3D 127,
>  };
> =20
> +static struct i2c_board_info __initdata sdp4430_i2c_1_boardinfo[] =3D=
 {
> +	{
> +		I2C_BOARD_INFO("twl6040", 0x4b),
> +		.irq =3D 119 + OMAP44XX_IRQ_GIC_START,
> +		.platform_data =3D &twl6040_data,
> +	},
> +};
> +
>  static struct twl4030_platform_data sdp4430_twldata =3D {
>  	/* Regulators */
>  	.vusim		=3D &sdp4430_vusim,
> @@ -578,8 +586,8 @@ static int __init omap4_i2c_init(void)
>  			TWL_COMMON_REGULATOR_CLK32KG |
>  			TWL_COMMON_REGULATOR_V1V8 |
>  			TWL_COMMON_REGULATOR_V2V1);
> -	omap4_pmic_init("twl6030", &sdp4430_twldata,
> -			&twl6040_data, 119 + OMAP44XX_IRQ_GIC_START);
> +	omap4_pmic_init("twl6030", &sdp4430_twldata, sdp4430_i2c_1_boardinf=
o,
> +			ARRAY_SIZE(sdp4430_i2c_1_boardinfo));
>  	omap_register_i2c_bus(2, 400, NULL, 0);
>  	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
>  				ARRAY_SIZE(sdp4430_i2c_3_boardinfo));
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-o=
map2/board-omap4panda.c
> index 45fe2d3..7b592d3 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -264,6 +264,14 @@ static struct twl6040_platform_data twl6040_data=
 =3D {
>  	.audpwron_gpio	=3D 127,
>  };
> =20
> +static struct i2c_board_info __initdata panda_i2c_1_boardinfo[] =3D =
{
> +	{
> +		I2C_BOARD_INFO("twl6040", 0x4b),
> +		.irq =3D 119 + OMAP44XX_IRQ_GIC_START,
> +		.platform_data =3D &twl6040_data,
> +	},
> +};
> +
>  /* Panda board uses the common PMIC configuration */
>  static struct twl4030_platform_data omap4_panda_twldata;
> =20
> @@ -291,8 +299,8 @@ static int __init omap4_panda_i2c_init(void)
>  			TWL_COMMON_REGULATOR_CLK32KG |
>  			TWL_COMMON_REGULATOR_V1V8 |
>  			TWL_COMMON_REGULATOR_V2V1);
> -	omap4_pmic_init("twl6030", &omap4_panda_twldata,
> -			&twl6040_data, 119 + OMAP44XX_IRQ_GIC_START);
> +	omap4_pmic_init("twl6030", &omap4_panda_twldata, panda_i2c_1_boardi=
nfo,
> +			ARRAY_SIZE(panda_i2c_1_boardinfo));
>  	omap_register_i2c_bus(2, 400, NULL, 0);
>  	/*
>  	 * Bus 3 is attached to the DVI port where devices like the pico DL=
P
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/t=
wl-common.c
> index 99be94e..af93acc 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -40,16 +40,6 @@ static struct i2c_board_info __initdata pmic_i2c_b=
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
> @@ -79,30 +69,25 @@ void __init omap_pmic_init(int bus, u32 clkrate,
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
> -	omap4_i2c1_board_info[0].irq =3D 7 + OMAP44XX_IRQ_GIC_START;
> -	omap4_i2c1_board_info[0].platform_data =3D pmic_data;
> -
> -	/* TWL6040 audio IC part */
> -	omap4_i2c1_board_info[1].irq =3D twl6040_irq;
> -	omap4_i2c1_board_info[1].platform_data =3D twl6040_data;
> -
> -	omap_register_i2c_bus(1, 400, omap4_i2c1_board_info, 2);
> +	omap_pmic_init(1, 400, pmic_type, 7 + OMAP44XX_IRQ_GIC_START, pmic_=
data);
> =20
> +	/* Register additional devices on i2c1 bus if needed */
> +	if (devices)
> +		i2c_register_board_info(1, devices, nr_devices);
>  }
> =20
>  void __init omap_pmic_late_init(void)
>  {
> -	/* Init the OMAP TWL parameters (if PMIC has been registered) */
> -	if (pmic_i2c_board_info.irq)
> -		omap3_twl_init();
> -	if (omap4_i2c1_board_info[0].irq)
> -		omap4_twl_init();
> +	/* Init the OMAP TWL parameters (if PMIC has been registerd) */
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
> index d109c09..2256efe 100644
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
