From: Ruchika Kharwar <ruchika-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] [RFC] usb: dwc3: removal of assumption that usb3 phy
 always present
Date: Fri, 5 Jul 2013 09:35:05 -0500
Message-ID: <51D6D999.5020505@ti.com>
References: <1372919202-26755-1-git-send-email-ruchika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1372919202-26755-1-git-send-email-ruchika-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ruchika Kharwar <ruchika-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 07/04/2013 01:26 AM, Ruchika Kharwar wrote:
> DRA7XX has several USB OTG subsystems. USB_OTG_SS1 includes a USB1 and USB2
> phy. USB_OTG_SS2 includes only a USB2 phy.
> This patch allows the dwc3 probe to continue if a usb3_phy is not found.
The need for this will go away as soon as "of_get_maximum_speed" is 
introduced. The speed can then be used to determine if a USB3 phy is 
required or not for dra7xx as well.
>
> This patch currently works for DRA7XX and submitted in the interim a nicer
> method emerges.
>
> Signed-off-by: Ruchika Kharwar <ruchika-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/usb/dwc3/core.c   |   38 ++++++++++++++++++++------------------
>   drivers/usb/dwc3/gadget.c |   11 ++++++++---
>   2 files changed, 28 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 358375e..feea92d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -100,7 +100,10 @@ static void dwc3_core_soft_reset(struct dwc3 *dwc)
>   	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>   
>   	usb_phy_init(dwc->usb2_phy);
> -	usb_phy_init(dwc->usb3_phy);
> +
> +	if (!IS_ERR(dwc->usb3_phy))
> +		usb_phy_init(dwc->usb3_phy);
> +
>   	mdelay(100);
>   
>   	/* Clear USB3 PHY reset */
> @@ -360,7 +363,9 @@ err0:
>   static void dwc3_core_exit(struct dwc3 *dwc)
>   {
>   	usb_phy_shutdown(dwc->usb2_phy);
> -	usb_phy_shutdown(dwc->usb3_phy);
> +
> +	if (!IS_ERR(dwc->usb3_phy))
> +		usb_phy_shutdown(dwc->usb3_phy);
>   }
>   
>   #define DWC3_ALIGN_MASK		(16 - 1)
> @@ -450,22 +455,13 @@ static int dwc3_probe(struct platform_device *pdev)
>   	}
>   
>   	if (IS_ERR(dwc->usb3_phy)) {
> -		ret = PTR_ERR(dwc->usb3_phy);
> -
> -		/*
> -		 * if -ENXIO is returned, it means PHY layer wasn't
> -		 * enabled, so it makes no sense to return -EPROBE_DEFER
> -		 * in that case, since no PHY driver will ever probe.
> -		 */
> -		if (ret == -ENXIO)
> -			return ret;
> -
> -		dev_err(dev, "no usb3 phy configured\n");
> -		return -EPROBE_DEFER;
> +		dev_dbg(dev, "no usb3 phy configured, possibly absent\n");
>   	}
>   
>   	usb_phy_set_suspend(dwc->usb2_phy, 0);
> -	usb_phy_set_suspend(dwc->usb3_phy, 0);
> +
> +	if (!IS_ERR(dwc->usb3_phy))
> +		usb_phy_set_suspend(dwc->usb3_phy, 0);
>   
>   	spin_lock_init(&dwc->lock);
>   	platform_set_drvdata(pdev, dwc);
> @@ -604,7 +600,9 @@ static int dwc3_remove(struct platform_device *pdev)
>   	struct dwc3	*dwc = platform_get_drvdata(pdev);
>   
>   	usb_phy_set_suspend(dwc->usb2_phy, 1);
> -	usb_phy_set_suspend(dwc->usb3_phy, 1);
> +
> +	if (!IS_ERR(dwc->usb3_phy))
> +		usb_phy_set_suspend(dwc->usb3_phy, 1);
>   
>   	pm_runtime_put(&pdev->dev);
>   	pm_runtime_disable(&pdev->dev);
> @@ -700,7 +698,9 @@ static int dwc3_suspend(struct device *dev)
>   	dwc->gctl = dwc3_readl(dwc->regs, DWC3_GCTL);
>   	spin_unlock_irqrestore(&dwc->lock, flags);
>   
> -	usb_phy_shutdown(dwc->usb3_phy);
> +	if (!IS_ERR(dwc->usb3_phy))
> +		usb_phy_shutdown(dwc->usb3_phy);
> +
>   	usb_phy_shutdown(dwc->usb2_phy);
>   
>   	return 0;
> @@ -711,7 +711,9 @@ static int dwc3_resume(struct device *dev)
>   	struct dwc3	*dwc = dev_get_drvdata(dev);
>   	unsigned long	flags;
>   
> -	usb_phy_init(dwc->usb3_phy);
> +	if (!IS_ERR(dwc->usb3_phy))
> +		usb_phy_init(dwc->usb3_phy);
> +
>   	usb_phy_init(dwc->usb2_phy);
>   	msleep(100);
>   
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index b5e5b35..7ca3745 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2176,7 +2176,9 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
>   	if (dwc->revision < DWC3_REVISION_194A) {
>   		/* Resume PHYs */
>   		dwc3_gadget_usb2_phy_suspend(dwc, false);
> -		dwc3_gadget_usb3_phy_suspend(dwc, false);
> +
> +		if (!IS_ERR(dwc->usb3_phy))
> +			dwc3_gadget_usb3_phy_suspend(dwc, false);
>   	}
>   
>   	if (dwc->gadget.speed != USB_SPEED_UNKNOWN)
> @@ -2231,7 +2233,8 @@ static void dwc3_gadget_phy_suspend(struct dwc3 *dwc, u8 speed)
>   	case USB_SPEED_HIGH:
>   	case USB_SPEED_FULL:
>   	case USB_SPEED_LOW:
> -		dwc3_gadget_usb3_phy_suspend(dwc, true);
> +		if (!IS_ERR(dwc->usb3_phy))
> +			dwc3_gadget_usb3_phy_suspend(dwc, true);
>   		break;
>   	}
>   }
> @@ -2649,7 +2652,9 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>   	/* Enable USB2 LPM and automatic phy suspend only on recent versions */
>   	if (dwc->revision >= DWC3_REVISION_194A) {
>   		dwc3_gadget_usb2_phy_suspend(dwc, false);
> -		dwc3_gadget_usb3_phy_suspend(dwc, false);
> +
> +		if (!IS_ERR(dwc->usb3_phy))
> +			dwc3_gadget_usb3_phy_suspend(dwc, false);
>   	}
>   
>   	ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
