From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] gpio/omap: implement irq_enable/disable using mask/unmask.
Date: Thu, 20 Dec 2012 11:29:38 +0530
Message-ID: <50D2A94A.6060100@ti.com>
References: <1355736437-14186-1-git-send-email-andreas.fenkart@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51766 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab2LTF7H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Dec 2012 00:59:07 -0500
In-Reply-To: <1355736437-14186-1-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org

On Monday 17 December 2012 02:57 PM, Andreas Fenkart wrote:

Please add some changelog here too.

> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> ---
Patch seems straight forward thought will be interesting where you found
the need of it.

>   drivers/gpio/gpio-omap.c |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index d335af1..c1951ec 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -815,6 +815,8 @@ static struct irq_chip gpio_irq_chip = {
>   	.irq_unmask	= gpio_unmask_irq,
>   	.irq_set_type	= gpio_irq_type,
>   	.irq_set_wake	= gpio_wake_enable,
> +	.irq_disable    = gpio_mask_irq,
> +	.irq_enable     = gpio_unmask_irq,
>   };
>
>   /*---------------------------------------------------------------------*/
>

