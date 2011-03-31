From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [pm-core][PATCH v3 01/21] OMAP4: PM: Add omap WakeupGen module
 support
Date: Thu, 31 Mar 2011 11:58:37 +0530
Message-ID: <4D941F15.1010403@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com> <1301304157-2466-2-git-send-email-santosh.shilimkar@ti.com> <20110328205027.GC30616@atomide.com> <5cbdd88c3ca3fe5c5a0f119be446ce99@mail.gmail.com> <20110329170113.GG4016@atomide.com> <4D92CA92.50805@ti.com> <20110330184058.GF18334@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:34874 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302Ab1CaG3B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 02:29:01 -0400
Received: by mail-gw0-f44.google.com with SMTP id 20so1134463gwb.17
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 23:28:59 -0700 (PDT)
In-Reply-To: <20110330184058.GF18334@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On 3/31/2011 12:10 AM, Tony Lindgren wrote:
> * Santosh<santosh.shilimkar@ti.com>  [110329 23:13]:
>> On 3/29/2011 10:31 PM, Tony Lindgren wrote:
>>> * Santosh Shilimkar<santosh.shilimkar@ti.com>   [110328 22:47]:
>>>>> From: Tony Lindgren [mailto:tony@atomide.com]
>>>>>
>>>>> Do you really need to initialize all of this that early?
>>>>>
>>>> Yes. It's a interrupt controller extension and needs to work
>>>> together with GIC.
>>>
>>> Hmm to me it seems that the gic_arch_extn functions should be
>>> all NULL during runtime operation, and the wake-up generator
>>> should be programmed only before entering an idle state.
>>>
>>> Then the wake-up generator can be cleared after delivering
>>> the wake-up event(s).
>>>
>>> Or am I missing something on why this should be enabled all
>>> the time?
>>>
>> Yep. The WakeupGen sits between GIC and CPU and can
>> gate the interrupts in normal operation too. It's
>> mandatory that the interrupt mask at GIC and WakeupGen
>> matches to deliver the interrupt to CPU.
>
> But it seems that the states of GIC and WakeupGen can be
> synced up just before hitting an idle mode.
>
Even during normal operation, WakeUpGen delivers external
interrupts directly to the Interrupt Controller (GIC)
in the CortexA9 MP Core.

> And then the wake-ups only need to be acked after waking
> from idle and delivering the interrupts.
>
>> This is the reason why all the necessary GIC hooks are
>> populated with it so that they work together.
>
> Hmm I still see no reason to call these functions for every
> interrupt during runtime.
>
> AFAIK, these functions only need to be called only once
> right after waking from idle.
>
No. That's pure hack. I think the name of the module
"WakeupGen" seems to be the confusing point.

>> So far without this patch all interrupts at WakeupGen
>> level were always enabled and hence there was no issue.
>
> OK so things work during runtime without calling these
> functions for every interrupt. Why then would we want to
> call them for each interrupt?
>
Because that's the best way to ensure the synchronization
between the GIC and Wakeupgen interrupts mask. The IRQ
framework does this job and we don't have to hack low
level idle code to make special arrangement.

FYI, this is not OMAP4 only problem but even other
architectures based on Cortex-A9 needs an additional
interrupt controller. And they are managed through
the Linux IRQ framework.

As I said earlier it's another interrupt controller
works along with GIC and it's control needs to be
in kernel IRQ framework.

Regards
Santosh
