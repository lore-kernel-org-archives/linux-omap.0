From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] of: provide of_platform_unpopulate()
Date: Mon, 22 Jul 2013 10:25:34 +0200
Message-ID: <51ECEC7E.7000008@linutronix.de>
References: <2333396.179421374298979822.JavaMail.weblogic@epml22>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <2333396.179421374298979822.JavaMail.weblogic@epml22>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: ch.naveen@samsung.com
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Doug Anderson <dianders@chromium.org>, Vivek Gautam <gautam.vivek@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kishon Vijay Abraham I <kishon@ti.com>, Roger Quadros <rogerq@ti.com>, George Cherian <george.cherian@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On 07/20/2013 07:42 AM, NAVEEN KRISHNA CHATRADHI wrote:
> Hello Sebastian,

Hello Naveen,

> 
> I just did one more testing.
> 
> In case of iio/adc/exynos_adc.c there is a bug in the remove path.
> If I fix the bug in the driver, with below patch
> 
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -375,14 +375,14 @@ static int exynos_adc_remove(struct platform_device *pdev)
>         struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>         struct exynos_adc *info = iio_priv(indio_dev);
> 
> -       device_for_each_child(&pdev->dev, NULL,
> -                               exynos_adc_remove_devices);
>         regulator_disable(info->vdd);
>         clk_disable_unprepare(info->clk);
>         writel(0, info->enable_reg);
>         iio_device_unregister(indio_dev);
>         free_irq(info->irq, info);
>         iio_device_free(indio_dev);
> +       device_for_each_child(&pdev->dev, NULL,
> +                               exynos_adc_remove_devices);
> 
> Even without your fix, I could configure it as a module and the rmmod, insmod are working fine. (no crash)

I have no idea why you moved it. I haven't found any .dts with this
binding but from the binding document I would assume that you do not
have any memory resources and therefore you don't see that crash.

> Regards,
> Naveen

Sebastian
