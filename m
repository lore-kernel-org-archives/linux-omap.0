From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [PATCH v3 2/3] usb: xhci: Add the suspend/resume functionality
Date: Thu, 18 Oct 2012 07:59:56 -0700
Message-ID: <20121018145956.GS5378@xanatos>
References: <1350380738-32473-1-git-send-email-vikas.sajjan@linaro.org>
 <1350380738-32473-3-git-send-email-vikas.sajjan@linaro.org>
 <20121016095932.GA17416@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24311 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885Ab2JRPAH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 11:00:07 -0400
Content-Disposition: inline
In-Reply-To: <20121016095932.GA17416@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Vikas Sajjan <vikas.sajjan@linaro.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

On Tue, Oct 16, 2012 at 12:59:33PM +0300, Felipe Balbi wrote:
> Hi,
> 
> > +#ifdef CONFIG_PM_SLEEP
> > +static int xhci_plat_suspend(struct device *dev)
> > +{
> > +	struct usb_hcd	*hcd	= dev_get_drvdata(dev);
> > +	struct xhci_hcd	*xhci	= hcd_to_xhci(hcd);
> > +
> > +	/* Make sure that the HCD Core has set state to HC_STATE_SUSPENDED */
> > +	if (hcd->state != HC_STATE_SUSPENDED ||
> > +		xhci->shared_hcd->state != HC_STATE_SUSPENDED)
> > +		return -EINVAL;
> > +
> > +	return xhci_suspend(xhci);
> 
> this is pretty much what xhci_pci_suspend() is doing. Sarah, would you
> be ok with a patch such as:

Yes, that patch looks fine.

> usb: host: xhci: move HC_STATE_SUSPENDED check to xhci_suspend()
> 
> [ STILL NEED TO WRITE A PROPER COMMIT LOG ]
> 
> NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 8345d7c..aeb3973 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -218,15 +218,8 @@ static void xhci_pci_remove(struct pci_dev *dev)
>  static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
>  {
>  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> -	int	retval = 0;
>  
> -	if (hcd->state != HC_STATE_SUSPENDED ||
> -			xhci->shared_hcd->state != HC_STATE_SUSPENDED)
> -		return -EINVAL;
> -
> -	retval = xhci_suspend(xhci);
> -
> -	return retval;
> +	return xhci_suspend(xhci);
>  }
>  
>  static int xhci_pci_resume(struct usb_hcd *hcd, bool hibernated)
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 8d7fcbb..b85029e 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -879,6 +879,10 @@ int xhci_suspend(struct xhci_hcd *xhci)
>  	struct usb_hcd		*hcd = xhci_to_hcd(xhci);
>  	u32			command;
>  
> +	if (hcd->state != HC_STATE_SUSPENDED ||
> +			xhci->shared_hcd->state != HC_STATE_SUSPENDED)
> +		return -EINVAL;
> +
>  	spin_lock_irq(&xhci->lock);
>  	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
>  	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
> 
> do you think there is any reason to keep replicating the
> HC_STATE_SUSPENDED test all over the place ?

Nope, no reason I can see.  I'm pretty sure I only check the suspended
state in case the code in the USB core to handle the host controller
suspend ever breaks for the corner case of the host hardware needing two
roothubs (USB 2.0 and USB 3.0 in this case).  It doesn't matter if we
check that in the PCI/platform suspend or in xhci_suspend, as long as it
gets checked.

Sarah Sharp
