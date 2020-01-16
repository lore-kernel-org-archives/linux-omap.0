From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] clocksource: timer-ti-dm: Fix regression
Date: Thu, 16 Jan 2020 14:32:50 +0100
Message-ID: <d42f0dbc-a93e-8ca0-978c-56c32f2362cd@linaro.org>
References: <20200106203700.21009-1-tony@atomide.com>
 <CA+G9fYvRNiFK54oiGt9hYP=RTfazf2E7rmnnkwP+ELMUYtJ7bQ@mail.gmail.com>
 <3d6da16f-45e6-5acd-021c-bc87da99cdec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43961 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAPNcz (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jan 2020 08:32:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so19167928wre.10
        for <linux-omap@vger.kernel.org>; Thu, 16 Jan 2020 05:32:53 -0800 (PST)
In-Reply-To: <3d6da16f-45e6-5acd-021c-bc87da99cdec@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, open list <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Yangtao Li <tiny.windzz@gmail.com>

On 16/01/2020 04:46, Keerthy wrote:
> 
> 
> On 11/01/20 11:58 am, Naresh Kamboju wrote:
>> On Tue, 7 Jan 2020 at 02:07, Tony Lindgren <tony@atomide.com> wrote:
>>>
>>> Clean-up commit 8c82723414d5 ("clocksource/drivers/timer-ti-dm:
>>> Switch to
>>> platform_get_irq") caused a regression where we now try to access
>>> uninitialized data for timer:
>>>
>>> drivers/clocksource/timer-ti-dm.c: In function 'omap_dm_timer_probe':
>>> drivers/clocksource/timer-ti-dm.c:798:13: warning: 'timer' may be used
>>> uninitialized in this function [-Wmaybe-uninitialized]
>>>
>>> On boot we now get:
>>>
>>> Unable to handle kernel NULL pointer dereference at virtual address
>>> 00000004
>>> ...
>>> (omap_dm_timer_probe) from [<c061ac7c>] (platform_drv_probe+0x48/0x98)
>>> (platform_drv_probe) from [<c0618c04>] (really_probe+0x1dc/0x348)
>>> (really_probe) from [<c0618ef4>] (driver_probe_device+0x5c/0x160)
>>>
>>> Let's fix the issue by moving platform_get_irq to happen after timer has
>>> been allocated.
>>>
>>> Fixes: 8c82723414d5 ("clocksource/drivers/timer-ti-dm: Switch to
>>> platform_get_irq")
>>
>> Thanks for fixing this issue.
>> I have noticed arm BeagleBoard-X15 boot failed on linux next tree
>> (5.5.0-rc5-next-20200110).
>>
>> [    6.157822] 8<--- cut here ---
>> [    6.160911] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000004
>> [    6.169120] pgd = 25d83e32
>> [    6.171903] [00000004] *pgd=80000080204003, *pmd=00000000
>> [    6.177358] Internal error: Oops: a06 [#1] SMP ARM
>> [    6.182179] Modules linked in:
>> [    6.185260] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>> 5.5.0-rc5-next-20200110 #1
>> [    6.192694] Hardware name: Generic DRA74X (Flattened Device Tree)
>> [    6.198832] PC is at omap_dm_timer_probe+0x48/0x310
> 
> Tony/Daniel,
> 
> This is still not in linux-next. Any idea when this will be pushed to
> linux-next branch?

It should be actually.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
