From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/2] OneNAND: OMAP2: Switch to gpio_request/free calls
 (OMAP and mainline)
Date: Wed, 3 Dec 2008 09:41:05 +0200
Message-ID: <20081203094105.807e8684.jarkko.nikula@nokia.com>
References: <1228289844-5897-1-git-send-email-jarkko.nikula@nokia.com>
	<1228289844-5897-3-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34058 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbYLCHlb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Dec 2008 02:41:31 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB37enso011016
	for <linux-omap@vger.kernel.org>; Wed, 3 Dec 2008 01:41:28 -0600
In-Reply-To: <1228289844-5897-3-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org, Adrian Hunter <ext-adrian.hunter@nokia.com>

On Wed,  3 Dec 2008 09:37:24 +0200
Jarkko Nikula <jarkko.nikula@nokia.com> wrote:

> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  drivers/mtd/onenand/omap2.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
Grr, I forgot to add Adrian into cc list.

> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 1298563..9ae49b1 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -630,7 +630,7 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
>  	}
>  
>  	if (c->gpio_irq) {
> -		if ((r = omap_request_gpio(c->gpio_irq)) < 0) {
> +		if ((r = gpio_request(c->gpio_irq, "OneNAND irq")) < 0) {
>  			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
>  				"OneNAND\n", c->gpio_irq);
>  			goto err_iounmap;
> @@ -727,7 +727,7 @@ err_release_dma:
>  		free_irq(gpio_to_irq(c->gpio_irq), c);
>  err_release_gpio:
>  	if (c->gpio_irq)
> -		omap_free_gpio(c->gpio_irq);
> +		gpio_free(c->gpio_irq);
>  err_iounmap:
>  	iounmap(c->onenand.base);
>  err_release_mem_region:
> @@ -762,7 +762,7 @@ static int __devexit omap2_onenand_remove(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, NULL);
>  	if (c->gpio_irq) {
>  		free_irq(gpio_to_irq(c->gpio_irq), c);
> -		omap_free_gpio(c->gpio_irq);
> +		gpio_free(c->gpio_irq);
>  	}
>  	iounmap(c->onenand.base);
>  	release_mem_region(c->phys_base, ONENAND_IO_SIZE);
> -- 
> 1.5.6.5
> 
