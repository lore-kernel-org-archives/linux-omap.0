From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC v2 12/18] ARM: OMAP2+: timer: Add suspend-resume callbacks
 for clockevent device
Date: Wed, 30 Jan 2013 11:46:34 -0600
Message-ID: <51095C7A.9080904@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com> <1356959231-17335-13-git-send-email-vaibhav.bedia@ti.com> <50EC37FE.705@ti.com> <B5906170F1614E41A8A28DE3B8D121433ECE0D51@DBDE01.ent.ti.com> <50F846D7.8060509@ti.com> <50F8DCD7.707@ti.com> <B5906170F1614E41A8A28DE3B8D121433ECF0B60@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53146 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756550Ab3A3Rqi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jan 2013 12:46:38 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ECF0B60@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>


On 01/21/2013 01:22 AM, Bedia, Vaibhav wrote:
> On Fri, Jan 18, 2013 at 10:55:43, Shilimkar, Santosh wrote:
>> On Friday 18 January 2013 12:15 AM, Jon Hunter wrote:
>>>
>>> On 01/10/2013 10:37 PM, Bedia, Vaibhav wrote:
>>>> On Tue, Jan 08, 2013 at 20:45:10, Shilimkar, Santosh wrote:
>>>>> On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
>>>>>> The current OMAP timer code registers two timers -
>>>>>> one as clocksource and one as clockevent.
>>>>>> AM33XX has only one usable timer in the WKUP domain
>>>>>> so one of the timers needs suspend-resume support
>>>>>> to restore the configuration to pre-suspend state.
>>>>>>
>>>>>> commit adc78e6 (timekeeping: Add suspend and resume
>>>>>> of clock event devices) introduced .suspend and .resume
>>>>>> callbacks for clock event devices. Leverages these
>>>>>> callbacks to have AM33XX clockevent timer which is
>>>>>> in not in WKUP domain to behave properly across system
>>>>>> suspend.
>>>>>>
>>>>>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>>>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>>>>> Cc: Paul Walmsley <paul@pwsan.com>
>>>>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>>>>> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
>>>>>> Cc: Jon Hunter <jon-hunter@ti.com>
>>>>>> ---
>>>>>> v1->v2:
>>>>>> 	Get rid of harcoded timer id.
>>>>>> 	Note: since a platform device is not created for these timer
>>>>>> 	instances and because there's very minimal change needed for
>>>>>> 	restarting the timer a full blown context save and restore
>>>>>> 	has been skipped.
>>>>>>
>>>>>>    arch/arm/mach-omap2/timer.c |   33 +++++++++++++++++++++++++++++++++
>>>>>>    1 files changed, 33 insertions(+), 0 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>>>>>> index 691aa67..38f9cbc 100644
>>>>>> --- a/arch/arm/mach-omap2/timer.c
>>>>>> +++ b/arch/arm/mach-omap2/timer.c
>>>>>> @@ -128,6 +128,36 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>>>>>>    	}
>>>>>>    }
>>>>>>
>>>>>> +static void omap_clkevt_suspend(struct clock_event_device *unused)
>>>>>> +{
>>>>>> +	char name[10];
>>>>>> +	struct omap_hwmod *oh;
>>>>>> +
>>>>>> +	sprintf(name, "timer%d", clkev.id);
>>>>>> +	oh = omap_hwmod_lookup(name);
>>>>>> +	if (!oh)
>>>>>> +		return;
>>>>>> +
>>>>>> +	__omap_dm_timer_stop(&clkev, 1, clkev.rate);
>>>>>> +	omap_hwmod_idle(oh);
>>>>>> +}
>>>>>> +
>>>>>> +static void omap_clkevt_resume(struct clock_event_device *unused)
>>>>>> +{
>>>>>> +	char name[10];
>>>>>> +	struct omap_hwmod *oh;
>>>>>> +
>>>>>> +	sprintf(name, "timer%d", clkev.id);
>>>>>> +	oh = omap_hwmod_lookup(name);
>>>>>> +	if (!oh)
>>>>>> +		return;
>>>>>> +
>>>>>> +	omap_hwmod_enable(oh);
>>>>>> +	__omap_dm_timer_load_start(&clkev,
>>>>>> +			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
>>>>>> +	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
>>>>>> +}
>>>>>> +
>>>>> Am still bit uncomfortable with direct hwmod usage in the suspend/resmue
>>>>> hooks.
>>>>>
>>>>> Jon, Any alternatives you can think of ?
>>>>>
>>>>
>>>> Jon,
>>>>
>>>> Any suggestions here?
>>>
>>> Sorry completed this missed this!
>>>
>>> Unfortunately, I don't have any good suggestions here. However, I am
>>> wondering if the suspend/resume handlers can just be calls to
>>> omap_hwmod_idle/enable and we can remove these __omap_dm_timer_xxxx
>>> calls (I don't think they are needed). Furthermore, my understanding is
>>> this is only needed for AM335x (per the changelog), and so we should not
>>> add suspend/resume handlers for all OMAP2+ based devices.
>>>
>> I agree with the direction.
>>
> 
> I need to retain the call to enable the interrupt but the others can be dropped.
> Will take care of this and the comment on invoking the suspend/resume handlers
> only for AM335x in the next version.

Ok fair enough. By the way, I posted a patch today [1] that will use the
hwmod name as the clockevent timer name. Care to try on top of that
patch and then we can eliminate the sprintf.

Cheers
Jon

[1] http://www.spinics.net/lists/arm-kernel/msg221262.html

