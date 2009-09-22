From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP3: Beagleboard: Fix EHCI initialization
Date: Mon, 21 Sep 2009 18:35:51 -0700
Message-ID: <20090922013550.GL27699@atomide.com>
References: <5e088bd90909011455y48ce86c4t532ed5a66bac01fe@mail.gmail.com> <979D9760-ABA4-48A1-87DE-5E335E7C24F9@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55404 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbZIVBfu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 21:35:50 -0400
Content-Disposition: inline
In-Reply-To: <979D9760-ABA4-48A1-87DE-5E335E7C24F9@mindspring.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Witcher <ewitcher@mindspring.com>
Cc: Steve Sakoman <sakoman@gmail.com>, linux-omap@vger.kernel.org

* Eric Witcher <ewitcher@mindspring.com> [090907 18:17]:
>
> On Sep 1, 2009, at 5:55 PM, Steve Sakoman wrote:
>
>> Enable USB power, use correct gpio for usb_ehci_init
>>
>> Signed-off-by: Steve Sakoman <steve@sakoman.com>
>
> Tested-by: Eric Witcher <ewitcher@mindspring.com>
> This patch worked at commit
> 3dff8750255bf5a1e9a69931b1d8739a65a933d0
> of linux-omap-2.6.git master

This one should also be updated to pass the configuration
in the platform data unless already done with what's in
the linux-omap ehci and master branches. Can you please
check?

> I also needed
>
> [PATCH 4/8] ehci: fix phy_reset init in ehci probe
> [PATCH] omapfb: Reorder Register_framebuffer call
>
> to get a clean boot.

I've added this into omap-fixes queue and merged it
also into the linux-omap master branch.

Regards,

Tony


> Build configuration was omap3_beagle_defconfig.
>
>
>> ---
>> arch/arm/mach-omap2/board-omap3beagle.c |    5 +++--
>> 1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
>> b/arch/arm/mach-omap2/board-omap3beagle.c
>> index 07aee90..65934ea 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -161,7 +161,7 @@ static int beagle_twl_gpio_setup(struct device  
>> *dev,
>>
>> 	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low)  
>> */
>> 	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
>> -	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
>> +	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
>>
>> 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
>> 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
>> @@ -412,7 +412,8 @@ static void __init omap3_beagle_init(void)
>> 	gpio_direction_output(170, true);
>>
>> 	usb_musb_init();
>> -	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
>> +	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true,
>> +			-EINVAL, 147);
>> 	omap3beagle_flash_init();
>>
>> 	/* Ensure SDRC pins are mux'd for self-refresh */
>> -- 
>> 1.6.0.4
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
