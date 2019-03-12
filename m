From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 16/42] drivers: gpio: janz-ttl: drop unneccessary temp
 variable dev
Date: Tue, 12 Mar 2019 09:17:48 +0000
Message-ID: <539b3cd4-8af3-d6d8-f5a9-2c426a1f0faa@codethink.co.uk>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-16-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552330521-4276-16-git-send-email-info@metux.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, thierry.reding@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/03/2019 18:54, Enrico Weigelt, metux IT consult wrote:
> don't need the temporary variable "dev", directly use &pdev->dev
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

This is quite usual to do, and I like it as it saves typing.
Personally I would say don't bother with this change.

> ---
>   drivers/gpio/gpio-janz-ttl.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-janz-ttl.c b/drivers/gpio/gpio-janz-ttl.c
> index b97a911..91f91f6 100644
> --- a/drivers/gpio/gpio-janz-ttl.c
> +++ b/drivers/gpio/gpio-janz-ttl.c
> @@ -144,18 +144,17 @@ static void ttl_setup_device(struct ttl_module *mod)
>   static int ttl_probe(struct platform_device *pdev)
>   {
>   	struct janz_platform_data *pdata;
> -	struct device *dev = &pdev->dev;
>   	struct ttl_module *mod;
>   	struct gpio_chip *gpio;
>   	int ret;
>   
>   	pdata = dev_get_platdata(&pdev->dev);
>   	if (!pdata) {
> -		dev_err(dev, "no platform data\n");
> +		dev_err(&pdev->dev, "no platform data\n");
>   		return -ENXIO;
>   	}
>   
> -	mod = devm_kzalloc(dev, sizeof(*mod), GFP_KERNEL);
> +	mod = devm_kzalloc(&pdev->dev, sizeof(*mod), GFP_KERNEL);
>   	if (!mod)
>   		return -ENOMEM;
>   
> @@ -181,9 +180,9 @@ static int ttl_probe(struct platform_device *pdev)
>   	gpio->base = -1;
>   	gpio->ngpio = 20;
>   
> -	ret = devm_gpiochip_add_data(dev, gpio, NULL);
> +	ret = devm_gpiochip_add_data(&pdev->dev, gpio, NULL);
>   	if (ret) {
> -		dev_err(dev, "unable to add GPIO chip\n");
> +		dev_err(&pdev->dev, "unable to add GPIO chip\n");
>   		return ret;
>   	}
>   
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
