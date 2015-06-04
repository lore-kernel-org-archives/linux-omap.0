From: Mason <slash.tmp@free.fr>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Thu, 04 Jun 2015 11:46:59 +0200
Message-ID: <55701E93.60303@free.fr>
References: <1433363565-17725-1-git-send-email-balbi@ti.com> <2466648.WjMxjIpAUG@wuerfel> <20150603210455.GD6042@saruman.tx.rr.com> <20150603212821.GH6042@saruman.tx.rr.com> <556F7493.2060602@codeaurora.org> <20150603215445.GK6042@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:47804 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbbFDJrL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Jun 2015 05:47:11 -0400
In-Reply-To: <20150603215445.GK6042@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Linux OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 03/06/2015 23:54, Felipe Balbi wrote:

> On Wed, Jun 03, 2015 at 02:41:39PM -0700, Stephen Boyd wrote:
>>>>>> AM43xx, even though it's a single processor A9, it still has TWD and global
>>>>>> timer. I was doing some profiling with RT v4.0 and latency is 3.5x lower just
>>>>>> by switching from gptimer to twd/global.
>>>>>>
>>>>>> The only problem is that currently, is_smp() check prevents me from using twd
>>>>>> with AM43xx (that's why it's commented below, for testing purposes).
>>>>>>
>>>>>> In the hopes that we can start a, hopefully, small thread around the subject,
>>>>>> I'm sending this HACK which I used to get TWD and global timer enabled so I
>>>>>> could measure latencies with cyclictest.
>>>>>>
>>>>>> Is it so that TWD shouldn't be available on UP integrations of ARM's Cortex-A
>>>>>> processors ?
>>>>>>
>>>>>>
>>>>> I wondered about this recently when looking at something unrelated
>>>>> and noticed that the check had been introduced as part of
>>>>> 904464b91eca8 ("ARM: 7655/1: smp_twd: make twd_local_timer_of_register()
>>>>> no-op for nosmp").
>>>>>
>>>>> I suspect this was just the wrong fix at the time, and that the
>>>>> real culprit is either alloc_percpu() or request_percpu_irq()
>>>>> getting called too early on a machine without SMP support.
>>>>>
>>>>> Possibly the problem is already resolved independently, if you
>>>>> didn't run into it.
>>>> no, no splats, nothing at all. See [1]
>>>>
>>>> [1] http://hastebin.com/helekubutu
>>> Adding Shawn
>>>
>>
>> Mason was also interested in doing this. See [2]. From what I could tell
>> back then, commit 904464b91eca8 was working around the local timer APIs that
>> no longer exist.
>>
>> [2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/389931/focus=392348
> 
> A lot of good information on that thread, thanks. Seems like getting
> twd/global timer working would also have some effect on context
> switching, perhaps ?

Hello,

In my case, I need to support two platforms:

  single core Cortex A9 MPCore
    dual core Cortex A9 MPCore

However, as the MPCore moniker implies, even the single core platform
is "SMP capable". (I think this only means an SCU is available?)

Thus, I worked around the issue by using the same SMP kernel for both
platforms; which is why I didn't push any patch.

Also, check /proc/timer_list for a "Broadcast device". If you don't
define one, the TWD timers are set to periodic mode, with hrtimers
disabled.

Regards.

