From: Paul Zimmerman <Paul.Zimmerman-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: RE: [PATCH] usb: dwc3: core: modify IO memory resource after
 deferred probe completes
Date: Thu, 25 Jul 2013 19:46:58 +0000
Message-ID: <A2CA0424C0A6F04399FB9E1CD98E030458DE112E@US01WEMBX2.internal.synopsys.com>
References: <1374769590-14491-1-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1374769590-14491-1-git-send-email-iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> From: Ivan T. Ivanov
> Sent: Thursday, July 25, 2013 9:27 AM
> 
> When deferred probe happens driver will try to ioremap multiple times
> and will fail. Memory resource.start variable is a global variable,
> modifications in this field will be accumulated on every probe.
> Fix this by moving the above operations after driver hold all
> required PHY's.
> 
> Signed-off-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/usb/dwc3/core.c |   31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 607bef8..50c833f 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -384,21 +384,6 @@ static int dwc3_probe(struct platform_device *pdev)
>  		dev_err(dev, "missing memory resource\n");
>  		return -ENODEV;
>  	}
> -	dwc->xhci_resources[0].start = res->start;
> -	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
> -					DWC3_XHCI_REGS_END;
> -	dwc->xhci_resources[0].flags = res->flags;
> -	dwc->xhci_resources[0].name = res->name;
> -
> -	res->start += DWC3_GLOBALS_REGS_START;
> -
> -	 /*
> -	  * Request memory region but exclude xHCI regs,
> -	  * since it will be requested by the xhci-plat driver.
> -	  */
> -	regs = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(regs))
> -		return PTR_ERR(regs);
> 
>  	if (node) {
>  		dwc->maximum_speed = of_usb_get_maximum_speed(node);
> @@ -452,6 +437,22 @@ static int dwc3_probe(struct platform_device *pdev)
>  		return -EPROBE_DEFER;
>  	}
> 
> +	dwc->xhci_resources[0].start = res->start;
> +	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
> +					DWC3_XHCI_REGS_END;
> +	dwc->xhci_resources[0].flags = res->flags;
> +	dwc->xhci_resources[0].name = res->name;
> +
> +	res->start += DWC3_GLOBALS_REGS_START;

Ick. The driver is modifying the struct resource passed to it by the
platform code? That seems like a layering violation, and is fragile as
hell. In addition to this bug, what would happen if the struct resource
was declared 'const'?

-- 
Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
