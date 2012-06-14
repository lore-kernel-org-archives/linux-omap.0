From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/4] memory: emif: add device tree support to emif
 driver
Date: Thu, 14 Jun 2012 08:48:20 -0700
Message-ID: <20120614154820.GG17140@kroah.com>
References: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com>
 <1339669764-27244-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49591 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000Ab2FNPsY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 11:48:24 -0400
Received: by pbbrp8 with SMTP id rp8so3978673pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 08:48:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339669764-27244-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>

On Thu, Jun 14, 2012 at 03:59:24PM +0530, Santosh Shilimkar wrote:
> From: Aneesh V <aneesh@ti.com>
> 
> Device tree support for the EMIF driver.
> 
> Reviewed-by: Benoit Cousson <b-cousson@ti.com>
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Aneesh V <aneesh@ti.com>
> [santosh.shilimkar@ti.com: Rebased against 3.5-rc]
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Am I the memory maintainer now taking these patches?

> @@ -1267,7 +1534,13 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
>  	struct resource		*res;
>  	int			irq;
>  
> -	emif = get_device_details(pdev);
> +#if defined(CONFIG_OF)
> +	if (pdev->dev.of_node)
> +		emif = of_get_device_details(pdev->dev.of_node, &pdev->dev);
> +	else
> +#endif
> +		emif = get_device_details(pdev);
> +

Can't you do this without the #ifdef?

thanks,

greg k-h
