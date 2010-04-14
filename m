From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v5] board-omap3-beagle: add DSS2 support
Date: Wed, 14 Apr 2010 15:59:19 +0200
Message-ID: <614635D1-7168-4934-A2EA-6E4ABB687A38@dominion.thruhere.net>
References: <1271252041-24658-1-git-send-email-koen@dominion.thruhere.net> <19F8576C6E063C45BE387C64729E7394044E136BB7@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:46417 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab0DNN7Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 09:59:24 -0400
Received: by wwb34 with SMTP id 34so102223wwb.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Apr 2010 06:59:23 -0700 (PDT)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E136BB7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


Op 14 apr 2010, om 15:56 heeft Hiremath, Vaibhav het volgende geschreven:
>> 
>> +static struct regulator_consumer_supply beagle_vdvi_supply =
>> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss")l
>> +
> [Hiremath, Vaibhav] Koen, sorry but I think in hurry you miss-types it to 'l' instead of semi-colon.
> 
> Let's get another cup of coffee.

I'll wait till tomorrow and re-test it on the device :)


> 
> Thanks,
> Vaibhav
> 
> 
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
>> @@ -181,16 +244,6 @@ static struct twl4030_gpio_platform_data
>> beagle_gpio_data = {
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
>> /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220
>> mA) */
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
>> @@ -456,8 +503,9 @@ static void __init omap3_beagle_init(void)
>> 	/* Ensure SDRC pins are mux'd for self-refresh */
>> 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>> 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>> -}
>> 
>> +	beagle_display_init();
>> +}
>> static void __init omap3_beagle_map_io(void)
>> {
>> 	omap2_set_globals_343x();
>> --
>> 1.6.6.1
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

