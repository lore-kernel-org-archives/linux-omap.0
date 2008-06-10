From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap3beagle: add a platform device to hook up the
	GPIO leds to the leds-gpio driver
Date: Tue, 10 Jun 2008 14:31:06 -0700
Message-ID: <20080610213106.GO23796@atomide.com>
References: <1212195566-22695-1-git-send-email-k.kooi@student.utwente.nl> <96F02D3C-315B-4D51-812F-8E8B1C592B1A@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:64123 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758387AbYFJVbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 17:31:07 -0400
Content-Disposition: inline
In-Reply-To: <96F02D3C-315B-4D51-812F-8E8B1C592B1A@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Koen Kooi <k.kooi@student.utwente.nl> [080610 14:26]:
> 
> Op 31 mei 2008, om 02:59 heeft Koen Kooi het volgende geschreven:
> 
> > From: Koen Kooi <koen@openembedded.org>
> >
> > omap3beagle: add a platform device to hook up the GPIO leds to the  
> > leds-gpio driver
> > * on revision A5 and earlier board the two leds can't be controlled  
> > seperately, should be fixed in rev. B and C boards.
> >
> > Changes since v1: indented structs with tabs
> >
> > Signed-off-by: Koen Kooi <koen@openembedded.org>
> 
> 
> Any objections against applying this patch?

Nope, and blinking leds are always considered the highhest priority
patches ;) Pushing today.

Tony


> 
> 
> 
> 
> >
> > ---
> > arch/arm/mach-omap2/board-omap3beagle.c |   28 ++++++++++++++++++++++ 
> > ++++++
> > 1 files changed, 28 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach- 
> > omap2/board-omap3beagle.c
> > index c992cc7..83891fc 100644
> > --- a/arch/arm/mach-omap2/board-omap3beagle.c
> > +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> > @@ -19,6 +19,7 @@
> > #include <linux/err.h>
> > #include <linux/clk.h>
> > #include <linux/io.h>
> > +#include <linux/leds.h>
> >
> > #include <asm/hardware.h>
> > #include <asm/mach-types.h>
> > @@ -72,6 +73,32 @@ static struct omap_lcd_config  
> > omap3_beagle_lcd_config __initdata = {
> > 	.ctrl_name	= "internal",
> > };
> >
> > +struct gpio_led gpio_leds[] = {
> > +	{
> > +		.name = "beagleboard::led0",
> > +		.default_trigger = "none",
> > +		.gpio = 149,
> > +	},
> > +	{
> > +		.name = "beagleboard::led1",
> > +		.default_trigger = "none",
> > +		.gpio = 150,
> > +	},
> > +};
> > +
> > +static struct gpio_led_platform_data gpio_led_info = {
> > +	.leds = gpio_leds,
> > +	.num_leds = ARRAY_SIZE(gpio_leds),
> > +};
> > +
> > +static struct platform_device leds_gpio = {
> > +	.name = "leds-gpio",
> > +	.id   = -1,
> > +	.dev  = {
> > +		.platform_data = &gpio_led_info,
> > +	},
> > +};
> > +
> > static struct omap_board_config_kernel omap3_beagle_config[]  
> > __initdata = {
> > 	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
> > 	{ OMAP_TAG_MMC,		&omap3beagle_mmc_config },
> > @@ -83,6 +110,7 @@ static struct platform_device  
> > *omap3_beagle_devices[] __initdata = {
> > #ifdef CONFIG_RTC_DRV_TWL4030
> > 	&omap3_beagle_twl4030rtc_device,
> > #endif
> > +	&leds_gpio,
> > };
> >
> > static void __init omap3_beagle_init(void)
> > -- 
> > 1.5.4.3
> >
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
