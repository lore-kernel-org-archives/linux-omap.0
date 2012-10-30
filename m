From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio-keys: Pinctrl-fy
Date: Tue, 30 Oct 2012 11:25:44 -0700
Message-ID: <20121030182544.GO11908@atomide.com>
References: <1351699019-4313-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351699019-4313-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pantelis Antoniou <panto@antoniou-consulting.com> [121030 11:23]:
> Enable pinctrl support for gpio-keys.

There's some discussion going on regarding doing the
pinctrl boilerplate things somewhere else started by
Dmitry, but meanwhile:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> ---
>  drivers/input/keyboard/gpio_keys.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 6a68041..e421082 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -29,6 +29,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/of_gpio.h>
>  #include <linux/spinlock.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  struct gpio_button_data {
>  	const struct gpio_keys_button *button;
> @@ -666,6 +667,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
>  	struct input_dev *input;
>  	int i, error;
>  	int wakeup = 0;
> +	struct pinctrl *pinctrl;
>  
>  	if (!pdata) {
>  		pdata = gpio_keys_get_devtree_pdata(dev);
> @@ -731,6 +733,10 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
>  		goto fail3;
>  	}
>  
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(&pdev->dev, "unable to select pin group\n");
> +
>  	/* get current state of buttons that are connected to GPIOs */
>  	for (i = 0; i < pdata->nbuttons; i++) {
>  		struct gpio_button_data *bdata = &ddata->data[i];
> -- 
> 1.7.12
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
