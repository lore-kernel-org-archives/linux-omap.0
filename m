From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] omap2plus: wdt: Fix boot warn when CONFIG_PM_RUNTIME=n
Date: Tue, 12 Oct 2010 15:09:34 +0200
Message-ID: <4CB45E0E.6080104@ti.com>
References: <1286798556-22749-1-git-send-email-charu@ti.com> <4CB40B07.8080301@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB030CFC553C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60687 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860Ab0JLNJi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Oct 2010 09:09:38 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CFC553C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>, Paul Walmsley <paul@pwsan.com>, kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Adding more folks to the discussion.

On 10/12/2010 9:30 AM, Varadarajan, Charulatha wrote:
>
>> From: Cousson, Benoit
>> Sent: Tuesday, October 12, 2010 12:45 PM
>> To: Varadarajan, Charulatha
>>
>> Hi Charu,
>>
>> On 10/11/2010 2:02 PM, Varadarajan, Charulatha wrote:
>>> Fix the below warning during boot
>>>
>>> [    0.000000] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1185
>> _omap_hwmod_enable+0x34/0x150()
>>> [    0.000000] omap_hwmod: wd_timer2: enabled state can only be entered
>> from initialized, idle, or disabled state
>>> [    0.000000] Modules linked in:
>>> [    0.000000] [<c0050460>] (unwind_backtrace+0x0/0xe4) from
>> [<c0083954>] (warn_slowpath_common+0x4c/0x64)
>>> [    0.000000] [<c0083954>] (warn_slowpath_common+0x4c/0x64) from
>> [<c00839ec>] (warn_slowpath_fmt+0x2c/0x3c)
>>> [    0.000000] [<c00839ec>] (warn_slowpath_fmt+0x2c/0x3c) from
>> [<c0059be4>] (_omap_hwmod_enable+0x34/0x150)
>>> [    0.000000] [<c0059be4>] (_omap_hwmod_enable+0x34/0x150) from
>> [<c0059d28>] (omap_hwmod_enable+0x28/0x3c)
>>> [    0.000000] [<c0059d28>] (omap_hwmod_enable+0x28/0x3c) from
>> [<c005580c>] (omap2_disable_wdt+0x48/0xdc)
>>> [    0.000000] [<c005580c>] (omap2_disable_wdt+0x48/0xdc) from
>> [<c0058898>] (omap_hwmod_for_each_by_class+0x60/0xa4)
>>> [    0.000000] [<c0058898>] (omap_hwmod_for_each_by_class+0x60/0xa4)
>> from [<c000f6d0>] (omap2_init_devices+0x44/0x330)
>>> [    0.000000] [<c000f6d0>] (omap2_init_devices+0x44/0x330) from
>> [<c0049578>] (do_one_initcall+0xcc/0x1a4)
>>> [    0.000000] [<c0049578>] (do_one_initcall+0xcc/0x1a4) from
>> [<c0008780>] (kernel_init+0x148/0x210)
>>> [    0.000000] [<c0008780>] (kernel_init+0x148/0x210) from [<c004acb8>]
>> (kernel_thread_exit+0x0/0x8)
>>> [    0.000000] ---[ end trace 1b75b31a2719ed1f ]---
>>> [    0.000000] wd_timer2: Could not enable clocks for omap2_disable_wdt
>>>
>>> When CONFIG_PM_RUNTIME is not defined, watchdog timer clocks are not
>>> disabled after a watchdog reset. Hence in omap2_disable_wdt(), it is
>>> not required to enable clocks before accessing the watchdog timer
>>> registers if CONFIG_PM_RUNTIME is not defined.
>>
>> I'm not a big fan of adding some dependencies with CONFIG_PM_RUNTIME
>> inside this code.
>>
>> The real root cause is not CONFIG_PM_RUNTIME, but mostly the
>> skip_setup_idle variable added in arch/arm/mach-omap2/io.c by Paul.
>
> Yes.
>
>>
>> So I'd rather use that parameter as an input for the omap2_disable_wdt.
>
> I also thought about this, but we need to
>
> 1. call omap2_disable_wdt() in omap2_init_common_hw() rather than
> omap2_init_devices(). That would involve movement of
> omap2_disable_wdt() from devices.c to io.c.
> (or)
> 2. make skip_setup_idle global
> (or)
> 3. make omap2_disable_wdt() global and call it from
> omap2_init_common_hw() and pass skip_setup_idle as parameter.
>
> I felt that the usage of CONFIG_PM_RUNTIME is better than the above.
> But still we may consider any of the above options or any other
> option. Please suggest.

It is maybe easier, but I don't think it is better...

As I said, CONFIG_PM_RUNTIME is not the root cause of your issue, just 
an indirect cause. OK, maybe strictly speaking, it is the root cause, 
since it started for that... but that not the cause that we should 
consider in your case.

If we decide to remove that CONFIG_PM_RUNTIME dependency in the io / 
hwmod code, nobody will be able to find the relation with your code in WDT.

That's why you should not do that, for my point of view.

Paul, Kevin,
Any thoughts on that point?

Thanks,
Benoit

>
>>
>> Regards,
>> Benoit
>>
>>
>>
>>>
>>> Tested on OMAP3430 SDP and OMAP4430 SDP.
>>>
>>> Signed-off-by: Charulatha V<charu@ti.com>
>>> ---
>>>    arch/arm/mach-omap2/devices.c |    6 +++++-
>>>    1 files changed, 5 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-
>> omap2/devices.c
>>> index eaf3799..b592952 100644
>>> --- a/arch/arm/mach-omap2/devices.c
>>> +++ b/arch/arm/mach-omap2/devices.c
>>> @@ -926,7 +926,7 @@ static inline void omap_init_vout(void) {}
>>>    static int omap2_disable_wdt(struct omap_hwmod *oh, void *unused)
>>>    {
>>>    	void __iomem *base;
>>> -	int ret;
>>> +	int ret = 0;
>>>
>>>    	if (!oh) {
>>>    		pr_err("%s: Could not look up wdtimer_hwmod\n", __func__);
>>> @@ -940,6 +940,7 @@ static int omap2_disable_wdt(struct omap_hwmod *oh,
>> void *unused)
>>>    		return -EINVAL;
>>>    	}
>>>
>>> +#ifdef CONFIG_PM_RUNTIME
>>>    	/* Enable the clocks before accessing the WDT registers */
>>>    	ret = omap_hwmod_enable(oh);
>>>    	if (ret) {
>>> @@ -947,6 +948,7 @@ static int omap2_disable_wdt(struct omap_hwmod *oh,
>> void *unused)
>>>    				oh->name, __func__);
>>>    		return ret;
>>>    	}
>>> +#endif
>>>
>>>    	/* sequence required to disable watchdog */
>>>    	__raw_writel(0xAAAA, base + OMAP_WDT_SPR);
>>> @@ -957,10 +959,12 @@ static int omap2_disable_wdt(struct omap_hwmod *oh,
>> void *unused)
>>>    	while (__raw_readl(base + OMAP_WDT_WPS)&   0x10)
>>>    		cpu_relax();
>>>
>>> +#ifdef CONFIG_PM_RUNTIME
>>>    	ret = omap_hwmod_idle(oh);
>>>    	if (ret)
>>>    		pr_err("%s: Could not disable clocks for %s\n",
>>>    				oh->name, __func__);
>>> +#endif
>>>
>>>    	return ret;
>>>    }
>

