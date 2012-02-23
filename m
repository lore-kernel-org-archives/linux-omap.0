From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v2 5/7] ARM: OMAP2+: Split omap2_hsmmc_init() to properly
 support I2C GPIO pins
Date: Thu, 23 Feb 2012 16:28:15 +0200
Message-ID: <4F464CFF.3080006@compulab.co.il>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com> <1329997247-27342-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:60578
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756437Ab2BWO2a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 09:28:30 -0500
In-Reply-To: <1329997247-27342-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>, Steve Sakoman <sakoman@gmail.com>

Hi Tony, Rajendra,

On 02/23/12 13:40, Rajendra Nayak wrote:
> From: Tony Lindgren <tony@atomide.com>
> 
> Otherwise omap_device_build() and omap_mux related functions
> can't be marked as __init when twl is build as a module.
> 
> If a board is using GPIO pins or regulators configured by an
> external chip, such as TWL PMIC on I2C bus, the board must
> mark those MMC controllers as deferred. Additionally both
> omap_hsmmc_init() and omap_hsmmc_deferred_add() must be called
> by the board.
> 
> For MMC controllers using internal GPIO pins for card
> detect and regulators the slots don't need to be marked
> deferred. In this case calling omap_hsmmc_init() is sufficient.
> 
> Note that this patch does not change the behaviour for
> board-4430sdp.c board-omap4panda.c. These boards wrongly
> rely on the omap_hsmmc.c init function callback to configure
> the PMIC GPIO interrupt lines on external chip. If the PMIC
> interrupt lines are not configured during init, they will
> fail.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
>  arch/arm/mach-omap2/board-3430sdp.c          |   12 ++--
>  arch/arm/mach-omap2/board-4430sdp.c          |    4 +-
>  arch/arm/mach-omap2/board-am3517evm.c        |    2 +-
>  arch/arm/mach-omap2/board-cm-t35.c           |   10 +-
>  arch/arm/mach-omap2/board-devkit8000.c       |    7 +-
>  arch/arm/mach-omap2/board-igep0020.c         |   11 ++-
>  arch/arm/mach-omap2/board-ldp.c              |    2 +-
>  arch/arm/mach-omap2/board-omap3beagle.c      |    7 +-
>  arch/arm/mach-omap2/board-omap3evm.c         |    9 +-
>  arch/arm/mach-omap2/board-omap3logic.c       |    2 +-
>  arch/arm/mach-omap2/board-omap3pandora.c     |   13 ++--
>  arch/arm/mach-omap2/board-omap3stalker.c     |   14 ++--
>  arch/arm/mach-omap2/board-omap3touchbook.c   |    7 +-
>  arch/arm/mach-omap2/board-omap4panda.c       |    4 +-
>  arch/arm/mach-omap2/board-overo.c            |    5 +-
>  arch/arm/mach-omap2/board-rm680.c            |    2 +-
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    9 ++-
>  arch/arm/mach-omap2/hsmmc.c                  |  117 +++++++++++++++++++-------
>  arch/arm/mach-omap2/hsmmc.h                  |   13 ++-
>  21 files changed, 165 insertions(+), 89 deletions(-)

[...]

> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index d73316e..14df109 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -411,9 +411,9 @@ static struct omap2_hsmmc_info mmc[] = {
>  	{
>  		.mmc		= 1,
>  		.caps		= MMC_CAP_4_BIT_DATA,
> -		.gpio_cd	= -EINVAL,
> +		.gpio_cd	= OMAP_MAX_GPIO_LINES + 0,
>  		.gpio_wp	= -EINVAL,
> -
> +		.deferred	= true,
>  	},
>  	{
>  		.mmc		= 2,
> @@ -422,6 +422,7 @@ static struct omap2_hsmmc_info mmc[] = {
>  		.gpio_cd	= -EINVAL,
>  		.gpio_wp	= -EINVAL,
>  		.ocr_mask	= 0x00100000,	/* 3.3V */
> +		.deferred	= true,

Why do you defer this one?
It does not use external GPIO chip, in fact it does not use CD/WP at all.

>  	},
>  	{}	/* Terminator */
>  };
> @@ -469,9 +470,7 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
>  		pr_err("CM-T35: could not obtain gpio for WiFi reset\n");
>  	}
>  
> -	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> -	mmc[0].gpio_cd = gpio + 0;
> -	omap2_hsmmc_init(mmc);
> +	omap_hsmmc_deferred_add(mmc);
>  
>  	return 0;
>  }
> @@ -639,6 +638,7 @@ static void __init cm_t3x_common_init(void)
>  	omap_serial_init();
>  	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
>  			     mt46h32m32lf6_sdrc_params);
> +	omap_hsmmc_init(mmc);
>  	cm_t35_init_i2c();
>  	omap_ads7846_init(1, CM_T35_GPIO_PENDOWN, 0, NULL);
>  	cm_t35_init_ethernet();

