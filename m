Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651B3AEF55;
	Sun, 18 Oct 2026 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792324486; cv=none; b=NKpV4gaLCsRZQwR/zrnhrEmUFKAsKyx9zO0vr5UUoDTFWzcMiRK8LKFB+EqTy9mMFxA9PKQTVwkxEwZBxnRghuNROtze/k5kJzsJRkWJWq+J0QLxYvFpwXb5rulXl4EevW1vP4AIpeNFgkId0IzW/7T3WrwX8Fl68WpZvATdivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792324486; c=relaxed/simple;
	bh=XbgBIHMFKGFcE9LC7gmsbmSS9wfP3Jtj0ni7YB++Xmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6K6evf0k8TQiW4Q8Y6sx/pcxd+jdK0F6OxOfBxjjnpAF5kA8esNCKTsNpKQ6vYvZ111MIktEuCOz22yj/EubAHYtrP6OIrLcOkL9fVrc/9LLtZIFKhA/YWDtooJzVjM0Jbl/fM9RWE38tVq3ne1U/qhm57gzjtHC1gvf5tl4hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wpzH6F2q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wpzH6F2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E953A1F000C4;
	Sun, 18 Oct 2026 11:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792324484;
	bh=SXLZZh2SqVfX3v6EiQb+U1FG7TVR/66f3oBiFcuMpBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wpzH6F2qGX2618TJz1EE/JNFUA9FHeUI/cKZpxfOxkjNqdt9770t3yjli04Og+h1G
	 o4NxxrgfafKKXZZOmwsezpIx/TlmCdVhNtnmT4TZBTc+JQRC47Eu0soYII4FS2PIor
	 pzZ88I6iAqqG9rb2QMQ9uxog9sEG8fNoCbFtOFXQ=
Date: Sun, 18 Oct 2026 13:54:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: ohci-omap: handle root hub overcurrent
Message-ID: <2026101827-compactly-yippee-0be3@gregkh>
References: <20261018015747.246611-1-ampr.mhd@gmail.com>
 <20261018111124.32979-1-ampr.mhd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018111124.32979-1-ampr.mhd@gmail.com>

