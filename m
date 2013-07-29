From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping
 for every GPIO on DT"
Date: Mon, 29 Jul 2013 08:57:27 -0400
Message-ID: <51F666B7.7020209@ti.com>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com>
 <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
 <51F633AE.8090308@collabora.co.uk> <51F63864.9000601@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F63864.9000601@collabora.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Linux-OMAP <linux-omap@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Javier,

On Monday 29 July 2013 05:39 AM, Javier Martinez Canillas wrote:
> On 07/29/2013 11:19 AM, Javier Martinez Canillas wrote:
>> On 07/29/2013 11:01 AM, Linus Walleij wrote:
>>> Hi Paul,
>>>
>>> On Mon, Jul 29, 2013 at 9:52 AM, Paul Walmsley <paul@pwsan.com> wrote:
>>>
>>>> your commit 0e970cec05635adbe7b686063e2548a8e4afb8f4 ("gpio/omap: don't
>>>> create an IRQ mapping for every GPIO on DT") breaks the boot on the
>>>> OMAP5912 OSK:
>>>
>>> I'm contemplating just reverting this whole series, as I didn't like
>>> the approach from the beginning and it has exploded in exactly
>>> the way I thought it would.
>>>
>>> If we revert these three patches:
>>>
>>> commit 949eb1a4d29dc75e0b5b16b03747886b52ecf854
>>> "gpio/omap: fix build error when OF_GPIO is not defined."
>>> commit b4419e1a15905191661ffe75ba2f9e649f5d565e
>>> "gpio/omap: auto request GPIO as input if used as IRQ via DT"
>>> commit 0e970cec05635adbe7b686063e2548a8e4afb8f4
>>> "gpio/omap: don't create an IRQ mapping for every GPIO on DT"
>>>
>>> Does the OMAP1 boot again after this?
>>>
>>> I think it's a way better idea to proceed with input-hogs on the gpiochip
>>> DT node and use that to get auto-request on the GPIO lines that
>>> will be used as IRQs only.
>>>
>>> Yours,
>>> Linus Walleij
>>>
>>
>> Hi Paul,
>>
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
>>          * are used as interrupts.
>>          */
>>         if (!omap_gpio_chip_boot_dt(&bank->chip))
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
>>         irq_set_chained_handler(bank->irq, gpio_irq_handler);
>>         irq_set_handler_data(bank->irq, bank);
>>
> 
> In case this solves Paul issue, a cleaned patch with a commit message is [2].
> But we should decide if is better to fix this or just drop the patches and go
> with Linus' input-hogs idea to do the GPIO auto request.
> 
> Santosh, Kevin, Grant, what do you think we should do?
> 
With some helps from MMC and other guys, we validated the Linus's tip which includes
your patches. It actually doesn't break anything and as OMAP hsmmc maintainer
clarified, the cd-gpios isn't supported yet for DT. While supporting that it
can use appropriate binding whichever works.

But with OMAP1 breakage reported by Paul, I think we are not left with choice
but to revert those commits. We *must* respect rc rules for the fixes.
*No regression*

Thanks for your hardwork to cook up those patches but now Linus's W proposal
is going to be generic, hopefully the issue can be address better. Till
then we can't get the ethernet support.

Linus,
I guess you have already gone ahead on revert path as seen from other email.
Lets just make that official. We are sorry for cause you trouble over a
week-end.

Regards,
Santosh
