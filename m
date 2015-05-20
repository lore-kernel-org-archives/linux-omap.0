From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Constify irq_domain_ops
Date: Wed, 20 May 2015 10:14:38 -0700
Message-ID: <20150520171437.GZ10274@atomide.com>
References: <1430138984-3523-1-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430138984-3523-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Krzysztof Kozlowski <k.kozlowski.k@gmail.com> [150427 05:52]:
> The irq_domain_ops are not modified by the driver and the irqdomain core
> code accepts pointer to a const data.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Applying into omap-for-v4.2/cleanup thanks.

Tony

> ---
>  arch/arm/mach-omap2/omap-wakeupgen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
> index 3b56722dfd8a..8e52621b5a6b 100644
> --- a/arch/arm/mach-omap2/omap-wakeupgen.c
> +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
> @@ -444,7 +444,7 @@ static int wakeupgen_domain_alloc(struct irq_domain *domain,
>  	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
>  }
>  
> -static struct irq_domain_ops wakeupgen_domain_ops = {
> +static const struct irq_domain_ops wakeupgen_domain_ops = {
>  	.xlate	= wakeupgen_domain_xlate,
>  	.alloc	= wakeupgen_domain_alloc,
>  	.free	= irq_domain_free_irqs_common,
> -- 
> 2.1.0
> 
