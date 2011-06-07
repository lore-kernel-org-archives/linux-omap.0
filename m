From: "Kridner, Jason" <jdk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v7] OMAP3: beagle: add support for
 beagleboard xM revision C
Date: Tue, 7 Jun 2011 17:26:29 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E928C407E@dlee03.ent.ti.com>
References: <8FFAA0BFC4E5374B8F85F65FE1F2BFA5C62252EF@dlee02.ent.ti.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <beagleboard+bncCKmZx5vdGRCZy7rvBBoEc8-9ug-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <8FFAA0BFC4E5374B8F85F65FE1F2BFA5C62252EF-EovWT4A8QTWIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post?hl=en_US>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard?hl=en_US>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe?hl=en_US>,
 <mailto:beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Language: en-US
To: "Fernandes, Joel A" <joelagnel-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Kooi, Koen" <k-kooi-l0cyMroinI0@public.gmane.org>, "beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Fernandes, Joel A
> Sent: Tuesday, June 07, 2011 4:55 PM
> To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Kridner, Jason; Kooi, Koen; beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
> Subject: [PATCH v7] OMAP3: beagle: add support for beagleboard xM
> revision C
> 
> OMAP3: beagle: add support for beagleboard xM revision C
> 
> The USB enable GPIO has been in beagleboard xM revision C.
> The USER button has been moved since beagleboard xM.
> Also, board specific initialization has been moved to beagle_config
> struct
> and initialized in omap3_beagle_init_rev. Default values in struct are
> for xMC.
> 
> Signed-off-by: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>

Hope this isn't considered noise, but...

Ack.

