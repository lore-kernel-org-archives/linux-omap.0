From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] gpio: omap: implement get_direction
Date: Tue, 22 Apr 2014 12:24:02 +0200
Message-ID: <CABxcv=nieJq1NS1s=jtHOH_hK-C=O0Rh2OiZ36+2RK=8uLWh-A@mail.gmail.com>
References: <1398158635-18415-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1398158635-18415-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: yegorslists@googlemail.com
Cc: Linux GPIO List <linux-gpio@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hello Yegor,

On Tue, Apr 22, 2014 at 11:23 AM,  <yegorslists@googlemail.com> wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> This patch implements gpio_chip's get_direction() routine, that
> lets other drivers get particular GPIOs direction using
> struct gpio_desc.
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  drivers/gpio/gpio-omap.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 19b886c..b55bf7b 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -102,6 +102,20 @@ static int omap_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
>         return irq_find_mapping(bank->domain, offset);
>  }
>
> +static int _get_gpio_direction(struct gpio_bank *bank, int gpio)
> +{
> +       void __iomem *reg = bank->base;
> +       u32 l;
> +       u32 mask = 1 << gpio;
> +
> +       reg += bank->regs->direction;
> +       l = readl_relaxed(reg);
> +       if (l & mask)
> +               return 1;
> +
> +       return 0;
> +}
> +

You can avoid the if condition here by using return !!(l & mask) but
the above code is more clear indeed so is up to you.

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

>  static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
>  {
>         void __iomem *reg = bank->base;
> @@ -936,6 +950,19 @@ static inline void mpuio_init(struct gpio_bank *bank)
>
>  /*---------------------------------------------------------------------*/
>
> +static int gpio_get_direction(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct gpio_bank *bank;
> +       unsigned long flags;
> +       int dir;
> +
> +       bank = container_of(chip, struct gpio_bank, chip);
> +       spin_lock_irqsave(&bank->lock, flags);
> +       dir = _get_gpio_direction(bank, offset);
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +       return dir;
> +}
> +
>  static int gpio_input(struct gpio_chip *chip, unsigned offset)
>  {
>         struct gpio_bank *bank;
> @@ -1092,6 +1119,7 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
>          */
>         bank->chip.request = omap_gpio_request;
>         bank->chip.free = omap_gpio_free;
> +       bank->chip.get_direction = gpio_get_direction;
>         bank->chip.direction_input = gpio_input;
>         bank->chip.get = gpio_get;
>         bank->chip.direction_output = gpio_output;
> --
> 1.7.7
>
