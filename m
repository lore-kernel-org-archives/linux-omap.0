From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC 2/4] ARM: OMAP: PM: Get rid of Powerdomain book-keeping from cpuidle
Date: Wed, 25 Jul 2012 15:43:03 -0700
Message-ID: <87obn3798o.fsf@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>
	<1342764284-8143-3-git-send-email-rnayak@ti.com>
	<CAMQu2gyCmx57ctZFBoAUKUXY+9zwFLCDHsBfehXicH7mEyDzQg@mail.gmail.com>
	<5009120A.1060400@ti.com> <1342774283.4672.181.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:60498 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751206Ab2GYWnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jul 2012 18:43:07 -0400
Received: by yenl12 with SMTP id l12so2361469yen.1
        for <linux-omap@vger.kernel.org>; Wed, 25 Jul 2012 15:43:05 -0700 (PDT)
In-Reply-To: <1342774283.4672.181.camel@sokoban> (Tero Kristo's message of
	"Fri, 20 Jul 2012 11:51:23 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Rajendra Nayak <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com

Tero Kristo <t-kristo@ti.com> writes:

> On Fri, 2012-07-20 at 13:38 +0530, Rajendra Nayak wrote:
>> On Friday 20 July 2012 12:55 PM, Shilimkar, Santosh wrote:
>> > On Fri, Jul 20, 2012 at 11:34 AM, Rajendra Nayak<rnayak@ti.com>  wrote:
>> >> pwrdm_pre_transition()/pwrdm_post_transition() have always been high latency
>> >> operations done within cpuidle to do Powerdomain level book-keeping to know
>> >> what state transitions for different Powerdomains have been triggered.
>> >> This is also useful to do a restore-on-demand in some cases when we know
>> >> the context for the given Powerdomain was lost etc.
>> >>
>> >> Now that we have definitive entry/exit points (thanks to the Powerdomain
>> >> level usecounting) for Powerdomain transitions, these book-keeping functions
>> >> can very well be moved from within CPUidle into pwrdm_clkdm_enable()/pwrdm_
>> >> clkdm_disable() functions.
>> >>
>> >> Also rename _pwrdm_pre/post_transition_cb() to pwrdm_pre/post_transition()
>> >> and get rid of the original ones which iterate over all powerdomains.
>> >>
>> >> Signed-off-by: Rajendra Nayak<rnayak@ti.com>

This is excellent!   Thanks for working on this.

However, it needs a rebase against mainline though because I merged a
set of optimizations[1] to this code already that only calls pre/post
per-pwrdm.

[...]

>> > Glad to see this is getting optimized.
>> > I haven't seen how "pwrdm_cpu_[idle/wakeup]()" is
>> > implemented but will those work on SMP system ?
>> > I mean OMAP4, any CPU can make this call ?
>> 
>> Thats a good question. I think Tero did this so he can kick in
>> voltage transitions at the right time in idle/suspend.
>> Given that these deal with incrementing/decrementing the MPU and CORE
>> pwrdm usecounts alone, maybe on OMAP4 (SMP systems) this needs to also
>> increment/decrement the specific CPU usecounts on the CPUs these calls
>> are made.
>
> Yeah, you should keep the usecounts valid by each cpu separately calling
> these functions. My current set only sets these usecounts based on cpu0
> activity, as cpu1 is statically controlled through cpu online / offline.
> Once per-cpu cpuidle is in, these should be changed so that each
> individual cpu increases the usecounts when they are brought up,
> decrease/increase during idle, and decrease when they are brought down.
> The usecount should always reflect the number of CPUs active on MPU
> domain.

Coupled CPUidle is merging for v3.6 (hopefully OMAP support too), so
this should be addressed sooner rather than later.

Kevin

[1] Specifically, see:
commit 58f0829b7186150318c79515f0e0850c5e7a9c89
Author: Kevin Hilman <khilman@ti.com>
Date:   Fri May 11 15:47:17 2012 -0700

    ARM: OMAP3: PM: call pre/post transition per powerdomain
    
    We only need to call the pre/post transtion methods when we know the
    power state is changing.  First, split up the pre/post transition
    calls to be per-powerdomain, and then make them conditional on whether
    the power domain is actually changing states.
    
    Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
    Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
    Tested-by: Grazvydas Ignotas <notasas@gmail.com>
    Signed-off-by: Kevin Hilman <khilman@ti.com>

