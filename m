From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] gpio/omap: ensure gpio context is initialised
Date: Thu, 18 Apr 2013 13:52:32 +0530
Message-ID: <516FAD48.4020304@ti.com>
References: <1366230707-32681-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33433 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754992Ab3DRIUe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Apr 2013 04:20:34 -0400
In-Reply-To: <1366230707-32681-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thursday 18 April 2013 02:01 AM, Jon Hunter wrote:
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
> +
The use of 'context_valid' is just for the probe resume case and hence
adding a state variable for GPIO bank structures looks bit too much.
Ideally gpio_init_context() should make the first callback successful
as well if ordered correctly but then you need clocks for that
to happen which are enabled in runtime pm calls. 

Do you really need that "context_valid" flag per bank ? I mean
every gpio bank which can "loses_context", probe time context
validity is an issue, right ? In that case, won't just an
__init static variable do for all banks which can loose
context?

Regards,
Santosh