> ---
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-
> omap2/board-omap3beagle.c
> index 7f21d24..4b113b2 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -61,7 +61,8 @@
>   *	AXBX	= GPIO173, GPIO172, GPIO171: 1 1 1
>   *	C1_3	= GPIO173, GPIO172, GPIO171: 1 1 0
>   *	C4	= GPIO173, GPIO172, GPIO171: 1 0 1
> - *	XM	= GPIO173, GPIO172, GPIO171: 0 0 0
> + *	XMA/XMB = GPIO173, GPIO172, GPIO171: 0 0 0
> + *	XMC = GPIO173, GPIO172, GPIO171: 0 1 0
>   */
>  enum {
>  	OMAP3BEAGLE_BOARD_UNKN = 0,
> @@ -69,14 +70,26 @@ enum {
>  	OMAP3BEAGLE_BOARD_C1_3,
>  	OMAP3BEAGLE_BOARD_C4,
>  	OMAP3BEAGLE_BOARD_XM,
> +	OMAP3BEAGLE_BOARD_XMC,
>  };
> 
>  static u8 omap3_beagle_version;
> 
> -static u8 omap3_beagle_get_rev(void)
> -{
> -	return omap3_beagle_version;
> -}
> +/*
> + * Board-specific configuration
> + * Defaults to BeagleBoard-xMC
> + */
> +static struct {
> +	int mmc1_gpio_wp;
> +	int usb_pwr_level;
> +	int reset_gpio;
> +	int usr_button_gpio;
> +} beagle_config = {
> +	.mmc1_gpio_wp = -EINVAL,
> +	.usb_pwr_level = GPIOF_OUT_INIT_LOW,
> +	.reset_gpio = 129,
> +	.usr_button_gpio = 4,
> +};
> 
>  static struct gpio omap3_beagle_rev_gpios[] __initdata = {
>  	{ 171, GPIOF_IN, "rev_id_0"    },
> @@ -111,18 +124,32 @@ static void __init omap3_beagle_init_rev(void)
>  	case 7:
>  		printk(KERN_INFO "OMAP3 Beagle Rev: Ax/Bx\n");
>  		omap3_beagle_version = OMAP3BEAGLE_BOARD_AXBX;
> +		beagle_config.mmc1_gpio_wp = 29;
> +		beagle_config.reset_gpio = 170;
> +		beagle_config.usr_button_gpio = 7;
>  		break;
>  	case 6:
>  		printk(KERN_INFO "OMAP3 Beagle Rev: C1/C2/C3\n");
>  		omap3_beagle_version = OMAP3BEAGLE_BOARD_C1_3;
> +		beagle_config.mmc1_gpio_wp = 23;
> +		beagle_config.reset_gpio = 170;
> +		beagle_config.usr_button_gpio = 7;
>  		break;
>  	case 5:
>  		printk(KERN_INFO "OMAP3 Beagle Rev: C4\n");
>  		omap3_beagle_version = OMAP3BEAGLE_BOARD_C4;
> +		beagle_config.mmc1_gpio_wp = 23;
> +		beagle_config.reset_gpio = 170;
> +		beagle_config.usr_button_gpio = 7;
>  		break;
>  	case 0:
> -		printk(KERN_INFO "OMAP3 Beagle Rev: xM\n");
> +		printk(KERN_INFO "OMAP3 Beagle Rev: xM Ax/Bx\n");
>  		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
> +		beagle_config.usb_pwr_level = GPIOF_OUT_INIT_HIGH;
> +		break;
> +	case 2:
> +		printk(KERN_INFO "OMAP3 Beagle Rev: xM C\n");
> +		omap3_beagle_version = OMAP3BEAGLE_BOARD_XMC;
>  		break;
>  	default:
>  		printk(KERN_INFO "OMAP3 Beagle Rev: unknown %hd\n",
> beagle_rev);
> @@ -234,7 +261,7 @@ static struct omap2_hsmmc_info mmc[] = {
>  	{
>  		.mmc		= 1,
>  		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
> -		.gpio_wp	= 29,
> +		.gpio_wp	= -EINVAL,
>  	},
>  	{}	/* Terminator */
>  };
> @@ -252,17 +279,11 @@ static struct gpio_led gpio_leds[];
>  static int beagle_twl_gpio_setup(struct device *dev,
>  		unsigned gpio, unsigned ngpio)
>  {
> -	int r, usb_pwr_level;
> -
> -	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> -		mmc[0].gpio_wp = -EINVAL;
> -	} else if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3)
> ||
> -		(omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C4)) {
> -		omap_mux_init_gpio(23, OMAP_PIN_INPUT);
> -		mmc[0].gpio_wp = 23;
> -	} else {
> -		omap_mux_init_gpio(29, OMAP_PIN_INPUT);
> -	}
> +	int r;
> +
> +	if (beagle_config.mmc1_gpio_wp != -EINVAL)
> +		omap_mux_init_gpio(beagle_config.mmc1_gpio_wp,
> OMAP_PIN_INPUT);
> +	mmc[0].gpio_wp = beagle_config.mmc1_gpio_wp;
>  	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
>  	mmc[0].gpio_cd = gpio + 0;
>  	omap2_hsmmc_init(mmc);
> @@ -276,9 +297,8 @@ static int beagle_twl_gpio_setup(struct device *dev,
>  	 * high / others active low)
>  	 * DVI reset GPIO is different between beagle revisions
>  	 */
> -	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> -		usb_pwr_level = GPIOF_OUT_INIT_HIGH;
> -		beagle_dvi_device.reset_gpio = 129;
> +	/* Valid for all -xM revisions */
> +	if (cpu_is_omap3630()) {
>  		/*
>  		 * gpio + 1 on Xm controls the TFP410's enable line
> (active low)
>  		 * gpio + 2 control varies depending on the board rev as
> below:
> @@ -296,8 +316,6 @@ static int beagle_twl_gpio_setup(struct device *dev,
>  			pr_err("%s: unable to configure DVI_LDO_EN\n",
>  				__func__);
>  	} else {
> -		usb_pwr_level = GPIOF_OUT_INIT_LOW;
> -		beagle_dvi_device.reset_gpio = 170;
>  		/*
>  		 * REVISIT: need ehci-omap hooks for external VBUS
>  		 * power switch and overcurrent detect
> @@ -305,8 +323,10 @@ static int beagle_twl_gpio_setup(struct device
> *dev,
>  		if (gpio_request_one(gpio + 1, GPIOF_IN, "EHCI_nOC"))
>  			pr_err("%s: unable to configure EHCI_nOC\n",
> __func__);
>  	}
> +	beagle_dvi_device.reset_gpio = beagle_config.reset_gpio;
> 
> -	gpio_request_one(gpio + TWL4030_GPIO_MAX, usb_pwr_level,
> "nEN_USB_PWR");
> +	gpio_request_one(gpio + TWL4030_GPIO_MAX,
> beagle_config.usb_pwr_level,
> +			"nEN_USB_PWR");
> 
>  	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED)
> */
>  	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
> @@ -458,7 +478,8 @@ static struct platform_device leds_gpio = {
>  static struct gpio_keys_button gpio_buttons[] = {
>  	{
>  		.code			= BTN_EXTRA,
> -		.gpio			= 7,
> +		/* Dynamically assigned depending on board */
> +		.gpio			= -EINVAL,
>  		.desc			= "user",
>  		.wakeup			= 1,
>  	},
> @@ -525,8 +546,8 @@ static void __init beagle_opp_init(void)
>  		return;
>  	}
> 
> -	/* Custom OPP enabled for XM */
> -	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> +	/* Custom OPP enabled for all xM versions */
> +	if (cpu_is_omap3630()) {
>  		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
>  		struct omap_hwmod *dh = omap_hwmod_lookup("iva");
>  		struct device *dev;
> @@ -566,6 +587,9 @@ static void __init omap3_beagle_init(void)
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	omap3_beagle_init_rev();
>  	omap3_beagle_i2c_init();
> +
> +	gpio_buttons[0].gpio = beagle_config.usr_button_gpio;
> +
>  	platform_add_devices(omap3_beagle_devices,
>  			ARRAY_SIZE(omap3_beagle_devices));
>  	omap_display_init(&beagle_dss_data);

-- 
You received this message because you are subscribed to the Google Groups "Beagle Board" group.
To post to this group, send email to beagleboard-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/beagleboard?hl=en.
