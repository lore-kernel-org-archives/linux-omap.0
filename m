From: Greg KH <greg@kroah.com>
Subject: Re: USB EHCI - Power Management - Query
Date: Wed, 29 Apr 2009 08:20:07 -0700
Message-ID: <20090429152007.GE16302@kroah.com>
References: <814dfab70904290402g494dcf4ci111c10b85109595d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:54171 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816AbZD2PlD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Apr 2009 11:41:03 -0400
Content-Disposition: inline
In-Reply-To: <814dfab70904290402g494dcf4ci111c10b85109595d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Remith Ravi <remithmailinglist@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-usb@vger.kernel.org

On Wed, Apr 29, 2009 at 04:32:21PM +0530, Remith Ravi wrote:
> Hi,
> 
> I have a query on OMAP3530 USB EHCI Power Management.
> USB EHCI port is not switching off the port during suspend activity
> and it is drawing current from the system.
> 
> Is the power management tested for USB EHCI ?
> In file "drivers/usb/host/ehci-omap.c", the function
> ehci_hcd_omap_drv_suspend() and ehci_hcd_omap_drv_resume() is
> commented out.
> 
> Did anybody tried power management on USB EHCI ?

On some EHCI controllers, yes, it has been tested and works.  However it
looks like for your specific hardware, it hasn't been.

Care to send us patches to implement it as you have the hardware to test
it out with?

thanks,

greg k-h
