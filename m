From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v7 14/14] usb: host: xhci-plat: Add otg device to
 platform data
Date: Wed, 11 May 2016 17:00:27 +0800
Message-ID: <20160511090027.GK16910@shlinux2.ap.freescale.net>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
 <1462191537-10314-15-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462191537-10314-15-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: peter.chen@freescale.com, stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 02, 2016 at 03:18:57PM +0300, Roger Quadros wrote:
> Host controllers that are part of an OTG/dual-role instance
> need to somehow pass the OTG controller device information
> to the HCD core.
> 
> We use platform data to pass the OTG controller device.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/host/xhci-plat.c     | 35 ++++++++++++++++++++++++++++-------
>  include/linux/usb/xhci_pdriver.h |  3 +++
>  2 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 5c15e9b..84ebe18 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -230,11 +230,20 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  			goto put_usb3_hcd;
>  	}
>  
> -	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
> +	if (pdata && pdata->otg_dev)
> +		ret = usb_otg_add_hcd(hcd, irq, IRQF_SHARED, pdata->otg_dev);
> +	else
> +		ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
> +
>  	if (ret)
>  		goto disable_usb_phy;
>  
> -	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> +	if (pdata && pdata->otg_dev)
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
> +	if (pdata && pdata->otg_dev)
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
> +	if (pdata && pdata->otg_dev)
> +		usb_otg_remove_hcd(xhci->shared_hcd);
> +	else
> +		usb_remove_hcd(xhci->shared_hcd);
>  
> -	usb_remove_hcd(xhci->shared_hcd);
>  	usb_phy_shutdown(hcd->usb_phy);
>  
> -	usb_remove_hcd(hcd);
> +	if (pdata && pdata->otg_dev)
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
> 2.7.4
> 

Reviewed-by: Peter Chen <peter.chen@nxp.com>

-- 

Best Regards,
Peter Chen
