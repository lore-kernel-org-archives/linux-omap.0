From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging
 of backup battery
Date: Wed, 6 Jan 2016 08:36:07 -0600
Message-ID: <568D2657.6050400@ti.com>
References: <cover.1451995297.git.hns@goldelico.com>
 <b4a6fe205cbb1a9eddc4e5f63fa05d299641313d.1451995297.git.hns@goldelico.com>
 <568C5451.8070709@ti.com>
 <B2CEA92E-5F60-43C1-8265-F7C66FBD90D6@goldelico.com>
 <568CCCA2.4040004@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <568CCCA2.4040004@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

On 01/06/2016 02:13 AM, Laxman Dewangan wrote:
> 
> On Wednesday 06 January 2016 01:12 PM, H. Nikolaus Schaller wrote:
>> Hi,
>>
>> Am 06.01.2016 um 00:40 schrieb Nishanth Menon <nm@ti.com>:
>>
>>> On 01/05/2016 06:01 AM, H. Nikolaus Schaller wrote:
>>>> +        rtc {
>>>> +            compatible = "ti,palmas-rtc";
>>>> +            interrupt-parent = <&palmas>;
>>>> +            interrupts = <8 IRQ_TYPE_NONE>;
>>> IRQ_TYPE_NONE is not correct here -> it should have some polarity - if
>>> it had none, there'd be no interrupt, right?
>> Well, it just translates IRQ_TYPE_NONE through
>>
>> Linux/include/dt-bindings/interrupt-controller/irq.h
>>
>> to
>>
>> interrupts = <8 0>;
>>
>> which is given as an example in
>>
>> Documentation//devicetree/bindings/rtc/rtc-palmas.txt
>>
>> Since I don't know anything about the rtc driver beyond the bindings
>> documentation I assume it is correct...
>> I have added Laxman Dewangan because he introduced this interrupts =
>> <8 0>;
>>
> 
> As this is for palmas interrupt controller, it does not use the second
> field for interrupt from RTC.
> So there is no really any polarity. It can be set to 0.
> 
> The second argument will be used for GPIOs mainly. However, support need
> to be added on GPIO driver for rising/falling configuration.


Device tree represents the hardware - not to reflect how the driver
works. if the driver is wrong, fix it. the interrupt polarity needs to
be described in DT. based on palmas like designs, you should probably
use IRQ_TYPE_EDGE_FALLING because that is the default signaling inside
the SoC as it reaches Secondary interrupt handlers(SIH) registers.

-- 
Regards,
Nishanth Menon
