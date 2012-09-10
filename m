From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP5: Enable arch timer support
Date: Mon, 10 Sep 2012 15:14:03 +0200
Message-ID: <504DE79B.3090302@ti.com>
References: <1344856045-15134-1-git-send-email-santosh.shilimkar@ti.com> <1344856045-15134-3-git-send-email-santosh.shilimkar@ti.com> <504DE165.4000208@ti.com> <CAMQu2gxE8e9RBykLDyukZwV7dPKv3nG1vCynO1pijUBXBnyq8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36018 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab2IJNOF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 09:14:05 -0400
In-Reply-To: <CAMQu2gxE8e9RBykLDyukZwV7dPKv3nG1vCynO1pijUBXBnyq8Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.orig, tony@atomide.com

On 09/10/2012 03:01 PM, Shilimkar, Santosh wrote:
> On Mon, Sep 10, 2012 at 6:17 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>>
>> Hi Santosh,
>>
>> On 08/13/2012 01:07 PM, Santosh Shilimkar wrote:
>>> Enable Cortex A15 generic timer support for OMAP5 based SOCs.
>>> The CPU local timers run on the free running real time counter clock.
>>>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
>>>  arch/arm/boot/dts/omap5.dtsi |    6 ++++++
>>>  arch/arm/mach-omap2/Kconfig  |    1 +
>>>  arch/arm/mach-omap2/timer.c  |    7 +++++++
>>>  3 files changed, 14 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>>> index 57e5270..9686056 100644
>>> --- a/arch/arm/boot/dts/omap5.dtsi
>>> +++ b/arch/arm/boot/dts/omap5.dtsi
>>> @@ -73,6 +73,12 @@
>>>                             <0x48212000 0x1000>;
>>>               };
>>>
>>> +             arch-timer {
>>
>> arch-timer is the ARM specific name, so I guess here it should be named
>> with the generic timer name.
>>
> is "local_timer" name fine then?

No, *timer* is fine. The point here is to provide the generic name when
it exists. That name is supposed to be the general class of the device.

Potentially you can add a label to give an unique name, but since that
label will not be used elsewhere it is not even needed.

arch-timer: timer { ... }

> 
>>> +                     compatible = "arm,armv7-timer";
>>> +                     interrupts = <1 14 0x304>;
>>
>> Could you add some comment, because these hexa value are a little bit
>> hard to understand.
>>
> OK. Will add some comments.
> 
>>> +                     clock-frequency = <6140000>;
>>> +             };
>>> +
>>
>> That node does not even have a base address?
>> If this is located inside the MPU, it should not be in the OCP node.
>>
> Its inside MPU and Cp15 control based. No OCP node.

OK, so you must move it inside the CPU node.

>> Silly question: Don't we have one arch-timer per CPU?
>>
> It is per CPU just like A9 TWD

Shouldn't we have two nodes then?

Regards,
Benoit


