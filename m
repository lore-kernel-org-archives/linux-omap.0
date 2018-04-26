From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] mfd: omap-usb-host: Fix dts probe of children
Date: Thu, 26 Apr 2018 13:25:44 +0300
Message-ID: <e3d78586-2e57-b7ca-70da-584f41845aa2@ti.com>
References: <20180425142922.128233-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425142922.128233-1-tony@atomide.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 25/04/18 17:29, Tony Lindgren wrote:
> It currently only works if the parent bus uses "simple-bus". We
> currently try to probe children with non-existing compatible values.
> And we're missing .probe.
> 
> I noticed this while testing devices configured to probe using ti-sysc
> interconnect target module driver. For that we also may want to rebind
> the driver, so let's remove __init and __exit.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
> 
> This is OK to wait for v4.18 merge window as the related dts node has
> not yet been updated to probe via ti-sysc interconnect target driver.
> 
> ---
>  drivers/mfd/omap-usb-host.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -548,8 +548,8 @@ static int usbhs_omap_get_dt_pdata(struct device *dev,
>  }
>  
>  static const struct of_device_id usbhs_child_match_table[] = {
> -	{ .compatible = "ti,omap-ehci", },
> -	{ .compatible = "ti,omap-ohci", },
> +	{ .compatible = "ti,ehci-omap", },
> +	{ .compatible = "ti,ohci-omap3", },
>  	{ }
>  };
>  
> @@ -875,6 +875,7 @@ static struct platform_driver usbhs_omap_driver = {
>  		.pm		= &usbhsomap_dev_pm_ops,
>  		.of_match_table = usbhs_omap_dt_ids,
>  	},
> +	.probe		= usbhs_omap_probe,
>  	.remove		= usbhs_omap_remove,
>  };
>  
> @@ -884,9 +885,9 @@ MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("usb host common core driver for omap EHCI and OHCI");
>  
> -static int __init omap_usbhs_drvinit(void)
> +static int omap_usbhs_drvinit(void)
>  {
> -	return platform_driver_probe(&usbhs_omap_driver, usbhs_omap_probe);
> +	return platform_driver_register(&usbhs_omap_driver);
>  }
>  
>  /*
> @@ -898,7 +899,7 @@ static int __init omap_usbhs_drvinit(void)
>   */
>  fs_initcall_sync(omap_usbhs_drvinit);
>  
> -static void __exit omap_usbhs_drvexit(void)
> +static void omap_usbhs_drvexit(void)
>  {
>  	platform_driver_unregister(&usbhs_omap_driver);
>  }
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
