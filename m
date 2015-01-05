From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v11 5/9] ARM: l2c: Get outer cache .write_sec callback
 from mach_desc only if not NULL
Date: Mon, 5 Jan 2015 08:25:09 -0800
Message-ID: <20150105162508.GE4081@atomide.com>
References: <1420460348-20302-1-git-send-email-m.szyprowski@samsung.com>
 <1420460348-20302-6-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420460348-20302-6-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, lauraa@codeaurora.org, linus.walleij@linaro.org, drake@endlessm.com, loeliger@gmail.com, Mark Rutland <mark.rutland@arm.com>, nm@ti.com, khilman@linaro.org
List-Id: linux-omap@vger.kernel.org

* Marek Szyprowski <m.szyprowski@samsung.com> [150105 04:22]:
> From: Tomasz Figa <t.figa@samsung.com>
> 
> Certain platforms (i.e. Exynos) might need to set .write_sec callback
> from firmware initialization which is happenning in .init_early callback
> of machine descriptor. However current code will overwrite the pointer
> with whatever is present in machine descriptor, even though it can be
> already set earlier. This patch fixes this by making the assignment
> conditional, depending on whether current .write_sec callback is NULL.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/kernel/irq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index ad857bada96c..350f188c92d2 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -109,7 +109,8 @@ void __init init_IRQ(void)
>  
>  	if (IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_CACHE_L2X0) &&
>  	    (machine_desc->l2c_aux_mask || machine_desc->l2c_aux_val)) {
> -		outer_cache.write_sec = machine_desc->l2c_write_sec;
> +		if (!outer_cache.write_sec)
> +			outer_cache.write_sec = machine_desc->l2c_write_sec;
>  		ret = l2x0_of_init(machine_desc->l2c_aux_val,
>  				   machine_desc->l2c_aux_mask);
>  		if (ret)
> -- 
> 1.9.2
> 
