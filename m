From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v3 03/23] serial: omap: don't access the platform_device
Date: Wed, 5 Sep 2012 13:27:21 -0700
Message-ID: <20120905202721.GA2430@kroah.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
 <1345717983-18179-4-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1345717983-18179-4-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: alan@linux.intel.com, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Sourav Poddar <sourav.poddar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 23, 2012 at 01:32:43PM +0300, Felipe Balbi wrote:
> The driver doesn't need to know about its platform_device.
> 
> Everything the driver needs can be done through the
> struct device pointer. In case we need to use the
> OMAP-specific PM function pointers, those can make
> sure to find the device's platform_device pointer
> so they can find the struct omap_device through
> pdev->archdata field.
> 
> Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

This series fails when applying to my tty-next branch at this patch :(

Care to refresh it, and resend it, with Tony's acks added, so I can
apply it?  Note, I've already applied the first two.

thanks,

greg k-h
