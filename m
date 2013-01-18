From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 5/5] ARM: dts: OMAP5: Specify nonsecure PPI IRQ for arch
 timer
Date: Fri, 18 Jan 2013 17:08:06 +0000
Message-ID: <50F98176.6070703@arm.com>
References: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com> <1358523141-12295-6-git-send-email-santosh.shilimkar@ti.com> <50F97207.1030706@arm.com> <50F97FA4.9010608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:51841 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab3ARRIO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 12:08:14 -0500
In-Reply-To: <50F97FA4.9010608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 18/01/13 17:00, Santosh Shilimkar wrote:
> On Friday 18 January 2013 09:32 PM, Marc Zyngier wrote:
>> On 18/01/13 15:32, Santosh Shilimkar wrote:
>>> From: Rajendra Nayak <rnayak@ti.com>
>>>
>>> Specify both secure as well as nonsecure PPI IRQ for arch
>>> timer. This fixes the following errors seen on DT OMAP5 boot..
>>>
>>> [    0.000000] arch_timer: No interrupt available, giving up
>>>
>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>>
>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
>>>   arch/arm/boot/dts/omap5.dtsi |   16 ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>>> index 790bb2a..7a78d1b 100644
>>> --- a/arch/arm/boot/dts/omap5.dtsi
>>> +++ b/arch/arm/boot/dts/omap5.dtsi
>>> @@ -35,8 +35,12 @@
>>>   			compatible = "arm,cortex-a15";
>>>   			timer {
>>>   				compatible = "arm,armv7-timer";
>>> -				/* 14th PPI IRQ, active low level-sensitive */
>>> -				interrupts = <1 14 0x308>;
>>> +				/*
>>> +				 * PPI secure/nonsecure IRQ,
>>> +				 * active low level-sensitive
>>> +				 */
>>> +				interrupts = <1 13 0x308>,
>>> +					     <1 14 0x308>;
>>
>> Care to add the virtual and HYP timer interrupts? So KVM can get a
>> chance to run on this HW...
>>
> Thanks Marc for spotting it. Will take care of it.

I just realised something silly... You have one timer node *per cpu*,
and this is not really expected.

The driver really wants one single node. See
arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts for an example.

Oh, and your GIC node could do with some updating too (no VGIC regs or
interrupt).

	M.
-- 
Jazz is not dead. It just smells funny...

