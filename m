From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH RFC 2/2] usb: ehci-omap: add suspend/resume support
Date: Fri, 14 May 2010 19:31:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D8AA@dbde02.ent.ti.com>
References: <1273762822-23073-2-git-send-email-gadiyar@ti.com>
 <Pine.LNX.4.44L0.1005131305320.1731-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59867 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab0ENOBd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 10:01:33 -0400
In-Reply-To: <Pine.LNX.4.44L0.1005131305320.1731-100000@iolanthe.rowland.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>

Alan Stern wrote:
> On Thu, 13 May 2010, Anand Gadiyar wrote:
> 
> > Add support for suspend and resume to the ehci-omap driver.
> > Added routines for platform_driver suspend/resume and 
> > wrappers around ehci_bus_suspend/resume.
> 
> > +#ifdef CONFIG_PM
> >  
> /*-------------------------------------------------------------------------*/
> > +static int ehci_omap_dev_suspend(struct device *dev)
> > +{
> > +	struct ehci_hcd_omap *omap = dev_get_drvdata(dev);
> > +
> > +	if (!omap->suspended)
> > +		ehci_omap_enable(omap, 0);
> > +	return 0;
> > +}
> > +
> > +static int ehci_omap_dev_resume(struct device *dev)
> > +{
> > +	struct ehci_hcd_omap *omap = dev_get_drvdata(dev);
> > +
> > +	if (omap->suspended)
> > +		ehci_omap_enable(omap, 1);
> > +	return 0;
> > +}
> > +
> > +static int ehci_omap_bus_suspend(struct usb_hcd *hcd)
> > +{
> > +	struct usb_bus *bus = hcd_to_bus(hcd);
> > +	int ret;
> > +
> > +	ret = ehci_bus_suspend(hcd);
> > +
> > +	ehci_omap_dev_suspend(bus->controller);
> > +
> > +	return ret;
> > +}
> > +static int ehci_omap_bus_resume(struct usb_hcd *hcd)
> > +{
> > +	struct usb_bus *bus = hcd_to_bus(hcd);
> > +	int ret;
> > +
> > +	ehci_omap_dev_resume(bus->controller);
> > +
> > +	ret = ehci_bus_resume(hcd);
> > +
> > +	return ret;
> > +}
> 
> You could use the runtime-PM interface instead of explicitly suspending 
> and resuming the controller.  It is now standard.
> 

Will work on this. I'll be out for a while, so it could be some time
before I repost.

Thanks,
Anand
