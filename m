From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Wed, 03 Jun 2015 14:41:39 -0700
Message-ID: <556F7493.2060602@codeaurora.org>
References: <1433363565-17725-1-git-send-email-balbi@ti.com> <2466648.WjMxjIpAUG@wuerfel> <20150603210455.GD6042@saruman.tx.rr.com> <20150603212821.GH6042@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39012 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbbFCVll (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 17:41:41 -0400
In-Reply-To: <20150603212821.GH6042@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Shawn Guo <shawn.guo@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, slash.tmp@free.fr

On 06/03/2015 02:28 PM, Felipe Balbi wrote:
> On Wed, Jun 03, 2015 at 04:04:55PM -0500, Felipe Balbi wrote:
>> On Wed, Jun 03, 2015 at 10:55:27PM +0200, Arnd Bergmann wrote:
>>> On Wednesday 03 June 2015 15:32:45 Felipe Balbi wrote:
>>>> Hi Tony and Russell,
>>>>
>>>> AM43xx, even though it's a single processor A9, it still has TWD and global
>>>> timer. I was doing some profiling with RT v4.0 and latency is 3.5x lower just
>>>> by switching from gptimer to twd/global.
>>>>
>>>> The only problem is that currently, is_smp() check prevents me from using twd
>>>> with AM43xx (that's why it's commented below, for testing purposes).
>>>>
>>>> In the hopes that we can start a, hopefully, small thread around the subject,
>>>> I'm sending this HACK which I used to get TWD and global timer enabled so I
>>>> could measure latencies with cyclictest.
>>>>
>>>> Is it so that TWD shouldn't be available on UP integrations of ARM's Cortex-A
>>>> processors ?
>>>>
>>>>
>>> I wondered about this recently when looking at something unrelated
>>> and noticed that the check had been introduced as part of
>>> 904464b91eca8 ("ARM: 7655/1: smp_twd: make twd_local_timer_of_register()
>>> no-op for nosmp").
>>>
>>> I suspect this was just the wrong fix at the time, and that the
>>> real culprit is either alloc_percpu() or request_percpu_irq()
>>> getting called too early on a machine without SMP support.
>>>
>>> Possibly the problem is already resolved independently, if you
>>> didn't run into it.
>> no, no splats, nothing at all. See [1]
>>
>> [1] http://hastebin.com/helekubutu
> Adding Shawn
>

Mason was also interested in doing this. See [2]. From what I could tell 
back then, commit 904464b91eca8 was working around the local timer APIs 
that no longer exist.

[2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/389931/focus=392348

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

