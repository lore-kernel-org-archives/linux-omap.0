From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 24/24] omap4: multi-omap: Allow build to work
Date: Tue, 16 Feb 2010 10:53:48 -0800
Message-ID: <20100216185348.GO21755@atomide.com>
References: <1266335895-32741-15-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-16-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-17-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-18-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-19-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-20-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-21-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-22-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-23-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-24-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59399 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932871Ab0BPSxE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 13:53:04 -0500
Content-Disposition: inline
In-Reply-To: <1266335895-32741-24-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100216 07:55]:
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
> +
>  	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!iomem || irq == 0)
>  		return -ENODEV;

Should the comment here be "FIXME: allow multi-omap to boot until
musb is updated for omap4" instead?

Regards,

Tony
