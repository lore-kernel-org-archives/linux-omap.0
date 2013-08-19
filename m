From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 05/31] CLK: TI: add support for OMAP gate clock
Date: Mon, 19 Aug 2013 19:19:26 +0300
Message-ID: <5212458E.906@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com> <1375460751-23676-6-git-send-email-t-kristo@ti.com> <20130813110437.GK27165@e106331-lin.cambridge.arm.com> <521220AD.4070308@ti.com> <20130819142959.GP3719@e106331-lin.cambridge.arm.com> <52122F03.5050602@ti.com> <20130819155830.GR3719@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35028 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897Ab3HSQT6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Aug 2013 12:19:58 -0400
In-Reply-To: <20130819155830.GR3719@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "nm@ti.com" <nm@ti.com>, "rnayak@ti.com" <rnayak@ti.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 08/19/2013 06:58 PM, Mark Rutland wrote:
> On Mon, Aug 19, 2013 at 03:43:15PM +0100, Tero Kristo wrote:
>> On 08/19/2013 05:29 PM, Mark Rutland wrote:
>>> On Mon, Aug 19, 2013 at 02:42:05PM +0100, Tero Kristo wrote:
>>>> On 08/13/2013 02:04 PM, Mark Rutland wrote:
>>>>> On Fri, Aug 02, 2013 at 05:25:24PM +0100, Tero Kristo wrote:
>>>>>> This node adds support for a clock node which allows control to the
>>>>>> clockdomain enable / disable.
>>>>>>
>>>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>>>> ---
>>>>>>     .../devicetree/bindings/clock/ti/gate.txt          |   41 ++++++++
>>>>>>     arch/arm/mach-omap2/clock.h                        |    9 --
>>>>>>     drivers/clk/ti/Makefile                            |    2 +-
>>>>>>     drivers/clk/ti/gate.c                              |  106 ++++++++++++++++++++
>>>>>>     include/linux/clk/ti.h                             |    8 ++
>>>>>>     5 files changed, 156 insertions(+), 10 deletions(-)
>>>>>>     create mode 100644 Documentation/devicetree/bindings/clock/ti/gate.txt
>>>>>>     create mode 100644 drivers/clk/ti/gate.c
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/clock/ti/gate.txt b/Documentation/devicetree/bindings/clock/ti/gate.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..620a73d
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/clock/ti/gate.txt
>>>>>> @@ -0,0 +1,41 @@
>>>>>> +Binding for Texas Instruments gate clock.
>>>>>> +
>>>>>> +This binding uses the common clock binding[1]. This clock is
>>>>>> +quite much similar to the basic gate-clock [2], however,
>>>>>> +it supports a number of additional features. If no register
>>>>>> +is provided for this clock, the code assumes that a clockdomain
>>>>>> +will be controlled instead and the corresponding hw-ops for
>>>>>> +that is used.
>>>>>> +
>>>>>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>>>>>> +[2] Documentation/devicetree/bindings/clock/gate-clock.txt
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- compatible : shall be "ti,gate-clock"
>>>>>> +- #clock-cells : from common clock binding; shall be set to 0
>>>>>> +- clocks : link to phandle of parent clock
>>>>>> +
>>>>>> +Optional properties:
>>>>>> +- reg : base address for register controlling adjustable gate
>>>>>
>>>>> Optional? That's odd. If I have a clock with registers, but don't
>>>>> specify the register, will it still work? i.e. are registerless clocks
>>>>> really compatible with clocks with registers?.
>>>>
>>>> I think I implemented this in somewhat confusing manner. This could be
>>>> split to:
>>>>
>>>> ti,gate-clock:
>>>>      requires reg and ti,enable-bit info
>>>> ti,clkdm-clock:
>>>>      requires ti,clkdm-name
>>>>
>>>> clkdm clock is kind of a master clock for clockdomain, the clock is
>>>> provided always if the clockdomain is active.
>>>
>>> Ok.
>>>
>>>>
>>>>>
>>>>>> +- ti,enable-bit : bit shift for programming the clock gate
>>>>>
>>>>> Why is this needed? Does the hardware vary wildly, or are several clocks
>>>>> sharing the same register(s)?
>>>>
>>>> Yea, same register is shared.
>>>
>>> Ok. Are those gate clocks are part of a larger "gate clocks" block, with
>>> the register that controls them? or are they really independent? Does
>>> the register control other items too?
>>
>> Not really. Typically they only have the clockdomain in common, and the
>> individual clocks are mostly controlled independently from each other.
>> For example on omap3 we have following register:
>
> You say they typically only have the clockdomain in common. Do you mean
> that they always have the same clockdomain, but not necessarily other
> properties, or may they not even have the clockdomain in common?

Currently it seems if the clocks share a register, they are in the same 
clockdomain (I guess this is something that might also change in 
future.) The input clocks can be different (some are using the same), 
and the outputs are routed to different destinations on the SoC. For the 
below example, GPTs can have either sys_ck or 32k_ck as parent, UARTs 
are fed from 48M clock etc.

>
>>
>> CM_FCLKEN_PER
>> Physical Address 0x4800 5000
>> BIT31:19 RESERVED Write 0s for future compatibility. Read returns 0.
>> BIT18 EN_UART4 UART4 functional clock control.
>> BIT17 EN_GPIO6 GPIO6 functional clock control.
>> BIT16 EN_GPIO5 GPIO5 functional clock control.
>> BIT15 EN_GPIO4 GPIO4 functional clock control.
>> BIT14 EN_GPIO3 GPIO3 functional clock control.
>> BIT13 EN_GPIO2 GPIO2 functional clock control.
>> BIT12 EN_WDT3 WDT3 functional clock control.
>> BIT11 EN_UART3 Type UART3 functional clock control.
>> BIT10 EN_GPT9 GPTIMER 9 functional clock control.
>> BIT9 EN_GPT8 GPTIMER 8 functional clock control.
>> BIT8 EN_GPT7 GPTIMER 7 functional clock control.
>> BIT7 EN_GPT6 GPTIMER 6 functional clock control.
>> BIT6 EN_GPT5 GPTIMER 5 functional clock control.
>> BIT5 EN_GPT4 GPTIMER 4 functional clock control.
>> BIT4 EN_GPT3GPTIMER 3 functional clock control.
>> BIT3 EN_GPT2 GPTIMER 2 functional clock control.
>> BIT2 EN_MCBSP4 McBSP 4 functional clock control.
>> BIT1 EN_MCBSP3 McBSP3 functional clock control.
>> BIT0 EN_MCBSP2 McBSP 2 functional clock control.
>>
>> So multiple drivers will be using this register for example.
>
> The point I was trying to get across is that this looks like a single
> logical block which controls the (independent) gating of several clocks,
> along the same lines as multiple swtiches bound together in a DIP
> switch.
>
> It's equally valid to view that as several clock gates which happen to
> have their control bits in close proximity in the memory map, as you
> suggest.

For clarity, I think it is better to have the clocks as separate nodes, 
as otherwise specifying the mapping for individual clocks becomes a pain 
for the layers that are going to use the clock mapping. You would end up 
with obfuscated name for UART3 / GPTIMER5 for example, and this would be 
rather error prone approach also if I understand your point correctly.

-Tero

>
> Thanks,
> Mark.
>

