From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v4 03/11] ARM: OMAP2+: timer: Add suspend-resume callbacks
 for clkevent device
Date: Mon, 14 Jul 2014 12:42:07 -0500
Message-ID: <53C4166F.1050003@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com> <1405047349-15101-4-git-send-email-d-gerlach@ti.com> <20140714111536.GC20068@atomide.com> <53C3EB1F.2010109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50449 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbaGNRme (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Jul 2014 13:42:34 -0400
In-Reply-To: <53C3EB1F.2010109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>

Santosh, Tony,

On 07/14/2014 09:37 AM, Santosh Shilimkar wrote:
> On Monday 14 July 2014 07:15 AM, Tony Lindgren wrote:
>> * Dave Gerlach <d-gerlach@ti.com> [140710 19:59]:
>>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>>
>>> OMAP timer code registers two timers - one as clocksource
>>> and one as clockevent. Since AM33XX has only one usable timer
>>> in the WKUP domain one of the timers needs suspend-resume
>>> support to restore the configuration to pre-suspend state.
>>>
>>> commit adc78e6 (timekeeping: Add suspend and resume
>>> of clock event devices) introduced .suspend and .resume
>>> callbacks for clock event devices. Leverages these
>>> callbacks to have AM33XX clockevent timer which is
>>> in not in WKUP domain to behave properly across system
>>> suspend.
>>>
>>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>> ---
>>> v3->v4:
>>> 	Only use for am33xx soc now.
>>>
>>>   arch/arm/mach-omap2/timer.c | 28 ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>>> index 43d03fb..6fc1748 100644
>>> --- a/arch/arm/mach-omap2/timer.c
>>> +++ b/arch/arm/mach-omap2/timer.c
>>> @@ -128,6 +128,29 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>>>   	}
>>>   }
>>>
>>> +static void omap_clkevt_suspend(struct clock_event_device *unused)
>>> +{
>>> +	struct omap_hwmod *oh;
>>> +
>>> +	oh = omap_hwmod_lookup(clockevent_gpt.name);
>>> +	if (!oh)
>>> +		return;
>>> +
>>> +	omap_hwmod_idle(oh);
>>> +}
>>> +
>>> +static void omap_clkevt_resume(struct clock_event_device *unused)
>>> +{
>>> +	struct omap_hwmod *oh;
>>> +
>>> +	oh = omap_hwmod_lookup(clockevent_gpt.name);
>>> +	if (!oh)
>>> +		return;
>>> +
>>> +	omap_hwmod_enable(oh);
>>> +	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
>>> +}
>>> +
>>
>> This is going to make moving the timer code into drivers one step
>> tougher to do. And you don't need to look up the hwmod entry every
>> time, just initialize it during the init.

Yes you are right about looking up only at init I need to change that. I agree 
that this makes moving the timers harder but I'm not sure there's any way around 
this. I attempted to use the omap_device layer here but there is no device at 
all created here, it does not hook into the normal PM layer through omap_device. 
This clock must be shut off as it sits in the peripheral power domain and any 
active clock within the domain will prevent suspend from happening, so we end up 
with a platform specific issue here. It seems that the only way I can get to the 
clock is through the hwmod.

>>
>>> +	if (soc_is_am33xx()) {
>>> +		clockevent_gpt.suspend = omap_clkevt_suspend;
>>> +		clockevent_gpt.resume = omap_clkevt_resume;
>>> +	}
>>> +
>>
>> Maybe try to set up things so we initialize the SoC specific
>> timer suspend and resume functions in mach-omap2/timer.c
>> in a way where eventually the device driver can easily use
>> them?
>>
> +1. I had similar comments on the previous version too.

This was my attempt to make things specific to only am335x based on Santosh's 
previous comments as last time they were populated for every device even when 
unneeded. These are not standard suspend/resume handlers, they are specific to 
clock event. I know there will always need to be at least some code here for the 
early timer init based on previous timer cleanup series I've seen, so perhaps I 
could hook it in there when the time comes?

Regards,
Dave

>
> Regards,
> Santosh
>

