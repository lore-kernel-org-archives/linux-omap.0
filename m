From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Thu, 14 Feb 2019 12:55:10 +0200
Message-ID: <5C65490E.6000800@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <CACRpkdamWQUW_O+gageB4Q6XuBg+t-h+eW1gpor7_DHvx41j=A@mail.gmail.com>
 <9c58bc48-90bf-8ac5-7fbd-0f6443e3fc5e@ti.com>
 <CACRpkdb4Q0efW5MaDmPTmewq-RFwXOTp15DCE1VpPf6g216iBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdb4Q0efW5MaDmPTmewq-RFwXOTp15DCE1VpPf6g216iBw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, ext Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, David Lechner <david@lechnology.com>, "Nori, Sekhar" <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, nsaulnier@ti.com, jreeder@ti.com, Murali Karicheri <m-karicheri2@ti.com>, woods.technical@gmail.com, Linux-OMAP <linux-omap@vger.kernel.org>, linux-remoteproc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


On 14/02/19 10:37, Linus Walleij wrote:
> On Thu, Feb 14, 2019 at 4:13 AM Suman Anna <s-anna@ti.com> wrote:
>> [Me]
> 
>>> To be able to use hierarchical interrupt domain in the kernel, the top
>>> interrupt controller must use the hierarchical (v2) irqdomain, so
>>> if this is anything else than the ARM GIC it will be an interesting
>>> undertaking to handle this.
>>
>> These are interrupt lines coming towards the host processor running
>> Linux and are directly connected to the ARM GIC. This INTC module is
>> actually an PRUSS internal interrupt controller that can take in 64 (on
>> most SoCs) external events/interrupt sources and multiplexing them
>> through two layers of many-to-one events-to-intr channels &
>> intr-channels-to-host interrupts. Couple of the host interrupts go to
>> the PRU cores themselves while the remaining ones come out of the IP to
>> connect to other GICs in the SoC.
> 
> If the muxing is static (like set up once at probe) so that while the system is
> running, there is one and one only event mapped to the GIC from
> the component below it, then it is hierarchical.

This is how it looks.

[GIC]<---8---[INTC]<---64---[events from peripherals]

The 8 interrupt lines from INTC to the GIC are 1:1 mapped and fixed per SoC.
The muxing between 64 inputs to INTC and its 8 outputs are programmable
and might not necessarily be static per boot/probe as it depends on what firmware
is loaded on the PRU.

A typical PRUSS use case will usually use just one firmware per boot but if required it
can switch at runtime and the muxing might change.

> 
>> We have implemented this as an irqchip using chained interrupt handlers
>> with the consumers using the event numbers on the Linux-side. The PRUs
>> also access some of the associated registers for clearing an event source.
> 
> Chaining with cascading is when two or more interrupts fire the
> same upper level (say GIC) IRQ. If there is a 1:1 mapping,
> it is not chained/cascaded but hierarchical.
> 
> I understand you used old irqdomain/chip frameworks in the past,
> because everyone was working around the fact that they didn't have
> an abstraction for hierarchical IRQs. Using chained interrupts
> and custom 1:1 maps and assigning a long list of IRQs like this
> patch does was the most common workaround. But we should
> step out of that habit now.
> 
> Different levels of the IRQ handling having to do different stuff is
> what hierarchical irqdomains do best, so it sounds like a good fit.
> 
> We handle some stuff at our level of the hierarchy and then fall
> up to the next higher level using calls such as
> irq_chip_ack_parent(), irq_chip_mask_parent() and friends.
> 
> Yours,
> Linus Walleij
> 

--
cheers,
-roger
 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
