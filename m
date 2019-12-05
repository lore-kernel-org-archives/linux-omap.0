From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpio: pca953x: Read irq trigger type from DT
Date: Thu, 5 Dec 2019 17:01:14 +0200
Message-ID: <5837a37d-479d-5c33-45b5-c1b32b0cdc52@ti.com>
References: <20191205144508.31339-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205144508.31339-1-vigneshr@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh Raghavendra <vigneshr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 05/12/2019 16:45, Vignesh Raghavendra wrote:
> Instead of hardcoding irq trigger type to IRQF_TRIGGER_LOW, let's
> respect settings specified in DT. Default to IRQF_TRIGGER_LOW,
> if DT does not provide a flag.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>   drivers/gpio/gpio-pca953x.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 6652bee01966..e0e2a77ef6ad 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -744,6 +744,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
>   	struct irq_chip *irq_chip = &chip->irq_chip;
>   	DECLARE_BITMAP(reg_direction, MAX_LINE);
>   	DECLARE_BITMAP(irq_stat, MAX_LINE);
> +	unsigned long irqflags;
>   	int ret;
>   
>   	if (!client->irq)
> @@ -768,10 +769,14 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
>   	bitmap_and(chip->irq_stat, irq_stat, reg_direction, chip->gpio_chip.ngpio);
>   	mutex_init(&chip->irq_lock);
>   
> +	irqflags = irq_get_trigger_type(client->irq);
> +	if (irqflags == IRQF_TRIGGER_NONE)
> +		irqflags = IRQF_TRIGGER_LOW;

I think you can just drop IRQF_TRIGGER_LOW:
- for paltform code it will be set from resources in platform_get_irq_optional()
- for DT code it will be set in __setup_irq()

> +	irqflags |= IRQF_ONESHOT | IRQF_SHARED;
> +
>   	ret = devm_request_threaded_irq(&client->dev, client->irq,
>   					NULL, pca953x_irq_handler,
> -					IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> -					IRQF_SHARED,
> +					irqflags,
>   					dev_name(&client->dev), chip);
>   	if (ret) {
>   		dev_err(&client->dev, "failed to request irq %d\n",
> 

-- 
Best regards,
grygorii
