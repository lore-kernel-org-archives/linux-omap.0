From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 12/12] i2c: gpio: flag atomic capability if possible
Date: Mon, 15 Apr 2019 15:38:41 +0300
Message-ID: <CAHp75Vfh05KuXLrU+eVeBSFonBHQAemf8iyWFsRk4Oww-HbEvw@mail.gmail.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com> <20190403124019.8947-13-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403124019.8947-13-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 3, 2019 at 3:42 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> If switching GPIOs does not sleep, then we can support atomic transfers.
>

Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-gpio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> index bba5c4627de3..9684a0ac2a6d 100644
> --- a/drivers/i2c/busses/i2c-gpio.c
> +++ b/drivers/i2c/busses/i2c-gpio.c
> @@ -413,6 +413,8 @@ static int i2c_gpio_probe(struct platform_device *pdev)
>
>         if (gpiod_cansleep(priv->sda) || gpiod_cansleep(priv->scl))
>                 dev_warn(dev, "Slow GPIO pins might wreak havoc into I2C/SMBus bus timing");
> +       else
> +               bit_data->can_do_atomic = true;
>
>         bit_data->setsda = i2c_gpio_setsda_val;
>         bit_data->setscl = i2c_gpio_setscl_val;
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
