From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] drivers: gpio: Add support for multiple IPs
Date: Sat, 5 Nov 2016 09:23:05 +0100
Message-ID: <CACRpkdac_UgM=xeXkSZ+rOvZvutt40USjCoEt5-SoFkqspuExw@mail.gmail.com>
References: <1476855239-32730-1-git-send-email-j-keerthy@ti.com>
 <1476855239-32730-3-git-send-email-j-keerthy@ti.com> <CACRpkdbsgM-yiWpiA5G35jQR8v3FO=Me+4rhe6TzE0qsWOJ8Ew@mail.gmail.com>
 <c5c95d86-2c89-3819-725c-ee0b86c37ec0@ti.com> <98447580-cbc4-152e-f2cb-7c4756545479@ti.com>
 <c047fb27-a8bb-c10d-2b16-a3e6bf45d88f@ti.com> <CACRpkdZmuc__QL6b7Jvb8xL5Bm+PD2X60NtiugrnH7iAO=-tLQ@mail.gmail.com>
 <b92f729b-5897-c29a-31ec-97510776d85d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b92f729b-5897-c29a-31ec-97510776d85d-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 4, 2016 at 8:59 PM, Grygorii Strashko
<grygorii.strashko-l0cyMroinI0@public.gmane.org> wrote:
> On 11/04/2016 09:28 AM, Linus Walleij wrote:

>> The DT model sort of mandates how the interrupts should be mapped
>> at this point, and as far as I can tell from the binding the example looks
>> like so:
>>
>> gpio: gpio@1e26000 {
>>         compatible = "ti,dm6441-gpio";
>>         gpio-controller;
>>         #gpio-cells = <2>;
>>         reg = <0x226000 0x1000>;
>>         interrupt-parent = <&intc>;
>>         interrupts = <42 IRQ_TYPE_EDGE_BOTH 43 IRQ_TYPE_EDGE_BOTH
>>                 44 IRQ_TYPE_EDGE_BOTH 45 IRQ_TYPE_EDGE_BOTH
>>                 46 IRQ_TYPE_EDGE_BOTH 47 IRQ_TYPE_EDGE_BOTH
>>                 48 IRQ_TYPE_EDGE_BOTH 49 IRQ_TYPE_EDGE_BOTH
>>                 50 IRQ_TYPE_EDGE_BOTH>;
>>         ti,ngpio = <144>;
>>         ti,davinci-gpio-unbanked = <0>;
>>         interrupt-controller;
>>         #interrupt-cells = <2>;
>> };
>
> Above, DT bindings models Davinci GPIO IP as monolithic GPIO controller
> with N gpio pins, but internally separate GPIO chips are created for each
> banksX&Y register set (32 pins, 2 banked irq -or- 32 direct irqs).

Hm it would be good to get away from that and just have one big gpio
chip.

> Translation from linear GPIO numbering to the proper internal GPIO chip is done
> using chip.of_xlate().

Yeah :/ this could be made simpler with a single chip just spanning all
the banks and the common registers I think.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
