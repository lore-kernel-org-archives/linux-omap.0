From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Wed, 5 Sep 2012 11:06:22 +0800
Message-ID: <CAK5ve-Jqc1xpXa0VM7=+MN1cvm=8ysg9W9WRiG66yq7GRfh+Gw@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:32896 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab2IEDGo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 23:06:44 -0400
In-Reply-To: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>, Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>
Cc: rpurdie@rpsys.net, tony@atomide.com, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

On Sat, Sep 1, 2012 at 4:16 PM, AnilKumar Ch <anilkumar@ti.com> wrote:
> Adopt pinctrl support to leds-gpio driver based on leds-gpio
> device pointer, pinctrl driver configure SoC pins to GPIO
> mode according to definitions provided in .dts file.
>

Thanks for this, actually Marek Vasut submitted a similar patch
before. I'm pretty fine with this patch.
But without proper DT setting, it will also give us warning I think.
or we can provide some dummy functions as a temp solution as Shawn
pointed out before.

-Bryan

> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
> Changes from v1:
>         - Seperated from "Add DT for AM33XX devices" patch series
>         - Incorporated Tony's comments on v1
>           * Changed to warning message instead od error return
>
>  drivers/leds/leds-gpio.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index c032b21..ad577f4 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -20,6 +20,7 @@
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>  #include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
>
>  struct gpio_led_data {
>         struct led_classdev cdev;
> @@ -236,8 +237,14 @@ static int __devinit gpio_led_probe(struct platform_device *pdev)
>  {
>         struct gpio_led_platform_data *pdata = pdev->dev.platform_data;
>         struct gpio_leds_priv *priv;
> +       struct pinctrl *pinctrl;
>         int i, ret = 0;
>
> +       pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +       if (IS_ERR(pinctrl))
> +               dev_warn(&pdev->dev,
> +                       "pins are not configured from the driver\n");
> +
>         if (pdata && pdata->num_leds) {
>                 priv = devm_kzalloc(&pdev->dev,
>                                 sizeof_gpio_leds_priv(pdata->num_leds),
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-leds" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer    +86.186-168-78255 Mobile
Canonical Ltd.      www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