Other then the comment above, looks fine.
I will probably be able to test this on Sunday.

[...]

> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> index a59ace0..11a6aa4 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -293,8 +293,9 @@ static struct omap2_hsmmc_info mmc[] = {
>  	{
>  		.mmc		= 1,
>  		.caps		= MMC_CAP_4_BIT_DATA,
> -		.gpio_cd	= -EINVAL,
> +		.gpio_cd	= OMAP_MAX_GPIO_LINES + 0,
>  		.gpio_wp	= -EINVAL,
> +		.deferred	= true,
>  	},
>  #if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
>  	{
> @@ -302,6 +303,7 @@ static struct omap2_hsmmc_info mmc[] = {
>  		.caps		= MMC_CAP_4_BIT_DATA,
>  		.gpio_cd	= -EINVAL,
>  		.gpio_wp	= -EINVAL,
> +		.deferred	= true,

same here, why defer it?

>  	},
>  #endif
>  	{}      /* Terminator */
> @@ -400,9 +402,7 @@ static int igep_twl_gpio_setup(struct device *dev,
>  {
>  	int ret;
>  
> -	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> -	mmc[0].gpio_cd = gpio + 0;
> -	omap2_hsmmc_init(mmc);
> +	omap_hsmmc_deferred_add(mmc);
>  
>  	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
>  #if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
> @@ -639,6 +639,9 @@ static void __init igep_init(void)
>  
>  	/* Get IGEP2 hardware revision */
>  	igep2_get_revision();
> +
> +	omap_hsmmc_init(mmc);
> +
>  	/* Register I2C busses and drivers */
>  	igep_i2c_init();
>  	platform_add_devices(igep_devices, ARRAY_SIZE(igep_devices));

[...]

> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index c775bea..b736c4d 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -315,8 +315,9 @@ static struct omap2_hsmmc_info mmc[] = {
>  	{
>  		.mmc		= 1,
>  		.caps		= MMC_CAP_4_BIT_DATA,
> -		.gpio_cd	= -EINVAL,
> +		.gpio_cd	= OMAP_MAX_GPIO_LINES + 0,
>  		.gpio_wp	= 63,
> +		.deferred	= true,
>  	},
>  #ifdef CONFIG_WL12XX_PLATFORM_DATA
>  	{
> @@ -326,6 +327,7 @@ static struct omap2_hsmmc_info mmc[] = {
>  		.gpio_wp	= -EINVAL,
>  		.gpio_cd	= -EINVAL,
>  		.nonremovable	= true,
> +		.deferred	= true,

ditto

>  	},
>  #endif
>  	{}	/* Terminator */
> @@ -360,10 +362,8 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
>  {
>  	int r, lcd_bl_en;
>  
> -	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
>  	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
> -	mmc[0].gpio_cd = gpio + 0;
> -	omap2_hsmmc_init(mmc);
> +	omap_hsmmc_deferred_add(mmc);
>  
>  	/*
>  	 * Most GPIOs are for USB OTG.  Some are mostly sent to
> @@ -644,6 +644,7 @@ static void __init omap3_evm_init(void)
>  	omap_board_config = omap3_evm_config;
>  	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
>  
> +	omap_hsmmc_init(mmc);
>  	omap3_evm_i2c_init();
>  
>  	omap_display_init(&omap3_evm_dss_data);

[...]

> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
> index 1644b73..d984048 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -270,17 +270,19 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
>  	{
>  		.mmc		= 1,
>  		.caps		= MMC_CAP_4_BIT_DATA,
> -		.gpio_cd	= -EINVAL,
> +		.gpio_cd	= OMAP_MAX_GPIO_LINES + 0,
>  		.gpio_wp	= 126,
>  		.ext_clock	= 0,
> +		.deferred	= true,
>  	},
>  	{
>  		.mmc		= 2,
>  		.caps		= MMC_CAP_4_BIT_DATA,
> -		.gpio_cd	= -EINVAL,
> +		.gpio_cd	= OMAP_MAX_GPIO_LINES + 1,
>  		.gpio_wp	= 127,
>  		.ext_clock	= 1,
>  		.transceiver	= true,
> +		.deferred	= true,
>  	},
>  	{
>  		.mmc		= 3,
> @@ -288,6 +290,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
>  		.gpio_cd	= -EINVAL,
>  		.gpio_wp	= -EINVAL,
>  		.init_card	= pandora_wl1251_init_card,
> +		.deferred	= true,

ditto

>  	},
>  	{}	/* Terminator */
>  };
> @@ -297,10 +300,7 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
>  {
>  	int ret, gpio_32khz;
>  
> -	/* gpio + {0,1} is "mmc{0,1}_cd" (input/IRQ) */
> -	omap3pandora_mmc[0].gpio_cd = gpio + 0;
> -	omap3pandora_mmc[1].gpio_cd = gpio + 1;
> -	omap2_hsmmc_init(omap3pandora_mmc);
> +	omap_hsmmc_deferred_add(omap3pandora_mmc);
>  
>  	/* gpio + 13 drives 32kHz buffer for wifi module */
>  	gpio_32khz = gpio + 13;
> @@ -580,6 +580,7 @@ static struct omap_board_mux board_mux[] __initdata = {
>  static void __init omap3pandora_init(void)
>  {
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> +	omap_hsmmc_init(omap3pandora_mmc);
>  	omap3pandora_i2c_init();
>  	pandora_wl1251_init();
>  	platform_add_devices(omap3pandora_devices,

[...]

> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> index 52c0cef..8b6065b 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -301,6 +301,7 @@ static struct omap2_hsmmc_info mmc[] = {
>  		.caps		= MMC_CAP_4_BIT_DATA,
>  		.gpio_cd	= -EINVAL,
>  		.gpio_wp	= -EINVAL,
> +		.deferred	= true,
>  	},
>  	{
>  		.mmc		= 2,
> @@ -309,6 +310,7 @@ static struct omap2_hsmmc_info mmc[] = {
>  		.gpio_wp	= -EINVAL,
>  		.transceiver	= true,
>  		.ocr_mask	= 0x00100000,	/* 3.3V */
> +		.deferred	= true,
>  	},
>  	{}	/* Terminator */
>  };
> @@ -407,7 +409,7 @@ static inline void __init overo_init_keys(void) { return; }
>  static int overo_twl_gpio_setup(struct device *dev,
>  		unsigned gpio, unsigned ngpio)
>  {
> -	omap2_hsmmc_init(mmc);
> +	omap_hsmmc_deferred_add(mmc);

This board does not look like using external chip for MMC GPIOs,
if that is true, then the above can be just removed.

Added Steve to Cc.

>  
>  #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
>  	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
> @@ -505,6 +507,7 @@ static void __init overo_init(void)
>  	int ret;
>  
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> +	omap_hsmmc_init(mmc);
>  	overo_i2c_init();
>  	omap_display_init(&overo_dss_data);
>  	omap_serial_init();

[...]

> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index c126461..f99284f 100644
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -203,8 +203,10 @@ static struct omap2_hsmmc_info mmc[] = {
>  		.name		= "external",
>  		.mmc		= 1,
>  		.caps		= MMC_CAP_4_BIT_DATA,
> +		.gpio_cd	= OMAP_MAX_GPIO_LINES + 0,
>  		.gpio_wp	= -EINVAL,
>  		.power_saving	= true,
> +		.deferred	= true,
>  	},
>  	{
>  		.name		= "internal",
> @@ -214,6 +216,7 @@ static struct omap2_hsmmc_info mmc[] = {
>  		.gpio_wp	= -EINVAL,
>  		.nonremovable	= true,
>  		.power_saving	= true,
> +		.deferred	= true,

ditto, why defer?

>  	},
>  	{
>  		.name		= "wl1271",
> @@ -222,6 +225,7 @@ static struct omap2_hsmmc_info mmc[] = {
>  		.gpio_wp	= -EINVAL,
>  		.gpio_cd	= -EINVAL,
>  		.nonremovable	= true,
> +		.deferred	= true,

ditto

>  	},
>  	{}      /* Terminator */
>  };
> @@ -231,9 +235,7 @@ static int zoom_twl_gpio_setup(struct device *dev,
>  {
>  	int ret;
>  
> -	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> -	mmc[0].gpio_cd = gpio + 0;
> -	omap2_hsmmc_init(mmc);
> +	omap_hsmmc_deferred_add(mmc);
>  
>  	ret = gpio_request_one(LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
>  			       "lcd enable");
> @@ -301,6 +303,7 @@ void __init zoom_peripherals_init(void)
>  	if (ret)
>  		pr_err("error setting wl12xx data: %d\n", ret);
>  
> +	omap_hsmmc_init(mmc);
>  	omap_i2c_init();
>  	platform_device_register(&omap_vwlan_device);
>  	usb_musb_init(NULL);

[...]


-- 
Regards,
Igor.
