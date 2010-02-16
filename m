From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 24/24] omap4: multi-omap: Allow build to work
Date: Tue, 16 Feb 2010 16:30:21 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002161625020.10478@utopia.booyaka.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-12-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-13-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-14-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-15-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-16-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-17-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-18-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-19-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-20-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-21-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-22-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-23-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-24-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45186 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933267Ab0BPXaW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 18:30:22 -0500
In-Reply-To: <1266335895-32741-24-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, gadiyar@ti.com, lrg@slimlogic.co.uk

On Tue, 16 Feb 2010, Santosh Shilimkar wrote:

> The musb support is enable to omap3 platforms. For omap4 only board
> support is available and the driver still isn't supported.
> Because of this build with omap3_defconfig used for multi-omap
> doesn't work on omap4430 sdp.
> 
> This patch hacks the musb probe to keep the multi-omap build
> working on omap4430 sdp
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  drivers/usb/musb/musb_core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index bcce8e8..13b1c4a 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2124,6 +2124,10 @@ static int __init musb_probe(struct platform_device *pdev)
>  	struct resource	*iomem;
>  	void __iomem	*base;
>  
> +	/* FIXME: multi-omap build to work on omap4 */
> +	if (cpu_is_omap44xx())
> +		return 0;

NAK.  This will break musb compilation on all non-OMAP platforms.  This is 
a major part of the reason why these cpu_is_omap*() calls should not go 
into any device driver.

The right place for this kind of hack is in mach-omap2/usb-musb.c.

Also, this should return an error, not pretend that it succeeded.  It 
should also include a big fat WARN_ON() to reduce the risk that this 
temporary hack will be overlooked.

> +
>  	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!iomem || irq == 0)
>  		return -ENODEV;
> -- 
> 1.6.0.4
> 


- Paul
