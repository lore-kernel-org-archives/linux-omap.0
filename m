From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2 04/14] irqchip: pruss: Add a PRUSS irqchip driver for
 PRUSS interrupts
Date: Wed, 13 Feb 2019 20:16:34 -0600
Message-ID: <cb1cdaf1-afeb-0bce-5566-2859ee1df5e8@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-5-git-send-email-rogerq@ti.com>
 <20190204181518.GN5720@atomide.com> <5C596700.1010000@ti.com>
 <86sgx2ts28.wl-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86sgx2ts28.wl-marc.zyngier@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, ohad@wizery.com, bjorn.andersson@linaro.org, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-omap@vger.kernel.org

On 2/5/19 5:04 AM, Marc Zyngier wrote:
> On Tue, 05 Feb 2019 10:35:44 +0000,
> Roger Quadros <rogerq@ti.com> wrote:
>>
>> On 04/02/19 20:15, Tony Lindgren wrote:
>>> * Roger Quadros <rogerq@ti.com> [190204 14:23]:
>>>> From: "Andrew F. Davis" <afd@ti.com>
>>>>
>>>> The Programmable Real-Time Unit Subsystem (PRUSS) contains an
>>>> interrupt controller (INTC) that can handle various system input
>>>> events and post interrupts back to the device-level initiators.
>>>> The INTC can support upto 64 input events with individual control
>>>> configuration and hardware prioritization. These events are mapped
>>>> onto 10 interrupt signals through two levels of many-to-one mapping
>>>> support. Different interrupt signals are routed to the individual
>>>> PRU cores or to the host CPU.
>>>>
>>>> The PRUSS INTC platform driver manages this PRUSS interrupt
>>>> controller and implements an irqchip driver to provide a Linux
>>>> standard way for the PRU client users to enable/disable/ack/
>>>> re-trigger a PRUSS system event. The system events to interrupt
>>>> channels and host interrupts relies on the mapping configuration
>>>> provided through a firmware resource table for now. This will be
>>>> revisited and enhanced in the future for a better interface. The
>>>> mappings will currently be programmed during the boot/shutdown
>>>> of the PRU.
>>>>
>>>> The PRUSS INTC module is reference counted during the interrupt
>>>> setup phase through the irqchip's irq_request_resources() and
>>>> irq_release_resources() ops. This restricts the module from being
>>>> removed as long as there are active interrupt users.
>>>>
>>>> The PRUSS INTC can generate an interrupt to various processor
>>>> subsystems on the SoC through a set of 64 possible PRU system
>>>> events. These system events can be used by PRU client drivers
>>>> or applications for event notifications/signalling between PRUs
>>>> and MPU or other processors. An API, pruss_intc_trigger() is
>>>> provided to MPU-side PRU client drivers/applications to be able
>>>> to trigger an event/interrupt using IRQ numbers provided by the
>>>> PRUSS-INTC irqdomain chip.
>>>
>>> I suggest you send the binding patch and the interrupt
>>> controller driver separately to the irqchip guys. Maybe
>>> put the trigger function in to a separate patch that can
>>> be reviewed and applied separately.
>>
>> Good idea. I will send irqchip related patches separately.
> 
> Yes please. But also please document why you have so many non
> irq-related entry points in this irqchip driver. It seems to replicate
> the same "events vs irq" stuff we're trying to get rid of in the K3
> patches...

This is not the same, the whole INTC is a sub-module within the
sub-system serving interrupts to both the PRUs and the main host
processor. In anycase, we can add more details when we send out the
series separately.

regards
Suman
