From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 08/15] genirq: Add runtime power management support for
 IRQ chips
Date: Thu, 17 Mar 2016 16:02:38 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603171556020.3978@nanos>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com> <1458224359-32665-9-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458224359-32665-9-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 17 Mar 2016, Jon Hunter wrote:
>  /**
>   * struct irq_chip - hardware interrupt chip descriptor
>   *
> + * @parent:		pointer to associated device

That's really a bad name. parent suggests that this is a parent interrupt chip
and your explanation sucks as well. What's an associated device? Network card? 

>  #include <linux/irqdesc.h>
>  #include <linux/kernel_stat.h>
> +#include <linux/pm_runtime.h>
>  
>  #ifdef CONFIG_SPARSE_IRQ
>  # define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index b2a93a37f772..65878e7c7c82 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1114,6 +1114,10 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>  	if (!try_module_get(desc->owner))
>  		return -ENODEV;
>  
> +	ret = irq_chip_pm_get(&desc->irq_data);
> +	if (ret < 0)
> +		goto out_mput;

So this call nests inside the chip_bus_lock() region. Is that intentional?

Thanks,

	tglx
