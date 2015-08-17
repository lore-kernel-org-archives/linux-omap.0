From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpiolib: irqchip: use different lockdep class for each
 gpio irqchip
Date: Mon, 17 Aug 2015 12:40:08 +0300
Message-ID: <55D1ABF8.1070809@ti.com>
References: <1439477919-24356-1-git-send-email-grygorii.strashko@ti.com> <CACRpkdYtUWc7X5d8mGbZK9dTgKmi1vqYZKK3Ho6mdH5MTE8K8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYtUWc7X5d8mGbZK9dTgKmi1vqYZKK3Ho6mdH5MTE8K8g@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On 08/14/2015 03:34 PM, Linus Walleij wrote:
> On Thu, Aug 13, 2015 at 4:58 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> 
>> Since IRQ chip helpers were introduced drivers lose ability to
>> register separate lockdep classes for each registered GPIO IRQ
>> chip and the gpiolib now is using shared lockdep class for
>> all GPIO IRQ chips (gpiochip_irq_lock_class).
>> As result, lockdep will produce warning when there are min two
>> stacked GPIO chips and all of them are interrupt controllers.
>>
>> HW configuration which generates lockdep warning (TI dra7-evm):
> (...)
>>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Roger Quadros <rogerq@ti.com>
>> Reported-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Ah, I see...
> 
> 
>>   *     implies that if the chip supports IRQs, these IRQs need to be threaded
>>   *     as the chip access may sleep when e.g. reading out the IRQ status
>>    *     registers.
>> + * @exported: flags if the gpiochip is exported for use from sysfs. Private.
>>    * @irq_not_threaded: flag must be set if @can_sleep is set but the
>>    *     IRQs don't need to be threaded
>>    *
>> @@ -126,6 +128,7 @@ struct gpio_chip {
>>          irq_flow_handler_t      irq_handler;
>>          unsigned int            irq_default_type;
>>          int                     irq_parent;
>> +       struct lock_class_key   *lock_key;
> 
> There is something weird with the kerneldoc. It is documenting something
> else but not documenting the new member.
> 

Sorry, for that.

There are no kerneldocs for any of GPIO IRQ chip's specific fields,
Do you prefer me to add doc for "lock_key" or all of them?

-- 
regards,
-grygorii
