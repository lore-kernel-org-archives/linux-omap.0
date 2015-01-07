From: =?ISO-8859-15?Q?Peter_K=FCmmel?= <syntheticpp@gmx.net>
Subject: Re: [PATCH] irqchip: omap-intc: fix legacy DMA regression
Date: Wed, 07 Jan 2015 12:12:34 +0100
Message-ID: <54AD14A2.1060006@gmx.net>
References: <20150106123830.GD30544@fuloong-minipc.musicnaut.iki.fi> <1420563093-26026-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:63452 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbbAGLN2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Jan 2015 06:13:28 -0500
In-Reply-To: <1420563093-26026-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Santosh Shilimkar <ssantosh@kernel.org>



Am 06.01.2015 um 17:51 schrieb Felipe Balbi:
> commit 55601c9f2467 (arm: omap: intc: switch over
> to linear irq domain) introduced a regression with
> SDMA legacy driver because that driver strictly depends
> on INTC's IRQs starting at NR_IRQs. Aparently
> irq_domain_add_linear() won't guarantee that, since we see
> a 7 IRQs difference when booting with and without the
> commit cited above.
>
> Until arch/arm/plat-omap/dma.c is properly fixed, we
> must maintain OMAP2/3 using irq_domain_add_legacy().
>
> A FIXME note was added so people know to delete that
> code once that legacy DMA driver is fixed up.
>
> Fixes: 55601c9f2467 (arm: omap: intc: switch over to linear irq domain)
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>   drivers/irqchip/irq-omap-intc.c | 26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
> index 3c970259c0eb..6ef88f56cf8d 100644
> --- a/drivers/irqchip/irq-omap-intc.c
> +++ b/drivers/irqchip/irq-omap-intc.c
> @@ -263,7 +263,7 @@ static int __init omap_init_irq_of(struct device_node *node)
>   	return ret;
>   }
>
> -static int __init omap_init_irq_legacy(u32 base)
> +static int __init omap_init_irq_legacy(u32 base, struct device_node *node)
>   {
>   	int j, irq_base;
>
> @@ -277,7 +277,7 @@ static int __init omap_init_irq_legacy(u32 base)
>   		irq_base = 0;
>   	}
>
> -	domain = irq_domain_add_legacy(NULL, omap_nr_irqs, irq_base, 0,
> +	domain = irq_domain_add_legacy(node, omap_nr_irqs, irq_base, 0,
>   			&irq_domain_simple_ops, NULL);
>
>   	omap_irq_soft_reset();
> @@ -301,10 +301,26 @@ static int __init omap_init_irq(u32 base, struct device_node *node)
>   {
>   	int ret;
>
> -	if (node)
> +	/*
> +	 * FIXME legacy OMAP DMA driver sitting under arch/arm/plat-omap/dma.c
> +	 * depends is still not ready for linear IRQ domains; because of that
> +	 * we need to temporarily "blacklist" OMAP2 and OMAP3 devices from using
> +	 * linear IRQ Domain until that driver is finally fixed.
> +	 */
> +	if (of_device_is_compatible(node, "ti,omap2-intc") ||
> +			of_device_is_compatible(node, "ti,omap3-intc")) {
> +		struct resource res;
> +
> +		if (of_address_to_resource(node, 0, &res))
> +			return -ENOMEM;
> +
> +		base = res.start;
> +		ret = omap_init_irq_legacy(base, node);
> +	} else if (node) {
>   		ret = omap_init_irq_of(node);
> -	else
> -		ret = omap_init_irq_legacy(base);
> +	} else {
> +		ret = omap_init_irq_legacy(base, NULL);
> +	}
>
>   	if (ret == 0)
>   		omap_irq_enable_protection();
>

Thanks, works on DM3730.

Peter
