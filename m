From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH] arm: omap3: beagle: Ensure msecure is mux'd to be able
 to set the RTC
Date: Tue, 07 Jun 2011 13:15:36 +0200
Message-ID: <4DEE0858.2020308@ahsoftware.de>
References: <4D9AEB76.2060509@ahsoftware.de> <1302010808-3065-1-git-send-email-holler@ahsoftware.de> <20110531102903.GU11352@atomide.com> <4DEDDAF6.2070505@ahsoftware.de> <4DEDF451.1080604@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:42077 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab1FGLP6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 07:15:58 -0400
Received: from eiche.ahsoftware (p57B2165D.dip0.t-ipconnect.de [87.178.22.93])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id 31B974345A9
	for <linux-omap@vger.kernel.org>; Tue,  7 Jun 2011 13:15:56 +0200 (CEST)
In-Reply-To: <4DEDF451.1080604@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Am 07.06.2011 11:50, schrieb Igor Grinberg:
> On 06/07/11 11:01, Alexander Holler wrote:
>
>> Am 31.05.2011 12:29, schrieb Tony Lindgren:
>>> * Alexander Holler<holler@ahsoftware.de>   [110405 06:38]:
>>>> Without msecure beeing high it isn't possible to set (or start)
>>>> the RTC.
>>>>
>>>> Tested with a BeagleBoard C4.
>>>
>>> Adding this into fixes.
>>>
>>> Tony
>>>
>>>> Signed-off-by: Alexander Holler<holler@ahsoftware.de>
>>>> ---
>>>>    arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
>>>>    1 files changed, 3 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
>>>> index 46d814a..ebe3a7e 100644
>>>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>>>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>>>> @@ -628,6 +628,9 @@ static void __init omap3_beagle_init(void)
>>>>        usb_ehci_init(&ehci_pdata);
>>>>        omap3beagle_flash_init();
>>>>
>>>> +    /* Ensure msecure is mux'd to be able to set the RTC. */
>>>> +    omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPUT_HIGH);
>>>> +
>>>>        /* Ensure SDRC pins are mux'd for self-refresh */
>>>>        omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>>>>        omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>>>> --
>>>> 1.7.3.4
>>>>
>>
>> I've later switched to the following patch which muxes msecure as GPIO (the drm-mode isn't explained in the TRM) and also exports the GPIO, so root could easily switch it to prevent modifications on the RTC.
>>
>> (Warning, either my clipboard or the version of Thunderbird I'm currently using replaces the tabs with spaces in the pasted patch and I'm currently too lazy to search a workaround).
>>
>> ---
>>   arch/arm/mach-omap2/board-omap3beagle.c |    6 ++++++
>>   1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
>> index 33007fd..24b4417 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -673,6 +673,12 @@ static void __init omap3_beagle_init(void)
>>          usbhs_init(&usbhs_bdata);
>>          omap3beagle_flash_init();
>>
>> +       /* Ensure msecure is high to be able to set the RTC. */
>> +       omap_mux_init_signal("gpio_22", OMAP_PIN_OFF_OUTPUT_HIGH);
>> +       gpio_request(22, "msecure");
>> +       gpio_direction_output(22, true);
>
> Can this be gpio_request_one() instead, please?
> Also, it will be nice to make a define for the magic 22.

You need the "gpio_22" in the mux_init, so using a define would imho 
introduce a potential source for an error, at least when the define 
would not be anywhere near the "gpio_22" and someone would forget change 
the string too, when he changes the define. So I don't think a define 
adds much value there.

>
>> +       gpio_export(22, false);
>> +
>>          /* Ensure SDRC pins are mux'd for self-refresh */
>>          omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>>          omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>

Regards,

Alexander
