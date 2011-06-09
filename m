From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] arm: omap3: beagle: Ensure msecure is mux'd to be able
 to set the RTC
Date: Thu, 09 Jun 2011 10:40:20 +0300
Message-ID: <4DF078E4.8040903@compulab.co.il>
References: <4D9AEB76.2060509@ahsoftware.de> <1302010808-3065-1-git-send-email-holler@ahsoftware.de> <20110531102903.GU11352@atomide.com> <4DEDDAF6.2070505@ahsoftware.de> <4DEDF451.1080604@compulab.co.il> <4DEE0858.2020308@ahsoftware.de> <4DEFF035.4070004@compulab.co.il> <4DF0120E.5030204@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:60944
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752827Ab1FIHk1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 03:40:27 -0400
In-Reply-To: <4DF0120E.5030204@ahsoftware.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 06/09/11 03:21, Alexander Holler wrote:

> On 08.06.2011 23:57, Igor Grinberg wrote:
>> On 06/07/11 14:15, Alexander Holler wrote:
>>> Am 07.06.2011 11:50, schrieb Igor Grinberg:
>>>> On 06/07/11 11:01, Alexander Holler wrote:
>>>>
>>>>> Am 31.05.2011 12:29, schrieb Tony Lindgren:
>>>>>> * Alexander Holler<holler@ahsoftware.de>   [110405 06:38]:
>>>>>>> Without msecure beeing high it isn't possible to set (or start)
>>>>>>> the RTC.
>>>>>>>
>>>>>>> Tested with a BeagleBoard C4.
>>>>>> Adding this into fixes.
>>>>>>
>>>>>> Tony
>>>>>>
>>>>>>> Signed-off-by: Alexander Holler<holler@ahsoftware.de>
>>>>>>> ---
>>>>>>>    arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
>>>>>>>    1 files changed, 3 insertions(+), 0 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
>>>>>>> index 46d814a..ebe3a7e 100644
>>>>>>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>>>>>>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>>>>>>> @@ -628,6 +628,9 @@ static void __init omap3_beagle_init(void)
>>>>>>>        usb_ehci_init(&ehci_pdata);
>>>>>>>        omap3beagle_flash_init();
>>>>>>>
>>>>>>> +    /* Ensure msecure is mux'd to be able to set the RTC. */
>>>>>>> +    omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPUT_HIGH);
>>>>>>> +
>>>>>>>        /* Ensure SDRC pins are mux'd for self-refresh */
>>>>>>>        omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>>>>>>>        omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>>>>>>> -- 
>>>>>>> 1.7.3.4
>>>>>>>
>>>>> I've later switched to the following patch which muxes msecure as GPIO (the drm-mode isn't explained in the TRM) and also exports the GPIO, so root could easily switch it to prevent modifications on the RTC.
>>>>>
>>>>> (Warning, either my clipboard or the version of Thunderbird I'm currently using replaces the tabs with spaces in the pasted patch and I'm currently too lazy to search a workaround).
>>>>>
>>>>> ---
>>>>>   arch/arm/mach-omap2/board-omap3beagle.c |    6 ++++++
>>>>>   1 files changed, 6 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
>>>>> index 33007fd..24b4417 100644
>>>>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>>>>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>>>>> @@ -673,6 +673,12 @@ static void __init omap3_beagle_init(void)
>>>>>          usbhs_init(&usbhs_bdata);
>>>>>          omap3beagle_flash_init();
>>>>>
>>>>> +       /* Ensure msecure is high to be able to set the RTC. */
>>>>> +       omap_mux_init_signal("gpio_22", OMAP_PIN_OFF_OUTPUT_HIGH);
>>>>> +       gpio_request(22, "msecure");
>>>>> +       gpio_direction_output(22, true);
>>>> Can this be gpio_request_one() instead, please?
>>>> Also, it will be nice to make a define for the magic 22.
>>> You need the "gpio_22" in the mux_init, so using a define would imho introduce a potential source for an error, at least when the define would not be anywhere near the "gpio_22" and someone would forget change the string too, when he changes the define. So I don't think a define adds much value there.
>> Why not leave "sys_drm_msecure" for mux_init, or does it make troubles on XM?
> There is nothing wrong with the small patch which uses sys_drm_msecure.
> It's short and does everything which is needed to use the RTC. I've
> posted the solution with the use of the GPIO-mode only as an alternative
> because the drm-mode isn't explained in the TRM (I assume one has to
> sign a NDA to get more informations on that).
> So it is not obvious what my first patch does. Using sys_drm_msecure
> works because it seems to be always off, at least on the BeagleBoards.
> The additional functionality in my second patch to turn off possible
> modifications on the RTC through switching the GPIO is most likely just
> an educational feature, I don't think someone will ever use that.
> I don't have any preferences which solution will end in the kernel, I
> just wanted to offer the second one too.

I see. Is the new patch version somehow provides better functionality?
You configure the gpio for output, this means that the pin is actually driven
and not just relies on internal pullup (which can vary from chip to chip).
I know nothing about that msecure stuff, but may be it is better to drive the pin,
then just configuring the mux (enabling internal pullup)...

>> What about gpio_request_one()? To conform with the rest of the file and mach-omap2/*.
> Below is an updated version. The gpio_export() might be removed too.

The original patch version is already in Linus' tree, so this one will not apply as it is.
If you decide it is better then the original one, then it must be rebased.
Otherwise, looks OK.

> Regards,
>
> Alexander
>
>
> From: Alexander Holler <holler@ahsoftware.de>
> Date: Thu, 19 May 2011 11:42:05 +0200
> Subject: [PATCH v3] arm: omap3: beagle: Ensure msecure is mux'd and high
> to be able to set the RTC
>
> Without msecure beeing high it isn't possible to set (or start)
> the RTC.
>
> Tested with a BeagleBoard C4.
>
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
> b/arch/arm/mach-omap2/board-omap3beagle.c
> index 33007fd..4c9e26e 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -673,6 +673,11 @@ static void __init omap3_beagle_init(void)
>  	usbhs_init(&usbhs_bdata);
>  	omap3beagle_flash_init();
>
> +	/* Ensure msecure is high to be able to set the RTC. */
> +	omap_mux_init_signal("gpio_22", OMAP_PIN_OFF_OUTPUT_HIGH);
> +	gpio_request_one(22, GPIOF_OUT_INIT_HIGH, "msecure");
> +	gpio_export(22, false);
> +
>  	/* Ensure SDRC pins are mux'd for self-refresh */
>  	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>  	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);

-- 
Regards,
Igor.

