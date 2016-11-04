From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] drivers: gpio: Add support for multiple IPs
Date: Fri, 4 Nov 2016 15:28:42 +0100
Message-ID: <CACRpkdZmuc__QL6b7Jvb8xL5Bm+PD2X60NtiugrnH7iAO=-tLQ@mail.gmail.com>
References: <1476855239-32730-1-git-send-email-j-keerthy@ti.com>
 <1476855239-32730-3-git-send-email-j-keerthy@ti.com> <CACRpkdbsgM-yiWpiA5G35jQR8v3FO=Me+4rhe6TzE0qsWOJ8Ew@mail.gmail.com>
 <c5c95d86-2c89-3819-725c-ee0b86c37ec0@ti.com> <98447580-cbc4-152e-f2cb-7c4756545479@ti.com>
 <c047fb27-a8bb-c10d-2b16-a3e6bf45d88f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c047fb27-a8bb-c10d-2b16-a3e6bf45d88f-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 27, 2016 at 10:07 AM, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> wrote:
> On Thursday 27 October 2016 01:23 PM, Roger Quadros wrote:
>> On 27/10/16 06:42, Keerthy wrote:
>>> On Sunday 23 October 2016 04:02 PM, Linus Walleij wrote:
>>>> On Wed, Oct 19, 2016 at 7:33 AM, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> wrote:
>>>>> From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>

>>> In case of k2g. There are 2 big GPIO modules GPIO0 and GPIO1.
>>> GPIO0 comprises of 144 GPIOs
>>> and GPIO1 has about 68 GPIOs. Wanted feedback from you on how this is
>>> being modeled.
>>>
>>> I am creating a controller for every 32 GPIOs under the big module each
>>> containing a gpio_chip. Each 32 GPIOs chip has 2 banks of 16 GPIOs each.
>>> Each 16 GPIO bank has an interrupt.
>>>
>>> Is this modeling fine or do you think creating one chip with 144 pins and
>>> another with 68 pins is a better way?
>>
>>
>> If GPIO0 has 144 GPIOs, why don't we model it as a gpiochip with 144
>> GPIOs?
>> What is the benefit of partitioning it into gpiochips of 32 GPIOs each?
>
> 144 GPIOs where in 16 GPIOs form a bank. So about 9 banks with one interrupt
> each. So split it into gpiochips with 32 GPIOs each handling 2 Interrupts.

I'm a bit confused.

This sounds like you should either have one gpio_chip per interrupt
(if that fits with how the device tree looks) or one big gpio_chip for
all the lines.

The DT model sort of mandates how the interrupts should be mapped
at this point, and as far as I can tell from the binding the example looks
like so:

gpio: gpio@1e26000 {
        compatible = "ti,dm6441-gpio";
        gpio-controller;
        #gpio-cells = <2>;
        reg = <0x226000 0x1000>;
        interrupt-parent = <&intc>;
        interrupts = <42 IRQ_TYPE_EDGE_BOTH 43 IRQ_TYPE_EDGE_BOTH
                44 IRQ_TYPE_EDGE_BOTH 45 IRQ_TYPE_EDGE_BOTH
                46 IRQ_TYPE_EDGE_BOTH 47 IRQ_TYPE_EDGE_BOTH
                48 IRQ_TYPE_EDGE_BOTH 49 IRQ_TYPE_EDGE_BOTH
                50 IRQ_TYPE_EDGE_BOTH>;
        ti,ngpio = <144>;
        ti,davinci-gpio-unbanked = <0>;
        interrupt-controller;
        #interrupt-cells = <2>;
};

So I don't see any reason to split this up in subchips internally in
Linux?

It looks like the irqdomain will be a bit tricksy though.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
