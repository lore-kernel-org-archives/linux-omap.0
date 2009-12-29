From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: omap1: mailbox: kill compile warning
Date: Mon, 28 Dec 2009 16:26:56 -0800
Message-ID: <20091229002656.GW3512@atomide.com>
References: <1261512955-19437-1-git-send-email-felipe.balbi@nokia.com>
 <1261512955-19437-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52671 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbZL2A07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 19:26:59 -0500
Content-Disposition: inline
In-Reply-To: <1261512955-19437-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

* Felipe Balbi <felipe.balbi@nokia.com> [091222 12:17]:
> use ioremap to get the virtual address and
> avoid a compile warning.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap1/mailbox.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
> index caf889a..38a7d2c 100644
> --- a/arch/arm/mach-omap1/mailbox.c
> +++ b/arch/arm/mach-omap1/mailbox.c
> @@ -160,7 +160,12 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "invalid mem resource\n");
>  		return -ENODEV;
>  	}
> -	mbox_base = res->start;
> +
> +	mbox_base = ioremap(res->start, resource_size(res));
> +	if (!mbox_base) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		return -ENODEV;
> +	}
>  
>  	/* DSP IRQ */
>  	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);

This does not look right, if you look at mach-omap1/devices.c,
OMAP1_MBOX_BASE is still using OMAP1_IO_ADDRESS, so it's already
a virt address.

Maybe update the patch to remove OMAP1_IO_ADDRESS in
mach-omap1/devices.c?

Regards,

Tony
