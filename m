From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH] save and restore etm state across core OFF modes
Date: Mon, 18 Jan 2010 07:47:16 -0600
Message-ID: <4B546664.2080907@gmail.com>
References: <1263315891-4440-1-git-send-email-virtuoso@slind.org> <4B4CADA9.4020502@ti.com> <20100112173022.GG29059@shisha.kicks-ass.net> <4B4CB259.2010301@ti.com> <20100112210404.GB2986@atomide.com> <20100112214654.GH29059@shisha.kicks-ass.net> <4B4CF2D7.9000200@ti.com> <20100113113616.GI29059@shisha.kicks-ass.net> <4B4DC374.1010909@gmail.com> <20100118104659.GN29059@shisha.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:44385 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab0ARNrX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 08:47:23 -0500
Received: by yxe17 with SMTP id 17so3563431yxe.33
        for <linux-omap@vger.kernel.org>; Mon, 18 Jan 2010 05:47:22 -0800 (PST)
In-Reply-To: <20100118104659.GN29059@shisha.kicks-ass.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linu>

Alexander Shishkin said the following on 01/18/2010 04:46 AM:
> On Wed, Jan 13, 2010 at 06:58:28 -0600, Nishanth Menon wrote:
>> Alexander Shishkin said the following on 01/13/2010 05:36 AM:
>>> On Tue, Jan 12, 2010 at 04:08:23 -0600, Nishanth Menon wrote:
>>>> Alexander Shishkin had written, on 01/12/2010 03:46 PM, the following:
>>>>> On Tue, Jan 12, 2010 at 01:04:04 -0800, Tony Lindgren wrote:
>>>>>> * Nishanth Menon <nm@ti.com> [100112 09:31]:
>>>>>>> Alexander Shishkin had written, on 01/12/2010 11:30 AM, the following:
>>>>>>>> On Tue, Jan 12, 2010 at 11:13:13 -0600, Nishanth Menon wrote:
>>>>>>>>> Alexander Shishkin had written, on 01/12/2010 11:04 AM, the following:
>>>>>>>>>> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
>>>>>>>>>> index 69521be..0a5ec86 100644
>>>>>>>>>> --- a/arch/arm/mach-omap2/sleep34xx.S
>>>>>>>>>> +++ b/arch/arm/mach-omap2/sleep34xx.S
>>>>>>> [...]
>>>>>>>>>> 	/* Store current cpsr*/
>>>>>>>>>> 	mrs	r2, cpsr
>>>>>>>>>> 	stmia	r8!, {r2}
>>>>>>>>>> @@ -520,6 +616,7 @@ clean_caches:
>>>>>>>>>> 	cmp	r9, #1 /* Check whether L2 inval is required or not*/
>>>>>>>>>> 	bne	skip_l2_inval
>>>>>>>>>> clean_l2:
>>>>>>>>>> +#if 0
>>>>>>>>> my aversion to #if 0 kicks in here :(.. do we have an alternative
>>>>>>>>> like using the CONFIG_ENABLE_OFF_MODE_JTAG_ETM_DEBUG or something
>>>>>>>>> else?
>>>>>>>> Fair enough. I could replace it with "#if !defined(...)" as the first
>>>>>>>> thing that comes to mind. This way it will only take disabling the
>>>>>>>> config option to catch any possible regressions in between. Does this
>>>>>>>> sound reasonable?
>>>>>>> sounds ok to me.. unless folks have ideas coz of clean_l2 label..
>>>>>>> more comments might be useful before a rev2 of the patch..
>>>>>> The best solution would be to be able to toggle this via sysfs or
>>>>>> debugfs by swapping the sram code for idle loop when JTAG support
>>>>>> is needed.
>>>>> Well, if you say, compile the ETM driver in, this will be needed most of
>>>>> the time.
>>>>>
>>>> I can think of reasons for an against a sysfs entry (as part of
>>>> discussion -warning lot of self contradictions below- but I think
>>>> might save a bit of back and froth ;)):
>>>>
>>>> for sysfs entry:
>>>> a) save and restore will have additional latency when you save a
>>>> chunk such as EMU domain regs - this will not be needed in
>>>> production phones, disabling it might pop up surprises
>>>> 	counter: having a disabled defconfig allows relevant folks to
>>>> 	enable on a need basis
>>>> 		counter to counter: what do you do when a user reports
>>>> 		an issue in a release and you'd want to debug it with 		
>>>> 		ETM on his platform other than doing a rebuild?
>>> Well, my intention is to have it enabled for most of the cases only having
>>> it disabled for testing purposes.
>> with a sysfs you can go either way, with proper #ifdeferry, you can
>> get the best of all worlds I guess.. I know in one of the products,
>> a similar patch was not taken in due to introduction of additional
>> scratchpad space and latencies - so there are folks who would like
>> this and those who would like to see this not present in the binary
>> they flash to thier device.
> 
> What would you suggest for a place in sysfs for such a file? I'm thinking
> /sys/power.
I would have imagined this is a perfect candidate for debugfs?
Regards,
Nishanth Menon
