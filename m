From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [RESEND PATCH v6 4/4] usb: musb: da8xx: Add a primary support of
 PM runtime
Date: Fri, 24 Mar 2017 12:26:38 -0500
Message-ID: <703e5e95-8bde-2b1c-0d63-4ed3e03f53b8@ti.com>
References: <20170324143600.4704-1-abailon@baylibre.com>
 <20170324143600.4704-5-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170324143600.4704-5-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, b-liu-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 03/24/2017 09:36 AM, Alexandre Bailon wrote:
> Currently, MUSB DA8xx glue driver doesn't have PM runtime support.
> Because the CPPI 4.1 is using the same clock as MUSB DA8xx and
> CPPI 4.1 is a child of MUSB DA8xx glue, add support of PM runtime
> to the DA8xx glue driver in order to let the CPPI 4.1 driver manage
> the clock by using PM runtime.
> 
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/usb/musb/da8xx.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
> index ed28afd..89e12f6 100644
> --- a/drivers/usb/musb/da8xx.c
> +++ b/drivers/usb/musb/da8xx.c
> @@ -30,7 +30,6 @@
>   */
>  

[...]

>  
> @@ -527,12 +520,6 @@ static int da8xx_probe(struct platform_device *pdev)
>  	if (!glue)
>  		return -ENOMEM;
>  
> -	clk = devm_clk_get(&pdev->dev, "usb20");
> -	if (IS_ERR(clk)) {
> -		dev_err(&pdev->dev, "failed to get clock\n");
> -		return PTR_ERR(clk);
> -	}
> -
>  	glue->phy = devm_phy_get(&pdev->dev, "usb-phy");
>  	if (IS_ERR(glue->phy)) {
>  		if (PTR_ERR(glue->phy) != -EPROBE_DEFER)
> @@ -541,7 +528,6 @@ static int da8xx_probe(struct platform_device *pdev)
>  	}
>  
>  	glue->dev			= &pdev->dev;
> -	glue->clk			= clk;
>  
>  	if (IS_ENABLED(CONFIG_OF) && np) {
>  		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> @@ -587,6 +573,8 @@ static int da8xx_probe(struct platform_device *pdev)
>  	pinfo.data = pdata;
>  	pinfo.size_data = sizeof(*pdata);
>  
> +	pm_runtime_enable(&pdev->dev);
> +
>  	glue->musb = platform_device_register_full(&pinfo);
>  	ret = PTR_ERR_OR_ZERO(glue->musb);
>  	if (ret) {
> @@ -603,6 +591,7 @@ static int da8xx_remove(struct platform_device *pdev)
>  
>  	platform_device_unregister(glue->musb);
>  	usb_phy_generic_unregister(glue->usb_phy);
> +	pm_runtime_disable(&pdev->dev);
>  
>  	return 0;
>  }
> @@ -616,7 +605,7 @@ static int da8xx_suspend(struct device *dev)
>  	ret = phy_power_off(glue->phy);
>  	if (ret)
>  		return ret;
> -	clk_disable_unprepare(glue->clk);
> +	pm_runtime_put_sync(dev);

This, most probably will do nothing as Suspend framework will increase ref counter.
Better way might be to use PM runtime force API. pm_runtime_force_suspend()

>  
>  	return 0;
>  }
> @@ -626,7 +615,7 @@ static int da8xx_resume(struct device *dev)
>  	int ret;
>  	struct da8xx_glue *glue = dev_get_drvdata(dev);
>  
> -	ret = clk_prepare_enable(glue->clk);
> +	ret = pm_runtime_get_sync(dev);
>  	if (ret)
>  		return ret;

Better way might be to use PM runtime force API.

>  	return phy_power_on(glue->phy);
> 

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
