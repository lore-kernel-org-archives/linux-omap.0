From: Tony Lindgren <tony@atomide.com>
Subject: Re: Accessing GPIOs from userspace using recent kernels
Date: Fri, 30 May 2014 13:25:25 -0700
Message-ID: <20140530202525.GA5922@atomide.com>
References: <3385f19f3e1427613732f6d5c9f8513d@net2air.co>
 <CABxcv=mFV3nJf1eqNhTbh1KWwe8Z6Z62JtFn5KZbHnGprk1_bg@mail.gmail.com>
 <7bd3dbc0c3217f43eefc8d228995690f@net2air.co>
 <CABxcv=nTV23Un91fSUmkixsF5uywoisCOi1qhPqVvZb+RvikDA@mail.gmail.com>
 <ea43ccacfe4caf1f51f9e5a5c8bbdd5e@net2air.co>
 <CACRpkdYTa+_zAsbwU+XYSWnsN4i4Xkfm28S1=vcC5=oz0TH3Gg@mail.gmail.com>
 <20140523151140.GF2321@atomide.com>
 <CABxcv=nHWpX-KWMxnwu8Hjsankh+SgQp_ggVxSA=35VAU7X0kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60163 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbaE3UZb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 May 2014 16:25:31 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=nHWpX-KWMxnwu8Hjsankh+SgQp_ggVxSA=35VAU7X0kA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Peter TB Brett <peter@peter-b.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Javier Martinez Canillas <javier@dowhile0.org> [140530 12:41]:
> Hello Tony,
> 
> On Fri, May 23, 2014 at 5:11 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Linus Walleij <linus.walleij@linaro.org> [140523 04:36]:
> >> On Fri, May 16, 2014 at 12:15 PM, Peter TB Brett <peter@peter-b.co.uk> wrote:
> >> > The current call chain seems to be: gpiod_export() --> gpiod_request() -->
> >> > omap_gpio_request().  Looking at other GPIO drivers, it seems like
> >> > omap_gpio_request() should eventually call pinctrl_request_gpio().  Would be
> >> > useful if someone who knows about OMAP4/gpio/pinctrl could take a look at
> >> > this.
> 
> I looked briefly at adding pinctrl back-end commands to the OMAP GPIO
> driver. That is to make all GPIO operations fall through to the
> pinctrl-single driver as Linus suggested before. The changes in the
> GPIO driver are quite trivial, here is a RFC patch [0]  that has only
> build tested but I think is useful to at least discuss this.
> 
> Now, in order to make that patch to actually work someone has to
> register the chip GPIO range to pin controller mapping with
> gpiochip_add_pin_range() or something similar to make
> pinctrl_get_device_gpio_range() to succeed. The pinctrl-single driver
> has a "pinctrl-single,gpio-range" property that can be used to define
> a GPIO range to be registered.
> 
> But the problem is as you said that since there are two different hw
> blocks for pin muxing and GPIO control, the pins that can be
> multiplexed as GPIO are scattered all over the padconf registers
> address space. So there isn't an easy way to specify the mapping and
> we will have to add an entry on "pinctrl-single,gpio-range" for every
> single GPIO pin (that's from 128 to 256 entries depending on the SoC).

Yes.
 
> To make even more complicated, the padconf registers offset for GPIO
> pins are SoC specific so we need a mapping for each SoC.
> 
> So I wonder if is worth to add all that information to the DTS files.
> Athough on the other hand is nice to have a better coordination
> between the GPIO and pinctrl drivers and as Tony said there are use
> cases where this is needed to workaround some silicion erratas.

I don't see any way around it short of adding the gpio to pinctrl
mappings for each SoC, and not do remuxing if the mapping is missing.

Then we need to make sure that the pinctrl register mappings are the
same for each SoC revision and package. If there are revision or package
specific changes, we'd have to handle those too somehow by specifying
the package with a compatible value in the board specific .dts file
or something like that.

> > If we do this, we also need a solution to prevent automatic remuxing
> > of GPIO pins from happending. For wake-up events, some drivers need
> > to remux a rx pin to GPIO input for the duration of idle, and then
> > back to device rx pin. This is needed on some other platforms too
> > AFAIK.
> >
> > For the drivers needing GPIO wake-up events, request_gpio is done in
> > the driver after drivers/base/pinctrl.c has already muxed the device
> > pin to rx. At minimum we would get warnings about reserved pins if
> > we tried to automatically mux them to GPIO.
> >
> > We may be able to use some GPIO specific property to prevent
> > automatic remuxing as we discussed in the #armlinux few days ago.
> >
> 
> Yes, adding a GPIO specific property to prevent automatic remuxing
> sounds sensible to me.

OK that probably needs to be discussed separately.
 
> > Related to automatic remuxing of GPIO pins, there are also other
> > needs for pinctrl and GPIO interaction. We need to remux GPIO output
> > pins to input + pull + safe_mode to prevent the GPIO pins losing
> > value briefly during off-idle. That's the gpio errata 1.158 at as
> > shown at least at [1]. Because the GPIO to pinctrl mapping is
> > sparse and SoC specific, there's currently now obvious way to do
> > that. And we would need few new GPIO functions to tell pinctrl
> > subsystem about the change.
> >
> 
> I'm not that familiar with the pinctrl-single driver but can't that
> errata be handled on pinctrl-single without the GPIO OMAP driver
> intervention?

No, it needs to happen from the GPIO driver based on runtime PM
calls. Only the GPIO driver knows when a GPIO output value is being
changed.
 
> I mean if we already add the complete GPIO <--> pin mapping using
> "pinctrl-single,gpio-range" then the pinctrl-single driver will know
> what pins can be muxed as GPIO and which ones were set as output with
> pinctrl_gpio_direction_output() and then can just mux these output
> GPIO pins to input + pull + safe_mode during off-idle. Or am I
> completely lost here? :-)

