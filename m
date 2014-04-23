From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: regressions in linux-next?
Date: Wed, 23 Apr 2014 09:24:42 +0200
Message-ID: <CABxcv=m3PhTXi=dRGPm_02-Edt_jOSCeVnTVKo_NiJkCzcKSew@mail.gmail.com>
References: <53566C20.6000208@ti.com>
	<53568706.1050204@ti.com>
	<5356E5E4.1060509@ti.com>
	<CABxcv=nATX0m8janD=kTZ_Askuy8StNx5r9vJM_Fq+EmQeZ0-g@mail.gmail.com>
	<5356F2A4.6010106@ti.com>
	<CABxcv=kx6zhJqVKcE1cijyOEak+jgXgsFaRAFYcZA4L_zxLRHg@mail.gmail.com>
	<20140423013022.GA18648@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:58704 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728AbaDWHYo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 03:24:44 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so446282wgh.28
        for <linux-omap@vger.kernel.org>; Wed, 23 Apr 2014 00:24:43 -0700 (PDT)
In-Reply-To: <20140423013022.GA18648@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Hello Nishanth and Tony,

On Wed, Apr 23, 2014 at 3:30 AM, Nishanth Menon <nm@ti.com> wrote:
> On 01:08-20140423, Javier Martinez Canillas wrote:
> [...]
>> > on AM335x-sk:
>> >> So this makes only am335x-sk to fail with the gpiolib irpchip
>> >> conversion as reported by Peter and you.
>> >>
>> >> Do you know what special use of GPIO have this board to behave
>> >> differently than the other boards? I've looked at the DTS but didn't
>> >> find anything evident.
>> >
>> > I could not find anything interesting yet. Peter did mention that
>> > reverting d04b76626e94 helped make the platform boot fine. I am trying
>> > to add a few prints and see which specific line does things go bad..
>> > and if so why.. unfortunately, I am using the board remotely as well..
>> > Will try to track this down in the next few hours and post back.
>> >
>>
>> Great, thanks a lot for your help and sorry for the inconvenience!
>
> Yep - If I am correct, and as we all suspected, GPIO0_7 which controls
> the VTT regulator for DDR is getting configured as input, instead of
> output.
> http://slexy.org/raw/s2gReMRZI6 (with diff:
> http://slexy.org/view/s20nueCE8H - ignore many of the prints as I was
> trying to truncate and isolate - had to switch to non-relaxed versions
> of writes to force sequencing with barriers to trace it down..)
>
>
> Anyways, the key log is [0]:
> gpiochip_irq_map -> calls
>                 irq_set_irq_type(irq, chip->irq_default_type);
>         which inturn triggers: gpio-omap.c's gpio_irq_type
>         in this, logic:
>         if (!LINE_USED(bank->mod_usage, offset)) is invoked prior to
>         setting the input type for the GPIO 0_7 (you can see the logic
> walks through setting every GPIO to input!).
>
> The original usage as far as I could discern was that this function was
> only called after probe got completed as the gpio requests were
> triggered.

Thanks a lot for figuring out what was going on here. I think that is
not correct for gpiochip_irq_map() to call this function. After all
creating a mapping doesn't mean that  the GPIO is actually used as an
IRQ.

>
> There are probably many hacks possible, but a cleaner solution might
> involve gpio_irqchip knowing when to set the type and knowing which gpios
> not to mess with.
>
> Example hack:
> Since we call gpiochip_irqchip_add with IRQ_TYPE_NONE,
>   in gpio-omap's   gpio_irq_type could do:
>        if (type == IRQ_TYPE_NONE)
>                 return 0;
>  boots, http://slexy.org/raw/s24M8lHqZX - but ofcourse, there'd be other
>  side effects I have'nt thought through..

Linus, what do you think of the following patch?

>From ede333e85e0320d32e8c2d123560808ed7e43ece Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date: Wed, 23 Apr 2014 09:13:54 +0200
Subject: [PATCH 1/1] gpio: don't call irq_set_irq_type() on IRQ domain map
 function

Creating a mapping for a GPIO pin into the Linux virtual IRQ
space does not necessarily mean that the GPIO is going to be
used as an interrupt line, it only means that it could be used.

So, calling irq_set_irq_type() is not correct since that is
already done either when a driver calls request_irq() or when
the OF core calls of_irq_to_resource() because a device node
defined a GPIO controller phandle as its "interrupt-parent".

In either case irq_set_irq_type() will be called and the GPIO
controller driver will take any required action for an IRQ.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/gpio/gpiolib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c12fe9d..b493781 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1402,7 +1402,6 @@ static int gpiochip_irq_map(struct irq_domain
*d, unsigned int irq,
 #else
  irq_set_noprobe(irq);
 #endif
- irq_set_irq_type(irq, chip->irq_default_type);

  return 0;
 }
-- 
1.9.1
