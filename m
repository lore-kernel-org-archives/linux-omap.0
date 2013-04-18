From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] gpio/omap: ensure gpio context is initialised
Date: Thu, 18 Apr 2013 14:34:00 -0700
Message-ID: <871ua734mv.fsf@linaro.org>
References: <1366230707-32681-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38020 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab3DRVeF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 17:34:05 -0400
Received: by mail-pa0-f50.google.com with SMTP id bg2so1863543pad.37
        for <linux-omap@vger.kernel.org>; Thu, 18 Apr 2013 14:34:03 -0700 (PDT)
In-Reply-To: <1366230707-32681-1-git-send-email-jon-hunter@ti.com> (Jon
	Hunter's message of "Wed, 17 Apr 2013 15:31:47 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

Jon Hunter <jon-hunter@ti.com> writes:

> Commit a2797be (gpio/omap: force restore if context loss is not
> detectable) broke gpio support for OMAP when booting with device-tree
> because a restore of the gpio context being performed without ever
> initialising the gpio context. In other words, the context restored was
> bad.
>
> This problem could also occur in the non device-tree case, however, it
> is much less likely because when booting without device-tree we can
> detect context loss via a platform specific API and so context restore
> is performed less often.
>
> Nevertheless we should ensure that the gpio context is initialised
> during the probe for gpio banks that could lose their state regardless
> of whether we are booting with device-tree or not.
>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/gpio/gpio-omap.c |   53 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 0557529..0ba5cb9 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -70,6 +70,7 @@ struct gpio_bank {
>  	bool is_mpuio;
>  	bool dbck_flag;
>  	bool loses_context;
> +	bool context_valid;
>  	int stride;
>  	u32 width;
>  	int context_loss_count;
> @@ -1085,6 +1086,7 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
>  }
>  
>  static const struct of_device_id omap_gpio_match[];
> +static void omap_gpio_init_context(struct gpio_bank *p);
>  
>  static int omap_gpio_probe(struct platform_device *pdev)
>  {
> @@ -1179,8 +1181,10 @@ static int omap_gpio_probe(struct platform_device *pdev)
>  	omap_gpio_chip_init(bank);
>  	omap_gpio_show_rev(bank);
>  
> -	if (bank->loses_context)
> +	if (bank->loses_context) {
>  		bank->get_context_loss_count = pdata->get_context_loss_count;
> +		omap_gpio_init_context(bank);
> +	}
>  
>  	pm_runtime_put(bank->dev);
>  
> @@ -1269,6 +1273,14 @@ static int omap_gpio_runtime_resume(struct device *dev)
>  	int c;
>  
>  	spin_lock_irqsave(&bank->lock, flags);
> +
> +	/*
> +	 * On the first resume during the probe, the context has not
> +	 * been initialised and so if the context is not valid return.
> +	 */
> +	if (!bank->context_valid)
> +		goto done;

Not sure I follow the reason to separate it here and in probe.  

Also, this makes the first runtime_resume a special case and leaves
things in a strange semi-initialized state that is confusing IMO.

Why not just init context right here if bank->loses_context &&
!bank->context_valid?

Then the first resume can continue as expected, and everything is fully
initialized as expected also.  IMO, this is much more readable (and
maintainable, but that's your job now, so you can decide ;)

Kevin
