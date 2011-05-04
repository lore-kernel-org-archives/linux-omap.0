From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Wed, 4 May 2011 17:41:51 +0530
Message-ID: <4DC14287.1030201@ti.com>
References: <1304494704-7285-1-git-send-email-archit@ti.com>	 <1304494704-7285-2-git-send-email-archit@ti.com>	 <20110504094050.GI27860@atomide.com>  <1304506408.2099.21.camel@deskari> <1304508095.2099.36.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36457 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754016Ab1EDMG5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 May 2011 08:06:57 -0400
In-Reply-To: <1304508095.2099.36.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 04 May 2011 04:51 PM, Valkeinen, Tomi wrote:
> On Wed, 2011-05-04 at 13:53 +0300, Tomi Valkeinen wrote:
>> On Wed, 2011-05-04 at 12:40 +0300, Tony Lindgren wrote:
>>> * Archit Taneja<archit@ti.com>  [110504 10:30]:
>>>> --- a/arch/arm/mach-omap2/board-3430sdp.c
>>>> +++ b/arch/arm/mach-omap2/board-3430sdp.c
>>>> @@ -401,7 +401,7 @@ static struct regulator_consumer_supply sdp3430_vdda_dac_supplies[] = {
>>>>   /* VPLL2 for digital video outputs */
>>>>   static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
>>>>   	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
>>>> -	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
>>>> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
>>>>   };
>>>>
>>>>   static struct regulator_consumer_supply sdp3430_vmmc1_supplies[] = {
>>>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
>>>> index 570e83f..eafadb4 100644
>>>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>>>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>>>> @@ -375,7 +375,7 @@ static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
>>>>   };
>>>>   static struct regulator_consumer_supply sdp4430_vcxio_supply[] = {
>>>>   	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
>>>> -	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
>>>> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
>>>>   };
>>> ...
>>>
>>> Looks like we should first combine all this cut and paste data
>>> for each board file into some common init function to cut
>>> down the "crazy churn".
>>
>> I was actually thinking about this earlier today.
>>
>> All the boards I have seen use vdds_dsi the same way (depending on the
>> omap version, though). For OMAP3 it comes from VPPL2 and for OMAP4 it's
>> VCXIO. Optimally a common piece of code would just set up the regulator
>> properly.
>>
>> But I think in the end the config has to come from the board data, as I
>> don't see that the above config would be the only possibility. The
>> vdds_dsi could be supplied from anywhere (with suitable voltage, of
>> course), as far as I understand.
>>
>> What we could do is:
>>
>> 1. The board file tells the common display code which regulator is used
>> for vdds_dsi, and the common code can setup the regulator supply for all
>> DSS devices which need it (omapdss_dss, omapdss_dsi1, omapdss_dsi2).
>>
>> I guess this needs dynamically adding the regulator supply in display.c,
>> and I'm not quite sure if that's possible. We have to look at this.
>
> I don't see how this would be possible. As far as I see, the regulator
> consumers have to be given statically at init time. We could get the
> whole VPLL2 or VCXIO supply array from a common display code, but that
> would prevent adding any other consumers to those regulators, so that's
> not an option either.

Also, I think the twl driver expects all the regulators to come from the 
twl4030_platform_data struct, so if we set vpll2 to NULL in 
twl4030_platform_data and declare it in our common display code, the twl 
driver will throw an error.

Archit