What about when a driver does gpio_set_value()? :)

> > [1] https://www.gitorious.org/rowboat/kernel/commit/86b15f21298b749a9d8216ff1839d33ad542464e?format=patch
> 
> [0]
> commit 96c886987219e37395a160f8bd0d228509c1d4f0
> Author: Javier Martinez Canillas <javier@dowhile0.org>
> Date:   Fri May 30 20:50:39 2014 +0200
> 
>     gpio: omap: Make GPIO operations fall through pinctrl-single
> 
>     On OMAP platforms, there are two diferent hardware blocks for
>     I/O multiplexing / pad configuration and GPIO control. So two
>     different drivers are used: pinctrl-single and gpio-omap.
> 
>     Since two separate drivers are used there is no coordination
>     between these and a I/O pad is not configured as a GPIO when
>     a GPIO pin is requested.
> 
>     This patch adds pinctrl back-end commands to the GPIO OMAP
>     driver so the pinmux_ops functions in the pinctrl-single
>     driver are called for each GPIO operation.
> 
>     Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>

This looks pretty straight forward, but we should not merge this
until the dependencies are sorted out first. And we should bail
out if no gpio to pinctrl mapping exists.

Regards,

Tony
 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 00f29aa..cee63c6 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -27,6 +27,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/gpio.h>
>  #include <linux/bitops.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_data/gpio-omap.h>
> 
>  #define OFF_MODE       1
> @@ -664,6 +665,11 @@ static int omap_gpio_request(struct gpio_chip
> *chip, unsigned offset)
>  {
>         struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
>         unsigned long flags;
> +       int ret;
> +
> +       ret = pinctrl_request_gpio(chip->base + offset);
> +       if (ret)
> +               return ret;
> 
>         /*
>          * If this is the first gpio_request for the bank,
> @@ -704,6 +710,8 @@ static void omap_gpio_free(struct gpio_chip *chip,
> unsigned offset)
>          */
>         if (!BANK_USED(bank))
>                 pm_runtime_put(bank->dev);
> +
> +       pinctrl_free_gpio(chip->base + offset);
>  }
> 
>  /*
> @@ -947,6 +955,11 @@ static int gpio_input(struct gpio_chip *chip,
> unsigned offset)
>  {
>         struct gpio_bank *bank;
>         unsigned long flags;
> +       int ret;
> +
> +       ret = pinctrl_gpio_direction_input(chip->base + offset);
> +       if (ret)
> +               return ret;
> 
>         bank = container_of(chip, struct gpio_bank, chip);
>         spin_lock_irqsave(&bank->lock, flags);
> @@ -973,6 +986,11 @@ static int gpio_output(struct gpio_chip *chip,
> unsigned offset, int value)
>  {
>         struct gpio_bank *bank;
>         unsigned long flags;
> +       int ret;
> +
> +       ret = pinctrl_gpio_direction_output(chip->base + offset);
> +       if (ret)
> +               return ret;
> 
>         bank = container_of(chip, struct gpio_bank, chip);
>         spin_lock_irqsave(&bank->lock, flags);
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
