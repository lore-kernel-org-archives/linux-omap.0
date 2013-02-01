From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 5/5] ARM: OMAP3: Update clocksource timer selection
Date: Fri, 1 Feb 2013 03:25:31 -0600
Message-ID: <510B8A0B.9000600@ti.com>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com> <1359565471-30721-6-git-send-email-jon-hunter@ti.com> <B5906170F1614E41A8A28DE3B8D121433ED07250@DBDE01.ent.ti.com> <510B83D5.1090500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40067 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756115Ab3BAJZh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Feb 2013 04:25:37 -0500
In-Reply-To: <510B83D5.1090500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 02/01/2013 02:59 AM, Jon Hunter wrote:
> 
> On 02/01/2013 02:41 AM, Bedia, Vaibhav wrote:
>> Hi Jon,
>>
>> On Wed, Jan 30, 2013 at 22:34:31, Hunter, Jon wrote:
>>> When booting with device-tree for OMAP3 and AM335x devices and a gptimer
>>> is used as the clocksource (which is always the case for AM335x), a
>>> gptimer located in a power domain that is not always-on is selected.
>>> Ideally we should use a gptimer located in a power domain that is always
>>> on (such as the wake-up domain) so that time can be maintained during a
>>> kernel suspend without keeping on additional power domains unnecessarily.
>>>
>>> In order to fix this so that we can select a gptimer located in a power
>>> domain that is always-on, the following changes were made ...
>>> 1. Currently, only when selecting a gptimer to use for a clockevent
>>>    timer, do we pass a timer property that can be used to select a
>>>    specific gptimer. Change this so that we can pass a property when
>>>    selecting a gptimer to use for a clocksource timer too.
>>> 2. Currently, when selecting either a gptimer to use for a clockevent
>>>    timer or a clocksource timer and no timer property is passed, then
>>>    the first available timer is selected regardless of the properties
>>>    it has. Change this so that if no properties are passed, then a timer
>>>    that does not have additional features (such as always-on, dsp-irq,
>>>    pwm, and secure) is selected.
>>>
>>> Please note that using a gptimer for both clocksource and clockevents
>>> can have a system power impact during idle. The reason being is that
>>> OMAP and AMxxx devices typically only have one gptimer in a power domain
>>> that is always-on. Therefore when the kernel is idle both the clocksource
>>> and clockevent timers will be active and this will keep additional power
>>> domains on. During kernel suspend, only the clocksource timer is active
>>> and therefore, it is better to use a gptimer in a power domain that is
>>> always-on for clocksource.
>>>
>>
>> It's always a pleasure reading the changelog in your patches :)
> 
> Thanks.
> 
>> [...]
>>>  
>>>  #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
>>> -OMAP_SYS_GP_TIMER_INIT(3, 1, "timer_sys_ck", "ti,timer-alwon",
>>> -		       2, "timer_sys_ck");
>>> +OMAP_SYS_GP_TIMER_INIT(3, 2, "timer_sys_ck", NULL,
>>> +		       1, "timer_sys_ck", "ti,timer-alwon");
>>>  #endif
>>>
>>
>> Minor point... was the intention of changing of clkev_nr and clksrc_nr to make
>> it consistent with what happens on AM33xx which is DT-only?
> 
> I don't see this as being DT specific. It is more of a policy change to
> ensure a wake-up domain timer is used for clocksource when we are using
> gptimers for both clocksource and clockevents. It was your patch for
> AM335x that made me see the need for this, if that makes sense. May be I
> should have referenced that in the changelog.

Sorry to be clear, I don't see the policy change as DT specific.

In answer to your question, yes clkev_nr and clksrc_nr are changed so
the policy it is consistent regardless of whether you use DT or not. In
other words, an OMAP3 board using a gptimer for clocksource  (such as
cm-t3517) and does not use DT, would work the same as AM335x with DT.

Cheers
Jon
