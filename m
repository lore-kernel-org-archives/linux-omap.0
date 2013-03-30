From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [RFC][BUG] arm/dts: OMAP3: set #interrupt-cells to two
Date: Sat, 30 Mar 2013 14:18:19 +0100
Message-ID: <CAAwP0s35J-edpvFv08xjjpwaezQBYNvMNhhXL-UacsuUtSt4ZA@mail.gmail.com>
References: <1364631689.3767.7.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:55194 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756341Ab3C3NSl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Mar 2013 09:18:41 -0400
Received: by mail-ia0-f182.google.com with SMTP id u8so977664iag.13
        for <linux-omap@vger.kernel.org>; Sat, 30 Mar 2013 06:18:41 -0700 (PDT)
In-Reply-To: <1364631689.3767.7.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Jon Hunter <jon-hunter@ti.com>

On Sat, Mar 30, 2013 at 9:21 AM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:
> This patch sets gpio #interrupt-cells from a falsely acquired '1' to '2'
> referring to Documentation/devicetree/bindings/gpio/gpio-omap.txt:
>
>       The first cell is the GPIO number.
>       The second cell is used to specify flags:
>         bits[3:0] trigger type and level flags:
>           1 = low-to-high edge triggered.
>           2 = high-to-low edge triggered.
>           4 = active high level-sensitive.
>           8 = active low level-sensitive.
>
> But using this trigger cell in a board specific devicetree leads to a
> non-starting kernel. This is due to not yet enabled gpio-clocks while
> kernel/irq/irqdomain.c tries to set this trigger-flag (from the second
> interrupt-cell) to gpio-irq-controller.
>
>  Any ideas?

Hi Christoph,

A call to gpio_request() to enable the GPIO bank is needed before
using a GPIO as an IRQ source, otherwise accesses to the GPIO bank
registers fails making the kernel to hang. Jon's (added as cc)
"gpio/omap: warn if bank is not enabled on setting irq type" patch [1]
fixes the issue by warning and returning -EINVAL.

This patch will make the kernel to boot but the call to request_irq()
will fail of course. For now, the only solution is to call
gpio_request() before request_irq() in your platform code or device
driver. There is an on going discussion about what's the better way to
address this but we still haven't found a good solution to this
problem, you can see the last email for this discussion here [2]

Also, even when calling gpio_request() before request_irq() this won't
work. When specifying the trigger/level flags on the second cell for
an GPIO-IRQ, this is not set on the IORESOURCE_IRQ struct resource.
The IRQ flag is set on of_irq_to_resource() but it just does:

r->flags = IORESOURCE_IRQ;

and then the call stack is irq_to_parse_and_map() ->
irq_set_irq_type() ->  __irq_set_trigger() -> chip->irq_set_type() ->
(drivers/gpio/gpio-omap.c) gpio_irq_type().

So, even when gpio_irq_type() receive the correct flags, this are not
returned neither stored on the flags member of the IORESOURCE_IRQ
struct resource that passed to the drivers in their struct
platform_device.

I have on my TODO to better investigate if this behavior is
intentional or is a bug in the interrupt core but didn't have time to
work on this yet. A relevant discussion about this is here [3].

> ---
>  arch/arm/boot/dts/omap3.dtsi |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 1997b41..e8e6b8f 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -99,7 +99,7 @@
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                         interrupt-controller;
> -                       #interrupt-cells = <1>;
> +                       #interrupt-cells = <2>;
>                 };
>
>                 gpio2: gpio@49050000 {
> @@ -108,7 +108,7 @@
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                         interrupt-controller;
> -                       #interrupt-cells = <1>;
> +                       #interrupt-cells = <2>;
>                 };
>
>                 gpio3: gpio@49052000 {
> @@ -117,7 +117,7 @@
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                         interrupt-controller;
> -                       #interrupt-cells = <1>;
> +                       #interrupt-cells = <2>;
>                 };
>
>                 gpio4: gpio@49054000 {
> @@ -126,7 +126,7 @@
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                         interrupt-controller;
> -                       #interrupt-cells = <1>;
> +                       #interrupt-cells = <2>;
>                 };
>
>                 gpio5: gpio@49056000 {
> @@ -135,7 +135,7 @@
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                         interrupt-controller;
> -                       #interrupt-cells = <1>;
> +                       #interrupt-cells = <2>;
>                 };
>
>                 gpio6: gpio@49058000 {
> @@ -144,7 +144,7 @@
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                         interrupt-controller;
> -                       #interrupt-cells = <1>;
> +                       #interrupt-cells = <2>;
>                 };
>
>                 uart1: serial@4806a000 {
> --
> 1.7.10.4
>
>
>

By the way, Jon has already sent a "ARM: dts: OMAP3+: Correct gpio
#interrupts-cells property" patch [4] that changes #interrupt-cells to
<2> for all OMAP platforms.

Best regards,
Javier

[1]: https://patchwork.kernel.org/patch/2202511/
[2]: http://www.spinics.net/lists/linux-omap/msg89247.html
[3]: https://patchwork.kernel.org/patch/2194911/
[4]: https://patchwork.kernel.org/patch/2278081/
