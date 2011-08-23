From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 20/22] gpio/omap: cleanup prepare_for_idle and resume_after_idle
Date: Tue, 23 Aug 2011 20:10:01 +0530
Message-ID: <4E53BBC1.3040309@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-21-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:37051 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753128Ab1HWOkJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 10:40:09 -0400
Received: by mail-yw0-f49.google.com with SMTP id 17so159542ywp.36
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 07:40:08 -0700 (PDT)
In-Reply-To: <1312455893-14922-21-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> Simplify  omap2_gpio_prepare_for_idle() and omap2_gpio_resume_after_idle()
/s /Simplify /Cleanup

> by moving most of the stuff to *_runtime_suspend() and *_runtime_resume().
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
>   drivers/gpio/gpio-omap.c |  230 ++++++++++++++++++++++++----------------------
>   1 files changed, 121 insertions(+), 109 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index ce93898..ba743f5 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1132,142 +1132,149 @@ static int omap_gpio_resume(struct device *dev)
>   static void omap_gpio_save_context(struct gpio_bank *bank);
>   static void omap_gpio_restore_context(struct gpio_bank *bank);
>
> -void omap2_gpio_prepare_for_idle(int off_mode)
> +static int omap_gpio_runtime_suspend(struct device *dev)
>   {
> -	struct gpio_bank *bank;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct gpio_bank *bank = platform_get_drvdata(pdev);
> +	u32 l1 = 0, l2 = 0;
> +	int j;
>
> -	list_for_each_entry(bank,&omap_gpio_list, node) {
> -		u32 l1 = 0, l2 = 0;
> -		int j;
> +	for (j = 0; j<  hweight_long(bank->dbck_enable_mask); j++)
> +		clk_disable(bank->dbck);
>
> -		if (!bank->loses_context)
> -			continue;
> +	/* If going to OFF, remove triggering for all
> +	 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
> +	 * generated.  See OMAP2420 Errata item 1.101. */
> +	if (!(bank->enabled_non_wakeup_gpios))
> +		goto save_gpio_ctx;
>
> -		for (j = 0; j<  hweight_long(bank->dbck_enable_mask); j++)
> -			clk_disable(bank->dbck);
> +	bank->saved_datain = __raw_readl(bank->base +
> +						bank->regs->datain);
> +	l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
> +	l2 = __raw_readl(bank->base + bank->regs->risingdetect);
>
> -		if (!off_mode)
> -			continue;
> +	bank->saved_fallingdetect = l1;
> +	bank->saved_risingdetect = l2;
> +	l1&= ~bank->enabled_non_wakeup_gpios;
> +	l2&= ~bank->enabled_non_wakeup_gpios;
>
> -		if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev)<  0))
> -			dev_err(bank->dev, "%s: GPIO bank %d "
> -					"pm_runtime_put_sync failed\n",
> -					__func__, bank->id);
> +	__raw_writel(l1, bank->base + bank->regs->fallingdetect);
> +	__raw_writel(l2, bank->base + bank->regs->risingdetect);
> +
> +save_gpio_ctx:
> +	if (bank->get_context_loss_count)
> +		bank->ctx_loss_count = bank->get_context_loss_count(bank->dev);
> +	omap_gpio_save_context(bank);
> +
> +	return 0;
> +}
> +
> +static int omap_gpio_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct gpio_bank *bank = platform_get_drvdata(pdev);
> +	u32 ctx_lost_cnt_after;
> +	u32 l = 0, gen, gen0, gen1;
> +	int j;
> +
> +	for (j = 0; j<  hweight_long(bank->dbck_enable_mask); j++)
> +		clk_enable(bank->dbck);
>
> -		/* If going to OFF, remove triggering for all
> -		 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
> -		 * generated.  See OMAP2420 Errata item 1.101. */
> -		if (!(bank->enabled_non_wakeup_gpios))
> -			goto save_gpio_ctx;
> +	if (bank->get_context_loss_count) {
> +		ctx_lost_cnt_after =
> +			bank->get_context_loss_count(bank->dev);
> +		if (ctx_lost_cnt_after != bank->ctx_loss_count ||
> +						!ctx_lost_cnt_after)
> +			omap_gpio_restore_context(bank);
> +		else
> +			return 0;
> +	}
>
> -		bank->saved_datain = __raw_readl(bank->base +
> -							bank->regs->datain);
> -		l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
> -		l2 = __raw_readl(bank->base + bank->regs->risingdetect);
> +	if (!(bank->enabled_non_wakeup_gpios))
> +		return 0;
>
> -		bank->saved_fallingdetect = l1;
> -		bank->saved_risingdetect = l2;
> -		l1&= ~bank->enabled_non_wakeup_gpios;
> -		l2&= ~bank->enabled_non_wakeup_gpios;
> +	__raw_writel(bank->saved_fallingdetect,
> +			bank->base + bank->regs->fallingdetect);
> +	__raw_writel(bank->saved_risingdetect,
> +			bank->base + bank->regs->risingdetect);
> +	l = __raw_readl(bank->base + bank->regs->datain);
>
> -		__raw_writel(l1, bank->base + bank->regs->fallingdetect);
> -		__raw_writel(l2, bank->base + bank->regs->risingdetect);
> +	/* Check if any of the non-wakeup interrupt GPIOs have changed
> +	 * state.  If so, generate an IRQ by software.  This is
> +	 * horribly racy, but it's the best we can do to work around
> +	 * this silicon bug. */
Multi-line comment.

> +	l ^= bank->saved_datain;
> +	l&= bank->enabled_non_wakeup_gpios;
Space please around operator.

>
> -save_gpio_ctx:
> -		if (bank->get_context_loss_count)
> -			bank->ctx_loss_count =
> -				bank->get_context_loss_count(bank->dev);
> +	/*
> +	 * No need to generate IRQs for the rising edge for gpio IRQs
> +	 * configured with falling edge only; and vice versa.
> +	 */
> +	gen0 = l&  bank->saved_fallingdetect;
> +	gen0&= bank->saved_datain;
> +	gen1 = l&  bank->saved_risingdetect;
> +	gen1&= ~(bank->saved_datain);
Ditto

Rest looks fine.

regards
Santosh
