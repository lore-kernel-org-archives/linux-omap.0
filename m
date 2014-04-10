From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/5] gpio: omap: convert to use irq_domain_add_simple()
Date: Thu, 10 Apr 2014 13:35:14 -0400
Message-ID: <5346D652.3020702@ti.com>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk> <1396796297-13002-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45770 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbaDJRgU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 13:36:20 -0400
In-Reply-To: <1396796297-13002-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Linus Walleij <linus.walleij@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sunday 06 April 2014 10:58 AM, Javier Martinez Canillas wrote:
> The GPIO OMAP driver supports different OMAP SoC families and
> not all of them have the needed support to use the linear IRQ
> domain mapping like OMAP1 that use the legacy domain mapping.
> 
> But this special check is not necessary since the simple IRQ
> domain mapping is able to handle both cases. Having a zero
> IRQ offset will be interpreted as a linear domain case while
> a non-zero value will be interpreted as a legacy domain case.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  drivers/gpio/gpio-omap.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 19b886c..3ee9b8d 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1138,9 +1138,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
>  	const struct omap_gpio_platform_data *pdata;
>  	struct resource *res;
>  	struct gpio_bank *bank;
> -#ifdef CONFIG_ARCH_OMAP1
> -	int irq_base;
> -#endif
> +	int irq_base = 0;
>  
>  	match = of_match_device(of_match_ptr(omap_gpio_match), dev);
>  
> @@ -1185,21 +1183,16 @@ static int omap_gpio_probe(struct platform_device *pdev)
>  #ifdef CONFIG_ARCH_OMAP1
>  	/*
>  	 * REVISIT: Once we have OMAP1 supporting SPARSE_IRQ, we can drop
> -	 * irq_alloc_descs() and irq_domain_add_legacy() and just use a
> -	 * linear IRQ domain mapping for all OMAP platforms.
> +	 * irq_alloc_descs() since a base IRQ offset will no longer be needed.
>  	 */
>  	irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
>  	if (irq_base < 0) {
>  		dev_err(dev, "Couldn't allocate IRQ numbers\n");
>  		return -ENODEV;
>  	}
> -
> -	bank->domain = irq_domain_add_legacy(node, bank->width, irq_base,
> -					     0, &irq_domain_simple_ops, NULL);
> -#else
> -	bank->domain = irq_domain_add_linear(node, bank->width,
> -					     &irq_domain_simple_ops, NULL);
>  #endif
> +	bank->domain = irq_domain_add_simple(node, bank->width, irq_base,
> +					     &irq_domain_simple_ops, NULL);
>  	if (!bank->domain) {
>  		dev_err(dev, "Couldn't register an IRQ domain\n");
>  		return -ENODEV;
> 
Looks good.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

