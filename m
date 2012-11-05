From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 12/15] ARM: OMAP: timer: Add suspend-resume callbacks
 for clockevent device
Date: Mon, 5 Nov 2012 20:25:00 +0530
Message-ID: <5097D344.7010209@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-13-git-send-email-vaibhav.bedia@ti.com> <50953DA4.10008@ti.com> <B5906170F1614E41A8A28DE3B8D121433EBFFD03@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34524 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932251Ab2KEOzI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 09:55:08 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EBFFD03@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Sunday 04 November 2012 08:55 PM, Bedia, Vaibhav wrote:
> Hi Santosh,
>
> On Sat, Nov 03, 2012 at 21:22:04, Shilimkar, Santosh wrote:
>> On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
>>> From: Vaibhav Hiremath <hvaibhav@ti.com>
>>>
>>> The current OMAP timer code registers two timers -
>>> one as clocksource and one as clockevent.
>> Actually OMAP also uses only one timer. The clocksource
>> is taken care by 32K syntimer till OMAP4 and by realtime
>> counter on OMAP5. There is a clocksource registration of
>> timer is available but that is not being used in systems.
>>
>
> Yes, I guess the changelog should mention that AM33xx does not
> have the 32k synctimer. I'll also add in the OMAP details that
> you pointed out so that all the details get captured.
>
>>> AM33XX has only one usable timer in the WKUP domain
>>> so one of the timers needs suspend-resume support
>>> to restore the configuration to pre-suspend state.
>>>
>>> commit adc78e6 (timekeeping: Add suspend and resume
>>> of clock event devices) introduced .suspend and .resume
>>> callbacks for clock event devices. Leverages these
>>> callbacks to have AM33XX clockevent timer which is
>>> in not in WKUP domain to behave properly across system
>>> suspend.
>>>
>> So you use WKUP domain timer for clocksource and PER
>> domain one for clock-event ?
>
> Yes, that's correct.
>
>>
>>
>>> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>> ---
>>>    arch/arm/mach-omap2/timer.c |   31 +++++++++++++++++++++++++++++++
>>>    1 files changed, 31 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>>> index 6584ee0..e8781fd 100644
>>> --- a/arch/arm/mach-omap2/timer.c
>>> +++ b/arch/arm/mach-omap2/timer.c
>>> @@ -135,6 +135,35 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>>>    	}
>>>    }
>>>
>>> +static void omap_clkevt_suspend(struct clock_event_device *unused)
>>> +{
>>> +	char name[10];
>>> +	struct omap_hwmod *oh;
>>> +
>>> +	sprintf(name, "timer%d", 2);
>>> +	oh = omap_hwmod_lookup(name);
>>> +	if (!oh)
>>> +		return;
>>
>> You can move all the look up stuff in init code and then
>> suspend resume hooks will be cleaner.
>
> Will do. Kevin also pointed this out.
>
>>> +
>>> +	omap_hwmod_idle(oh);
>>> +}
>>> +
>>> +static void omap_clkevt_resume(struct clock_event_device *unused)
>>> +{
>>> +	char name[10];
>>> +	struct omap_hwmod *oh;
>>> +
>>> +	sprintf(name, "timer%d", 2);
>>> +	oh = omap_hwmod_lookup(name);
>>> +	if (!oh)
>>> +		return;
>>> +
>>> +	omap_hwmod_enable(oh);
>>> +	__omap_dm_timer_load_start(&clkev,
>>> +			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
>>> +	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
>>> +}
>>> +
>> OK. So since your clk_event stops when PER idles, how do you plan
>> to support the SOC idle. For CPUIDLE path, you need your clock-event
>> to wakeup the system based on next timer expiry. So you need your
>> clock event to be active. Indirectly, you can't let PER idle which
>> leads npo CORE idle->SOC idle.
>>
>> How do you plan to address this ? Os is SOC idle is not suppose
>> to be added for AMXXX ?
>>
>
> We can't really have SOC idle on AM33xx or at least that's what I think.
> The deepest that we should be able to support is MPU off with external
> memory in self-refresh mode. I mentioned the reasons for that in the
> reply to Kevin [1]. If there's any another approach that we could take
> that would be great to know.
>
Thanks for information.

Regards
Santosh

