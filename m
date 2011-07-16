From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH v4 REPOST 13/20] gpio/omap: cleanup omap_gpio_mod_init
 function
Date: Sat, 16 Jul 2011 11:26:49 -0700
Message-ID: <20110716182649.GA990@google.com>
References: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
 <1310804152-9243-14-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:36807 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab1GPS1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Jul 2011 14:27:24 -0400
Content-Disposition: inline
In-Reply-To: <1310804152-9243-14-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Sat, Jul 16, 2011 at 01:45:45PM +0530, Tarun Kanti DebBarma wrote:
> With register offsets now defined for respective OMAP versions we can get rid
> of cpu_class_* checks. This function now has common initialization code for
> all OMAP versions. Initialization specific to OMAP16xx has been moved within
> omap16xx_gpio_init().
> 
...
>  static int __init omap16xx_gpio_init(void)
>  {
>  	int i;
> +	void __iomem *base;
> +	struct resource *res;
> +	struct platform_device *pdev;
> +	struct omap_gpio_platform_data *pdata;
>  
>  	if (!cpu_is_omap16xx())
>  		return -EINVAL;
>  
> -	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
> +	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
> +		pdev = omap16xx_gpio_dev[i];
> +		pdata = pdev->dev.platform_data;
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (unlikely(!res)) {
> +			dev_err(&pdev->dev, "Invalid mem resource.\n");
> +			return -ENODEV;
> +		}
> +
> +		base = ioremap(res->start, resource_size(res));
> +		if (unlikely(!base)) {
> +			dev_err(&pdev->dev, "ioremap failed.\n");
> +			return -ENOMEM;
> +		}

The value of base isn't saved anywhere, and the memory is not
unmapped, looks like a virtual memory leak.  If the purpose of the
ioremap is to perform the single write below then iounmap when done?
The previous code to perform that write used a
struct gpio_bank *bank->base ioremapped by omap_gpio_probe, but
apparently omap16xx_gpio_init isn't called in that path.

> +
> +		__raw_writel(0x0014, base + OMAP1610_GPIO_SYSCONFIG);

Suggest a symbol for the 0x14 value, or add a comment describing what
this does.  (I realize the existing code has many naked constants.)



Todd

