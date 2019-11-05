From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 28/62] gpio: gpio-omap: Use new GPIO_LINE_DIRECTION
Date: Tue, 5 Nov 2019 13:27:03 +0200
Message-ID: <90a8b355-8092-38c8-2f7d-a65f0e1ce746@ti.com>
References: <cover.1572945849.git.matti.vaittinen@fi.rohmeurope.com>
 <b27b35f4db5f05994e64e3bb78f0c632bef61e6f.1572945849.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b27b35f4db5f05994e64e3bb78f0c632bef61e6f.1572945849.git.matti.vaittinen@fi.rohmeurope.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, mazziesaccount@gmail.com
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 05/11/2019 12:25, Matti Vaittinen wrote:
> It's hard for occasional GPIO code reader/writer to know if values 0/1
> equal to IN or OUT. Use defined GPIO_LINE_DIRECTION_IN and
> GPIO_LINE_DIRECTION_OUT to help them out.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>   drivers/gpio/gpio-omap.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index d0f27084a942..3bd8adaeed9e 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -805,8 +805,10 @@ static int omap_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
>   {
>   	struct gpio_bank *bank = gpiochip_get_data(chip);
>   
> -	return !!(readl_relaxed(bank->base + bank->regs->direction) &
> -		  BIT(offset));
> +	if (readl_relaxed(bank->base + bank->regs->direction) & BIT(offset))
> +		return GPIO_LINE_DIRECTION_IN;
> +
> +	return GPIO_LINE_DIRECTION_OUT;
>   }
>   
>   static int omap_gpio_input(struct gpio_chip *chip, unsigned offset)
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
