From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping
 for every GPIO on DT"
Date: Mon, 29 Jul 2013 11:19:42 +0200
Message-ID: <51F633AE.8090308@collabora.co.uk>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com> <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:43241 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073Ab3G2JTv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 05:19:51 -0400
In-Reply-To: <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>

On 07/29/2013 11:01 AM, Linus Walleij wrote:
> Hi Paul,
> 
> On Mon, Jul 29, 2013 at 9:52 AM, Paul Walmsley <paul@pwsan.com> wrote:
> 
>> your commit 0e970cec05635adbe7b686063e2548a8e4afb8f4 ("gpio/omap: don't
>> create an IRQ mapping for every GPIO on DT") breaks the boot on the
>> OMAP5912 OSK:
> 
> I'm contemplating just reverting this whole series, as I didn't like
> the approach from the beginning and it has exploded in exactly
> the way I thought it would.
> 
> If we revert these three patches:
> 
> commit 949eb1a4d29dc75e0b5b16b03747886b52ecf854
> "gpio/omap: fix build error when OF_GPIO is not defined."
> commit b4419e1a15905191661ffe75ba2f9e649f5d565e
> "gpio/omap: auto request GPIO as input if used as IRQ via DT"
> commit 0e970cec05635adbe7b686063e2548a8e4afb8f4
> "gpio/omap: don't create an IRQ mapping for every GPIO on DT"
> 
> Does the OMAP1 boot again after this?
> 
> I think it's a way better idea to proceed with input-hogs on the gpiochip
> DT node and use that to get auto-request on the GPIO lines that
> will be used as IRQs only.
> 
> Yours,
> Linus Walleij
> 

Hi Paul,

I've looked at this and it seems that irq_create_mapping() does not call the
irq_domain_ops .map function handler since OMAP1 still uses legacy domain
mapping. I don't have an OMAP1 platform to test but could you please see if the
following patch [1] makes your OMAP1 platforms to boot again?

But I agree with Linus and probably we should just go and revert the whole
series since it is very hard to get it right. In another thread a user reported
that this change also broke his DTS tree.

I really tried to get this right without breaking anything but there are just
too many OMAP platforms behaving differently and most OMAP drivers are only half
converted to DT so this is really a can of worms.

Thanks a lot and sorry for the inconvenience,
Javier

[1]:
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c57244e..f1c6da8 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1090,8 +1090,18 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
         * are used as interrupts.
         */
        if (!omap_gpio_chip_boot_dt(&bank->chip))
-               for (j = 0; j < bank->width; j++)
-                       irq_create_mapping(bank->domain, j);
+               for (j = 0; j < bank->width; j++) {
+                       int irq = irq_create_mapping(bank->domain, j);
+                       irq_set_lockdep_class(irq, &gpio_lock_class);
+                       irq_set_chip_data(irq, bank);
+                       if (bank->is_mpuio) {
+                               omap_mpuio_alloc_gc(bank, irq, bank->width);
+                       } else {
+                               irq_set_chip_and_handler(irq, &gpio_irq_chip,
+                                                        handle_simple_irq);
+                               set_irq_flags(irq, IRQF_VALID);
+                       }
+               }
        irq_set_chained_handler(bank->irq, gpio_irq_handler);
        irq_set_handler_data(bank->irq, bank);

