From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpiolib: irqchip: use different lockdep class for each
 gpio irqchip
Date: Fri, 14 Aug 2015 14:34:00 +0200
Message-ID: <CACRpkdYtUWc7X5d8mGbZK9dTgKmi1vqYZKK3Ho6mdH5MTE8K8g@mail.gmail.com>
References: <1439477919-24356-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1439477919-24356-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 13, 2015 at 4:58 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> Since IRQ chip helpers were introduced drivers lose ability to
> register separate lockdep classes for each registered GPIO IRQ
> chip and the gpiolib now is using shared lockdep class for
> all GPIO IRQ chips (gpiochip_irq_lock_class).
> As result, lockdep will produce warning when there are min two
> stacked GPIO chips and all of them are interrupt controllers.
>
> HW configuration which generates lockdep warning (TI dra7-evm):
(...)
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Roger Quadros <rogerq@ti.com>
> Reported-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Ah, I see...


>  *     implies that if the chip supports IRQs, these IRQs need to be threaded
>  *     as the chip access may sleep when e.g. reading out the IRQ status
>   *     registers.
> + * @exported: flags if the gpiochip is exported for use from sysfs. Private.
>   * @irq_not_threaded: flag must be set if @can_sleep is set but the
>   *     IRQs don't need to be threaded
>   *
> @@ -126,6 +128,7 @@ struct gpio_chip {
>         irq_flow_handler_t      irq_handler;
>         unsigned int            irq_default_type;
>         int                     irq_parent;
> +       struct lock_class_key   *lock_key;

There is something weird with the kerneldoc. It is documenting something
else but not documenting the new member.

Anyway, so here:

> +int _gpiochip_irqchip_add(struct gpio_chip *gpiochip,
> +                         struct irq_chip *irqchip,
> +                         unsigned int first_irq,
> +                         irq_flow_handler_t handler,
> +                         unsigned int type,
> +                         struct lock_class_key *lock_key);
> +
> +#ifdef CONFIG_LOCKDEP
> +#define gpiochip_irqchip_add(...)                              \
> +(                                                              \
> +       ({                                                      \
> +               static struct lock_class_key _key;              \
> +               _gpiochip_irqchip_add(__VA_ARGS__, &_key);      \
> +       })                                                      \
> +)
> +#else
> +#define gpiochip_irqchip_add(...)                              \
> +       _gpiochip_irqchip_add(__VA_ARGS__, NULL)
> +#endif

Every chip will get their own lock class on the heap.

But I think it is a bit kludgy.

Is it not possible to have  the lock key in struct gpio_chip
be a real member instead of a pointer and get a per-chip
lock that way?

(...)
struct lock_class_key lock_key;

instead of:

struct lock_class_key  *lock_key;

-> problem solved, without kludgy header defines?

Yours,
Linus Walleij
