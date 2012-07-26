From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC 2/4] ARM: OMAP: PM: Get rid of Powerdomain book-keeping from cpuidle
Date: Thu, 26 Jul 2012 10:44:25 -0700
Message-ID: <87boj2s9hi.fsf@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>
	<1342764284-8143-3-git-send-email-rnayak@ti.com>
	<CAMQu2gyCmx57ctZFBoAUKUXY+9zwFLCDHsBfehXicH7mEyDzQg@mail.gmail.com>
	<5009120A.1060400@ti.com> <1342774283.4672.181.camel@sokoban>
	<87obn3798o.fsf@ti.com> <50113B3C.4090608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:40510 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752218Ab2GZRo0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 13:44:26 -0400
Received: by pbcwy7 with SMTP id wy7so4296589pbc.17
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 10:44:24 -0700 (PDT)
In-Reply-To: <50113B3C.4090608@ti.com> (Rajendra Nayak's message of "Thu, 26
	Jul 2012 18:12:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: t-kristo@ti.com, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com

Rajendra Nayak <rnayak@ti.com> writes:

> On Thursday 26 July 2012 04:13 AM, Kevin Hilman wrote:
>> Tero Kristo<t-kristo@ti.com>  writes:
>>
>>> On Fri, 2012-07-20 at 13:38 +0530, Rajendra Nayak wrote:
>>>> On Friday 20 July 2012 12:55 PM, Shilimkar, Santosh wrote:
>>>>> On Fri, Jul 20, 2012 at 11:34 AM, Rajendra Nayak<rnayak@ti.com>   wrote:
>>>>>> pwrdm_pre_transition()/pwrdm_post_transition() have always been high latency
>>>>>> operations done within cpuidle to do Powerdomain level book-keeping to know
>>>>>> what state transitions for different Powerdomains have been triggered.
>>>>>> This is also useful to do a restore-on-demand in some cases when we know
>>>>>> the context for the given Powerdomain was lost etc.
>>>>>>
>>>>>> Now that we have definitive entry/exit points (thanks to the Powerdomain
>>>>>> level usecounting) for Powerdomain transitions, these book-keeping functions
>>>>>> can very well be moved from within CPUidle into pwrdm_clkdm_enable()/pwrdm_
>>>>>> clkdm_disable() functions.
>>>>>>
>>>>>> Also rename _pwrdm_pre/post_transition_cb() to pwrdm_pre/post_transition()
>>>>>> and get rid of the original ones which iterate over all powerdomains.
>>>>>>
>>>>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>
>> This is excellent!   Thanks for working on this.
>>
>> However, it needs a rebase against mainline though because I merged a
>> set of optimizations[1] to this code already that only calls pre/post
>> per-pwrdm.
>>
>
> Hi Kevin,
>
> I thought some more on this patch, and I think this way of collecting
> stats and knowing what state transitions the powerdomains been through
> will not work on OMAP3, mainly because of the autodeps. Might work on
> OMAP4 and beyond which do not need any autodeps.
>
> Here why I think so,
> Lets assume a Powerdomain X with a last module Y active, once Y disables
> the last clock (lets assume no hardware controlled clocks for
> simplicity), we clear the last power state register for X. However
> due to autodeps X does not transition to a target state immediately.
> It only does so when the MPU (and IVA) go down, and because
> of the wakeup dependency (autodeps set a sleep and a wakeup dep with
> both MPU and IVA) is also woken up every time MPU or IVA are up.
> So its quite possible that X transitions in and out of sleep multiple
> times before Y decides to re-enable its clocks, which is when we end up
> looking for the last power state entered.
> Lets say X entered OFF 3 times in between Y disabling and re-enabling
> its clocks. Though we end up updating the counter only once (instead of
> 3) we still know and can tell Y that it lost context.
> The problem however arises if for some reason X entered OFF
> twice and happened to stay ON the third time the dependencies were met.
> When Y re-enables its clocks, we end up telling it that it *did not*
> lose context because we see the previous power state was ON.

Yeah, this is definitely a problem.

As long as we have autodeps, everything is centralized around CPU
transitions anyways, so it makes sense to keep the accounting
centralized too.

> I think as long as we have autodeps, the only way on OMAP3 to accurately
> do this is to do it for all dependent domains in CPUIdle :(

Or, to get rid of autodeps. ;)

Kevin
