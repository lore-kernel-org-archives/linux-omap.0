From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC 2/2] usb: ehci-omap: add suspend/resume support
Date: Thu, 13 May 2010 13:09:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005131305320.1731-100000@iolanthe.rowland.org>
References: <1273762822-23073-2-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34735 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754652Ab0EMRJs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 13:09:48 -0400
In-Reply-To: <1273762822-23073-2-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Ajay Kumar Gupta <ajay.gupta@ti.com>

On Thu, 13 May 2010, Anand Gadiyar wrote:

> Add support for suspend and resume to the ehci-omap driver.
> Added routines for platform_driver suspend/resume and 
> wrappers around ehci_bus_suspend/resume.

> +#ifdef CONFIG_PM
>  /*-------------------------------------------------------------------------*/
> +static int ehci_omap_dev_suspend(struct device *dev)
> +{
> +	struct ehci_hcd_omap *omap = dev_get_drvdata(dev);
> +
> +	if (!omap->suspended)
> +		ehci_omap_enable(omap, 0);
> +	return 0;
> +}
> +
> +static int ehci_omap_dev_resume(struct device *dev)
> +{
> +	struct ehci_hcd_omap *omap = dev_get_drvdata(dev);
> +
> +	if (omap->suspended)
> +		ehci_omap_enable(omap, 1);
> +	return 0;
> +}
> +
> +static int ehci_omap_bus_suspend(struct usb_hcd *hcd)
> +{
> +	struct usb_bus *bus = hcd_to_bus(hcd);
> +	int ret;
> +
> +	ret = ehci_bus_suspend(hcd);
> +
> +	ehci_omap_dev_suspend(bus->controller);
> +
> +	return ret;
> +}
> +static int ehci_omap_bus_resume(struct usb_hcd *hcd)
> +{
> +	struct usb_bus *bus = hcd_to_bus(hcd);
> +	int ret;
> +
> +	ehci_omap_dev_resume(bus->controller);
> +
> +	ret = ehci_bus_resume(hcd);
> +
> +	return ret;
> +}

You could use the runtime-PM interface instead of explicitly suspending 
and resuming the controller.  It is now standard.

Alan Stern

