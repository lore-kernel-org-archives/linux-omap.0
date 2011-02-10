From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 4/5 v5] OMAP2+: musb: HWMOD adaptation for musb.
Date: Thu, 10 Feb 2011 08:42:29 -0800
Message-ID: <87hbcbx2mi.fsf@ti.com>
References: <1291991739-21705-1-git-send-email-hemahk@ti.com>
	<1291991739-21705-5-git-send-email-hemahk@ti.com>
	<1297209792.10580.28.camel@vence>
	<ccae5231e5a765988953567b6911e48f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39414 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820Ab1BJQmd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 11:42:33 -0500
In-Reply-To: <ccae5231e5a765988953567b6911e48f@mail.gmail.com> (Hema
	Kalliguddi's message of "Thu, 10 Feb 2011 19:04:16 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema Kalliguddi <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hema Kalliguddi <hemahk@ti.com> writes:

>  Kevin,
>
>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Wednesday, February 09, 2011 5:33 AM
>>To: Hema HK
>>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org;
>>Felipe Balbi; Tony Lindgren; Cousson, Benoit; Paul Walmsley
>>Subject: Re: [PATCH 4/5 v5] OMAP2+: musb: HWMOD adaptation for musb.
>>
>>On Fri, 2010-12-10 at 20:05 +0530, Hema HK wrote:
>>> Using omap_device_build API instead of platform_device_register for
>>> OMAP2430,OMAP34xx and OMAP4430 musb device registration.
>>> The device specific resources defined in centralized
>>> database will be used.
>>>
>>> Signed-off-by: Hema HK <hemahk@ti.com>
>>> Cc: Felipe Balbi <balbi@ti.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>> Cc: Cousson, Benoit <b-cousson@ti.com>
>>> Cc: Paul Walmsley <paul@pwsan.com>
>>> ---
>>>  arch/arm/mach-omap2/usb-musb.c |   76
>>+++++++++++++++++++++++++++++------------
>>>  1 file changed, 55 insertions(+), 21 deletions(-)
>>>
>>> Index: usb/arch/arm/mach-omap2/usb-musb.c
>>> ===================================================================
>>> --- usb.orig/arch/arm/mach-omap2/usb-musb.c
>>> +++ usb/arch/arm/mach-omap2/usb-musb.c
>>> @@ -31,9 +31,12 @@
>>>  #include <mach/am35xx.h>
>>>  #include <plat/usb.h>
>>>  #include "control.h"
>>> +#include <plat/omap_device.h>
>>>
>>>  #if defined(CONFIG_USB_MUSB_OMAP2PLUS) || defined
>>(CONFIG_USB_MUSB_AM35X)
>>>
>>> +static const char name[] = "musb-omap2430";
>>> +
>>>  static void am35x_musb_reset(void)
>>>  {
>>>  	u32	regval;
>>> @@ -170,7 +173,7 @@ static struct musb_hdrc_platform_data mu
>>>  static u64 musb_dmamask = DMA_BIT_MASK(32);
>>>
>>>  static struct platform_device musb_device = {
>>> -	.name		= "musb-omap2430",
>>> +	.name		= "musb-am35x",
>>
>>Should be in AM35x specific code.
>>
>>>  	.id		= -1,
>>>  	.dev = {
>>>  		.dma_mask		= &musb_dmamask,
>>> @@ -181,26 +184,23 @@ static struct platform_device musb_devic
>>>  	.resource	= musb_resources,
>>>  };
>>>
>>> +static struct omap_device_pm_latency omap_musb_latency[] = {
>>> +	{
>>> +		.deactivate_func = omap_device_idle_hwmods,
>>> +		.activate_func   = omap_device_enable_hwmods,
>>> +		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
>>> +	},
>>> +};
>>> +
>>>  void __init usb_musb_init(struct omap_musb_board_data *board_data)
>>>  {
>>> -	if (cpu_is_omap243x()) {
>>> -		musb_resources[0].start = OMAP243X_HS_BASE;
>>> -	} else if (cpu_is_omap3517() || cpu_is_omap3505()) {
>>> -		musb_device.name = "musb-am35x";
>>> -		musb_resources[0].start = AM35XX_IPSS_USBOTGSS_BASE;
>>> -		musb_resources[1].start = INT_35XX_USBOTG_IRQ;
>>> -		board_data->set_phy_power = am35x_musb_phy_power;
>>> -		board_data->clear_irq = am35x_musb_clear_irq;
>>> -		board_data->set_mode = am35x_musb_set_mode;
>>> -		board_data->reset = am35x_musb_reset;
>>> -	} else if (cpu_is_omap34xx()) {
>>> -		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
>>> -	} else if (cpu_is_omap44xx()) {
>>> -		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
>>> -		musb_resources[1].start = OMAP44XX_IRQ_HS_USB_MC_N;
>>> -		musb_resources[2].start = OMAP44XX_IRQ_HS_USB_DMA_N;
>>> -	}
>>> -	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
>>> +	struct omap_hwmod *oh;
>>> +	struct omap_device *od;
>>> +	struct platform_device *pdev;
>>> +	struct device	*dev;
>>> +	int bus_id = -1;
>>> +	const char *oh_name = "usb_otg_hs";
>>> +	struct musb_hdrc_platform_data *pdata;
>>>
>>>  	/*
>>>  	 * REVISIT: This line can be removed once all the
>>platforms using
>>> @@ -212,8 +212,42 @@ void __init usb_musb_init(struct omap_mu
>>>  	musb_plat.mode = board_data->mode;
>>>  	musb_plat.extvbus = board_data->extvbus;
>>>
>>> -	if (platform_device_register(&musb_device) < 0)
>>> -		printk(KERN_ERR "Unable to register HS-USB
>>(MUSB) device\n");
>>> +	if (cpu_is_omap3517() || cpu_is_omap3505()) {
>>> +		musb_resources[0].start = AM35XX_IPSS_USBOTGSS_BASE;
>>> +		musb_resources[1].start = INT_35XX_USBOTG_IRQ;
>>> +		board_data->set_phy_power = am35x_musb_phy_power;
>>> +		board_data->clear_irq = am35x_musb_clear_irq;
>>> +		board_data->set_mode = am35x_musb_set_mode;
>>> +		board_data->reset = am35x_musb_reset;
>>> +		musb_resources[0].end = musb_resources[0].start
>>+ SZ_4K - 1;
>>> +
>>> +		if (platform_device_register(&musb_device) < 0)
>>> +			printk(KERN_ERR "Unable to register HS-USB \
>>> +					(MUSB) device\n");
>>
>>The need for  'if cpu_is_*' here should be a red flag indicating a
>>problem with this code.
>>
>>The goal of hwmod was to be able to get rid of this kind of cpu_is_*
>>cruft.  At least the base and IRQ stuff should not be needed
>>here.  What
>>is needed is hwmod data for AM35x where it is different from the
>>"normal" OMAP3.
>
> This file shared between the OMAP3 and AM35x.
> Since there is no HWMOD adaptation done for AM35x we have to live this
> till
> that is done.
>
>>
>>I'm not exactly sure what the rest of these pdata function pointers are
>>doing here since there seems to be an AM35x specific version of the
>>driver in drivers/usb/musb, but that part isn't for me to decide.
>>
> There was discussion with Felipe and Benoit on this
> and decided to go with cpu check till the HWMOD adaption is done for
> AM35x.

If we allow this now, then nobody will create a hwmod for AM35x.

Felipe will make the final decision, but my recommendation is to not
merge this as is.

Note that this series does not need to add omap_hwmod data entries for
all AM35x IPs that are different.  Just add one for the OTG block
Adding a hwmod entry for the OTG block on AM35x should be trivial, and
much preferred to this workaround.

Kevin
