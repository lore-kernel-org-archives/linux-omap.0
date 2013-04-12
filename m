From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] gpio/omap: implement irq_enable/disable using mask/unmask.
Date: Fri, 12 Apr 2013 15:49:52 +0530
Message-ID: <5167DFC8.8060202@ti.com>
References: <1365758001-15562-1-git-send-email-andreas.fenkart@streamunlimited.com> <1365758001-15562-2-git-send-email-andreas.fenkart@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57386 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954Ab3DLKSF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Apr 2013 06:18:05 -0400
In-Reply-To: <1365758001-15562-2-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>, jon-hunter@ti.com
Cc: khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org, daniel@zonque.org

On Friday 12 April 2013 02:43 PM, Andreas Fenkart wrote:
> In PM suspend, some omaps can't detect sdio irqs via the sdio interface.
> The way to implement this, is to declare the corresponding pin as part
> of the sdio interface and as a gpio input via pinctrl-single states.
> The MMC driver request states "default" "active" and "idle" during the
> probe, then toggles between active and idle during the runtime. This
> requires low overhead functions for enable/disable of gpio irqs.
> 
> For level triggered interrupt there is no difference between masking
> and disabling an interrupt. For edge interrupt interrupts there is.
> When masked, interrupts should still be latched to the interrupt status
> register so when unmasked later there is an interrupt straight away.
> However, if the interrupt is disabled then gpio events occurring will not
> be latched/stored. Hence proposed patch is incomplete for edge type
> interrupts.
> 
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> ---
Patch is incomplete and still confusing ;-) if some one reads the
patch without the thread. I think you have already ask the question/
suggestion in past but its better to split masking/disabling functions
and make them behave properly. Mapping enable/disable to mask/unmask
to get around the issue seems more of a hack.

Also I think, we can address the edge type IRQ issue along with this
patch to be complete.

Before you go ahead with the update, I would like to hear Jon's
opinion on the edge IRQ related fixing.

>  drivers/gpio/gpio-omap.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 159f5c5..69ef2d8 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -815,6 +815,8 @@ static struct irq_chip gpio_irq_chip = {
>  	.irq_unmask	= gpio_unmask_irq,
>  	.irq_set_type	= gpio_irq_type,
>  	.irq_set_wake	= gpio_wake_enable,
> +	.irq_disable    = gpio_mask_irq, /* FIXME for edge type IRQ */
> +	.irq_enable     = gpio_unmask_irq,
>  };
>  
>  /*---------------------------------------------------------------------*/
> 
Sorry to make you wait for the proposal discussion.

Regards,
Santosh

