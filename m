From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: regressions in linux-next?
Date: Wed, 23 Apr 2014 16:50:58 +0200
Message-ID: <CABxcv=n_B4qDrgunKnyiY9769xPYOssi3ESAysiXU2ek9Zt2Xg@mail.gmail.com>
References: <53566C20.6000208@ti.com>
	<53568706.1050204@ti.com>
	<5356E5E4.1060509@ti.com>
	<CABxcv=nATX0m8janD=kTZ_Askuy8StNx5r9vJM_Fq+EmQeZ0-g@mail.gmail.com>
	<5356F2A4.6010106@ti.com>
	<CABxcv=kx6zhJqVKcE1cijyOEak+jgXgsFaRAFYcZA4L_zxLRHg@mail.gmail.com>
	<20140423013022.GA18648@kahuna>
	<CABxcv=m3PhTXi=dRGPm_02-Edt_jOSCeVnTVKo_NiJkCzcKSew@mail.gmail.com>
	<CACRpkdZ1Sv9oWhPWYEemGEnsCojs5amMMkru8DjpPxc=c9MRHA@mail.gmail.com>
	<5357C04F.3060902@ti.com>
	<CACRpkdas=MxsvaB=q9rF7GwP+hJv61Ut5yL8Lc9amnTc=_E=pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:43214 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbaDWOvA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 10:51:00 -0400
Received: by mail-wi0-f179.google.com with SMTP id z2so1285274wiv.0
        for <linux-omap@vger.kernel.org>; Wed, 23 Apr 2014 07:50:58 -0700 (PDT)
In-Reply-To: <CACRpkdas=MxsvaB=q9rF7GwP+hJv61Ut5yL8Lc9amnTc=_E=pg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Wed, Apr 23, 2014 at 4:38 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Apr 23, 2014 at 3:29 PM, Nishanth Menon <nm@ti.com> wrote:
>> On 04/23/2014 08:01 AM, Linus Walleij wrote:
>
>>> What about this:
>>>
>>> if (chip->irq_default_type != IRQ_TYPE_NONE)
>>>     irq_set_irq_type(irq, chip->irq_default_type);
>>>
>>> This way you can pass IRQ_TYPE_NONE and nothing happens in
>>> the mapping.
>>
>> What if these drivers depend on IRQ_TYPE_NONE to do something for the
>> GPIO pins?
>
> Yeah :-(
>
>> would you expect these drivers to pass IRQ_TYPE_DEFAULT?
>
> Actually that sounds like a good idea. Maybe we can go over the few
> drivers that pass IRQ_TYPE_NONE and see what they actually want.
> There are not *too* many users of this call yet.
>
>> OR I wonder
>> if we could pass some flag like -1 for platforms that dont care?
>
> The flags parameter to gpiochip_irqchip_add() is unsigned...
> Switching to IRQ_TYPE_DEFAULT for drivers that want this is likely
> the sane thing to do.
>
> Yours,
> Linus Walleij

I prefer to have an explicit way to tell gpiolib whether it has to set
a default IRQ type or not than relying on passing magic numbers like
-1.

What do you think about the following patch? Although I agree that if
we can use IRQ_TYPE_NONE as you propose then tht is a much better and
efficient solution that this patch.

Best regards,
Javier

>From 8720c6798f86b71d8b11c57ecb7bae86a4ee656b Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date: Wed, 23 Apr 2014 16:45:05 +0200
Subject: [RFC] gpio: don't set IRQ default type unconditionally

Creating a mapping for a GPIO pin into the Linux virtual IRQ
space does not necessarily mean that the GPIO is going to be
used as an interrupt line, it only mean that it could be used.

But current gpiolib irqchip .map function handler calls to
irq_set_irq_type() for each GPIO pin in the bank. Some drivers
assume that this function is called either because a driver
has explicitly requested an IRQ with request_irq() or that a
DT device node has defined a GPIO controller phandle as its
"interrupt-parent" and setups the chip accordingly.

Others drivers have different semantics and expects that a
irq_set_irq_type() would setup the hardware to be some default state.

So is better to allow each driver to choose whether they want
to set a default IRQ type on the mapping function or not.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/gpio/gpio-omap.c    | 1 +
 drivers/gpio/gpiolib.c      | 3 ++-
 include/linux/gpio/driver.h | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 8cc9e91..2e23858 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1101,6 +1101,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank)
  gpio += bank->width;
  }
  bank->chip.ngpio = bank->width;
+ bank->chip.set_irq_default = false;

  ret = gpiochip_add(&bank->chip);
  if (ret) {
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c12fe9d..f12aea3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1402,7 +1402,8 @@ static int gpiochip_irq_map(struct irq_domain
*d, unsigned int irq,
 #else
  irq_set_noprobe(irq);
 #endif
- irq_set_irq_type(irq, chip->irq_default_type);
+ if (chip->set_irq_default)
+ irq_set_irq_type(irq, chip->irq_default_type);

  return 0;
 }
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 573e4f3..168c93e 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -113,6 +113,7 @@ struct gpio_chip {
  unsigned int irq_base;
  irq_flow_handler_t irq_handler;
  unsigned int irq_default_type;
+ bool set_irq_default;
 #endif

 #if defined(CONFIG_OF_GPIO)
-- 
1.9.1
