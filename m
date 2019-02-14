From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Wed, 13 Feb 2019 21:12:29 -0600
Message-ID: <9c58bc48-90bf-8ac5-7fbd-0f6443e3fc5e@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <CACRpkdamWQUW_O+gageB4Q6XuBg+t-h+eW1gpor7_DHvx41j=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdamWQUW_O+gageB4Q6XuBg+t-h+eW1gpor7_DHvx41j=A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Roger Quadros <rogerq@ti.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, David Lechner <david@lechnology.com>, "Nori, Sekhar" <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, nsaulnier@ti.com, jreeder@ti.com, Murali Karicheri <m-karicheri2@ti.com>, woods.technical@gmail.com, Linux-OMAP <linux-omap@vger.kernel.org>, linux-remoteproc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 2/8/19 7:51 AM, Linus Walleij wrote:
> On Mon, Feb 4, 2019 at 3:24 PM Roger Quadros <rogerq@ti.com> wrote:
> 
>> From: Suman Anna <s-anna@ti.com>
>>
>> This patch adds the bindings for the Programmable Real-Time Unit
>> and Industrial Communication Subsystem (PRU-ICSS) present on various
>> SoCs such as AM33xx, AM437x, AM57xx, Keystone 66AK2G SoC, etc. It is
>> present on the Davinci based OMAPL138 SoCs and K3 architecture
>> based AM65x SoCs as well (not covered for now).
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> (...)
>> +               pruss_intc: intc@20000 {
>> +                       compatible = "ti,am3356-pruss-intc";
>> +                       reg = <0x20000 0x2000>;
>> +                       reg-names = "intc";
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <1>;
>> +                       interrupts = <20 21 22 23 24 25 26 27>;
>> +                       interrupt-names = "host2", "host3", "host4",
>> +                                         "host5", "host6", "host7",
>> +                                         "host8", "host9";
> 
> If thsese interrupts are mapped 1-to-1 to a parent interrupt controller
> then this is a hierarchical interrupt domain and then these should
> be handled locally in the driver as offset from child to parent
> statically encoded in the driver.
> 
> Several old drivers and old device tree bindings make this kind
> of maps, but it is not how we do it anymore, if we can avoid it.
> 
> To be able to use hierarchical interrupt domain in the kernel, the top
> interrupt controller must use the hierarchical (v2) irqdomain, so
> if this is anything else than the ARM GIC it will be an interesting
> undertaking to handle this.

These are interrupt lines coming towards the host processor running
Linux and are directly connected to the ARM GIC. This INTC module is
actually an PRUSS internal interrupt controller that can take in 64 (on
most SoCs) external events/interrupt sources and multiplexing them
through two layers of many-to-one events-to-intr channels &
intr-channels-to-host interrupts. Couple of the host interrupts go to
the PRU cores themselves while the remaining ones come out of the IP to
connect to other GICs in the SoC.

We have implemented this as an irqchip using chained interrupt handlers
with the consumers using the event numbers on the Linux-side. The PRUs
also access some of the associated registers for clearing an event source.

regards
Suman

> 
> The more I understand of hierarchical irqdomains, the more of
> workarounds where we should be using it I see, we really need
> to spread this knowledge. Using it requires a lot of upfront work
> sometimes, sorry about that but the end result is so much better.
> 
> Yours,
> Linus Walleij
> 
