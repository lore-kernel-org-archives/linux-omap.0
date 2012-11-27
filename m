From: Andy Green <andy.green@linaro.org>
Subject: Re: [RFC PATCH 4/5] omap4: panda: add smsc95xx regulator and reset
 dependent on root hub
Date: Tue, 27 Nov 2012 08:17:37 +0800
Message-ID: <50B406A1.6040904@linaro.org>
References: <20121126123427.18106.4112.stgit@build.warmcat.com> <20121126124550.18106.29133.stgit@build.warmcat.com> <50B396B0.4070800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:41212 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754323Ab2K0ARq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 19:17:46 -0500
In-Reply-To: <50B396B0.4070800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: stern@rowland.harvard.edu, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com

On 11/27/2012 12:20 AM, the mail apparently from Roger Quadros included=
:
> Hi Andy,
>
> On 11/26/2012 02:45 PM, Andy Green wrote:
>> This adds regulators which are controlled by the OMAP4 PandaBoard (E=
S)'s
>> EHCI logical root hub existing.
>>
>> Without power control, the ULPI PHY + SMSC9614 on the Panda eats 700=
-900mW
>> all the time, which is around the same as the idle power of the SoC =
and
>> rest of the board.
>>
>> This allows us to start off with it depowered, and only power it if =
the
>> ehci-hcd module is inserted.  When the module is removed, it's depow=
ered
>> again.
>>
>> Signed-off-by: Andy Green <andy.green@linaro.org>
>> ---
>>   arch/arm/mach-omap2/Kconfig            |    1
>>   arch/arm/mach-omap2/board-omap4panda.c |   90 ++++++++++++++++++++=
+++++-------
>>   2 files changed, 72 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconf=
ig
>> index d669e22..5105109 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -368,6 +368,7 @@ config MACH_OMAP4_PANDA
>>   	select OMAP_PACKAGE_CBL
>>   	select OMAP_PACKAGE_CBS
>>   	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>> +	select USB_HUB_DEVICE_PATH_REGULATOR
>>
>>   config OMAP3_EMU
>>   	bool "OMAP3 debugging peripherals"
>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-=
omap2/board-omap4panda.c
>> index bfcd397..b032b6b 100644
>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -154,11 +154,6 @@ static const struct usbhs_omap_board_data usbhs=
_bdata __initconst =3D {
>>   	.reset_gpio_port[2]  =3D -EINVAL
>>   };
>>
>> -static struct gpio panda_ehci_gpios[] __initdata =3D {
>> -	{ GPIO_HUB_POWER,	GPIOF_OUT_INIT_LOW,  "hub_power"  },
>> -	{ GPIO_HUB_NRESET,	GPIOF_OUT_INIT_LOW,  "hub_nreset" },
>> -};
>> -
>>   static void __init omap4_ehci_init(void)
>>   {
>>   	int ret;
>> @@ -173,23 +168,76 @@ static void __init omap4_ehci_init(void)
>>   	clk_set_rate(phy_ref_clk, 19200000);
>>   	clk_prepare_enable(phy_ref_clk);
>>
>> -	/* disable the power to the usb hub prior to init and reset phy+hu=
b */
>> -	ret =3D gpio_request_array(panda_ehci_gpios,
>> -				 ARRAY_SIZE(panda_ehci_gpios));
>> -	if (ret) {
>> -		pr_err("Unable to initialize EHCI power/reset\n");
>> -		return;
>> -	}
>> +	usbhs_init(&usbhs_bdata);
>> +}
>>
>> -	gpio_export(GPIO_HUB_POWER, 0);
>> -	gpio_export(GPIO_HUB_NRESET, 0);
>> -	gpio_set_value(GPIO_HUB_NRESET, 1);
>> +/*
>> + * hub_nreset also resets the ULPI PHY and is required after poweri=
ng SMSC chip
>> + *	ULPI PHY is always powered... need to do reset once for both onc=
e
>> + * hub_power enables a 3.3V regulator for (hub + eth) chip
>> + *	however there's no point having ULPI PHY in use alone
>> + *	since it's only connected to the (hub + eth) chip
>> + */
>>
>> -	usbhs_init(&usbhs_bdata);
>> +static struct regulator_init_data panda_hub =3D {
>> +	.constraints =3D {
>> +		.name =3D "vhub",
>> +		.valid_ops_mask =3D REGULATOR_CHANGE_STATUS,
>> +	},
>> +};
>>
>> -	/* enable power to hub */
>> -	gpio_set_value(GPIO_HUB_POWER, 1);
>> -}
>> +static struct fixed_voltage_config panda_vhub =3D {
>> +	.supply_name =3D "vhub",
>> +	.microvolts =3D 3300000,
>> +	.gpio =3D GPIO_HUB_POWER,
>> +	.startup_delay =3D 70000, /* 70msec */
>> +	.enable_high =3D 1,
>> +	.enabled_at_boot =3D 0,
>> +	.init_data =3D &panda_hub,
>> +};
>> +
>> +static struct platform_device omap_vhub_device =3D {
>> +	.name		=3D "reg-fixed-voltage",
>> +	.id		=3D 2,
>> +	.dev =3D {
>> +		.platform_data =3D &panda_vhub,
>> +	},
>> +};
>> +
>> +static struct regulator_init_data panda_ulpireset =3D {
>> +	/*
>> +	 * idea is that when operating ulpireset, regulator api will make
>> +	 * sure that the hub+eth chip is powered, since it's the "parent"
>> +	 */
>> +	.supply_regulator =3D "vhub", /* we are a child of vhub */
>> +	.constraints =3D {
>> +		/*
>> +		 * this magic string associates us with ehci-omap.0 root hub
>> +		 * when the root hub logical device is up, we will power
>> +		 * and reset [ ULPI PHY + [ HUB + ETH ] ]
>> +		 */
>> +		.name =3D "/platform/usbhs_omap/ehci-omap.0/usb*",
>> +		.valid_ops_mask =3D REGULATOR_CHANGE_STATUS,
>> +	},
>> +};
>> +
>> +static struct fixed_voltage_config panda_vulpireset =3D {
>> +	.supply_name =3D "/platform/usbhs_omap/ehci-omap.0/usb*",
>
> Does this supply_name really needs to be the magic string?

I believe that's how the two regulators bind together in the=20
parent-child relationship.

Having the literal twice is bad I agree... it could be moved to a const=
=20
char * earlier and referenced as that.

-Andy

>> +	.microvolts =3D 3300000,
>> +	.gpio =3D GPIO_HUB_NRESET,
>> +	.startup_delay =3D 70000, /* 70msec */
>> +	.enable_high =3D 1,
>> +	.enabled_at_boot =3D 0,
>> +	.init_data =3D &panda_ulpireset,
>> +};
>> +
>> +static struct platform_device omap_vulpireset_device =3D {
>> +	.name		=3D "reg-fixed-voltage",
>> +	.id		=3D 3,
>> +	.dev =3D {
>> +		.platform_data =3D &panda_vulpireset,
>> +	},
>> +};
>>
>>   static struct omap_musb_board_data musb_board_data =3D {
>>   	.interface_type		=3D MUSB_INTERFACE_UTMI,
>> @@ -503,7 +551,11 @@ static void __init omap4_panda_init(void)
>>   	omap4_panda_init_rev();
>>   	omap4_panda_i2c_init();
>>   	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
>> +	/* let device_path api know anything matching this reports as this=
 */
>> +	device_path_register_wildcard_path(panda_ulpireset.constraints.nam=
e);
>>   	platform_device_register(&omap_vwlan_device);
>> +	platform_device_register(&omap_vhub_device);
>> +	platform_device_register(&omap_vulpireset_device);
>>   	omap_serial_init();
>>   	omap_sdrc_init(NULL, NULL);
>>   	omap4_twl6030_hsmmc_init(mmc);
>>
>
> --
> cheers,
> -roger
>


--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
