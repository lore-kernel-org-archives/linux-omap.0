From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v10 14/14] usb: host: xhci-plat: Add otg device to
 platform data
Date: Tue, 14 Jun 2016 11:18:51 +0300
Message-ID: <575FBDEB.3050004@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-15-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465564043-27163-15-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mathias.nyman@linux.intel.com
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Mathias,

On 10/06/16 16:07, Roger Quadros wrote:
> Host controllers that are part of an OTG/dual-role instance
> need to somehow pass the OTG controller device information
> to the HCD core.
> 
> We use platform data to pass the OTG controller device.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Reviewed-by: Peter Chen <peter.chen@nxp.com>
> ---
>  drivers/usb/host/xhci-plat.c     | 35 ++++++++++++++++++++++++++++-------
>  include/linux/usb/xhci_pdriver.h |  3 +++
>  2 files changed, 31 insertions(+), 7 deletions(-)

Any comments on this one?

> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 676ea45..24d030a 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -239,11 +239,20 @@ static int xhci_plat_probe(struct platform_device *pdev)
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
> @@ -251,7 +260,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
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
> @@ -269,16 +281,25 @@ put_hcd:
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
> 
