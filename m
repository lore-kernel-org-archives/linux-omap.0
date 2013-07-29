From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping
 for every GPIO on DT"
Date: Mon, 29 Jul 2013 09:47:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307290943000.30864@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com> <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com> <51F633AE.8090308@collabora.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54042 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab3G2Jrq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 05:47:46 -0400
In-Reply-To: <51F633AE.8090308@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>

Hi

On Mon, 29 Jul 2013, Javier Martinez Canillas wrote:

> I've looked at this and it seems that irq_create_mapping() does not call the
> irq_domain_ops .map function handler since OMAP1 still uses legacy domain
> mapping. I don't have an OMAP1 platform to test but could you please see if the
> following patch [1] makes your OMAP1 platforms to boot again?
> 
> But I agree with Linus and probably we should just go and revert the whole
> series since it is very hard to get it right. In another thread a user reported
> that this change also broke his DTS tree.
> 
> I really tried to get this right without breaking anything but there are just
> too many OMAP platforms behaving differently and most OMAP drivers are only half
> converted to DT so this is really a can of worms.
> 
> Thanks a lot and sorry for the inconvenience,
> Javier
> 
> [1]:
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index c57244e..f1c6da8 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1090,8 +1090,18 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
>          * are used as interrupts.
>          */
>         if (!omap_gpio_chip_boot_dt(&bank->chip))
> -               for (j = 0; j < bank->width; j++)
> -                       irq_create_mapping(bank->domain, j);
> +               for (j = 0; j < bank->width; j++) {
> +                       int irq = irq_create_mapping(bank->domain, j);
> +                       irq_set_lockdep_class(irq, &gpio_lock_class);
> +                       irq_set_chip_data(irq, bank);
> +                       if (bank->is_mpuio) {
> +                               omap_mpuio_alloc_gc(bank, irq, bank->width);
> +                       } else {
> +                               irq_set_chip_and_handler(irq, &gpio_irq_chip,
> +                                                        handle_simple_irq);
> +                               set_irq_flags(irq, IRQF_VALID);
> +                       }
> +               }
>         irq_set_chained_handler(bank->irq, gpio_irq_handler);
>         irq_set_handler_data(bank->irq, bank);
> 

For some reason this patch didn't apply cleanly on v3.11-rc3, so 
hand-applied the following patch.  It still doesn't boot on v3.11-rc3:

http://www.pwsan.com/omap/testlogs/bisect_5912osk_boot_fail_v3.11-rc3/20130729032525/boot/5912osk/5912osk_log.txt


- Paul

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c57244e..23da829 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1090,8 +1090,19 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 	 * are used as interrupts.
 	 */
 	if (!omap_gpio_chip_boot_dt(&bank->chip))
-		for (j = 0; j < bank->width; j++)
-			irq_create_mapping(bank->domain, j);
+		for (j = 0; j < bank->width; j++) {
+			int irq = irq_create_mapping(bank->domain, j);
+			irq_set_lockdep_class(irq, &gpio_lock_class);
+			irq_set_chip_data(irq, bank);
+			if (bank->is_mpuio) {
+				omap_mpuio_alloc_gc(bank, irq, bank->width);
+			} else {
+				irq_set_chip_and_handler(irq, &gpio_irq_chip,
+							 handle_simple_irq);
+				set_irq_flags(irq, IRQF_VALID);
+			}
+		}
+
 	irq_set_chained_handler(bank->irq, gpio_irq_handler);
 	irq_set_handler_data(bank->irq, bank);
 }
