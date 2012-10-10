From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [PATCH 2/3] usb: xhci: Add the suspend/resume functionality
Date: Wed, 10 Oct 2012 10:58:16 -0700
Message-ID: <20121010175816.GP18378@xanatos>
References: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
 <1349877949-18872-3-git-send-email-vikas.sajjan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26950 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756200Ab2JJR6U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Oct 2012 13:58:20 -0400
Content-Disposition: inline
In-Reply-To: <1349877949-18872-3-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikas C Sajjan <vikas.sajjan@linaro.org>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

On Wed, Oct 10, 2012 at 07:35:48PM +0530, Vikas C Sajjan wrote:
> From: Vikas Sajjan <vikas.sajjan@linaro.org>
> 
> Adding the suspend and resume functionality for the XHCI driver
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
> CC: Doug Anderson <dianders@chromium.org>

Acked-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>

Felipe, you want to take this?

> ---
>  drivers/usb/host/xhci-plat.c |   44 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 44 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index df90fe5..384cf4d 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -185,11 +185,55 @@ static int xhci_plat_remove(struct platform_device *dev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int xhci_plat_suspend(struct device *dev)
> +{
> +	struct usb_hcd		*hcd;
> +	struct xhci_hcd		*xhci;
> +
> +	hcd = dev_get_drvdata(dev);
> +	if (!hcd)
> +		return -EINVAL;
> +
> +	xhci = hcd_to_xhci(hcd);
> +
> +	/* Make sure that the HCD Core as set state HC_STATE_SUSPENDED */
> +	if (hcd->state != HC_STATE_SUSPENDED ||
> +		xhci->shared_hcd->state != HC_STATE_SUSPENDED)
> +		return -EINVAL;
> +
> +	return xhci_suspend(xhci);
> +}
> +
> +static int xhci_plat_resume(struct device *dev)
> +{
> +	struct usb_hcd		*hcd;
> +	struct xhci_hcd		*xhci;
> +
> +	hcd = dev_get_drvdata(dev);
> +
> +	if (!hcd)
> +		return -EINVAL;
> +
> +	xhci = hcd_to_xhci(hcd);
> +
> +	return xhci_resume(xhci, 0);
> +}
> +
> +static const struct dev_pm_ops xhci_plat_pm_ops = {
> +	.suspend		= xhci_plat_suspend,
> +	.resume			= xhci_plat_resume,
> +};
> +#endif
> +
>  static struct platform_driver usb_xhci_driver = {
>  	.probe	= xhci_plat_probe,
>  	.remove	= xhci_plat_remove,
>  	.driver	= {
>  		.name = "xhci-hcd",
> +#ifdef CONFIG_PM
> +		.pm = &xhci_plat_pm_ops,
> +#endif
>  	},
>  };
>  MODULE_ALIAS("platform:xhci-hcd");
> -- 
> 1.7.6.5
> 
