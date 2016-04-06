From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v6 12/12] usb: host: xhci-plat: Add otg device to platform
 data
Date: Wed, 6 Apr 2016 03:23:42 +0000
Message-ID: <SG2PR06MB09197D03470D6E6083270343D89F0@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-13-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459865117-7032-13-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Content-Language: ja-JP
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> Sent: Tuesday, April 05, 2016 11:05 PM
> 
> Host controllers that are part of an OTG/dual-role instance
> need to somehow pass the OTG controller device information
> to the HCD core.
> 
> We use platform data to pass the OTG controller device.
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/host/xhci-plat.c     | 35 ++++++++++++++++++++++++++++-------
>  include/linux/usb/xhci_pdriver.h |  3 +++
>  2 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 5c15e9b..3d0f597 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -230,11 +230,20 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  			goto put_usb3_hcd;
>  	}
> 
> -	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
> +	if (pdata->otg_dev)

I think that this should be changed like below:
	if (pdata && pdata->otg_dev)

Otherwise, panic happened on my environment (arm64 / r8a7795 board) because the pdata was NULL.

> +		ret = usb_otg_add_hcd(hcd, irq, IRQF_SHARED, pdata->otg_dev);
> +	else
> +		ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
> +
>  	if (ret)
>  		goto disable_usb_phy;
> 
> -	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> +	if (pdata->otg_dev)

Ditto.

> +		ret = usb_otg_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED,
> +				      pdata->otg_dev);
> +	else
> +		ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> +
>  	if (ret)
>  		goto dealloc_usb2_hcd;
> 
> @@ -242,7 +251,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
> 
> 
>  dealloc_usb2_hcd:
> -	usb_remove_hcd(hcd);
> +	if (pdata->otg_dev)

Ditto.

> +		usb_otg_remove_hcd(hcd);
> +	else
> +		usb_remove_hcd(hcd);
> 
>  disable_usb_phy:
>  	usb_phy_shutdown(hcd->usb_phy);
> @@ -260,16 +272,25 @@ put_hcd:
>  	return ret;
>  }
> 
> -static int xhci_plat_remove(struct platform_device *dev)
> +static int xhci_plat_remove(struct platform_device *pdev)
>  {
> -	struct usb_hcd	*hcd = platform_get_drvdata(dev);
> +	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
>  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
>  	struct clk *clk = xhci->clk;
> +	struct usb_xhci_pdata *pdata = dev_get_platdata(&pdev->dev);
> +
> +	if (pdata->otg_dev)

Ditto.

> +		usb_otg_remove_hcd(xhci->shared_hcd);
> +	else
> +		usb_remove_hcd(xhci->shared_hcd);
> 
> -	usb_remove_hcd(xhci->shared_hcd);
>  	usb_phy_shutdown(hcd->usb_phy);
> 
> -	usb_remove_hcd(hcd);
> +	if (pdata->otg_dev)

Ditto.

Best regards,
Yoshihiro Shimoda

> +		usb_otg_remove_hcd(hcd);
> +	else
> +		usb_remove_hcd(hcd);
> +
>  	usb_put_hcd(xhci->shared_hcd);
> 
>  	if (!IS_ERR(clk))
> diff --git a/include/linux/usb/xhci_pdriver.h b/include/linux/usb/xhci_pdriver.h
> index 376654b..5c68b83 100644
> --- a/include/linux/usb/xhci_pdriver.h
> +++ b/include/linux/usb/xhci_pdriver.h
> @@ -18,10 +18,13 @@
>   *
>   * @usb3_lpm_capable:	determines if this xhci platform supports USB3
>   *			LPM capability
> + * @otg_dev:		OTG controller device. Only requied if part of
> + *			OTG/dual-role.
>   *
>   */
>  struct usb_xhci_pdata {
>  	unsigned	usb3_lpm_capable:1;
> +	struct device	*otg_dev;
>  };
> 
>  #endif /* __USB_CORE_XHCI_PDRIVER_H */
> --
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
