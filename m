From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 4/6] irqchip/irq-pruss-intc: Add helper functions to
 configure internal mapping
Date: Wed, 17 Jul 2019 14:04:33 -0500
Message-ID: <a9162fd9-dc3c-57a9-8390-d92362674178@ti.com>
References: <20190708035243.12170-1-s-anna@ti.com>
 <20190708035243.12170-5-s-anna@ti.com>
 <9aa5acd8-81bf-10dc-5a86-cea2acd1132b@lechnology.com>
 <23ae1767-3531-ea57-2c82-f2657baa123f@ti.com>
 <22825f06-d968-03a7-585b-8cbf4123915c@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22825f06-d968-03a7-585b-8cbf4123915c@lechnology.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: Tony Lindgren <tony@atomide.com>, "Andrew F. Davis" <afd@ti.com>, Roger Quadros <rogerq@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Sekhar Nori <nsekhar@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 7/17/19 12:57 PM, David Lechner wrote:
> On 7/16/19 6:29 PM, Suman Anna wrote:
>> Hi David,
>>
>> On 7/10/19 10:10 PM, David Lechner wrote:
>>> On 7/7/19 10:52 PM, Suman Anna wrote:
>>>> The PRUSS INTC receives a number of system input interrupt source
>>>> events
>>>> and supports individual control configuration and hardware
>>>> prioritization.
>>>> These input events can be mapped to some output host interrupts
>>>> through 2
>>>> levels of many-to-one mapping i.e. events to channel mapping and
>>>> channels
>>>> to host interrupts.
>>>>
>>>> This mapping information is provided through the PRU firmware that is
>>>> loaded onto a PRU core/s or through the device tree node of the PRU
>>>
>>
>> Thanks for the thorough review and alternate solutions/suggestions.
>>
>>> What will the device tree bindings for this look like?
>>
>> They would be as in the below patch you already figured.
> 
> Ah, makes sense now: the mapping is defined in the remoteproc node
> rather than in the interrupt controller node.

Actually in the PRU consumer/application node, but the client driver
need not deal with invoking any special API. The functions are called
transparently by the PRU remoteproc driver when the PRU client driver
acquires a PRU. The 4th cell was used to identify the PRU from the list
of prus in the client node.

regards
Suman

> 
>>
>>>
>>> Looking back at Rob's comment on the initial series [1], I still think
>>> that increasing the #interrupt-cells sounds like a reasonable solution.
>>>
>>> [1]: https://patchwork.kernel.org/patch/10697705/#22375155
>>
>> So, there are couple of reasons why I did not use an extended
>> #interrupt-cells:
>>
>> 1. There is only one irq descriptor associated with each event, and the
>> usage of events is typically per application. And the descriptor mapping
>> is done once. We can have two different applications use the same event
>> with different mappings. So we want this programming done at
>> application's usage of PRU (so done when a consumer driver acquires a
>> PRU processor(s) which are treated as an exclusive resource). All the
>> different application properties that you saw in [1] are configured at
>> the time of acquiring a PRU and reset when they release a PRU.
>>
>> 2. The configuration is performed by Linux for all host interrupts and
>> channels, and this was primarily done to save the very limited IRAM
>> space for those needed by the PRUs. From firmware's point of view, this
>> was offloaded to the ARM OS driver/infrastructure, but in general it is
>> a design by contract between a PRU client driver and its firmware. Also,
>> the DT binding semantics using interrupts property and request_irq()
>> typically limits these to interrupts only being requested by MPU, and so
>> will leave out those needed by PRUs.
>>
> 
> Hmm... case 1. is a tricky one indeed. If there are going to be times where
> an event requires multiple mappings, I agree that this doesn't seem to fit
> into any existing device tree bindings.
> 
> 
