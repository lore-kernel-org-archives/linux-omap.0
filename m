From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 1/3] omap3: beaglexm: fix EHCI power up GPIO dir
Date: Mon, 10 Jan 2011 08:23:09 -0600
Message-ID: <4D2B164D.3060907@ti.com>
References: <[PATCH v3 0/3] OMAP3: beaglexm: GPIO fixes> <1294441282-17986-2-git-send-email-nm@ti.com> <alpine.DEB.1.10.1101101442460.18906@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:54396 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752218Ab1AJOXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Jan 2011 09:23:13 -0500
Received: by mail-yw0-f52.google.com with SMTP id 9so7358180ywf.39
        for <linux-omap@vger.kernel.org>; Mon, 10 Jan 2011 06:23:13 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1101101442460.18906@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Tony <tony@atomide.com>, Koen Kooi <koen@beagleboard.org>

Aaro Koskinen had written, on 01/10/2011 06:44 AM, the following:
> Hi,
> 
> On Fri, 7 Jan 2011, Nishanth Menon wrote:
>> From: Koen Kooi <koen@beagleboard.org>
>>
>> EHCI enable power pin is inverted (active high) in comparison
>> to vanilla beagle which is active low. Handle this case conditionally.
>>
>> Without this fix, Beagle XM 4 port EHCI will not function and no
>> networking will be available
>>
>> [nm@ti.com: split up, added descriptive changelogs]
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Koen Kooi <koen@beagleboard.org>
>> ---
>> arch/arm/mach-omap2/board-omap3beagle.c |    9 ++++++++-
>> 1 files changed, 8 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c 
>> b/arch/arm/mach-omap2/board-omap3beagle.c
>> index 6c12760..1b5aa7a 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -297,9 +297,16 @@ static int beagle_twl_gpio_setup(struct device *dev,
>>     gpio_request(gpio + 1, "EHCI_nOC");
>>     gpio_direction_input(gpio + 1);
>>
>> -    /* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active 
>> low) */
>> +    /*
>> +     * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
>> +     * high / others active low)
>> +     */
>>     gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
>>     gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
> 
> This call should be deleted.

yikes. yep. thanks for catching.


-- 
Regards,
Nishanth Menon
