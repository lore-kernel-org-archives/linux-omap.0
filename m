From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 5/5] ARM: dts: OMAP5: Specify nonsecure PPI IRQ for arch
 timer
Date: Sat, 19 Jan 2013 22:56:55 +0530
Message-ID: <50FAD75F.9080205@ti.com>
References: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com> <1358523141-12295-6-git-send-email-santosh.shilimkar@ti.com> <50F97207.1030706@arm.com> <50F97FA4.9010608@ti.com> <50F98176.6070703@arm.com> <50F999AA.2020901@ti.com> <e76a7048f02560a90f1e9cdc0181fd43@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48081 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080Ab3ASR0D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Jan 2013 12:26:03 -0500
In-Reply-To: <e76a7048f02560a90f1e9cdc0181fd43@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On Saturday 19 January 2013 08:16 PM, Marc Zyngier wrote:
> On Sat, 19 Jan 2013 00:21:22 +0530, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> On Friday 18 January 2013 10:38 PM, Marc Zyngier wrote:
>>> On 18/01/13 17:00, Santosh Shilimkar wrote:
>>>> On Friday 18 January 2013 09:32 PM, Marc Zyngier wrote:
>>>>> On 18/01/13 15:32, Santosh Shilimkar wrote:
>>>>>> From: Rajendra Nayak <rnayak@ti.com>
>>>>>>
>>>>>> Specify both secure as well as nonsecure PPI IRQ for arch
>>>>>> timer. This fixes the following errors seen on DT OMAP5 boot..
>>>>>>
>>>>>> [    0.000000] arch_timer: No interrupt available, giving up
>>>>>>
>>>>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>>>>>
>>>>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>>> ---
>>>>>>     arch/arm/boot/dts/omap5.dtsi |   16 ++++++++++++----
>>>>>>     1 file changed, 12 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/omap5.dtsi
>>>>>> b/arch/arm/boot/dts/omap5.dtsi
>>>>>> index 790bb2a..7a78d1b 100644
>>>>>> --- a/arch/arm/boot/dts/omap5.dtsi
>>>>>> +++ b/arch/arm/boot/dts/omap5.dtsi
>>>>>> @@ -35,8 +35,12 @@
>>>>>>     			compatible = "arm,cortex-a15";
>>>>>>     			timer {
>>>>>>     				compatible = "arm,armv7-timer";
>>>>>> -				/* 14th PPI IRQ, active low level-sensitive */
>>>>>> -				interrupts = <1 14 0x308>;
>>>>>> +				/*
>>>>>> +				 * PPI secure/nonsecure IRQ,
>>>>>> +				 * active low level-sensitive
>>>>>> +				 */
>>>>>> +				interrupts = <1 13 0x308>,
>>>>>> +					     <1 14 0x308>;
>>>>>
>>>>> Care to add the virtual and HYP timer interrupts? So KVM can get a
>>>>> chance to run on this HW...
>>>>>
>>>> Thanks Marc for spotting it. Will take care of it.
>>>
>>> I just realised something silly... You have one timer node *per cpu*,
>>> and this is not really expected.
>>>
>> This was discussed on the list here [1]
>> Benoit suggested to add per CPU node since arch timer is per
>> CPU and DT should describe the hw the way it is. Did we miss
>> something ?
>
> The current approach is not to duplicate banked resources. We do not have
> duplicated twd-timer nodes on Cortex A9, we do not expose multiple CPU
> interfaces for the GIC...
>
Yes, I have observed that. The arch/twd timer DT extraction code doesn't
expect per CPU DT node and on that basis only, initial patch was
adding single timer node outside cpu node. Benoit comment was that
the DT should describe the way hardware is and probably the DT
extraction code should be updated accordingly.

> And speaking of the GIC: how do you interpret the CPU mask in the
> interrupt field of the timer? The value 0x3xx in the third field is there
> to indicate that CPU0 and CPU1 are getting interrupted by the timer. What
> does it mean when you duplicate it?>          M.
>

>
Here too I have to keep mask for both CPUs because of the current DT
extraction code. I some how forgot to bring that discussion to your
notice. I can update the DT files to go back to the single timer
node if the plan is not to duplicate the per CPU resources.

Benoit,
Whats your take on it ?

Regards
Santosh

