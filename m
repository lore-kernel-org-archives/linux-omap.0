From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 05/13] gpio/omap: get rid of retrigger variable in gpio_irq_handler
Date: Mon, 12 Mar 2012 11:52:41 -0700
Message-ID: <87k42py7ly.fsf@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<1331118963-26364-6-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:55382 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752891Ab2CLSwe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 14:52:34 -0400
Received: by mail-iy0-f172.google.com with SMTP id z13so9807861iaz.17
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 11:52:33 -0700 (PDT)
In-Reply-To: <1331118963-26364-6-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 7 Mar 2012 16:45:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This local variable is just assigned zero and then OR'ed
> with isr. It does not appear to serve any purpose and so
> removing it.

Still missing the changelog changes I requested in v1.

Kevin

> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 3765654..de5fe8f 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -626,7 +626,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  	u32 isr;
>  	unsigned int gpio_irq, gpio_index;
>  	struct gpio_bank *bank;
> -	u32 retrigger = 0;
>  	int unmasked = 0;
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  
> @@ -663,8 +662,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  			chained_irq_exit(chip, desc);
>  		}
>  
> -		isr |= retrigger;
> -		retrigger = 0;
>  		if (!isr)
>  			break;
