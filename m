From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 07/30] drivers: gpio: msic: use subsys_platform_driver()
Date: Tue, 18 Jun 2019 12:00:31 +0300
Message-ID: <20190618090031.GK9224@smile.fi.intel.com>
References: <1560796871-18560-1-git-send-email-info@metux.net>
 <1560796871-18560-7-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1560796871-18560-7-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, thloh@altera.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 17, 2019 at 08:40:48PM +0200, Enrico Weigelt, metux IT consult wrote:
> From: Enrico Weigelt <info@metux.net>
> 
> Reduce driver init boilerplate by using the new
> subsys_platform_driver() macro.

> --- a/drivers/gpio/gpio-msic.c
> +++ b/drivers/gpio/gpio-msic.c
> @@ -306,9 +306,4 @@ static int platform_msic_gpio_probe(struct platform_device *pdev)
>  	},
>  	.probe		= platform_msic_gpio_probe,
>  };
> -
> -static int __init platform_msic_gpio_init(void)
> -{
> -	return platform_driver_register(&platform_msic_gpio_driver);
> -}
> -subsys_initcall(platform_msic_gpio_init);
> +subsys_platform_driver(platform_msic_gpio_driver);

How did you test this? Had you even compiled it?

P.S. Perhaps it makes #include <linux/init.h> redundant.

-- 
With Best Regards,
Andy Shevchenko
