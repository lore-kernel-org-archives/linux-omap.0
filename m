From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3+: TWL: add support for mapping platform
 data via pdata-quirks
Date: Fri, 10 Oct 2014 20:54:29 +0300
Message-ID: <54381D55.80605@ti.com>
References: <1412948442-19896-1-git-send-email-t-kristo@ti.com> <1412948442-19896-2-git-send-email-t-kristo@ti.com> <20141010170017.GH10014@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56441 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbaJJRyi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2014 13:54:38 -0400
In-Reply-To: <20141010170017.GH10014@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org

On 10/10/2014 08:00 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [141010 06:41]:
>> Device tree based boot does not currently support DVFS voltage scaling,
>> as the VC/VP mapping is broken. This patch adds support to provide
>> platform data in the device tree boot case also, basically to pass the
>> function pointers to the vc/vp core for voltage changes.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   arch/arm/mach-omap2/pdata-quirks.c |    8 ++--
>>   arch/arm/mach-omap2/twl-common.c   |   88 ++++++++++++++++++++++++++++++++----
>>   arch/arm/mach-omap2/twl-common.h   |    2 +
>>   3 files changed, 84 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
>> index 90c88d4..03e4a86 100644
>> --- a/arch/arm/mach-omap2/pdata-quirks.c
>> +++ b/arch/arm/mach-omap2/pdata-quirks.c
>> @@ -311,10 +311,10 @@ void omap_auxdata_legacy_init(struct device *dev)
>>   	if (dev->platform_data)
>>   		return;
>>
>> -	if (strcmp("twl4030-gpio", dev_name(dev)))
>> -		return;
>> -
>> -	dev->platform_data = &twl_gpio_auxdata;
>> +	if (!strcmp("twl4030-gpio", dev_name(dev)))
>> +		dev->platform_data = &twl_gpio_auxdata;
>> +	else
>> +		dev->platform_data = omap_twl_match_regulator(dev);
>>   }
>
> I think now you're passing also dev->platform_data for all the
> other devices as this gets called for any devices added.

This is true, however omap_twl_match_regulator will return NULL if no 
match against a DT compatible string is found.

>
> So you probale should use something like this instead:
>
> 	if (!strcmp("twl4030-gpio", dev_name(dev)))
> 		dev->platform_data = &twl_gpio_auxdata;
>
> 	if (!strcmp("twl4030-whatever-you-need", dev_name(dev)))
> 		dev->platform_data = &twl_gpio_auxdata;

This is what I did first, however the dev_name strings for the 
regulators are pretty complex: i2c@xyz:twl@48:twl4030-vdd1-regulator or 
something like that, and I need to do string comparisons against 5 
different devices. The current approach does a DT compatible match, 
which at least looks neater if it isn't more efficient also.

-Tero
