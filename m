From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCHv3 6/9] ARM: OMAP2+: timer: Add suspend-resume callbacks
 for clkevent device
Date: Thu, 8 Aug 2013 11:09:21 -0500
Message-ID: <5203C2B1.7050106@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <1375811376-49985-7-git-send-email-d-gerlach@ti.com> <5203A9E8.2090901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40632 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934137Ab3HHQJp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Aug 2013 12:09:45 -0400
In-Reply-To: <5203A9E8.2090901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>

On 08/08/2013 09:23 AM, Santosh Shilimkar wrote:
> On Tuesday 06 August 2013 01:49 PM, Dave Gerlach wrote:
>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>
>> OMAP timer code registers two timers - one as clocksource
>> and one as clockevent. Since AM33XX has only one usable timer
>> in the WKUP domain one of the timers needs suspend-resume
>> support to restore the configuration to pre-suspend state.
>>
>> commit adc78e6 (timekeeping: Add suspend and resume
>> of clock event devices) introduced .suspend and .resume
>> callbacks for clock event devices. Leverages these
>> callbacks to have AM33XX clockevent timer which is
>> in not in WKUP domain to behave properly across system
>> suspend.
>>
>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
> NAK
>
> This patch doesn't addressed previous comments.
> - The issue is specific to AM33XX and hence you
> need to take care of that. These callbacks will happen on
> all OMAP machines where the problem doesn't exist.
>
> - Don't use hwmod APIs directly. At least abstract it
> at omap_device layer and use that one instead.
>

Ok I will fix this, seems I missed those.

>>   arch/arm/mach-omap2/timer.c |   32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>> index b37e1fc..cce5d39 100644
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -118,11 +118,43 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>>   	}
>>   }
>>
>> +static void omap_clkevt_suspend(struct clock_event_device *unused)
>> +{
>> +	char name[10];
>> +	struct omap_hwmod *oh;
>> +
>> +	sprintf(name, "timer%d", clkev.id);
>> +	oh = omap_hwmod_lookup(name);
>> +	if (!oh)
>> +		return;
>> +
>> +	__omap_dm_timer_stop(&clkev, 1, clkev.rate);
>> +	omap_hwmod_idle(oh);
>> +}
>> +
>> +static void omap_clkevt_resume(struct clock_event_device *unused)
>> +{
>> +	char name[10];
>> +	struct omap_hwmod *oh;
>> +
>> +	sprintf(name, "timer%d", clkev.id);
>> +	oh = omap_hwmod_lookup(name);
>> +	if (!oh)
>> +		return;
>> +
>> +	omap_hwmod_enable(oh);
>> +	__omap_dm_timer_load_start(&clkev,
>> +			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
>> +	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
>> +}
>> +
>>   static struct clock_event_device clockevent_gpt = {
>>   	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
>>   	.rating		= 300,
>>   	.set_next_event	= omap2_gp_timer_set_next_event,
>>   	.set_mode	= omap2_gp_timer_set_mode,
>> +	.suspend	= omap_clkevt_suspend,
>> +	.resume		= omap_clkevt_resume,
>>   };
>>
>>   static struct property device_disabled = {
>>
>

