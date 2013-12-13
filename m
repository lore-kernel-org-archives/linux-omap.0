From: Anton Tikhomirov <av.tikhomirov@samsung.com>
Subject: RE: [PATCH 7/7] usb: dwc3: exynos: add pm_runtime support
Date: Fri, 13 Dec 2013 14:01:32 +0900
Message-ID: <000301cef7c0$640c1ce0$2c2456a0$%tikhomirov@samsung.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <1386884325-11440-8-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1386884325-11440-8-git-send-email-balbi@ti.com>
Content-language: en-us
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Felipe Balbi' <balbi@ti.com>, 'Linux USB Mailing List' <linux-usb@vger.kernel.org>
Cc: kgene.kim@samsung.com, 'Linux ARM Kernel Mailing List' <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, 'Linux OMAP Mailing List' <linux-omap@vger.kernel.org>, w-kwok2@ti.com, 'Santosh Shilimkar' <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

> -static int dwc3_exynos_suspend(struct device *dev)
> +static int __dwc3_exynos_suspend(struct dwc3_exynos *exynos)
>  {
> -	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> -
>  	clk_disable(exynos->clk);
> 
>  	return 0;
>  }
> 
> +static int __dwc3_exynos_resume(struct dwc3_exynos *exynos)
> +{
> +	return clk_enable(exynos->clk);
> +}
> +
> +static int dwc3_exynos_suspend(struct device *dev)
> +{
> +	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> +
> +	return __dwc3_exynos_suspend(exynos);

If dwc3-exynos is runtime suspended, the clock will be disabled
second time here (unbalanced clk_enable/clk_disable).

> +}
> +
>  static int dwc3_exynos_resume(struct device *dev)
>  {
>  	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> +	int ret;	
> 
> -	clk_enable(exynos->clk);
> +	ret = __dwc3_exynos_resume(exynos);
> +	if (ret)
> +		return ret;
> 
>  	/* runtime set active to reflect active state. */
>  	pm_runtime_disable(dev);
> @@ -207,8 +238,24 @@ static int dwc3_exynos_resume(struct device *dev)
>  	return 0;
>  }
> 
> +static int dwc3_exynos_runtime_suspend(struct device *dev)
> +{
> +	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> +
> +	return __dwc3_exynos_suspend(exynos);
> +}
> +
> +static int dwc3_exynos_runtime_resume(struct device *dev)
> +{
> +	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> +
> +	return __dwc3_exynos_resume(exynos);
> +}

Thanks
