From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 6/6 v2] arm: omap: usb: global Suspend and resume support
 of ehci and ohci
Date: Fri, 1 Jul 2011 15:06:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107011504530.1624-100000@iolanthe.rowland.org>
References: <1309546474-15363-7-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:48579 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752423Ab1GATGu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 15:06:50 -0400
In-Reply-To: <1309546474-15363-7-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, paul@pwsan.com, johnstul@us.ibm.com, vishwanath.bs@ti.com

On Sat, 2 Jul 2011, Keshava Munegowda wrote:

> From: Keshava Munegowda <Keshava_mgowda@ti.com>
> 
> The global suspend and resume functions for ehci and ohci
> drivers are implemented; these functions does the
> pm_runtime_get_sync and pm_runtime_put_sync of the
> parent device usbhs core driver respectively.
> 
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> ---
>  drivers/usb/host/ehci-omap.c  |   22 ++++++++++++++++++++--
>  drivers/usb/host/ohci-omap3.c |   21 +++++++++++++++++++++
>  2 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 178f63e..a02a684 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -259,14 +259,32 @@ static void ehci_hcd_omap_shutdown(struct platform_device *pdev)
>  		hcd->driver->shutdown(hcd);
>  }
>  
> +static int omap_ehci_resume(struct device *dev)
> +{
> +	if (dev->parent)
> +		pm_runtime_get_sync(dev->parent);
> +	return 0;
> +}
> +
> +static int omap_ehci_suspend(struct device *dev)
> +{
> +	if (dev->parent)
> +		pm_runtime_put_sync(dev->parent);
> +	return 0;
> +}

I don't see any point in these routines (and likewise for
omap_ohci_suspend/resume).  When the whole system is going to sleep
anyway, what reason is there for enabling runtime PM on the parent
device?

Alan Stern

