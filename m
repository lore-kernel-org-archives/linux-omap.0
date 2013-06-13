From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [v4 3/3] mtd: devices: elm: Low power transition support
Date: Thu, 13 Jun 2013 14:03:38 -0700
Message-ID: <8761xhbu51.fsf@linaro.org>
References: <1371032708-9242-1-git-send-email-pekon@ti.com>
	<1371032708-9242-4-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:33659 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757793Ab3FMVDm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 17:03:42 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so5285260pbc.7
        for <linux-omap@vger.kernel.org>; Thu, 13 Jun 2013 14:03:41 -0700 (PDT)
In-Reply-To: <1371032708-9242-4-git-send-email-pekon@ti.com> (Pekon Gupta's
	message of "Wed, 12 Jun 2013 15:55:08 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, avinash philip <avinashphilip@ti.com>

Pekon Gupta <pekon@ti.com> writes:

> From: avinash philip <avinashphilip@ti.com>
>
> In low power modes of AM335X platforms, peripherals power is cut off.
> This patch supports low power sleep transition support for ELM driver.

This series needs a bit more description about what "low power sleep
transition" is, and how adding runtime PM calls makes this transition
happen.

Kevin

> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  drivers/mtd/devices/elm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/mtd/devices/elm.c b/drivers/mtd/devices/elm.c
> index dccef9f..171efcd 100644
> --- a/drivers/mtd/devices/elm.c
> +++ b/drivers/mtd/devices/elm.c
> @@ -20,6 +20,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> +#include <linux/sched.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_data/elm.h>
>  
> @@ -385,6 +386,23 @@ static int elm_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int elm_suspend(struct device *dev)
> +{
> +	pm_runtime_put_sync(dev);
> +	return 0;
> +}
> +
> +static int elm_resume(struct device *dev)
> +{
> +	struct elm_info *info = dev_get_drvdata(dev);
> +
> +	pm_runtime_get_sync(dev);
> +	elm_config(dev, info->bch_type);
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(elm_pm_ops, elm_suspend, elm_resume);
> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id elm_of_match[] = {
>  	{ .compatible = "ti,am3352-elm" },
> @@ -398,6 +416,7 @@ static struct platform_driver elm_driver = {
>  		.name	= "elm",
>  		.owner	= THIS_MODULE,
>  		.of_match_table = of_match_ptr(elm_of_match),
> +		.pm	= &elm_pm_ops,
>  	},
>  	.probe	= elm_probe,
>  	.remove	= elm_remove,
