From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping for every GPIO on DT"
Date: Mon, 29 Jul 2013 12:19:22 +0200
Message-ID: <D135FD6D-D4B6-4237-9866-4FFED36C03CD@collabora.co.uk>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com> <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com> <51F633AE.8090308@collabora.co.uk> <alpine.DEB.2.02.1307290943000.30864@utopia.booyaka.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:43301 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab3G2KTf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 06:19:35 -0400
In-Reply-To: <alpine.DEB.2.02.1307290943000.30864@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>

On 29/07/2013, at 11:47, Paul Walmsley <paul@pwsan.com> wrote:

> Hi
> 
> On Mon, 29 Jul 2013, Javier Martinez Canillas wrote:
> 
>> I've looked at this and it seems that irq_create_mapping() does not call the
>> irq_domain_ops .map function handler since OMAP1 still uses legacy domain
>> mapping. I don't have an OMAP1 platform to test but could you please see if the
>> following patch [1] makes your OMAP1 platforms to boot again?
>> 
>> But I agree with Linus and probably we should just go and revert the whole
>> series since it is very hard to get it right. In another thread a user reported
>> that this change also broke his DTS tree.
>> 
>> I really tried to get this right without breaking anything but there are just
>> too many OMAP platforms behaving differently and most OMAP drivers are only half
>> converted to DT so this is really a can of worms.
>> 
>> Thanks a lot and sorry for the inconvenience,
>> Javier
>> 
>> [1]:
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index c57244e..f1c6da8 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -1090,8 +1090,18 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
>>         * are used as interrupts.
>>         */
>>        if (!omap_gpio_chip_boot_dt(&bank->chip))
>> -               for (j = 0; j < bank->width; j++)
>> -                       irq_create_mapping(bank->domain, j);
>> +               for (j = 0; j < bank->width; j++) {
>> +                       int irq = irq_create_mapping(bank->domain, j);
>> +                       irq_set_lockdep_class(irq, &gpio_lock_class);
>> +                       irq_set_chip_data(irq, bank);
>> +                       if (bank->is_mpuio) {
>> +                               omap_mpuio_alloc_gc(bank, irq, bank->width);
>> +                       } else {
>> +                               irq_set_chip_and_handler(irq, &gpio_irq_chip,
>> +                                                        handle_simple_irq);
>> +                               set_irq_flags(irq, IRQF_VALID);
>> +                       }
>> +               }
>>        irq_set_chained_handler(bank->irq, gpio_irq_handler);
>>        irq_set_handler_data(bank->irq, bank);
> 
> For some reason this patch didn't apply cleanly on v3.11-rc3, so 
> hand-applied the following patch.  It still doesn't boot on v3.11-rc3:
> 
> http://www.pwsan.com/omap/testlogs/bisect_5912osk_boot_fail_v3.11-rc3/20130729032525/boot/5912osk/5912osk_log.txt
> 
> 
> - Paul
> 

Weird since it was against -rc3, maybe my mail client corrupted somehow.

I'm out of ideas now and I don't have an OMAP1 platform to further debug this issue.

I guess the safer approach is to just revert these since they are causing a regression and what the patches aims to fix as been broken since the initial OMAP migration to DT anyways.

Unless the current gpio-omap maintainers are willing to keep these patches and know how to fix this OMAP1 regression

Thanks a lot and sorry for this mess,
Javier

> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index c57244e..23da829 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1090,8 +1090,19 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
>     * are used as interrupts.
>     */
>    if (!omap_gpio_chip_boot_dt(&bank->chip))
> -        for (j = 0; j < bank->width; j++)
> -            irq_create_mapping(bank->domain, j);
> +        for (j = 0; j < bank->width; j++) {
> +            int irq = irq_create_mapping(bank->domain, j);
> +            irq_set_lockdep_class(irq, &gpio_lock_class);
> +            irq_set_chip_data(irq, bank);
> +            if (bank->is_mpuio) {
> +                omap_mpuio_alloc_gc(bank, irq, bank->width);
> +            } else {
> +                irq_set_chip_and_handler(irq, &gpio_irq_chip,
> +                             handle_simple_irq);
> +                set_irq_flags(irq, IRQF_VALID);
> +            }
> +        }
> +
>    irq_set_chained_handler(bank->irq, gpio_irq_handler);
>    irq_set_handler_data(bank->irq, bank);
> }
