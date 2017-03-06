From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 08/12] gpio: davinci: use devm_irq_alloc_descs()
Date: Mon, 6 Mar 2017 10:29:18 +0530
Message-ID: <70d9fed2-1378-66a4-4640-dd93aae162b6@ti.com>
References: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
 <1488644620-11488-9-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488644620-11488-9-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-omap@vger.kernel.org



On Saturday 04 March 2017 09:53 PM, Bartosz Golaszewski wrote:
> This driver never frees the interrupt descriptors it allocates. Fix
> it by using the resource managed version of irq_alloc_descs().
>

Acked-by: Keerthy <j-keerthy@ti.com>

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/gpio-davinci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index 72f49d1..ac17357 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -483,7 +483,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
>  	clk_prepare_enable(clk);
>
>  	if (!pdata->gpio_unbanked) {
> -		irq = irq_alloc_descs(-1, 0, ngpio, 0);
> +		irq = devm_irq_alloc_descs(dev, -1, 0, ngpio, 0);
>  		if (irq < 0) {
>  			dev_err(dev, "Couldn't allocate IRQ numbers\n");
>  			return irq;
>
