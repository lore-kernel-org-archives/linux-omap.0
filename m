From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/5] omap gpmc: enable irq mode in gpmc
Date: Tue, 28 Sep 2010 15:27:28 -0700
Message-ID: <20100928222727.GS3117@atomide.com>
References: <1285594634-19277-1-git-send-email-s-ghorai@ti.com>
 <1285594634-19277-2-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52355 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab0I1W1c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 18:27:32 -0400
Content-Disposition: inline
In-Reply-To: <1285594634-19277-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org

* Sukumar Ghorai <s-ghorai@ti.com> [100927 06:30]:
>   add support the irq mode in GPMC.
>   gpmc_init() function move after omap_init_irq() as it has dependecy on irq.

> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -144,6 +144,7 @@ static void __init omap_2430sdp_init_irq(void)
>  	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
>  	omap2_init_common_hw(NULL, NULL);
>  	omap_init_irq();
> +	gpmc_init();
>  	omap_gpio_init();
>  }
>  
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 67b95b5..549cd62 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -328,6 +328,7 @@ static void __init omap_3430sdp_init_irq(void)
>  	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
>  	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
>  	omap_init_irq();
> +	gpmc_init();
>  	omap_gpio_init();
>  }
...

You can avoid adding gpmc_init() by making it a subsys_initcall().
Just make sure you return early from it with if (!cpu_class_is_omap2()).

> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -713,6 +721,31 @@ void __init gpmc_init(void)
>  	l |= (0x02 << 3) | (1 << 0);
>  	gpmc_write_reg(GPMC_SYSCONFIG, l);
>  	gpmc_mem_init();
> +
> +	/* initalize the irq_chained */
> +	irq = OMAP_GPMC_IRQ_BASE;
> +	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
> +		set_irq_handler(irq, handle_simple_irq);
> +		set_irq_flags(irq, IRQF_VALID);
> +		irq++;
> +	}
> +
> +	if (request_irq(20, gpmc_handle_irq, IRQF_SHARED, "gpmc", gpmc_base))
> +		printk(KERN_ERR "gpmc: irq-%d could not claim: err %d\n",
> +							INT_34XX_GPMC_IRQ, irq);
> +}

Hmm, this does not look right.. Shouldn't you call set_irq_chained_handler()
somewhere too? Also, are you sure the interrupt is 20 for all of mach-omap2?
It should be added to the irqs.h files.

> +static irqreturn_t gpmc_handle_irq(int irq, void *dev)
> +{
> +	u8 cs;
> +
> +	if (irq != INT_34XX_GPMC_IRQ)
> +		return IRQ_HANDLED;
> +	/* check cs to invoke the irq */
> +	cs = ((gpmc_read_reg(GPMC_PREFETCH_CONFIG1)) >> CS_NUM_SHIFT) & 0x7;
> +	generic_handle_irq(OMAP_GPMC_IRQ_BASE+cs);
> +
> +	return IRQ_HANDLED;
>  }

Doesn't doing OMAP_GPMC_IRQ_BASE + cs overlap with some other irq?

Regards,

Tony
