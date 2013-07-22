From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 1/3] misc: Add crossbar driver
Date: Mon, 22 Jul 2013 17:50:21 +0530
Message-ID: <51ED2385.60108@ti.com>
References: <1374165830-6367-1-git-send-email-r.sricharan@ti.com> <1374165830-6367-2-git-send-email-r.sricharan@ti.com> <51E83A4F.5080904@ti.com> <CACRpkdY3nQaWimTwB-Zt-8+Q_KZr8a0rpB1SUQq=AuoG4bAYnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CACRpkdY3nQaWimTwB-Zt-8+Q_KZr8a0rpB1SUQq=AuoG4bAYnQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rajendra Nayak <rnayak@ti.com>, Felipe Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

Hi Linus,
On Sunday 21 July 2013 10:19 PM, Linus Walleij wrote:
> On Thu, Jul 18, 2013 at 8:56 PM, Nishanth Menon <nm@ti.com> wrote:
>
>> I carry forward my TI internal objection to this approach:
> It is actually a very good sign of FOSS-maturity that you as a company
> take unresolved architectural issues to the community. Kudos!
>
>> Lets see what happens as a result of this:
>>
>> https://patchwork.kernel.org/patch/2825148/ (introducing DTS for DRA7)
>> uart1 to uart6 is defined. while in fact 10 uarts exist on IP block.
>> uart1: serial@4806a000 {
>> <snip>
>> +                       interrupts = <0 72 0x4>;
>> Assumes that GIC interrupt by default mapping used.
> So introducing this inbetween the GIC lines and its actual device IRQ
> lines inevitably means that the GIC three-cell concept is completely
> ill-devised to handle this.
>
> For routing IRQs, I think the proper solution would be to use a
> cascaded struct irqchip, which in turn contains an irqdomain
> translation to remux the signal onto the GIC inputs.
>
> I.e. the interrupt-controller given to that serial would be the
> crossbar irqchip, and that in turn will hog and allocate apropriate
> lines from the gic to it would probably itself list *all* the IRQs
> of the GIC as "its" IRQs.
>
> We already have plenty of cascading irqchips such as GPIO
> controller providing IRQs, just that they only multiplex on a
> single GIC line instead of the whole lot.
>
> Mock example:
>
>                 intc: interrupt-controller@0 {
>                         compatible = "arm,cortex-a9-gic";
>                         #interrupt-cells = <3>;
>                         #address-cells = <1>;
>                         interrupt-controller;
>                         reg = ...;
>                 };
>
>                 crossbar: crossbar@0 {
>                         compatible = "...";
>                         interrupt-controller;
>                         #interrupt-cells = <1>;
>                         interrupt-parent = <&intc>;
>                         interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
>                                           <0 1 IRQ_TYPE_LEVEL_HIGH>,
>                                           <0 2 IRQ_TYPE_LEVEL_HIGH>,
>                                           ....
>                                           <0 n IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
>                 uart0: serial@0 {
>                         compatible = "...";
>                         interrupt-parent = <&crossbar>;
>                         interrupts = <1234>;
>                  };
>
> Maybe the interrupts provided from crossbar cannot even be
> specified by a number, maybe a line name need to be used
> or so. I don't know the particulars.
>
> Whether this as a whole is a good idea, I don't know,
> but you would have to go about it something like this.
>
> What happens if there is no line to mux in a certain IRQ?
 Thanks for this.
 Was thinking of a similar kind of approach with irqchip.
 But then, there was a GAP since crossbar does not have an irq unlike
 other irqchips. But as you said  this can be done by setting the crossbar
 to map and receive the GIC interrupts and then direct to devices.
 Only thing is, this is fine for IRQs, and something different has to be done
 for DMA crossbars  again. Also when we allocate dynamically here,
 finding out a irq line when there is no free line is a question.

  With the other approach of using/extending  the pinctrl framework that you
 gave, it is good to handle both irqs/dma.  I looked at the other example in
 drivers/dma/amba-pl08x.c and i see that data is getting populated and passed
 from the platform. I initially started with something similar, where the data
 was passed statically from DT and a driver to use that.  So now it looks good
 to extend the pinctrl fw. I will try a approach for that first and see how it looks.

Regards,
 Sricharan


