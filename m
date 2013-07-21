From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] misc: Add crossbar driver
Date: Sun, 21 Jul 2013 18:49:40 +0200
Message-ID: <CACRpkdY3nQaWimTwB-Zt-8+Q_KZr8a0rpB1SUQq=AuoG4bAYnQ@mail.gmail.com>
References: <1374165830-6367-1-git-send-email-r.sricharan@ti.com>
 <1374165830-6367-2-git-send-email-r.sricharan@ti.com>
 <51E83A4F.5080904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51E83A4F.5080904-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 18, 2013 at 8:56 PM, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> wrote:

> I carry forward my TI internal objection to this approach:

It is actually a very good sign of FOSS-maturity that you as a company
take unresolved architectural issues to the community. Kudos!

> Lets see what happens as a result of this:
>
> https://patchwork.kernel.org/patch/2825148/ (introducing DTS for DRA7)
> uart1 to uart6 is defined. while in fact 10 uarts exist on IP block.
> uart1: serial@4806a000 {
> <snip>
> +                       interrupts = <0 72 0x4>;
> Assumes that GIC interrupt by default mapping used.

So introducing this inbetween the GIC lines and its actual device IRQ
lines inevitably means that the GIC three-cell concept is completely
ill-devised to handle this.

For routing IRQs, I think the proper solution would be to use a
cascaded struct irqchip, which in turn contains an irqdomain
translation to remux the signal onto the GIC inputs.

I.e. the interrupt-controller given to that serial would be the
crossbar irqchip, and that in turn will hog and allocate apropriate
lines from the gic to it would probably itself list *all* the IRQs
of the GIC as "its" IRQs.

We already have plenty of cascading irqchips such as GPIO
controller providing IRQs, just that they only multiplex on a
single GIC line instead of the whole lot.

Mock example:

                intc: interrupt-controller@0 {
                        compatible = "arm,cortex-a9-gic";
                        #interrupt-cells = <3>;
                        #address-cells = <1>;
                        interrupt-controller;
                        reg = ...;
                };

                crossbar: crossbar@0 {
                        compatible = "...";
                        interrupt-controller;
                        #interrupt-cells = <1>;
                        interrupt-parent = <&intc>;
                        interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
                                          <0 1 IRQ_TYPE_LEVEL_HIGH>,
                                          <0 2 IRQ_TYPE_LEVEL_HIGH>,
                                          ....
                                          <0 n IRQ_TYPE_LEVEL_HIGH>;
                };

                uart0: serial@0 {
                        compatible = "...";
                        interrupt-parent = <&crossbar>;
                        interrupts = <1234>;
                 };

Maybe the interrupts provided from crossbar cannot even be
specified by a number, maybe a line name need to be used
or so. I don't know the particulars.

Whether this as a whole is a good idea, I don't know,
but you would have to go about it something like this.

What happens if there is no line to mux in a certain IRQ?

Yours,
Linus Walleij
