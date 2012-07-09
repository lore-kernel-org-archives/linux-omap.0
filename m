From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 04/12] gpio/omap: remove saved_wakeup field from struct
 gpio_bank
Date: Mon, 9 Jul 2012 12:43:15 +0300
Message-ID: <4FFAA7B3.6020009@ti.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com> <1331906760-5259-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45270 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414Ab2GIJnY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jul 2012 05:43:24 -0400
In-Reply-To: <1331906760-5259-5-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org

Hi,

Just bumped across this patch and have a query.

On 03/16/2012 04:05 PM, Tarun Kanti DebBarma wrote:
> There is no more need to have saved_wakeup because bank->context.wake_en
> already holds that value. So getting rid of read/write operation associated
> with this field.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |   12 +++---------
>  1 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 3a4f151..3b91ade 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -57,7 +57,6 @@ struct gpio_bank {
>  	u16 irq;
>  	int irq_base;
>  	struct irq_domain *domain;
> -	u32 saved_wakeup;
>  	u32 non_wakeup_gpios;
>  	u32 enabled_non_wakeup_gpios;
>  	struct gpio_regs context;
> @@ -777,7 +776,6 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
>  	unsigned long		flags;
>  
>  	spin_lock_irqsave(&bank->lock, flags);
> -	bank->saved_wakeup = __raw_readl(mask_reg);
>  	__raw_writel(0xffff & ~bank->context.wake_en, mask_reg);

OK, here you are overwriting the mask_reg with the wakeup bitmask
without saving the mask_reg's original content.

>  	spin_unlock_irqrestore(&bank->lock, flags);
>  
> @@ -793,7 +791,7 @@ static int omap_mpuio_resume_noirq(struct device *dev)
>  	unsigned long		flags;
>  
>  	spin_lock_irqsave(&bank->lock, flags);
> -	__raw_writel(bank->saved_wakeup, mask_reg);
> +	__raw_writel(bank->context.wake_en, mask_reg);

Now you are restoring nothing but the same content that you stored
during suspend. This will cause the non-wakeup gpio interrupts to get
masked between a suspend/resume. So isn't this a bug?

Proper solution would be to save the mask_reg context into another
register than context.wake_en during suspend.

>  	spin_unlock_irqrestore(&bank->lock, flags);
>  
>  	return 0;


cheers,
-roger
