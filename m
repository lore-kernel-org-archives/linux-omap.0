From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 08/10] ARM: OMAP5: hwmod data: Create initial OMAP5 SOC
 hwmod data
Date: Tue, 29 Jan 2013 19:27:00 +0530
Message-ID: <5107D52C.80200@ti.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com> <1358522856-12180-9-git-send-email-santosh.shilimkar@ti.com> <20130118171500.GC15361@atomide.com> <50FCF838.6000105@ti.com> <50FD5993.5010008@ti.com> <20130121180113.GA22517@atomide.com> <50FE8C5C.2030409@ti.com> <20130122183213.GN15361@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50124 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756904Ab3A2N4A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Jan 2013 08:56:00 -0500
In-Reply-To: <20130122183213.GN15361@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, rnayak@ti.com, Paul Walmsley <paul@pwsan.com>

On Wednesday 23 January 2013 12:02 AM, Tony Lindgren wrote:
> * Benoit Cousson <b-cousson@ti.com> [130122 04:59]:
>> Hi Tony,
>>
>> On 01/21/2013 07:01 PM, Tony Lindgren wrote:
>>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130121 07:09]:
>>>>>
>>>> So I looked at this one with help of Rajendra. We can get rid of the
>>>> IRQ and DMA data(needs DMA biding updates) easily. The address
>>>> space though is needed since hwmod code uses it to setup the
>>>> sysconfig registers.
>>>
>>> OK great. The address space tinkering in hwmod code should be
>>> moved to be done in the drivers.
>>>
>>> As discussed earlier, there should be a driver specific reset
>>> function driver_xyz_reset() in the driver header file so the
>>> hwmod code can call it too in a late_initcall if no driver is
>>> loaded.
>>>
>>>> Extracting that from DT code seems to be really expensive and
>>>> ugly [1]. I am yet to try out DMA lines removal but that seems
>>>> to be doable by pulling Vinod'd DMA engine branch and updating
>>>> DT file.
>>>
>>> The overhead here does not matter as it should only happen in a
>>> late_initcall and only for some of the drivers. For that to
>>> happen we just need to go through the list of modules not yet
>>> probed. We also need to have some locking in the driver specific
>>> reset function to avoid races with the loadable modules.
>>
>> Mmm, not really, that address is used by *every* hwmod for sysconfig
>> access. So iterating over every DT nodes for every hwmods seems pretty
>> ugly and un-optimized.
>
> I think you missed one point. Iterating over all the modules should
> only happen for the unused modules. With sysconfig access moved to the
> drivers getting the ioaddress is done in the standard way in the driver
> probe instead of iterating over all of them.
>
>> That being said, it might worth checking the overhead. That will not
>> make the fix nicer anyway, but at least it will allow a smooth
>> transition toward a real clean solution. Assuming someone will work on
>> that later, which might never happen.
>
> Right, so who is going to do all the work needed?
>
OK so we do managed to clean up the address space, IRQ lines
and DMA request lines data from hwmod completely.

-OMAP5 hwmod data file, 2076 lines we could remove which significant
reduction. I ran the same scripts on OMAP4 and there too about 2200
lines getting deleted.

- I have to udapte DT file to add the all supported hwmods with reg
property so that OMAP5 continue to boot. Similar work is needed for
OMAP4 too once OMAP4 is made DT only support.

- To my suprise, the DT lookup isn't that bad. It is adding just
24 milliseconds to the boot time which is more or less noise.

Have pushed a branch with above update for OMAP5 here [1]

So we are left with two other topics which you mentioned in the
comments.

1. Movement of clock data to drivers/clk. Till we get direction here
I would like to hear the alternative to get OMAP5 booting from mainline.
If there is no alternative, we can keep OMAP5 clock data alone
out of tree and get rest of the data files merged.

2. The iormap() done by hwmod for sysconfig handling which you are
discussing with Rajendra. So far we don't have a viable way to
get the iormapped address from device drivers back to platform
code. Lets continue on this thread but this can evolve in
parallel.

Let me know your thoughts.

Regards,
Santosh

[1] git://github.com/SantoshShilimkar/linux.git
3.9/omap5-testing-hwmod-cleanup

