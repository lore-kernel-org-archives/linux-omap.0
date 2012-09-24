From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] ARM: OMAP4: twl-common: Support for additional
 devices on i2c1 bus
Date: Mon, 24 Sep 2012 08:43:15 -0700
Message-ID: <20120924154315.GY28835@atomide.com>
References: <1348478688-5737-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:20384 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756513Ab2IXPnS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 11:43:18 -0400
Content-Disposition: inline
In-Reply-To: <1348478688-5737-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120924 02:24]:
> On OMAP4 the i2c1 bus is dedicated for the PMIC and audio related devices.
> Manufacturers can opt to use different codec than twl6040 and also can add
> audio related IC to the bus (external amplifier for example on SDP4430).
> 
> Make it possible to add different set of additional devices to i2c1 bus on
> OMAP4 boards.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Tony,
> 
> I have refreshed the patch on top of arm-soc/for-next branch. Would it be
> possible to queue this patch via arm-soc so it will be in 3.7-rc1 already?
> Originally this patch was sent for 3.6...

Yes sorry the platform code has been been badly ignored
lately.. Let's see if we can still get it in now that there's
-rc7 tagged.

Regards,

Tony

 
>  arch/arm/mach-omap2/board-4430sdp.c    | 12 +++++++++--
>  arch/arm/mach-omap2/board-omap4panda.c | 12 +++++++++--
>  arch/arm/mach-omap2/twl-common.c       | 37 ++++++++++------------------------
>  arch/arm/mach-omap2/twl-common.h       |  3 ++-
>  4 files changed, 33 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 6fe9079..7c1a662 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -545,6 +545,14 @@ static struct twl6040_platform_data twl6040_data = {
>  	.audpwron_gpio	= 127,
>  };
>  
> +static struct i2c_board_info __initdata sdp4430_i2c_1_boardinfo[] = {
> +	{
> +		I2C_BOARD_INFO("twl6040", 0x4b),
> +		.irq = OMAP44XX_IRQ_SYS_2N,
> +		.platform_data = &twl6040_data,
> +	},
> +};
> +
>  static struct twl4030_platform_data sdp4430_twldata = {
>  	/* Regulators */
>  	.vusim		= &sdp4430_vusim,
> @@ -578,8 +586,8 @@ static int __init omap4_i2c_init(void)
>  			TWL_COMMON_REGULATOR_CLK32KG |
>  			TWL_COMMON_REGULATOR_V1V8 |
>  			TWL_COMMON_REGULATOR_V2V1);
> -	omap4_pmic_init("twl6030", &sdp4430_twldata,
> -			&twl6040_data, 119 + OMAP44XX_IRQ_GIC_START);
> +	omap4_pmic_init("twl6030", &sdp4430_twldata, sdp4430_i2c_1_boardinfo,
> +			ARRAY_SIZE(sdp4430_i2c_1_boardinfo));
>  	omap_register_i2c_bus(2, 400, NULL, 0);
>  	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
>  				ARRAY_SIZE(sdp4430_i2c_3_boardinfo));
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 8ebb16c..eb7a9a8 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -264,6 +264,14 @@ static struct twl6040_platform_data twl6040_data = {
>  	.audpwron_gpio	= 127,
>  };
>  
> +static struct i2c_board_info __initdata panda_i2c_1_boardinfo[] = {
> +	{
> +		I2C_BOARD_INFO("twl6040", 0x4b),
> +		.irq = OMAP44XX_IRQ_SYS_2N,
> +		.platform_data = &twl6040_data,
> +	},
> +};
> +
>  /* Panda board uses the common PMIC configuration */
>  static struct twl4030_platform_data omap4_panda_twldata;
>  
> @@ -291,8 +299,8 @@ static int __init omap4_panda_i2c_init(void)
>  			TWL_COMMON_REGULATOR_CLK32KG |
>  			TWL_COMMON_REGULATOR_V1V8 |
>  			TWL_COMMON_REGULATOR_V2V1);
> -	omap4_pmic_init("twl6030", &omap4_panda_twldata,
> -			&twl6040_data, 119 + OMAP44XX_IRQ_GIC_START);
> +	omap4_pmic_init("twl6030", &omap4_panda_twldata, panda_i2c_1_boardinfo,
> +			ARRAY_SIZE(panda_i2c_1_boardinfo));
>  	omap_register_i2c_bus(2, 400, NULL, 0);
>  	/*
>  	 * Bus 3 is attached to the DVI port where devices like the pico DLP
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index 040f480..e279732 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -40,16 +40,6 @@ static struct i2c_board_info __initdata pmic_i2c_board_info = {
>  	.flags		= I2C_CLIENT_WAKE,
>  };
>  
> -static struct i2c_board_info __initdata omap4_i2c1_board_info[] = {
> -	{
> -		.addr		= 0x48,
> -		.flags		= I2C_CLIENT_WAKE,
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
>  
>  void __init omap4_pmic_init(const char *pmic_type,
>  		    struct twl4030_platform_data *pmic_data,
> -		    struct twl6040_platform_data *twl6040_data, int twl6040_irq)
> +		    struct i2c_board_info *devices, int nr_devices)
>  {
>  	/* PMIC part*/
>  	omap_mux_init_signal("sys_nirq1", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
> -	strncpy(omap4_i2c1_board_info[0].type, pmic_type,
> -		sizeof(omap4_i2c1_board_info[0].type));
> -	omap4_i2c1_board_info[0].irq = 7 + OMAP44XX_IRQ_GIC_START;
> -	omap4_i2c1_board_info[0].platform_data = pmic_data;
> -
> -	/* TWL6040 audio IC part */
> -	omap4_i2c1_board_info[1].irq = twl6040_irq;
> -	omap4_i2c1_board_info[1].platform_data = twl6040_data;
> -
> -	omap_register_i2c_bus(1, 400, omap4_i2c1_board_info, 2);
> +	omap_pmic_init(1, 400, pmic_type, OMAP44XX_IRQ_SYS_1N, pmic_data);
>  
> +	/* Register additional devices on i2c1 bus if needed */
> +	if (devices)
> +		i2c_register_board_info(1, devices, nr_devices);
>  }
>  
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
>  
>  #if defined(CONFIG_ARCH_OMAP3)
> diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
> index d109c09..2256efe 100644
> --- a/arch/arm/mach-omap2/twl-common.h
> +++ b/arch/arm/mach-omap2/twl-common.h
> @@ -32,6 +32,7 @@
>  
>  struct twl4030_platform_data;
>  struct twl6040_platform_data;
> +struct i2c_board_info;
>  
>  void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int pmic_irq,
>  		    struct twl4030_platform_data *pmic_data);
> @@ -51,7 +52,7 @@ static inline void omap3_pmic_init(const char *pmic_type,
>  
>  void omap4_pmic_init(const char *pmic_type,
>  		    struct twl4030_platform_data *pmic_data,
> -		    struct twl6040_platform_data *audio_data, int twl6040_irq);
> +		    struct i2c_board_info *devices, int nr_devices);
>  
>  void omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
>  			   u32 pdata_flags, u32 regulators_flags);
> -- 
> 1.7.12
> 
