From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2 OneNAND GPIO fix
Date: Mon, 15 Dec 2008 15:40:59 -0800
Message-ID: <20081215234058.GC19551@atomide.com>
References: <200812111759.15180.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52230 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbYLOXlD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 18:41:03 -0500
Content-Disposition: inline
In-Reply-To: <200812111759.15180.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: linux-omap@vger.kernel.org

* Jean Pihet <jpihet@mvista.com> [081211 09:02]:
> Hi,
> 
> Here is a patch to have the OMAP2 OneNAND driver compile on the latest tree.
> I do not know if this has been addressed already, here is a patch.

Looks like I already applied similar fixes. These are queued up for
mainline too BTW.

Regards,

Tony

> 
> Regards,
> Jean
> 
> 
> 
> From f95826f916cde9c0d0da79e006f090bc69112a1e Mon Sep 17 00:00:00 2001
> From: Jean Pihet <jpihet@mvista.com>
> Date: Thu, 11 Dec 2008 17:48:31 +0100
> Subject: [PATCH] ARM: OMAP: use GPIO standard in OneNAND driver
> 
> This patch replaces some legacy OMAP GPIO calls with the standard
> calls that work on most platforms.
> 
> Tested on OMAP3 EVM board.
> 
> Signed-off-by: Jean Pihet <jpihet@mvista.com>
> ---
>  drivers/mtd/onenand/omap2.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 762623f..f223303 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -34,11 +34,11 @@
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
> +#include <linux/gpio.h>
> 
>  #include <asm/mach/flash.h>
>  #include <mach/gpmc.h>
>  #include <mach/onenand.h>
> -#include <mach/gpio.h>
>  #include <mach/pm.h>
> 
>  #include <mach/dma.h>
> @@ -149,7 +149,7 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int 
> state)
> 
>                 INIT_COMPLETION(c->irq_done);
>                 if (c->gpio_irq) {
> -                       result = omap_get_gpio_datain(c->gpio_irq);
> +                       result = gpio_get_value(c->gpio_irq);
>                         if (result == -1) {
>                                 ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
>                                 intr = read_reg(c, ONENAND_REG_INTERRUPT);
> @@ -629,12 +629,13 @@ static int __devinit omap2_onenand_probe(struct 
> platform_device *pdev)
>         }
> 
>         if (c->gpio_irq) {
> -               if ((r = omap_request_gpio(c->gpio_irq)) < 0) {
> +               r = gpio_request(c->gpio_irq, "OneNAND Irq");
> +               if (r < 0) {
>                         dev_err(&pdev->dev,  "Failed to request GPIO%d for "
>                                 "OneNAND\n", c->gpio_irq);
>                         goto err_iounmap;
>         }
> -       omap_set_gpio_direction(c->gpio_irq, 1);
> +       gpio_direction_input(c->gpio_irq);
> 
>         if ((r = request_irq(gpio_to_irq(c->gpio_irq),
>                              omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
> @@ -726,7 +727,7 @@ err_release_dma:
>                 free_irq(gpio_to_irq(c->gpio_irq), c);
>  err_release_gpio:
>         if (c->gpio_irq)
> -               omap_free_gpio(c->gpio_irq);
> +               gpio_free(c->gpio_irq);
>  err_iounmap:
>         iounmap(c->onenand.base);
>  err_release_mem_region:
> @@ -761,7 +762,7 @@ static int __devexit omap2_onenand_remove(struct 
> platform_device *pdev)
>         platform_set_drvdata(pdev, NULL);
>         if (c->gpio_irq) {
>                 free_irq(gpio_to_irq(c->gpio_irq), c);
> -               omap_free_gpio(c->gpio_irq);
> +               gpio_free(c->gpio_irq);
>         }
>         iounmap(c->onenand.base);
>         release_mem_region(c->phys_base, ONENAND_IO_SIZE);
> --
> 1.5.4.4.21.gc4a6c

> From f95826f916cde9c0d0da79e006f090bc69112a1e Mon Sep 17 00:00:00 2001
> From: Jean Pihet <jpihet@mvista.com>
> Date: Thu, 11 Dec 2008 17:48:31 +0100
> Subject: [PATCH] ARM: OMAP: use GPIO standard in OneNAND driver
> 
> This patch replaces some legacy OMAP GPIO calls with the standard
> calls that work on most platforms.
> 
> Tested on OMAP3 EVM board.
> 
> Signed-off-by: Jean Pihet <jpihet@mvista.com>
> ---
>  drivers/mtd/onenand/omap2.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 762623f..f223303 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -34,11 +34,11 @@
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
> +#include <linux/gpio.h>
>  
>  #include <asm/mach/flash.h>
>  #include <mach/gpmc.h>
>  #include <mach/onenand.h>
> -#include <mach/gpio.h>
>  #include <mach/pm.h>
>  
>  #include <mach/dma.h>
> @@ -149,7 +149,7 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
>  
>  		INIT_COMPLETION(c->irq_done);
>  		if (c->gpio_irq) {
> -			result = omap_get_gpio_datain(c->gpio_irq);
> +			result = gpio_get_value(c->gpio_irq);
>  			if (result == -1) {
>  				ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
>  				intr = read_reg(c, ONENAND_REG_INTERRUPT);
> @@ -629,12 +629,13 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
>  	}
>  
>  	if (c->gpio_irq) {
> -		if ((r = omap_request_gpio(c->gpio_irq)) < 0) {
> +		r = gpio_request(c->gpio_irq, "OneNAND Irq");
> +		if (r < 0) {
>  			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
>  				"OneNAND\n", c->gpio_irq);
>  			goto err_iounmap;
>  	}
> -	omap_set_gpio_direction(c->gpio_irq, 1);
> +	gpio_direction_input(c->gpio_irq);
>  
>  	if ((r = request_irq(gpio_to_irq(c->gpio_irq),
>  			     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
> @@ -726,7 +727,7 @@ err_release_dma:
>  		free_irq(gpio_to_irq(c->gpio_irq), c);
>  err_release_gpio:
>  	if (c->gpio_irq)
> -		omap_free_gpio(c->gpio_irq);
> +		gpio_free(c->gpio_irq);
>  err_iounmap:
>  	iounmap(c->onenand.base);
>  err_release_mem_region:
> @@ -761,7 +762,7 @@ static int __devexit omap2_onenand_remove(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, NULL);
>  	if (c->gpio_irq) {
>  		free_irq(gpio_to_irq(c->gpio_irq), c);
> -		omap_free_gpio(c->gpio_irq);
> +		gpio_free(c->gpio_irq);
>  	}
>  	iounmap(c->onenand.base);
>  	release_mem_region(c->phys_base, ONENAND_IO_SIZE);
> -- 
> 1.5.4.4.21.gc4a6c
> 

