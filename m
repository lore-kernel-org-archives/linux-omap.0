From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] USB: OHCI: ohci-omap: remove useless functions
Date: Fri, 2 Dec 2016 14:46:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1612021445530.1510-100000@iolanthe.rowland.org>
References: <1480640144-13485-1-git-send-email-csmanjuvijay@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480640144-13485-1-git-send-email-csmanjuvijay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: csmanjuvijay@gmail.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 2 Dec 2016 csmanjuvijay@gmail.com wrote:

> From: Manjunath Goudar <csmanjuvijay@gmail.com>
> 
> The ohci_hcd_omap_drv_probe and ohci_hcd_omap_drv_remove
> functions are removed as these are useless functions except calling
> usb_hcd_omap_probe and usb_hcd_omap_remove functions.
> 
> The usb_hcd_omap_probe function renamed to ohci_hcd_omap_probe
> and usb_hcd_omap_remove function renamed to ohci_hcd_omap_remove
> for proper naming.
> 
> Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ohci-omap.c | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
> index 495c145..1e809d7 100644
> --- a/drivers/usb/host/ohci-omap.c
> +++ b/drivers/usb/host/ohci-omap.c
> @@ -296,15 +296,14 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
>  /*-------------------------------------------------------------------------*/
>  
>  /**
> - * usb_hcd_omap_probe - initialize OMAP-based HCDs
> + * ohci_hcd_omap_probe - initialize OMAP-based HCDs
>   * Context: !in_interrupt()
>   *
>   * Allocates basic resources for this USB host controller, and
>   * then invokes the start() method for the HCD associated with it
>   * through the hotplug entry's driver_data.
>   */
> -static int usb_hcd_omap_probe (const struct hc_driver *driver,
> -			  struct platform_device *pdev)
> +static int ohci_hcd_omap_probe(struct platform_device *pdev)
>  {
>  	int retval, irq;
>  	struct usb_hcd *hcd = 0;
> @@ -336,7 +335,8 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
>  	}
>  
>  
> -	hcd = usb_create_hcd (driver, &pdev->dev, dev_name(&pdev->dev));
> +	hcd = usb_create_hcd(&ohci_omap_hc_driver, &pdev->dev,
> +			dev_name(&pdev->dev));
>  	if (!hcd) {
>  		retval = -ENOMEM;
>  		goto err0;
> @@ -384,17 +384,18 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
>  /* may be called with controller, bus, and devices active */
>  
>  /**
> - * usb_hcd_omap_remove - shutdown processing for OMAP-based HCDs
> + * ohci_hcd_omap_remove - shutdown processing for OMAP-based HCDs
>   * @dev: USB Host Controller being removed
>   * Context: !in_interrupt()
>   *
> - * Reverses the effect of usb_hcd_omap_probe(), first invoking
> + * Reverses the effect of ohci_hcd_omap_probe(), first invoking
>   * the HCD's stop() method.  It is always called from a thread
>   * context, normally "rmmod", "apmd", or something similar.
>   */
> -static inline void
> -usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
> +static int ohci_hcd_omap_remove(struct platform_device *pdev)
>  {
> +	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
> +
>  	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
>  	usb_remove_hcd(hcd);
>  	omap_ohci_clock_power(0);
> @@ -409,21 +410,6 @@ usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
>  	usb_put_hcd(hcd);
>  	clk_put(usb_dc_ck);
>  	clk_put(usb_host_ck);
> -}
> -
> -/*-------------------------------------------------------------------------*/
> -
> -static int ohci_hcd_omap_drv_probe(struct platform_device *dev)
> -{
> -	return usb_hcd_omap_probe(&ohci_omap_hc_driver, dev);
> -}
> -
> -static int ohci_hcd_omap_drv_remove(struct platform_device *dev)
> -{
> -	struct usb_hcd		*hcd = platform_get_drvdata(dev);
> -
> -	usb_hcd_omap_remove(hcd, dev);
> -
>  	return 0;
>  }
>  
> @@ -472,8 +458,8 @@ static int ohci_omap_resume(struct platform_device *dev)
>   * Driver definition to register with the OMAP bus
>   */
>  static struct platform_driver ohci_hcd_omap_driver = {
> -	.probe		= ohci_hcd_omap_drv_probe,
> -	.remove		= ohci_hcd_omap_drv_remove,
> +	.probe		= ohci_hcd_omap_probe,
> +	.remove		= ohci_hcd_omap_remove,
>  	.shutdown	= usb_hcd_platform_shutdown,
>  #ifdef	CONFIG_PM
>  	.suspend	= ohci_omap_suspend,
> 
