From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 11/15] ARM: OMAP: timer: Interchange clksrc and clkevt
 for AM33XX
Date: Tue, 6 Nov 2012 03:29:22 +0530
Message-ID: <509836BA.5030507@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com> <5095037A.2020503@deeprootsystems.com> <B5906170F1614E41A8A28DE3B8D121433EBFEA0E@DBDE01.ent.ti.com> <5095165E.10403@deeprootsystems.com> <B5906170F1614E41A8A28DE3B8D121433EBFEB57@DBDE01.ent.ti.com> <87pq3s7wro.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57082 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab2KEV70 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 16:59:26 -0500
In-Reply-To: <87pq3s7wro.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Monday 05 November 2012 11:33 PM, Kevin Hilman wrote:
> "Bedia, Vaibhav" <vaibhav.bedia@ti.com> writes:
>
>> On Sat, Nov 03, 2012 at 18:34:30, Kevin Hilman wrote:
>> [...]
>>>>>
>>>>> Doesn't this also mean that you won't get timer wakeups
>>>>> in idle?  Or are you keeping the domain where the clockevent is
>>>>> on during idle?
>>>>>
>>>>
>>>> The lowest idle state that we are targeting will have MPU powered
>>>> off with external memory in self-refresh mode. Peripheral domain
>>>> with the clockevent will be kept on.
>>>
>>> Is this a limitation of the hardware?  or the software?
>>>
>>
>> Well, making the lowest idle state same as the suspend state will
>> require us to involve WKUP_M3 in the idle path and wakeup sources get
>> limited to the IPs in the WKUP domain alone. There's no IO daisy
>> chaining in AM33XX so that's one big difference compared to OMAP.  The
>> other potential problem is that the IPC mechanism that we have uses
>> interrupts.
>
> It can still interrupt the M3, it's only the interrupt back to the MPU
> that is the issue, right?  That being said, there's no reason it
> couldn't use polling in the idle path, right?
>
>> Assuming that the lowest idle state, say Cx, is the same as the
>> suspend state, we'll need to communicate with the WKUP_M3 using
>> interrupts once we decide to enter Cx. I am not sure if we can do
>> something in the cpuidle implementation to work around the "interrupt
>> for idle" problem.
>>
>> We could probably not wait for an ACK when we want to enter Cx,
>
> why not?
>
> Are the response times from the M3 really up to 500ms (guessing based on
> the timeout you used in the suspend path.)  That seems rather unlikely.
>
> Hmm, but as I think about it.  Why does the MPU need to wait for an ACK
> at all?  Why not just send the cmd and WFI?
>
>> but the problem of limited wakeup sources remains. If we let the
>> various drivers block the entry to Cx, since almost all the IPs are in
>> the peripheral domain a system which uses anything other than UART and
>> Timer in WKUP domain will probably never be able enter Cx.
>
> Even so, I think the system needs to be designed to hit the same power
> states in idle and suspend.  Then, the states can be restricted based
> wakeup capabilities as you described.  This would be easy to do in the
> runtime PM implementation for this device.
>
> IMO, assuming that idle will not be useful from the begining is leading
> down the path to poor design choices that will be much more difficult to
> fixup down the road in order to add idle support later.  We need to
> design both idle and suspend at the same time.
>
I agree with Kevin. Not supporting CPUIDLE deep states can hit the
active power numbers dearly. I just don't know why the SOCs don't share
the standard and must have design choices. But thats another discussion.

How about leaving the timer choices as is. PER timer for clock source
and wakeuptimer for clock event. Anyway in suspend the clock-source
can be suspended and that is evident from recent discussion. The only
downside is you won't count time in suspend which is any way the case.

Vaibhav,
Do you guys see any implementation bottleneck for above ?

Regards
Santosh
