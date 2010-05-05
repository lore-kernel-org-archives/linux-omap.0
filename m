From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v9] board-omap3-beagle: add DSS2 support
Date: Wed, 5 May 2010 08:46:59 +0200
Message-ID: <074F5B48-DE92-46A2-B5DE-B6ECA362D524@dominion.thruhere.net>
References: <1271924622-21043-1-git-send-email-koen@dominion.thruhere.net> <1272896110.1997.0.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:57214 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756636Ab0EEGrM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 02:47:12 -0400
Received: by ewy22 with SMTP id 22so1385378ewy.37
        for <linux-omap@vger.kernel.org>; Tue, 04 May 2010 23:47:09 -0700 (PDT)
In-Reply-To: <1272896110.1997.0.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

Tony,

Would it be possible to get this applied in the next merge window?

regards,

Koen

Op 3 mei 2010, om 16:15 heeft Tomi Valkeinen het volgende geschreven:

> On Thu, 2010-04-22 at 10:23 +0200, ext Koen Kooi wrote:
>> This patch adds DSS2 support to the beagleboard boardfile. DVI and TV-out are supported.
>> 
>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> 
> 
>> ---
>> Changes since v1:
>>    * removed beagle_panel_enable_tv() and beagle_panel_disable_tv()
>> Changes since v2:
>>    * changed to REGULATOR_SUPPLY(_name, _dev_name) for dss regulators
>> Changes since v3:
>>    * really remove beagle_panel_enable_tv() and beagle_panel_disable_tv()
>>    * moved comments to this section
>> Changes since v4:
>>    * remove trailing whitespace
>> Changes since v5:
>>    * fix semicolon typo
>> Changes since v6:
>>    * use gpio_is_valid(dssdev->reset_gpio)
>> Changes since v8:
>>    * fix missing whitespace before __init omap3_beagle_map_io(){}
>> 
>> arch/arm/mach-omap2/board-omap3beagle.c |  101 +++++++++++++++++++++++--------
>> 1 files changed, 75 insertions(+), 26 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
>> index 962d377..69b154c 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -39,6 +39,7 @@
>> 
>> #include <plat/board.h>
>> #include <plat/common.h>
>> +#include <plat/display.h>
>> #include <plat/gpmc.h>
>> #include <plat/nand.h>
>> #include <plat/usb.h>
>> @@ -106,6 +107,77 @@ static struct platform_device omap3beagle_nand_device = {
>> 	.resource	= &omap3beagle_nand_resource,
>> };
>> 
>> +/* DSS */
>> +
>> +static int beagle_enable_dvi(struct omap_dss_device *dssdev)
>> +{
>> +	if (gpio_is_valid(dssdev->reset_gpio))
>> +		gpio_set_value(dssdev->reset_gpio, 1);
>> +
>> +	return 0;
>> +}
>> +
>> +static void beagle_disable_dvi(struct omap_dss_device *dssdev)
>> +{
>> +	if (gpio_is_valid(dssdev->reset_gpio))
>> +		gpio_set_value(dssdev->reset_gpio, 0);
>> +}
>> +
>> +static struct omap_dss_device beagle_dvi_device = {
>> +	.type = OMAP_DISPLAY_TYPE_DPI,
>> +	.name = "dvi",
>> +	.driver_name = "generic_panel",
>> +	.phy.dpi.data_lines = 24,
>> +	.reset_gpio = 170,
>> +	.platform_enable = beagle_enable_dvi,
>> +	.platform_disable = beagle_disable_dvi,
>> +};
>> +
>> +static struct omap_dss_device beagle_tv_device = {
>> +	.name = "tv",
>> +	.driver_name = "venc",
>> +	.type = OMAP_DISPLAY_TYPE_VENC,
>> +	.phy.venc.type = OMAP_DSS_VENC_TYPE_SVIDEO,
>> +};
>> +
>> +static struct omap_dss_device *beagle_dss_devices[] = {
>> +	&beagle_dvi_device,
>> +	&beagle_tv_device,
>> +};
>> +
>> +static struct omap_dss_board_info beagle_dss_data = {
>> +	.num_devices = ARRAY_SIZE(beagle_dss_devices),
>> +	.devices = beagle_dss_devices,
>> +	.default_device = &beagle_dvi_device,
>> +};
>> +
>> +static struct platform_device beagle_dss_device = {
>> +	.name          = "omapdss",
>> +	.id            = -1,
>> +	.dev            = {
>> +		.platform_data = &beagle_dss_data,
>> +	},
>> +};
>> +
>> +static struct regulator_consumer_supply beagle_vdac_supply =
>> +	REGULATOR_SUPPLY("vdda_dac", "omapdss");
>> +
>> +static struct regulator_consumer_supply beagle_vdvi_supply =
>> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
>> +
>> +static void __init beagle_display_init(void)
>> +{
>> +	int r;
>> +
>> +	r = gpio_request(beagle_dvi_device.reset_gpio, "DVI reset");
>> +	if (r < 0) {
>> +		printk(KERN_ERR "Unable to get DVI reset GPIO\n");
>> +		return;
>> +	}
>> +
>> +	gpio_direction_output(beagle_dvi_device.reset_gpio, 0);
>> +}
>> +
>> #include "sdram-micron-mt46h32m32lf-6.h"
>> 
>> static struct omap2_hsmmc_info mmc[] = {
>> @@ -117,15 +189,6 @@ static struct omap2_hsmmc_info mmc[] = {
>> 	{}	/* Terminator */
>> };
>> 
>> -static struct platform_device omap3_beagle_lcd_device = {
>> -	.name		= "omap3beagle_lcd",
>> -	.id		= -1,
>> -};
>> -
>> -static struct omap_lcd_config omap3_beagle_lcd_config __initdata = {
>> -	.ctrl_name	= "internal",
>> -};
>> -
>> static struct regulator_consumer_supply beagle_vmmc1_supply = {
>> 	.supply			= "vmmc",
>> };
>> @@ -181,16 +244,6 @@ static struct twl4030_gpio_platform_data beagle_gpio_data = {
>> 	.setup		= beagle_twl_gpio_setup,
>> };
>> 
>> -static struct regulator_consumer_supply beagle_vdac_supply = {
>> -	.supply		= "vdac",
>> -	.dev		= &omap3_beagle_lcd_device.dev,
>> -};
>> -
>> -static struct regulator_consumer_supply beagle_vdvi_supply = {
>> -	.supply		= "vdvi",
>> -	.dev		= &omap3_beagle_lcd_device.dev,
>> -};
>> -
>> /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
>> static struct regulator_init_data beagle_vmmc1 = {
>> 	.constraints = {
>> @@ -349,14 +402,8 @@ static struct platform_device keys_gpio = {
>> 	},
>> };
>> 
>> -static struct omap_board_config_kernel omap3_beagle_config[] __initdata = {
>> -	{ OMAP_TAG_LCD,		&omap3_beagle_lcd_config },
>> -};
>> -
>> static void __init omap3_beagle_init_irq(void)
>> {
>> -	omap_board_config = omap3_beagle_config;
>> -	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
>> 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
>> 			     mt46h32m32lf6_sdrc_params);
>> 	omap_init_irq();
>> @@ -367,9 +414,9 @@ static void __init omap3_beagle_init_irq(void)
>> }
>> 
>> static struct platform_device *omap3_beagle_devices[] __initdata = {
>> -	&omap3_beagle_lcd_device,
>> 	&leds_gpio,
>> 	&keys_gpio,
>> +	&beagle_dss_device,
>> };
>> 
>> static void __init omap3beagle_flash_init(void)
>> @@ -456,6 +503,8 @@ static void __init omap3_beagle_init(void)
>> 	/* Ensure SDRC pins are mux'd for self-refresh */
>> 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>> 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>> +
>> +	beagle_display_init();
>> }
>> 
>> static void __init omap3_beagle_map_io(void)
> 
> 