On Sun, Oct 18, 2026 at 02:41:24PM +0330, Muhammad Mahdi Amirpour wrote:
> Handle overcurrent GPIO interrupts, disable port power when
> overcurrent is detected, and report the status through the
> root hub port status.
> 
> Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
> ---
>  drivers/usb/host/ohci-omap.c | 212 +++++++++++++++++++++++++++++++----
>  1 file changed, 191 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
> index f6e56c4b9914..2a08147dc5fa 100644
> --- a/drivers/usb/host/ohci-omap.c
> +++ b/drivers/usb/host/ohci-omap.c
> @@ -15,6 +15,7 @@
>   * This file is licenced under the GPL.
>   */
>  
> +#include <linux/irqreturn.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> @@ -33,6 +34,9 @@
>  #include <linux/signal.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> +#include <linux/interrupt.h>
> +#include <linux/spinlock.h>
> +#include <linux/usb/ch11.h>
>  
>  #include "ohci.h"
>  
> @@ -46,6 +50,10 @@ struct ohci_omap_priv {
>  	struct clk *usb_dc_ck;
>  	struct gpio_desc *power;
>  	struct gpio_desc *overcurrent;
> +	spinlock_t overcurrent_lock;
> +	bool overcurrent_status;
> +	bool overcurrent_changed;
> +	int overcurrent_irq;
>  };
>  
>  static const char hcd_name[] = "ohci-omap";
> @@ -181,11 +189,110 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
>  	return 0;
>  }
>  
> +static irqreturn_t ohci_omap_overcurrent_irq(int irq, void *data)
> +{
> +	struct usb_hcd *hcd = data;
> +	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
> +	unsigned long flags;
> +	int status;
> +
> +	status = gpiod_get_value_cansleep(priv->overcurrent);
> +	if (status < 0)
> +		return IRQ_HANDLED;
> +
> +	if (status && priv->power)
> +		gpiod_set_value_cansleep(priv->power, 0);
> +
> +	spin_lock_irqsave(&priv->overcurrent_lock, flags);
> +	if (!!status != priv->overcurrent_status)
> +		priv->overcurrent_changed = true;
> +	priv->overcurrent_status = !!status;
> +	spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
> +
> +	usb_hcd_poll_rh_status(hcd);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ohci_omap_hub_status_data(struct usb_hcd *hcd, char *buf)
> +{
> +	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
> +	unsigned long flags;
> +	bool changed;
> +	int length;
> +
> +	length = ohci_hub_status_data(hcd, buf);
> +
> +	spin_lock_irqsave(&priv->overcurrent_lock, flags);
> +	changed = priv->overcurrent_changed;
> +	spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
> +
> +	if (changed) {
> +		if (!length) {
> +			buf[0] = 0;
> +			length = 1;
> +		}
> +		buf[0] |= BIT(1);
> +	}
> +
> +	return length;
> +}
> +
> +static int ohci_omap_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> +				 u16 wIndex, char *buf, u16 wLength)
> +{
> +	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
> +	unsigned long flags;
> +	bool status, changed;
> +	__le32 *portstatus;
> +	u32 value;
> +	int ret;
> +
> +	ret = ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
> +	if (ret)
> +		return ret;
> +
> +	if (typeReq == ClearPortFeature && wIndex == 1 &&
> +	    wValue == USB_PORT_FEAT_C_OVER_CURRENT) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&priv->overcurrent_lock, flags);
> +		priv->overcurrent_changed = false;
> +		spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
> +		return 0;
> +	}
> +
> +	if (typeReq != GetPortStatus || wIndex != 1)
> +		return ret;
> +
> +	spin_lock_irqsave(&priv->overcurrent_lock, flags);
> +	status = priv->overcurrent_status;
> +	changed = priv->overcurrent_changed;
> +	spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
> +
> +	portstatus = (__le32 *)buf;
> +	value = le32_to_cpu(*portstatus);
> +
> +	if (status)
> +		value |= USB_PORT_STAT_OVERCURRENT;
> +	else
> +		value &= ~USB_PORT_STAT_OVERCURRENT;
> +
> +	if (changed)
> +		value |= USB_PORT_STAT_C_OVERCURRENT;
> +	else
> +		value &= ~USB_PORT_STAT_C_OVERCURRENT;
> +
> +	*portstatus = cpu_to_le32(value);
> +
> +	return 0;
> +}
> +
>  /*-------------------------------------------------------------------------*/
>  
>  /**
>   * ohci_hcd_omap_probe - initialize OMAP-based HCDs
> - * @pdev:	USB controller to probe
> + * @pdev: USB controller to probe
>   *
>   * Context: task context, might sleep
>   *
> @@ -196,50 +303,53 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
>  static int ohci_hcd_omap_probe(struct platform_device *pdev)
>  {
>  	int retval, irq;
> -	struct usb_hcd *hcd = 0;
> +	struct usb_hcd *hcd;
>  	struct ohci_omap_priv *priv;
>  
>  	if (pdev->num_resources != 2) {
>  		dev_err(&pdev->dev, "invalid num_resources: %i\n",
> -		       pdev->num_resources);
> +			pdev->num_resources);
>  		return -ENODEV;
>  	}
>  
> -	if (pdev->resource[0].flags != IORESOURCE_MEM
> -			|| pdev->resource[1].flags != IORESOURCE_IRQ) {
> +	if (pdev->resource[0].flags != IORESOURCE_MEM ||
> +	    pdev->resource[1].flags != IORESOURCE_IRQ) {
>  		dev_err(&pdev->dev, "invalid resource type\n");
>  		return -ENODEV;
>  	}
>  
>  	hcd = usb_create_hcd(&ohci_omap_hc_driver, &pdev->dev,
> -			dev_name(&pdev->dev));
> +			     dev_name(&pdev->dev));
>  	if (!hcd)
>  		return -ENOMEM;
>  
>  	hcd->rsrc_start = pdev->resource[0].start;
> -	hcd->rsrc_len = pdev->resource[0].end - pdev->resource[0].start + 1;
> +	hcd->rsrc_len = pdev->resource[0].end -
> +			pdev->resource[0].start + 1;
>  	priv = hcd_to_ohci_omap_priv(hcd);
>  
> -	/* Obtain two optional GPIO lines */
> -	priv->power = devm_gpiod_get_optional(&pdev->dev, "power", GPIOD_ASIS);
> +	spin_lock_init(&priv->overcurrent_lock);
> +	priv->overcurrent_status = false;
> +	priv->overcurrent_changed = false;
> +	priv->overcurrent_irq = -1;
> +
> +	priv->power = devm_gpiod_get_optional(&pdev->dev, "power",
> +					      GPIOD_ASIS);
>  	if (IS_ERR(priv->power)) {
>  		retval = PTR_ERR(priv->power);
>  		goto err_put_hcd;
>  	}
> +
>  	if (priv->power)
>  		gpiod_set_consumer_name(priv->power, "OHCI power");
>  
> -	/*
> -	 * This "overcurrent" GPIO line isn't really used in the code,
> -	 * but has a designated hardware function.
> -	 * TODO: implement proper overcurrent handling.
> -	 */
> -	priv->overcurrent = devm_gpiod_get_optional(&pdev->dev, "overcurrent",
> -						    GPIOD_IN);
> +	priv->overcurrent = devm_gpiod_get_optional(&pdev->dev,
> +						    "overcurrent", GPIOD_IN);
>  	if (IS_ERR(priv->overcurrent)) {
>  		retval = PTR_ERR(priv->overcurrent);
>  		goto err_put_hcd;
>  	}
> +
>  	if (priv->overcurrent)
>  		gpiod_set_consumer_name(priv->overcurrent, "OHCI overcurrent");
>  
> @@ -277,23 +387,77 @@ static int ohci_hcd_omap_probe(struct platform_device *pdev)
>  	if (!hcd->regs) {
>  		dev_err(&pdev->dev, "can't ioremap OHCI HCD\n");
>  		retval = -ENOMEM;
> -		goto err2;
> +		goto err_release_mem;
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		retval = irq;
> -		goto err3;
> +		goto err_iounmap;
>  	}
> +
>  	retval = usb_add_hcd(hcd, irq, 0);
>  	if (retval)
> -		goto err3;
> +		goto err_iounmap;
> +
> +	if (priv->overcurrent) {
> +		int status;
> +		unsigned long flags;
> +
> +		priv->overcurrent_irq = gpiod_to_irq(priv->overcurrent);
> +		if (priv->overcurrent_irq < 0) {
> +			retval = priv->overcurrent_irq;
> +			goto err_remove_hcd;
> +		}
> +
> +		retval = request_threaded_irq(priv->overcurrent_irq, NULL,
> +					      ohci_omap_overcurrent_irq,
> +					      IRQF_ONESHOT |
> +					      IRQF_TRIGGER_RISING |
> +					      IRQF_TRIGGER_FALLING,
> +					      "ohci-omap-overcurrent", hcd);
> +		if (retval) {
> +			priv->overcurrent_irq = -1;
> +			goto err_remove_hcd;
> +		}
> +
> +		/*
> +		 * Synchronize the initial GPIO sample with the threaded
> +		 * handler so it cannot overwrite the sampled state.
> +		 */
> +		disable_irq(priv->overcurrent_irq);
> +
> +		status = gpiod_get_value_cansleep(priv->overcurrent);
> +		if (status < 0) {
> +			retval = status;
> +			enable_irq(priv->overcurrent_irq);
> +			goto err_remove_hcd;
> +		}
> +
> +		spin_lock_irqsave(&priv->overcurrent_lock, flags);
> +		priv->overcurrent_status = !!status;
> +		priv->overcurrent_changed = true;
> +		spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
> +
> +		if (status && priv->power)
> +			gpiod_set_value_cansleep(priv->power, 0);
> +
> +		enable_irq(priv->overcurrent_irq);
> +		usb_hcd_poll_rh_status(hcd);
> +	}
>  
>  	device_wakeup_enable(hcd->self.controller);
>  	return 0;
> -err3:
> +
> +err_remove_hcd:
> +	if (priv->overcurrent_irq >= 0) {
> +		free_irq(priv->overcurrent_irq, hcd);
> +		priv->overcurrent_irq = -1;
> +	}
> +	usb_remove_hcd(hcd);
> +err_iounmap:
>  	iounmap(hcd->regs);
> -err2:
> +err_release_mem:
>  	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
>  err_unprepare_dc_ck:
>  	clk_unprepare(priv->usb_dc_ck);
> @@ -327,6 +491,10 @@ static void ohci_hcd_omap_remove(struct platform_device *pdev)
>  	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
>  
>  	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
> +	if (priv->overcurrent_irq >= 0) {
> +		free_irq(priv->overcurrent_irq, hcd);
> +		priv->overcurrent_irq = -1;
> +	}
>  	usb_remove_hcd(hcd);
>  	omap_ohci_clock_power(priv, 0);
>  	if (!IS_ERR_OR_NULL(hcd->usb_phy)) {
> @@ -413,6 +581,8 @@ static int __init ohci_omap_init(void)
>  		return -ENODEV;
>  
>  	ohci_init_driver(&ohci_omap_hc_driver, &omap_overrides);
> +	ohci_omap_hc_driver.hub_status_data = ohci_omap_hub_status_data;
> +	ohci_omap_hc_driver.hub_control = ohci_omap_hub_control;
>  	return platform_driver_register(&ohci_hcd_omap_driver);
>  }
>  module_init(ohci_omap_init);
> -- 
> 2.55.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
