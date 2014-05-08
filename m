From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC 2/4] ARM: dts: Add ctrl-core DT node for DRA7
Date: Thu, 8 May 2014 10:53:49 +0300
Message-ID: <536B380D.7000503@ti.com>
References: <1397654063-8055-1-git-send-email-archit@ti.com> <1397654063-8055-2-git-send-email-archit@ti.com> <20140418171854.GJ5354@atomide.com> <5354A970.8040605@ti.com> <20140421151034.GA23945@atomide.com> <53687198.60405@ti.com> <20140506142606.GA18474@atomide.com> <536B1E12.1080304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39984 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409AbaEHHx6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 03:53:58 -0400
In-Reply-To: <536B1E12.1080304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On 05/08/2014 09:02 AM, Archit Taneja wrote:
> On Tuesday 06 May 2014 07:56 PM, Tony Lindgren wrote:
>> * Archit Taneja <archit@ti.com> [140505 22:24]:
>>> Hi,
>>>
>>> On Monday 21 April 2014 08:40 PM, Tony Lindgren wrote:
>>>> * Archit Taneja <archit@ti.com> [140420 22:16]:
>>>>> Hi,
>>>>>
>>>>> On Friday 18 April 2014 10:48 PM, Tony Lindgren wrote:
>>>>>> * Archit Taneja <archit@ti.com> [140416 06:20]:
>>>>>>> Add DT node for the ctrl-core sub module of the DRA7 control
>>>>>>> module. We map the
>>>>>>> CTRL_MODULE_CORE address region up to 0x4a002d60, this region
>>>>>>> contains register
>>>>>>> fields which configure clocks. The remainder of the registers are
>>>>>>> related to
>>>>>>> pad configurations or cross-bar configurations, and therefore
>>>>>>> aren't mapped.
>>>>>>
>>>>>> Can you please check if this can just use the existing
>>>>>> regmap syscon mapping:
>>>>>>
>>>>>> syscon = <&dra7_ctrl_general>;
>>>>>>
>>>>>> See how the drivers/regulator/pbias-regulator.c is using the
>>>>>> syscon to initialize a regulator and then omap_hsmmc.c just does
>>>>>> the standard regulator calls.
>>>>>
>>>>> The thing is that this bit needs to be set before the the DSS
>>>>> hwmods are
>>>>> reset, and that happens very early. If we don't do this, DSS won't
>>>>> reset
>>>>> properly, and not get back to an idle state.
>>>>>
>>>>> I am not sure where I can configure the syscon register early
>>>>> enough that it
>>>>> happens before the hwmods are reset. With a syscon mapping, I guess
>>>>> we would
>>>>> access the register when the DSS driver is probed. But that's too
>>>>> late for
>>>>> us.
>>>>>
>>>>> Ideally, it would be much better to have a syscon mapping. Do you
>>>>> have any
>>>>> suggestions how this can be achieved very early in boot?
>>>>
>>>> It's best to move the reset and initialization of DSS happen later.
>>>> I believe
>>>> we already are resetting only some of the hwmods early on.
>>>>
>>>
>>> I looked at this in some more detail. With the current hwmod
>>> flags(HWMOD_INIT_NO_RESET/NO_IDLE), we still try to enable the IP,
>>> it's just
>>> the reset part(ocp reset/custom reset and sysc register) or the
>>> disable part
>>> that is skipped. hwmod still tries to enable the IP.
>>>
>>> This again results in the same issue.
>>>
>>> One thing which wasn't clear was that why do we enable a hwmod in the
>>> first
>>> place, if we know that we are going to skip reset?
>>
>> Probably to configure the idle bits. In general, we should configure the
>> modules lazily as the driver probes as requested, and then idle the
>> unused modules with a late_initcall.
>
> Okay, we were thinking of changing the hwmod code to skip enable for
> hwmods(which have the HWMOD_INIT_NO_RESET flag) altogether. But that
> doesn't seem like a viable option.
>
> I can't think of any other way of getting around this, besides making
> control module a clock provider.
>
> Paul said that it's not that bad to make DRA7 CTRL module a clock
> provider, but outside of PRCM code. I guess that would involve having
> something along the lines of of_prcm_init() in mach-omap2/control.c

That sounds like pretty much one of the things I have done here:

https://github.com/t-kristo/linux-pm/tree/3.14-rc4-cm-prm-driver-wip

The patches in their current form haven't been posted yet though, as 
they are waiting for some of the pre-reqs, but feel free to re-use 
something from here.

-Tero

>
> Archit
>
>
> Archit
>

